Query 1: Buyer Revenue Segmentation
SELECT
    b.buyer_name,
    b.buyer_type,
    SUM(s.total_sale_value) AS total_revenue_inr,
    CASE
        WHEN SUM(s.total_sale_value) >= 1000000 THEN 'High Value'
        WHEN SUM(s.total_sale_value) >= 500000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS buyer_segment
FROM sales s
JOIN buyers b
    ON s.buyer_id = b.buyer_id
GROUP BY
   b.buyer_name,
   b.buyer_type
ORDER BY total_revenue_inr DESC;


Query 2: Forest Performance Segmentation
SELECT
    f.forest_name,
    SUM(c.collected_quantity_kg) AS total_procurement_kg,
    CASE
        WHEN SUM(c.collected_quantity_kg) >= 50000 THEN 'High Procurement'
        WHEN SUM(c.collected_quantity_kg) >= 25000 THEN 'Medium Procurement'
        ELSE 'Low Procurement'
    END AS forest_segment
FROM forests f
JOIN collection c
    ON f.forest_id = c.forest_id
GROUP BY f.forest_name
ORDER BY total_procurement_kg DESC;


Query 3: Labour Productivity Segmentation
SELECT
    labourer_id,
    labourer_name,
    skill_level,
    years_of_experience,
    daily_wage_inr,
    CASE
        WHEN skill_level = 'Experienced'AND years_of_experience >= 5 THEN 'High Productivity'
        WHEN skill_level = 'Intermediate'OR years_of_experience BETWEEN 2 AND 4 THEN 'Medium Productivity'
        ELSE 'Low Productivity'
    END AS productivity_classification
FROM labourers
WHERE active_status = 'Active'
ORDER BY
    CASE
        WHEN skill_level = 'Experienced' AND years_of_experience >= 5 THEN 1
        WHEN skill_level = 'Intermediate'OR years_of_experience BETWEEN 2 AND 4 THEN 2
        ELSE 3
    END,years_of_experience DESC;


Query 4: Quality Inspection Segmentation
SELECT
    inspection_id,
    collection_id,
    leaf_grade,
    accepted_quantity_kg,
    rejected_quantity_kg,
    moisture_percentage,
    CASE
        WHEN moisture_percentage <= 10
             AND rejected_quantity_kg <= accepted_quantity_kg * 0.05
            THEN 'High Quality'

        WHEN moisture_percentage <= 15
             AND rejected_quantity_kg <= accepted_quantity_kg * 0.15
            THEN 'Medium Quality'

        ELSE 'Low Quality'
    END AS quality_classification
FROM quality_inspection
ORDER BY moisture_percentage ASC;
