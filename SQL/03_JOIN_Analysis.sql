Query 1: How is tendu leaf collection distributed across forests?
SELECT
    f.forest_id,
    f.forest_name,
    f.district,
    f.state,
    COUNT(c.collection_id) AS collection_records,
    SUM(c.quantity) AS total_quantity
FROM collection c
INNER JOIN forests f
    ON c.forest_id = f.forest_id
GROUP BY
    f.forest_id,
    f.forest_name,
    f.district,
    f.state
ORDER BY total_quantity DESC;


Query 2: What is the contract value and total expense for each forest?
SELECT
    f.forest_id,
    f.forest_name,
    f.district,
    SUM(c.contract_value_inr) AS total_contract_value_inr,
    SUM(e.amount_inr) AS total_expenses_inr
FROM forests f
INNER JOIN contracts c
    ON f.forest_id = c.forest_id
INNER JOIN expenses e
    ON c.contract_id = e.contract_id
GROUP BY
    f.forest_id,
    f.forest_name,
    f.district
ORDER BY total_expenses_inr DESC;


Query 3: What are the total contract value and actual yield for each forest?
SELECT
    f.forest_id,
    f.forest_name,
    f.district,
    f.state,
    COUNT(c.contract_id) AS total_contracts,
    SUM(c.contract_value_inr) AS total_contract_value_inr,
    SUM(c.actual_yield_kg) AS total_actual_yield_kg
FROM contracts c
INNER JOIN forests f
    ON c.forest_id = f.forest_id
GROUP BY
    f.forest_id,
    f.forest_name,
    f.district,
    f.state
ORDER BY total_contract_value_inr DESC;


Query 4: Which buyers generate the most sales revenue, and which have outstanding  payments?
SELECT
    b.buyer_id,
    b.buyer_name,
    b.buyer_type,
    COUNT(DISTINCT s.sale_id) AS total_orders,
    SUM(s.quantity_sold_kg) AS total_quantity_sold_kg,
    SUM(s.total_sale_value) AS total_revenue_inr,
    COALESCE(SUM(p.amount_paid_inr), 0) AS total_paid_inr,
    SUM(s.total_sale_value)- COALESCE(SUM(p.amount_paid_inr), 0) AS outstanding_amount_inr
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


Query 5: Which forests have the highest accepted quantity and what percentage was rejected?
SELECT
    f.forest_id,
    f.forest_name,
    f.district,
    SUM(q.accepted_quantity_kg) AS total_accepted_kg,
    SUM(q.rejected_quantity_kg) AS total_rejected_kg,
    ROUND( (SUM(q.rejected_quantity_kg) * 100.0) / NULLIF(SUM(q.accepted_quantity_kg) + SUM(q.rejected_quantity_kg), 0), 2 ) 
    AS rejection_percentage,
    ROUND(AVG(q.moisture_percentage), 2) AS avg_moisture_percentage
FROM forests f
INNER JOIN collection c
    ON f.forest_id = c.forest_id
INNER JOIN quality_inspection q
    ON c.collection_id = q.collection_id
GROUP BY
    f.forest_id,
    f.forest_name,
    f.district
ORDER BY rejection_percentage DESC;


Query 6: Which forests have the highest expense-to-contract ratio?
SELECT
    f.forest_id,
    f.forest_name,
    f.district,
    SUM(c.contract_value_inr) AS total_contract_value_inr,
    SUM(e.amount_inr) AS total_expenses_inr,
    ROUND( (SUM(e.amount_inr) / SUM(c.contract_value_inr)) * 100,2) AS expense_percentage
FROM forests f
INNER JOIN contracts c
    ON f.forest_id = c.forest_id
INNER JOIN expenses e
    ON c.contract_id = e.contract_id
GROUP BY
    f.forest_id,
    f.forest_name,
    f.district
ORDER BY expense_percentage DESC;
