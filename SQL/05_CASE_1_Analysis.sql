Query 1: Contract Performance Classification
SELECT
    c.contract_id,
    c.forest_id,
    c.contract_value_inr,
    CASE
        WHEN c.contract_value_inr >= 1000000 THEN 'High Value'
        WHEN c.contract_value_inr >= 500000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS contract_segment
FROM contracts c
ORDER BY c.contract_value_inr DESC;

Query 2: Profitability Classification
WITH sales_by_contract AS (
    SELECT
        c.contract_id,
        SUM(s.total_sale_value) AS total_revenue_inr
    FROM sales s
    JOIN bundles b
        ON s.bundle_id = b.bundle_id
    JOIN quality_inspection qi
        ON b.inspection_id = qi.inspection_id
    JOIN collection c
        ON qi.collection_id = c.collection_id
    GROUP BY c.contract_id
),

expenses_by_contract AS (
    SELECT
        contract_id,
        SUM(amount_inr) AS total_expenses_inr
    FROM expenses
    GROUP BY contract_id
)

SELECT
    s.contract_id,
    s.total_revenue_inr,
    COALESCE(e.total_expenses_inr, 0) AS total_expenses_inr,
    s.total_revenue_inr - COALESCE(e.total_expenses_inr, 0) AS profit_inr,
    CASE
        WHEN s.total_revenue_inr - COALESCE(e.total_expenses_inr, 0) > 500000
            THEN 'Highly Profitable'
        WHEN s.total_revenue_inr - COALESCE(e.total_expenses_inr, 0) > 0
            THEN 'Profitable'
        ELSE 'Loss-Making'
    END AS profitability_class
FROM sales_by_contract s
LEFT JOIN expenses_by_contract e
    ON s.contract_id = e.contract_id
ORDER BY profit_inr DESC;

Query 3: Warehouse Capacity Risk
SELECT
    w.warehouse_id,
    w.warehouse_name,
    w.capacity_kg,
    COALESCE(SUM(i.remaining_quantity_kg), 0) AS current_inventory_kg,
    ROUND(
        COALESCE(SUM(i.remaining_quantity_kg), 0) * 100.0
        / NULLIF(w.capacity_kg, 0),
        2
    ) AS capacity_utilization_pct,
    CASE
        WHEN COALESCE(SUM(i.remaining_quantity_kg), 0) * 100.0
             / NULLIF(w.capacity_kg, 0) >= 90
            THEN 'Critical'
        WHEN COALESCE(SUM(i.remaining_quantity_kg), 0) * 100.0
             / NULLIF(w.capacity_kg, 0) >= 75
            THEN 'High'
        ELSE 'Normal'
    END AS capacity_risk
FROM warehouses w
LEFT JOIN inventory i
    ON w.warehouse_id = i.warehouse_id
GROUP BY
    w.warehouse_id,
    w.warehouse_name,
    w.capacity_kg
ORDER BY capacity_utilization_pct DESC;
