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
WITH CardTypeSummary AS (
    SELECT
        `Card Type`,
        COUNT(CustomerId) AS NumberOfCustomers,
        AVG(Balance) AS AverageBalance,
        SUM(Exited) AS TotalChurned
    FROM
        bank.`customer-churn-records`
    GROUP BY
        `Card Type`
)
SELECT
    *,
    (TotalChurned / NumberOfCustomers) AS ChurnRate
FROM
    CardTypeSummary;


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
ORDER BY Geography;
    

# Question 4: How do complaints and satisfaction scores affect churn?
SELECT 
    Complain,
    COUNT(CustomerId) AS TotalCustomers,
    AVG(Exited) AS ChurnRate
FROM
    bank.`customer-churn-records`
GROUP BY Complain;