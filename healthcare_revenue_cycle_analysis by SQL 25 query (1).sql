#1. Total Claims

SELECT COUNT(*) AS total_claims
FROM healthcare_claims;

#2. Total Unique Patients

SELECT COUNT(DISTINCT patient_id) AS total_patients
FROM healthcare_claims;

#3. Claims by Department

SELECT department, COUNT(*) AS total_claims
FROM healthcare_claims
GROUP BY department
ORDER BY total_claims DESC;

#4. Claims by Insurance Provider

SELECT insurance_provider, COUNT(*) AS total_claims
FROM healthcare_claims
GROUP BY insurance_provider
ORDER BY total_claims DESC;

#5. Monthly Claim Volume

SELECT 
    YEAR(admission_date) AS year,
    MONTH(admission_date) AS month,
    COUNT(*) AS total_claims
FROM healthcare_claims
GROUP BY YEAR(admission_date), MONTH(admission_date)
ORDER BY year, month;


---

#Revenue Analysis

#6. Total Billed Amount

SELECT 
    SUM(billed_amount) AS total_billed_amount
FROM healthcare_claims;

#7. Total Amount Collected

SELECT 
    SUM(amount_collected) AS total_collected
FROM healthcare_claims;

#8. Total Outstanding Amount

SELECT 
    SUM(outstanding_amount) AS total_outstanding
FROM healthcare_claims;

#9. Revenue by Department

SELECT 
    department,
    SUM(billed_amount) AS total_billed,
    SUM(amount_collected) AS total_collected
FROM healthcare_claims
GROUP BY department
ORDER BY total_billed DESC;

#10. Revenue by Insurance Provider

SELECT 
    insurance_provider,
    SUM(billed_amount) AS total_billed,
    SUM(amount_collected) AS total_collected
FROM healthcare_claims
GROUP BY insurance_provider
ORDER BY total_billed DESC;


---

# Claim Denial Analysis

#11. Overall Denial Rate

SELECT
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) * 100.0
    / COUNT(*) AS denial_rate
FROM healthcare_claims;

#12. Denial Rate by Department

SELECT
    department,
    COUNT(*) AS total_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) AS denied_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) * 100.0
        / COUNT(*) AS denial_rate
FROM healthcare_claims
GROUP BY department
ORDER BY denial_rate DESC;

#13. Denial Rate by Insurance Provider

SELECT
    insurance_provider,
    COUNT(*) AS total_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) AS denied_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) * 100.0
        / COUNT(*) AS denial_rate
FROM healthcare_claims
GROUP BY insurance_provider
ORDER BY denial_rate DESC;

#14. Top Claim Denial Reasons

SELECT
    denial_reason,
    COUNT(*) AS denied_claims
FROM healthcare_claims
WHERE claim_status = 'Denied'
GROUP BY denial_reason
ORDER BY denied_claims DESC;

#15. Denial Rate by Claim Type

SELECT
    claim_type,
    COUNT(*) AS total_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) AS denied_claims,
    COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) * 100.0
        / COUNT(*) AS denial_rate
FROM healthcare_claims
GROUP BY claim_type
ORDER BY denial_rate DESC;


#16. Payment Days: Denied vs Paid

SELECT
    claim_status,
    AVG(payment_days) AS avg_payment_days
FROM healthcare_claims
GROUP BY claim_status;


---

#Patient & Operations

#17. Average Length of Stay by Department

SELECT
    department,
    AVG(length_of_stay_days) AS avg_length_of_stay
FROM healthcare_claims
GROUP BY department
ORDER BY avg_length_of_stay DESC;

#18. Readmission Rate by Department

SELECT
    department,
    COUNT(*) AS total_patients,
    COUNT(CASE WHEN readmission_30d = 'Yes' THEN 1 END) AS readmissions,
    COUNT(CASE WHEN readmission_30d = 'Yes' THEN 1 END) * 100.0
        / COUNT(*) AS readmission_rate
FROM healthcare_claims
GROUP BY department
ORDER BY readmission_rate DESC;

#19. Average Payment Days by Insurance

SELECT
    insurance_provider,
    AVG(payment_days) AS avg_payment_days
FROM healthcare_claims
GROUP BY insurance_provider
ORDER BY avg_payment_days DESC;

#20. Patients with Highest Previous Visits

SELECT
    patient_id,
    previous_visits
FROM healthcare_claims
ORDER BY previous_visits DESC
LIMIT 10;

#21. Department with Highest Average Bill

SELECT
    department,
    AVG(billed_amount) AS avg_bill
FROM healthcare_claims
GROUP BY department
ORDER BY avg_bill DESC
LIMIT 1;


---

#⭐ Advanced SQL

#22. CTE — Department Denial Analysis

WITH department_claims AS (
    SELECT
        department,
        COUNT(*) AS total_claims,
        COUNT(CASE WHEN claim_status = 'Denied' THEN 1 END) AS denied_claims
    FROM healthcare_claims
    GROUP BY department
)

SELECT
    department,
    total_claims,
    denied_claims,
    denied_claims * 100.0 / total_claims AS denial_rate
FROM department_claims
ORDER BY denial_rate DESC;

#23. Window Function — Revenue Ranking

SELECT
    department,
    SUM(billed_amount) AS total_revenue,
    RANK() OVER (
        ORDER BY SUM(billed_amount) DESC
    ) AS revenue_rank
FROM healthcare_claims
GROUP BY department;

#24. CASE WHEN — Bill Category

SELECT
    claim_id,
    billed_amount,
    CASE
        WHEN billed_amount < 5000 THEN 'Low'
        WHEN billed_amount < 10000 THEN 'Medium'
        ELSE 'High'
    END AS bill_category
FROM healthcare_claims;

#25. Monthly Revenue & Collection

SELECT
    YEAR(admission_date) AS year,
    MONTH(admission_date) AS month,
    SUM(billed_amount) AS total_billed,
    SUM(amount_collected) AS total_collected,
    SUM(outstanding_amount) AS total_outstanding
FROM healthcare_claims
GROUP BY YEAR(admission_date), MONTH(admission_date)
ORDER BY year, month;
