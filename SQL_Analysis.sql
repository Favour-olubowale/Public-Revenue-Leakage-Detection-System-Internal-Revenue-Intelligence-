Total Expected vs Actual Revenue (Leakage Detection)
SELECT 
    t.tax_type_name,
    SUM(a.assessed_amount) AS total_expected,
    SUM(p.amount_paid) AS total_collected,
    (SUM(a.assessed_amount) - SUM(p.amount_paid)) AS revenue_gap
FROM tax_assessments a
JOIN tax_types t ON a.tax_type_id = t.tax_type_id
LEFT JOIN payments p ON a.taxpayer_id = p.taxpayer_id
GROUP BY t.tax_type_name
ORDER BY revenue_gap DESC;
