Query 1: Average Procurement Cost per Kg
SELECT
    ROUND(
        SUM(e.amount_inr) / NULLIF(SUM(c.collected_quantity_kg), 0),
        2
    ) AS average_procurement_cost_per_kg
FROM expenses e
CROSS JOIN (
    SELECT SUM(collected_quantity_kg) AS collected_quantity_kg
    FROM collection
) c;

Query 2: Average Selling Price per Kg
SELECT
    ROUND(
        SUM(total_sale_value) / NULLIF(SUM(quantity_sold_kg), 0),
        2
    ) AS average_selling_price_per_kg
FROM sales;

Query 3: Collection Acceptance Rate
SELECT
    ROUND(
        (
            SUM(accepted_quantity_kg)::numeric
            / NULLIF(SUM(accepted_quantity_kg) + SUM(rejected_quantity_kg), 0)
        ) * 100,
        2
    ) AS collection_acceptance_rate_percentage
FROM quality_inspection;

Query 4: Forest-Level Revenue & Operating Profit Analysis

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

Query 5: Outstanding Receivables
SELECT
    ROUND(
        SUM(s.total_sale_value)
        - COALESCE(SUM(p.amount_paid_inr), 0),
        2
    ) AS outstanding_receivables_inr
FROM sales s
LEFT JOIN payments p
    ON s.sale_id = p.sale_id;

Query 6: Profit Margin
WITH totals AS (
    SELECT
        (SELECT SUM(total_sale_value) FROM sales) AS total_revenue,
        (SELECT SUM(amount_inr) FROM expenses) AS total_expenses
)
SELECT
    ROUND(
        ((total_revenue - total_expenses) / NULLIF(total_revenue, 0)) * 100,
        2
    ) AS profit_margin_percentage
FROM totals;

Query 7: Buyer Sales & Payment Performance Analysis
SELECT
    b.buyer_id,
    b.buyer_name,
    b.buyer_type,
    COUNT(DISTINCT s.sale_id) AS total_orders,
    SUM(s.quantity_sold_kg) AS total_quantity_sold_kg,
    SUM(s.total_sale_value) AS total_revenue_inr,
    COALESCE(SUM(p.amount_paid_inr), 0) AS total_paid_inr,
    SUM(s.total_sale_value)
        - COALESCE(SUM(p.amount_paid_inr), 0) AS outstanding_amount_inr
FROM buyers b
INNER JOIN sales s
    ON b.buyer_id = s.buyer_id
LEFT JOIN payments p
    ON s.sale_id = p.sale_id
GROUP BY
    b.buyer_id,
    b.buyer_name,
    b.buyer_type
ORDER BY total_revenue_inr DESC;
