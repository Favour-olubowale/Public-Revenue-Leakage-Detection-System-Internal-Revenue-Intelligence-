-- Total Expected vs Actual Revenue
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


-- Taxpayer Compliance Rate
SELECT 
    taxpayer_id,
    COUNT(CASE WHEN payment_status = 'PAID' THEN 1 END) * 1.0 / COUNT(*) AS compliance_rate
FROM tax_assessments
GROUP BY taxpayer_id
ORDER BY compliance_rate ASC;


-- Suspicious Duplicate Taxpayer Detection
SELECT 
    full_name,
    phone_number,
    COUNT(*) AS duplicate_count
FROM taxpayers
GROUP BY full_name, phone_number
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- High-Risk Underpayment Detection
SELECT 
    taxpayer_id,
    assessed_amount,
    amount_paid,
    (assessed_amount - amount_paid) AS underpayment
FROM tax_assessments
WHERE amount_paid < assessed_amount * 0.5
ORDER BY underpayment DESC;


-- Monthly Revenue Collection Performance
SELECT 
    DATE_TRUNC('month', payment_date) AS month,
    SUM(amount_paid) AS total_revenue
FROM payments
GROUP BY month
ORDER BY month;


-- Tax Type Contribution Analysis
SELECT 
    t.tax_type_name,
    SUM(p.amount_paid) AS total_collected
FROM payments p
JOIN tax_assessments a ON p.assessment_id = a.assessment_id
JOIN tax_types t ON a.tax_type_id = t.tax_type_id
GROUP BY t.tax_type_name
ORDER BY total_collected DESC;


-- Enforcement Trigger Identification
SELECT 
    taxpayer_id,
    SUM(assessed_amount - amount_paid) AS total_debt
FROM tax_assessments
GROUP BY taxpayer_id
HAVING SUM(assessed_amount - amount_paid) > 100000
ORDER BY total_debt DESC;
