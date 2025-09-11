# Bank Customer Churn Analysis & Prediction

---

## Project Overview

This end-to-end data science project analyzes a decade's worth of customer data from a bank to identify key drivers of customer churn. The project involves comprehensive data processing with **SQL**, interactive dashboard creation with **Tableau**, and the development of a predictive machine learning model with **Python** to identify customers at high risk of leaving the bank.

* **Live Dashboard:** [**View the Interactive Churn Dashboard on Tableau Public**](https://public.tableau.com/app/profile/chun.kit.lai2955/viz/bank_17575264080150/Dashboard1?publish=yes)

---

## Tools & Technologies

* **Data Transformation & Analysis:** MySQL
* **Data Visualization:** Tableau
* **Predictive Modeling:** Python (Libraries: Pandas, Scikit-learn, Matplotlib)
* **IDE:** Jupyter Notebook, MySQL Workbench

---

## Data Source

The primary data used for this project is the `Customer-Churn-Records.csv` file, sourced from Kaggle. This file contains 10,000 records of the bank's customers. The additional CSV files in the `/data` folder are aggregated datasets exported from the SQL analysis, created specifically for the Tableau visualizations.

* **Link:** [Bank Customer Churn Dataset on Kaggle](https://www.kaggle.com/datasets/radheshyamkollipara/bank-customer-churn)

---

## Project Workflow

### 1. Database Analysis with SQL

I used MySQL to perform initial data exploration, cleaning, and aggregation. The SQL scripts answer key business questions and create focused datasets for visualization in Tableau.

**Key Questions Addressed:**

1.  **Customer Value:** Who are our most valuable customers based on geography and account balance?
2.  **Card Type Analysis:** Is there a significant difference in average balance or churn rate among customers with different card types?
3.  **Churn Drivers:** What are the main factors and average customer profiles associated with churn?
4.  **Complaint Impact:** How do customer complaints and satisfaction scores affect the churn rate?

### 2. Interactive Dashboard with Tableau

I created an interactive dashboard in Tableau to visually present the findings from the SQL analysis. The dashboard allows stakeholders to easily explore the factors contributing to customer churn.

**Dashboard Components:**

* KPIs for overall churn rate and customer counts.
* Geographic distribution of churned vs. existing customers.
* Breakdowns by key demographics (Age, Balance, Active Member status).
* A critical analysis showing the powerful correlation between customer complaints and churn.

### 3. Predictive Modeling with Python

To move from analysis to prediction, I built a **Logistic Regression** model using Python and Scikit-learn. The goal was to predict the likelihood of a customer churning based on their attributes.

**Process:**

1.  **Data Preprocessing:** Handled categorical variables using one-hot encoding.
2.  **Feature Engineering & Handling Target Leakage:** A key finding was that the `Complain` feature is a source of **target leakage**. Including it boosted model accuracy to over 99%. However, this is because a complaint is an event that happens *concurrently* with churning, not a predictor of a future event. To build a model that provides actionable, *proactive* insights, the `Complain` feature was deliberately excluded from the final feature set.
3.  **Feature Scaling:** Standardized numerical features to ensure model performance.
4.  **Model Training:** Trained a logistic regression classifier on 80% of the data.
5.  **Model Evaluation:** Achieved an **accuracy of 81.05%** on the unseen 20% test set. This score reflects a realistic and actionable model, as it predicts churn without relying on information that would only be available after the customer has already decided to leave.

---

## Key Insights & Business Recommendations

* **Insight 1: Complaints are a Critical Churn Signal.**
    * The analysis revealed that **99.5% of customers who make a complaint end up leaving the bank**. This is the single most significant indicator of churn.
    * **Recommendation:** Implement an immediate, high-priority response protocol for all customer complaints. Each complaint should be assigned to a dedicated retention specialist to resolve the issue and prevent churn.

* **Insight 2: Specific Segments Are High-Risk.**
    * Customers in **Germany**, **middle-aged customers (40-60)**, and **inactive members** show a significantly higher tendency to churn.
    * **Recommendation:** Proactively target these high-risk segments with tailored retention campaigns. Offer incentives for inactive members to re-engage and conduct market research to understand the specific pain points for German customers.

* **Insight 3: The Predictive Model Provides Actionable Intelligence.**
    * The Python model can successfully identify at-risk customers with **81.05% accuracy**, *without* using post-churn indicators like complaints. This makes it a powerful tool for proactive intervention.
    * **Recommendation:** Deploy the model to generate a weekly or monthly list of customers with the highest churn probability. This allows the retention team to engage these customers with preventative offers and support *before* they decide to leave, reducing churn and protecting revenue.

---

## How to Use This Repository

1.  **Database Setup:**
    * Set up a MySQL server.
    * Create a database (e.g., `bank`).
    * Import the `Customer-Churn-Records.csv` file (located in the `/data` folder) into a table.

2.  **SQL Analysis:**
    * Run the queries in `bank.sql` against your database to perform the analysis.

3.  **Tableau Dashboard:**
    * The data exports from the SQL queries can be used to recreate the dashboard in Tableau.
    * Alternatively, view the live dashboard [here](https://public.tableau.com/app/profile/chun.kit.lai2955/viz/bank_17575264080150/Dashboard1?publish=yes).

4.  **Predictive Model:**
    * Ensure you have Python and the required libraries (`pandas`, `scikit-learn`) installed.
    * Open and run the `Churn_Analysis.ipynb` Jupyter Notebook to see the model-building process and results.
