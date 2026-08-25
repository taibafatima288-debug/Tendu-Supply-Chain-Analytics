Query 1: Buyer Revenue Ranking using Window Function
SELECT
    b.buyer_id,
    b.buyer_name,
    SUM(s.total_sale_value) AS total_revenue,
    RANK() OVER (ORDER BY SUM(s.total_sale_value) DESC) AS revenue_rank
FROM buyers b
JOIN sales s
    ON b.buyer_id = s.buyer_id
GROUP BY
    b.buyer_id,
    b.buyer_name
ORDER BY revenue_rank;


Query 2: Forest Ranking by Total Procurement using CTE
WITH forest_procurement 
    AS (SELECT
        f.forest_id,
        f.forest_name,
        SUM(c.collected_quantity_kg) AS total_procured_kg
    FROM forests f
    JOIN collection c
        ON f.forest_id = c.forest_id
    GROUP BY
        f.forest_id,
        f.forest_name)
SELECT
    forest_id,
    forest_name,
    total_procured_kg,
    RANK() OVER (ORDER BY total_procured_kg DESC) AS procurement_rank
FROM forest_procurement
ORDER BY procurement_rank;


Query 3: Running Total Sales Revenue using Window Function
SELECT
    sale_date,
    total_sale_value,
    SUM(total_sale_value) OVER (ORDER BY sale_date ) AS cumulative_revenue
FROM sales
ORDER BY sale_date;


Query 4: Compare Each Sale with Previous Sale Using LAG
SELECT
    sale_id,
    sale_date,
    total_sale_value,
    LAG(total_sale_value) OVER (ORDER BY sale_date, sale_id) AS previous_sale_value,total_sale_value - LAG(total_sale_value) OVER (
            ORDER BY sale_date, sale_id) AS change_from_previous
FROM sales
ORDER BY sale_date, sale_id;


Query 5: Warehouse Efficiency using Multiple CTEs
WITH warehouse_inventory AS (
    SELECT
        warehouse_id,
        SUM(remaining_quantity_kg) AS current_inventory_kg
    FROM inventory
    GROUP BY warehouse_id),warehouse_efficiency 
    AS (SELECT
        w.warehouse_id,
        w.warehouse_name,
        w.capacity_kg,
        COALESCE(wi.current_inventory_kg, 0) AS current_inventory_kg, ROUND(COALESCE(wi.current_inventory_kg, 0) * 100.0
            / NULLIF(w.capacity_kg, 0),2) AS capacity_utilization_pct
    FROM warehouses w
    LEFT JOIN warehouse_inventory wi
        ON w.warehouse_id = wi.warehouse_id)
SELECT
    warehouse_id,
    warehouse_name,
    capacity_kg,
    current_inventory_kg,
    capacity_utilization_pct,
    CASE
        WHEN capacity_utilization_pct >= 80 THEN 'Critical'
        WHEN capacity_utilization_pct >= 60 THEN 'High'
        ELSE 'Normal'
    END AS capacity_risk
FROM warehouse_efficiency
ORDER BY capacity_utilization_pct DESC;
