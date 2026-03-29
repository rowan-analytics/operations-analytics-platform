# ============================================
# 01. IMPORT LIBRARIES
# ============================================

import requests
import pandas as pd


# ============================================
# 02. DEFINE API ENDPOINT
# ============================================
# This endpoint returns protocol-level DeFi data

url = "https://api.llama.fi/protocols"


# ============================================
# 03. REQUEST DATA
# ============================================

response = requests.get(url, timeout=30)
response.raise_for_status()
protocols_data = response.json()


# ============================================
# 04. CONVERT TO DATAFRAME
# ============================================

protocols_df = pd.DataFrame(protocols_data)


# ============================================
# 05. SAVE RAW OUTPUT
# ============================================

protocols_df.to_csv("../data/raw/protocols_raw.csv", index=False)


# ============================================
# 06. PREVIEW OUTPUT
# ============================================

print(protocols_df.head())
print(protocols_df.columns.tolist())
print("Saved: ../data/raw/protocols_raw.csv")
