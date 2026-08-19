Query 1: How does procurement vary over time?
SELECT
    DATE_TRUNC('month', collection_date)::date AS month,
    SUM(collected_quantity_kg) AS procurement_kg,
    COUNT(*) AS collection_records
FROM collection
GROUP BY 1
ORDER BY 1;

Query 2: How much tendu leaf was collected, and what was the total procurement value?
SELECT
    COUNT(*) AS total_collection_records,
    SUM(collected_quantity_kg) AS total_quantity_kg,
    ROUND(AVG(collected_quantity_kg), 2) AS average_collection_kg
FROM collection;

Query 3: Which forests contribute the most to total leaf procurement?
SELECT
    f.forest_id,
    f.forest_name,
    SUM(c.collected_quantity_kg) AS total_procurement_kg,
    ROUND(
        100.0 * SUM(c.collected_quantity_kg)
        / SUM(SUM(c.collected_quantity_kg)) OVER (),
        2
    ) AS procurement_share_pct
FROM forests f
JOIN collection c
    ON f.forest_id = c.forest_id
GROUP BY f.forest_id, f.forest_name
ORDER BY total_procurement_kg DESC;

Query 4:  What are the major expense categories and how do they change over time?
SELECT
    DATE_TRUNC('month', expense_date)::date AS month,
    expense_category,
    SUM(amount_inr) AS total_expense_inr
FROM expenses
GROUP BY
    1,
    expense_category
ORDER BY
    1,
    total_expense_inr DESC;

Query 5: Which forests generate the highest and lowest estimated operating profit?
WITH forest_revenue AS (
    SELECT
        c.forest_id,
        SUM(s.total_sale_value) AS revenue_inr
    FROM sales s
    JOIN bundles b
        ON s.bundle_id = b.bundle_id
    JOIN quality_inspection q
        ON b.inspection_id = q.inspection_id
    JOIN collection col
        ON q.collection_id = col.collection_id
    JOIN contracts c
        ON col.contract_id = c.contract_id
    GROUP BY c.forest_id
),

forest_expense AS (
    SELECT
        c.forest_id,
        SUM(e.amount_inr) AS expense_inr
    FROM expenses e
    JOIN contracts c
        ON e.contract_id = c.contract_id
    GROUP BY c.forest_id
)

SELECT
    f.forest_id,
    f.forest_name,
    COALESCE(r.revenue_inr, 0) AS revenue_inr,
    COALESCE(e.expense_inr, 0) AS expense_inr,
    COALESCE(r.revenue_inr, 0)
        - COALESCE(e.expense_inr, 0) AS operating_profit_inr
FROM forests f
LEFT JOIN forest_revenue r
    ON f.forest_id = r.forest_id
LEFT JOIN forest_expense e
    ON f.forest_id = e.forest_id
ORDER BY operating_profit_inr DESC;

Query 6: How do selling prices and revenue vary by leaf grade?

SELECT
    leaf_grade,
    SUM(quantity_sold_kg) AS quantity_sold_kg,
    ROUND(AVG(selling_price_per_kg), 2) AS avg_selling_price_per_kg,
    SUM(total_sale_value) AS total_revenue_inr
FROM sales
GROUP BY leaf_grade
ORDER BY leaf_grade;

Query 7: 5.  What are the major monthly sales trends?
SELECT
    DATE_TRUNC('month', sale_date)::date AS month,
    SUM(quantity_sold_kg) AS quantity_sold_kg,
    SUM(total_sale_value) AS revenue_inr,
    ROUND(AVG(selling_price_per_kg), 2) AS avg_price_per_kg
FROM sales
GROUP BY 1
ORDER BY 1;
