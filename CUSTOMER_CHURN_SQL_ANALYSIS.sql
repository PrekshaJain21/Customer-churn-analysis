CREATE DATABASE telco_churn;
USE telco_churn;

CREATE TABLE customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    tenure INT,
    PhoneService VARCHAR(10),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(10),
    PaymentMethod VARCHAR(50),
    MonthlyCharges FLOAT,
    TotalCharges VARCHAR(50),
    Churn VARCHAR(10)
);

SELECT * FROM customer_churn LIMIT 10;
SELECT COUNT(*) FROM customer_churn;

-- Data Cleaning :-
-- Check Missing Values 
SELECT 
    COUNT(*) AS total_rows,
    COUNT(customerID) AS customerID_count,
    COUNT(gender) AS gender_count,
    COUNT(TotalCharges) AS totalcharges_count
FROM customer_churn;

-- Check Blank Values
SELECT 
    COUNT(*) AS blank_totalcharges
FROM customer_churn
WHERE TotalCharges = '';

-- Check Duplicates
SELECT 
    customerID,
    COUNT(*) AS count
FROM customer_churn
GROUP BY customerID
HAVING COUNT(*) > 1;

-- Fix Data Type
SELECT 
    CAST(TotalCharges AS DECIMAL(10,2)) AS TotalCharges_numeric
FROM customer_churn;

-- Total Customers & Churn Count
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained_customers
FROM customer_churn;

-- Calculate Churn Rate
SELECT 
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) * 100.0 / COUNT(*) 
    AS churn_rate_percentage
FROM customer_churn;

-- Churn by Gender 
SELECT 
    gender,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY gender;

-- Churn by Contract Type
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY Contract;

-- Churn by Tenure
SELECT 
    tenure,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY tenure
ORDER BY tenure;

-- Churn by Monthly Charges
SELECT 
    MonthlyCharges,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY MonthlyCharges
ORDER BY MonthlyCharges;

-- Churn by Internet Service
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY InternetService;

-- Churn by Payment Method
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY PaymentMethod;

-- Churn by Tech Support
SELECT 
    TechSupport,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY TechSupport;

-- Churn by Senior Citizen
SELECT 
    SeniorCitizen,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY SeniorCitizen;

-- Churn by Paperless Billing
SELECT 
    PaperlessBilling,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY PaperlessBilling;

-- Customer Segmentation (High vs Low Tenure)
SELECT 
    CASE 
        WHEN tenure <= 12 THEN 'New Customers'
        ELSE 'Loyal Customers'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    COUNT(CASE WHEN Churn = 'Yes' THEN 1 END) AS churned_customers
FROM customer_churn
GROUP BY customer_segment;

-- 