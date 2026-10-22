import streamlit as st
import pandas as pd
import joblib
import requests
import os

st.set_page_config(
    page_title="Healthcare Claim Prediction",
    page_icon="🏥",
    layout="centered"
)

# ---------- Custom Design ----------
st.markdown("""
<style>
    .main-title {
        font-size: 34px;
        font-weight: 800;
        color: #176B5B;
        text-align: center;
    }
    .subtitle {
        text-align: center;
        color: #666666;
        margin-bottom: 25px;
    }
    .creator {
        position: fixed;
        bottom: 12px;
        right: 20px;
        color: #176B5B;
        font-size: 12px;
        font-weight: 600;
        background: rgba(255,255,255,0.9);
        padding: 6px 10px;
        border-radius: 8px;
        z-index: 999;
    }
</style>
<div class="creator">Created by Mohsin Saifi</div>
""", unsafe_allow_html=True)

st.markdown(
    '<div class="main-title">🏥 Healthcare Claim Status Prediction</div>',
    unsafe_allow_html=True
)
st.markdown(
    '<div class="subtitle">AI-powered claim status prediction</div>',
    unsafe_allow_html=True
)

# ---------- Optimized RAM-Safe Model Loading ----------
@st.cache_resource
def load_model():
    url = "https://huggingface.co/mohsinsaifi123/healthcare-claim-model/resolve/main/random_forest_model_compressed.pkl?download=true"
    local_filename = "random_forest_model_compressed.pkl"
    
    # Agar file pehle se downloaded nahi hai toh chunks mein download karein
    if not os.path.exists(local_filename):
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            with open(local_filename, 'wb') as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)
                    
    # mmap_mode='r' RAM usage ko bahut kam kar deta hai (prevents crashing)
    return joblib.load(local_filename, mmap_mode='r')

try:
    with st.spinner("⏳ Loading AI Model safely... Please wait..."):
        model = load_model()
except Exception as e:
    st.error("❌ Model load nahi ho pa raha hai.")
    st.exception(e)
    st.stop()

# ---------- Input Form ----------
with st.form("claim_form"):
    st.subheader("📋 Claim Details")

    submission_delay_days = st.number_input(
        "Submission Delay (Days)",
        min_value=-100,
        max_value=365,
        value=0
    )

    followup_required = st.selectbox(
        "Follow-up Required?",
        [0, 1],
        format_func=lambda x: "Yes" if x == 1 else "No"
    )

    collection_rate_pct = st.number_input(
        "Collection Rate (%)",
        min_value=0.0,
        max_value=100.0,
        value=50.0
    )

    city = st.selectbox(
        "City",
        ["Bijnor", "Chandigarh", "Dehradun", "Delhi",
         "Gurugram", "Jaipur", "Lucknow", "Meerut", "Noida"]
    )

    insurance = st.selectbox(
        "Insurance Provider",
        ["Medicaid", "Medicare", "Private", "Self-Pay"]
    )

    department = st.selectbox(
        "Department",
        ["Emergency", "Gastroenterology", "General Medicine",
         "Gynecology", "Neurology", "Oncology", "Orthopedics",
         "Pediatrics", "Pulmonology"]
    )

    diagnosis = st.selectbox(
        "Diagnosis",
        ["Arthritis", "Asthma", "Back Pain", "Breast Cancer",
         "Bronchitis", "COPD", "Chest Pain", "Colon Cancer",
         "Coronary Artery Disease", "Diabetes",
         "Digestive Disorder", "Endometriosis", "Epilepsy",
         "Fever", "Fracture", "GERD", "Gastritis",
         "Gastroenteritis", "Gynecological Infection",
         "Heart Failure", "Hypertension", "IBS", "Infection",
         "Injury", "Joint Disorder", "Liver Disorder",
         "Lung Cancer", "Lymphoma", "Migraine", "Neuropathy",
         "PCOS", "Pneumonia", "Pregnancy",
         "Respiratory Distress", "Stroke"]
    )

    claim_type = st.selectbox(
        "Claim Type",
        ["Inpatient", "Outpatient"]
    )

    submitted = st.form_submit_button(
        "🔍 Predict Claim Status",
        use_container_width=True
    )

# ---------- Prediction ----------
if submitted:
    try:
        input_data = {
            "submission_delay_days": submission_delay_days,
            "followup_required": followup_required,
            "collection_rate_pct": collection_rate_pct
        }

        for col in model.feature_names_in_:
            if col not in input_data:
                input_data[col] = 0

        selected_categories = [
            f"city_{city}",
            f"insurance_provider_{insurance}",
            f"department_{department}",
            f"diagnosis_{diagnosis}",
            f"claim_type_{claim_type}"
        ]

        for col in selected_categories:
            if col in input_data:
                input_data[col] = 1

        input_df = pd.DataFrame(
            [input_data],
            columns=model.feature_names_in_
        )

        prediction = model.predict(input_df)[0]

        st.divider()
        st.subheader("📊 Prediction Result")

        if prediction == 0:
            st.error("❌ Prediction: Claim Denied")
        elif prediction == 1:
            st.success("✅ Prediction: Claim Paid")
        else:
            st.warning(f"Predicted class: {prediction}")

        if hasattr(model, "predict_proba"):
            probabilities = model.predict_proba(input_df)[0]

            st.write("### Prediction Probabilities")

            for cls, prob in zip(model.classes_, probabilities):
                if cls == 0:
                    label = "Claim Denied"
                elif cls == 1:
                    label = "Claim Paid"
                else:
                    label = f"Class {cls}"

                st.write(f"**{label}: {prob:.2%}**")

    except Exception as e:
        st.error("Prediction mein error aaya.")
        st.exception(e)
