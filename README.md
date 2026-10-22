Healthcare Revenue Cycle & Claim Denial Analytics

An end-to-end healthcare analytics project combining SQL, Python, Power BI, and Machine Learning to analyze insurance claim denials, revenue collection, outstanding balances, and claim status prediction.

🔗 Live Application

"Open Healthcare Claim Prediction App" (https://mohsinsaifi123-healthcare-claim-model.onrender.com)   

📌 Business Problem

Healthcare providers depend on timely insurance reimbursements to maintain healthy cash flow and efficient revenue cycle operations. Claim denials, delayed payments, outstanding balances, and billing or documentation issues can slow down collections and increase administrative workload.

The business needs better visibility into where claim denials occur, which claim categories and departments require attention, and which claims may need early review.

This project uses healthcare claims data to analyze revenue cycle performance and demonstrate how analytics and machine learning can support more proactive claim management.

🎯 Project Objectives

- Analyze claim volumes, statuses, and denial patterns.
- Identify departments, insurance providers, and claim types with higher denial rates.
- Examine billed amounts, collected revenue, outstanding balances, and payment days.
- Explore common denial reasons and operational trends.
- Build a machine learning model to predict claim status.
- Present insights through a Power BI dashboard and an interactive Streamlit application.

🔍 Key Business Questions

1. What is the overall claim denial rate?
2. Which departments and insurance providers have higher denial rates?
3. What are the most frequent claim denial reasons?
4. Which claim types require closer monitoring?
5. How much revenue has been billed, collected, and left outstanding?
6. How do payment days vary by claim status and insurance provider?
7. Can machine learning help flag claims for earlier review?

💼 Business Impact

The analysis is designed to help healthcare revenue cycle teams:

- Identify claim categories that may need additional review.
- Prioritize follow-up on potentially high-risk claims.
- Investigate recurring denial patterns.
- Monitor outstanding balances and collection performance.
- Improve visibility into department and payer performance.
- Support data-driven decisions about claim processing workflows.

Actual financial savings and denial reduction must be validated using operational results; they are not assumed from model accuracy alone.

💡 Recommendations

- Review departments and claim types with the highest observed denial rates.
- Use verified denial reasons to create documentation, eligibility, coding, and authorization checks.
- Monitor payer-level denial rates, payment delays, and outstanding balances.
- Use model predictions as a prioritization aid, with human review before action.
- Track denial rate, first-pass acceptance rate, average payment days, and outstanding balances over time.
- Reassess model performance on new, representative claim data before operational use.

🛠️ Tools & Technologies

- SQL: Business queries, denial analysis, revenue analysis, aggregations, CTEs, and window functions.
- Python: Data cleaning, exploratory data analysis, and model evaluation.
- Pandas: Data manipulation and preparation.
- Scikit-learn: Random Forest classification.
- Power BI: Healthcare revenue cycle analytics dashboard.
- Streamlit: Interactive claim status prediction application.
- GitHub: Project version control and code repository.
- Render: Web application deployment.

🤖 Machine Learning

A Random Forest classification model is used to predict claim status based on the features provided to the application.

The model was simplified to reduce its deployment footprint. The reported test accuracy during development was approximately 94%. This is a development result, not a guarantee of real-world performance.

Model performance should also be assessed using precision, recall, F1-score, confusion matrix, and validation on representative unseen data. The meaning of each target class must be confirmed before interpreting class-specific results.

📂 Project Files

- "app.py" — Streamlit prediction application
- "random_forest_light.pkl" — Lightweight trained Random Forest model
- "requirements.txt" — Python dependencies
- "healthcare_project (1).ipynb" — Python analysis and model development
- "healthcare_revenue_cycle_analysis by SQL 25 query (1).sql" — SQL business analysis queries
- "healthcare_revenue_cycle_analytics_100000 (1).csv" — Healthcare claims dataset
- "Healthcare_Analytics_Dashboard.pdf" — Dashboard export

⚠️ Data Disclaimer

This is a portfolio project using a project dataset. Confirm the dataset's provenance before treating it as real operational or patient data. Model predictions are for analytical demonstration and should not replace professional claim review or payer rules.

🚀 How to Run Locally

1. Clone or download this repository.

2. Install the dependencies:
   
   pip install -r requirements.txt

3. Run the Streamlit application:
   
   streamlit run app.py

👤 Author

Mohsin Saifi

Aspiring Data Analyst | SQL | Python | Power BI | Machine Learning
