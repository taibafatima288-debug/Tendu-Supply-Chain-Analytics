Query 1: Data Quality Validation
SELECT 'bundles' AS table_name,
       COUNT(*) AS total_rows,
       COUNT(bundle_id) AS non_null_ids,
       COUNT(DISTINCT bundle_id) AS unique_ids,
       COUNT(*) - COUNT(DISTINCT bundle_id) AS duplicate_or_null_count
FROM bundles

UNION ALL
SELECT 'buyers',
       COUNT(*), COUNT(buyer_id), COUNT(DISTINCT buyer_id),
       COUNT(*) - COUNT(DISTINCT buyer_id)
FROM buyers

UNION ALL
SELECT 'collection',
       COUNT(*), COUNT(collection_id), COUNT(DISTINCT collection_id),
       COUNT(*) - COUNT(DISTINCT collection_id)
FROM collection

UNION ALL
SELECT 'contracts',
       COUNT(*), COUNT(contract_id), COUNT(DISTINCT contract_id),
       COUNT(*) - COUNT(DISTINCT contract_id)
FROM contracts

UNION ALL
SELECT 'expenses',
       COUNT(*), COUNT(expense_id), COUNT(DISTINCT expense_id),
       COUNT(*) - COUNT(DISTINCT expense_id)
FROM expenses

UNION ALL
SELECT 'forests',
       COUNT(*), COUNT(forest_id), COUNT(DISTINCT forest_id),
       COUNT(*) - COUNT(DISTINCT forest_id)
FROM forests

UNION ALL
SELECT 'inventory',
       COUNT(*), COUNT(inventory_id), COUNT(DISTINCT inventory_id),
       COUNT(*) - COUNT(DISTINCT inventory_id)
FROM inventory

UNION ALL
SELECT 'labourers',
       COUNT(*), COUNT(labourer_id), COUNT(DISTINCT labourer_id),
       COUNT(*) - COUNT(DISTINCT labourer_id)
FROM labourers

UNION ALL
SELECT 'payments',
       COUNT(*), COUNT(payment_id), COUNT(DISTINCT payment_id),
       COUNT(*) - COUNT(DISTINCT payment_id)
FROM payments

UNION ALL
SELECT 'quality_inspection',
       COUNT(*), COUNT(inspection_id), COUNT(DISTINCT inspection_id),
       COUNT(*) - COUNT(DISTINCT inspection_id)
FROM quality_inspection

UNION ALL
SELECT 'sales',
       COUNT(*), COUNT(sale_id), COUNT(DISTINCT sale_id),
       COUNT(*) - COUNT(DISTINCT sale_id)
FROM sales

UNION ALL
SELECT 'transportation',
       COUNT(*), COUNT(transport_id), COUNT(DISTINCT transport_id),
       COUNT(*) - COUNT(DISTINCT transport_id)
FROM transportation

UNION ALL
SELECT 'warehouses',
       COUNT(*), COUNT(warehouse_id), COUNT(DISTINCT warehouse_id),
       COUNT(*) - COUNT(DISTINCT warehouse_id)
FROM warehouses;


Query 2: Dats Type and Column Structure Validation
SELECT
    table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

Query 3: Database implementation and Record Count Validation
SELECT
    'forests' AS table_name, COUNT(*) AS records FROM forests
UNION ALL
SELECT 'contracts', COUNT(*) FROM contracts
UNION ALL
SELECT 'labourers', COUNT(*) FROM labourers
UNION ALL
SELECT 'collection', COUNT(*) FROM collection
UNION ALL
SELECT 'quality_inspection', COUNT(*) FROM quality_inspection
UNION ALL
SELECT 'warehouses', COUNT(*) FROM warehouses
UNION ALL
SELECT 'bundles', COUNT(*) FROM bundles
UNION ALL
SELECT 'transportation', COUNT(*) FROM transportation
UNION ALL
SELECT 'inventory', COUNT(*) FROM inventory
UNION ALL
SELECT 'buyers', COUNT(*) FROM buyers
UNION ALL
SELECT 'sales', COUNT(*) FROM sales
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'expenses', COUNT(*) FROM expenses;

Query 4: Primary Key and Duplicate Validation
SELECT 'bundles' AS table_name,
       COUNT(*) AS total_rows,
       COUNT(bundle_id) AS non_null_ids,
       COUNT(DISTINCT bundle_id) AS unique_ids,
       COUNT(*) - COUNT(DISTINCT bundle_id) AS duplicate_or_null_count
FROM bundles

UNION ALL
SELECT 'buyers',
       COUNT(*), COUNT(buyer_id), COUNT(DISTINCT buyer_id),
       COUNT(*) - COUNT(DISTINCT buyer_id)
FROM buyers

UNION ALL
SELECT 'collection',
       COUNT(*), COUNT(collection_id), COUNT(DISTINCT collection_id),
       COUNT(*) - COUNT(DISTINCT collection_id)
FROM collection

UNION ALL
SELECT 'contracts',
       COUNT(*), COUNT(contract_id), COUNT(DISTINCT contract_id),
       COUNT(*) - COUNT(DISTINCT contract_id)
FROM contracts

UNION ALL
SELECT 'expenses',
       COUNT(*), COUNT(expense_id), COUNT(DISTINCT expense_id),
       COUNT(*) - COUNT(DISTINCT expense_id)
FROM expenses

UNION ALL
SELECT 'forests',
       COUNT(*), COUNT(forest_id), COUNT(DISTINCT forest_id),
       COUNT(*) - COUNT(DISTINCT forest_id)
FROM forests

UNION ALL
SELECT 'inventory',
       COUNT(*), COUNT(inventory_id), COUNT(DISTINCT inventory_id),
       COUNT(*) - COUNT(DISTINCT inventory_id)
FROM inventory

UNION ALL
SELECT 'labourers',
       COUNT(*), COUNT(labourer_id), COUNT(DISTINCT labourer_id),
       COUNT(*) - COUNT(DISTINCT labourer_id)
FROM labourers

UNION ALL
SELECT 'payments',
       COUNT(*), COUNT(payment_id), COUNT(DISTINCT payment_id),
       COUNT(*) - COUNT(DISTINCT payment_id)
FROM payments

UNION ALL
SELECT 'quality_inspection',
       COUNT(*), COUNT(inspection_id), COUNT(DISTINCT inspection_id),
       COUNT(*) - COUNT(DISTINCT inspection_id)
FROM quality_inspection

UNION ALL
SELECT 'sales',
       COUNT(*), COUNT(sale_id), COUNT(DISTINCT sale_id),
       COUNT(*) - COUNT(DISTINCT sale_id)
FROM sales

UNION ALL
SELECT 'transportation',
       COUNT(*), COUNT(transport_id), COUNT(DISTINCT transport_id),
       COUNT(*) - COUNT(DISTINCT transport_id)
FROM transportation

UNION ALL
SELECT 'warehouses',
       COUNT(*), COUNT(warehouse_id), COUNT(DISTINCT warehouse_id),
       COUNT(*) - COUNT(DISTINCT warehouse_id)
FROM warehouses;


Query 5: Foreign Key Integrity Check
SELECT 'bundles → quality_inspection' AS relationship,
       COUNT(*) AS orphan_records
FROM bundles b
LEFT JOIN quality_inspection q ON b.inspection_id = q.inspection_id
WHERE b.inspection_id IS NOT NULL AND q.inspection_id IS NULL

UNION ALL
SELECT 'bundles → warehouses',
       COUNT(*)
FROM bundles b
LEFT JOIN warehouses w ON b.warehouse_id = w.warehouse_id
WHERE b.warehouse_id IS NOT NULL AND w.warehouse_id IS NULL

UNION ALL
SELECT 'collection → contracts',
       COUNT(*)
FROM collection c
LEFT JOIN contracts ct ON c.contract_id = ct.contract_id
WHERE c.contract_id IS NOT NULL AND ct.contract_id IS NULL

UNION ALL
SELECT 'collection → forests',
       COUNT(*)
FROM collection c
LEFT JOIN forests f ON c.forest_id = f.forest_id
WHERE c.forest_id IS NOT NULL AND f.forest_id IS NULL

UNION ALL
SELECT 'collection → labourers',
       COUNT(*)
FROM collection c
LEFT JOIN labourers l ON c.labourer_id = l.labourer_id
WHERE c.labourer_id IS NOT NULL AND l.labourer_id IS NULL

UNION ALL
SELECT 'contracts → forests',
       COUNT(*)
FROM contracts c
LEFT JOIN forests f ON c.forest_id = f.forest_id
WHERE c.forest_id IS NOT NULL AND f.forest_id IS NULL

UNION ALL
SELECT 'expenses → contracts',
       COUNT(*)
FROM expenses e
LEFT JOIN contracts c ON e.contract_id = c.contract_id
WHERE e.contract_id IS NOT NULL AND c.contract_id IS NULL

UNION ALL
SELECT 'inventory → bundles',
       COUNT(*)
FROM inventory i
LEFT JOIN bundles b ON i.bundle_id = b.bundle_id
WHERE i.bundle_id IS NOT NULL AND b.bundle_id IS NULL

UNION ALL
SELECT 'inventory → warehouses',
       COUNT(*)
FROM inventory i
LEFT JOIN warehouses w ON i.warehouse_id = w.warehouse_id
WHERE i.warehouse_id IS NOT NULL AND w.warehouse_id IS NULL

UNION ALL
SELECT 'payments → buyers',
       COUNT(*)
FROM payments p
LEFT JOIN buyers b ON p.buyer_id = b.buyer_id
WHERE p.buyer_id IS NOT NULL AND b.buyer_id IS NULL

UNION ALL
SELECT 'payments → sales',
       COUNT(*)
FROM payments p
LEFT JOIN sales s ON p.sale_id = s.sale_id
WHERE p.sale_id IS NOT NULL AND s.sale_id IS NULL

UNION ALL
SELECT 'quality_inspection → collection',
       COUNT(*)
FROM quality_inspection q
LEFT JOIN collection c ON q.collection_id = c.collection_id
WHERE q.collection_id IS NOT NULL AND c.collection_id IS NULL

UNION ALL
SELECT 'sales → bundles',
       COUNT(*)
FROM sales s
LEFT JOIN bundles b ON s.bundle_id = b.bundle_id
WHERE s.bundle_id IS NOT NULL AND b.bundle_id IS NULL

UNION ALL
SELECT 'sales → buyers',
       COUNT(*)
FROM sales s
LEFT JOIN buyers b ON s.buyer_id = b.buyer_id
WHERE s.buyer_id IS NOT NULL AND b.buyer_id IS NULL

UNION ALL
SELECT 'sales → transportation',
       COUNT(*)
FROM sales s
LEFT JOIN transportation t ON s.transport_id = t.transport_id
WHERE s.transport_id IS NOT NULL AND t.transport_id IS NULL

UNION ALL
SELECT 'sales → warehouses',
       COUNT(*)
FROM sales s
LEFT JOIN warehouses w ON s.warehouse_id = w.warehouse_id
WHERE s.warehouse_id IS NOT NULL AND w.warehouse_id IS NULL

UNION ALL
SELECT 'transportation → bundles',
       COUNT(*)
FROM transportation t
LEFT JOIN bundles b ON t.bundle_id = b.bundle_id
WHERE t.bundle_id IS NOT NULL AND b.bundle_id IS NULL

ORDER BY relationship;


Query 6: Transportation Date Integrity Constraint
CREATE TABLE transportation (
    transport_id VARCHAR(10) PRIMARY KEY,
    bundle_id VARCHAR(10) NOT NULL,
    vehicle_id VARCHAR(10) NOT NULL,
    driver_name VARCHAR(100) NOT NULL,
    source_location VARCHAR(100) NOT NULL,
    destination_location VARCHAR(100) NOT NULL,
    dispatch_date DATE NOT NULL,
    arrival_date DATE NOT NULL,
    distance_km INTEGER
        CHECK (distance_km > 0), vehicle_type VARCHAR(30)
        CHECK (vehicle_type IN ('Mini Truck', 'Pickup Van', 'Medium Truck', 'Heavy Truck')), load_weight_kg DECIMAL(6,2)
        CHECK (load_weight_kg > 0), transportation_cost_inr DECIMAL(10,2)
        CHECK (transportation_cost_inr >= 0), fuel_type VARCHAR(20)
        CHECK (fuel_type IN ('Diesel', 'CNG', 'Petrol')),transport_status VARCHAR(20)
        CHECK (transport_status IN ('Delivered', 'In Transit', 'Delayed')),

    FOREIGN KEY (bundle_id)
        REFERENCES bundles(bundle_id),

    CHECK (arrival_date >= dispatch_date));
