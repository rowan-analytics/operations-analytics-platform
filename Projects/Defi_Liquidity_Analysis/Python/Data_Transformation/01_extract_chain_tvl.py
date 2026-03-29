# ============================================
# 01. IMPORT LIBRARIES
# ============================================

import requests
import pandas as pd


# ============================================
# 02. DEFINE API ENDPOINT
# ============================================
# This endpoint returns historical TVL data for Ethereum

url = "https://api.llama.fi/v2/historicalChainTvl/ethereum"


# ============================================
# 03. REQUEST DATA
# ============================================
# Pull JSON data from the API and raise an error if the request fails

response = requests.get(url, timeout=30)
response.raise_for_status()
data = response.json()


# ============================================
# 04. CONVERT TO DATAFRAME
# ============================================
# Convert the JSON response into a pandas DataFrame

df_eth = pd.DataFrame(data)


# ============================================
# 05. CLEAN AND FORMAT DATA
# ============================================
# Convert Unix timestamp to readable datetime
# Sort by date so the time series is in order
# Rename 'tvl' to a clearer analytical column name
# Add a chain label for identification

df_eth["date"] = pd.to_datetime(df_eth["date"], unit="s")
df_eth = df_eth.sort_values("date").reset_index(drop=True)
df_eth = df_eth.rename(columns={"tvl": "chain_tvl_usd"})
df_eth["chain"] = "Ethereum"


# ============================================
# 06. SAVE RAW OUTPUT
# ============================================

df_eth.to_csv("../data/raw/ethereum_historical_tvl.csv", index=False)


# ============================================
# 07. PREVIEW OUTPUT
# ============================================

print(df_eth.head())
print("Saved: ../data/raw/ethereum_historical_tvl.csv")
