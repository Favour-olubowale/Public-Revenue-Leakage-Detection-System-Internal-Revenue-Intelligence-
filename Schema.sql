-- =========================================
-- DATABASE SCHEMA
-- Public Revenue Leakage Detection System
-- =========================================

-- 1. Taxpayers Table
CREATE TABLE taxpayers (
    taxpayer_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100),
    phone_number VARCHAR(15),
    registration_date DATE,
    tax_region VARCHAR(50)
);

-- 2. Tax Types Table
CREATE TABLE tax_types (
    tax_type_id VARCHAR(10) PRIMARY KEY,
    tax_type_name VARCHAR(50)
);

-- 3. Tax Assessments Table
CREATE TABLE tax_assessments (
    assessment_id VARCHAR(10) PRIMARY KEY,
    taxpayer_id VARCHAR(10),
    tax_type_id VARCHAR(10),
    assessed_amount DECIMAL(15,2),
    assessment_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (taxpayer_id) REFERENCES taxpayers(taxpayer_id),
    FOREIGN KEY (tax_type_id) REFERENCES tax_types(tax_type_id)
);

-- 4. Payments Table
CREATE TABLE payments (
    payment_id VARCHAR(10) PRIMARY KEY,
    assessment_id VARCHAR(10),
    taxpayer_id VARCHAR(10),
    amount_paid DECIMAL(15,2),
    payment_date DATE,
    FOREIGN KEY (assessment_id) REFERENCES tax_assessments(assessment_id),
    FOREIGN KEY (taxpayer_id) REFERENCES taxpayers(taxpayer_id)
);

-- 5. Enforcement Actions Table
CREATE TABLE enforcement_actions (
    action_id VARCHAR(10) PRIMARY KEY,
    taxpayer_id VARCHAR(10),
    action_type VARCHAR(50),
    action_date DATE,
    FOREIGN KEY (taxpayer_id) REFERENCES taxpayers(taxpayer_id)
);
