# Question 1: Who are our most valuable customers?
WITH CustomerScores AS (
    SELECT
        CustomerId,
        Geography,
        NTILE(4) OVER (ORDER BY Balance ASC) AS BalanceScore
    FROM
        bank.`customer-churn-records`
)
SELECT
    Geography,
    BalanceScore,
    COUNT(CustomerId) AS NumberOfCustomers
FROM
    CustomerScores
GROUP BY
    Geography,
    BalanceScore
ORDER BY
    Geography,
    BalanceScore;

# Question 2: What are the characteristics of different credit card type customers?
WITH GroupedMetrics AS (
    SELECT
        `Card Type`,
        COUNT(CustomerId) AS NumberOfCustomers,
        AVG(EstimatedSalary) AS AvgEstimatedSalary,
        AVG(Balance) AS AvgBalance,
        AVG(CreditScore) AS AvgCreditScore,
        AVG(Tenure) AS AvgTenureInYears,
        AVG(NumOfProducts) AS AvgNumOfProducts,
        AVG(IsActiveMember) AS ActiveMembers
    FROM
        bank.`customer-churn-records`
    GROUP BY
        `Card Type`
),
OverallMinMax AS (
    SELECT
        MIN(NumberOfCustomers) AS min_cust, MAX(NumberOfCustomers) AS max_cust,
        MIN(AvgEstimatedSalary) AS min_sal, MAX(AvgEstimatedSalary) AS max_sal,
        MIN(AvgBalance) AS min_bal, MAX(AvgBalance) AS max_bal,
        MIN(AvgCreditScore) AS min_score, MAX(AvgCreditScore) AS max_score,
        MIN(AvgTenureInYears) AS min_ten, MAX(AvgTenureInYears) AS max_ten,
        MIN(AvgNumOfProducts) AS min_prod, MAX(AvgNumOfProducts) AS max_prod,
        MIN(ActiveMembers) AS min_active, MAX(ActiveMembers) AS max_active
    FROM
        GroupedMetrics
)
SELECT
    gm.`Card Type`,
    (gm.NumberOfCustomers - omm.min_cust) / (omm.max_cust - omm.min_cust) AS scaled_Customers,
    (gm.AvgEstimatedSalary - omm.min_sal) / (omm.max_sal - omm.min_sal) AS scaled_Salary,
    (gm.AvgBalance - omm.min_bal) / (omm.max_bal - omm.min_bal) AS scaled_Balance,
    (gm.AvgCreditScore - omm.min_score) / (omm.max_score - omm.min_score) AS scaled_CreditScore,
    (gm.AvgTenureInYears - omm.min_ten) / (omm.max_ten - omm.min_ten) AS scaled_Tenure,
    (gm.AvgNumOfProducts - omm.min_prod) / (omm.max_prod - omm.min_prod) AS scaled_NumOfProducts,
    (gm.ActiveMembers - omm.min_active) / (omm.max_active - omm.min_active) AS scaled_ActiveMembers
FROM
    GroupedMetrics AS gm,
    OverallMinMax AS omm;

# Question 3: What are the main factors causing customer churn?
SELECT 
    Exited,
    COUNT(CustomerId) AS NumberOfCustomers,
    AVG(CreditScore) AS AvgCreditScore,
    AVG(Age) AS AvgAge,
    AVG(Tenure) AS AvgTenure,
    AVG(Balance) AS AvgBalance,
    AVG(NumOfProducts) AS AvgNumOfProducts,
    AVG(IsActiveMember) AS PctActiveMembers,
    AVG(EstimatedSalary) AS AvgEstimatedSalary,
    AVG(complain)
FROM
    bank.`customer-churn-records`
GROUP BY Exited;

SELECT 
    COUNT(CustomerId) AS NumberOfCustomers, Geography, Exited
FROM
    bank.`customer-churn-records`
GROUP BY Geography , Exited
ORDER BY Geography
;


    
# Question 4: How do complaints and satisfaction scores affect churn?
SELECT 
    Complain,
    COUNT(CustomerId) AS TotalCustomers,
    AVG(Exited) AS ChurnRate
FROM
    bank.`customer-churn-records`
GROUP BY Complain;