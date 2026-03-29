# ============================================
# 01. IMPORT LIBRARIES
# ============================================

import requests
import pandas as pd
import time


# ============================================
# 02. DEFINE CHAINS TO EXTRACT
# ============================================
# These are the major chains used in the analysis

chains = ["ethereum", "arbitrum", "base", "solana", "bsc"]


# ============================================
# 03. INITIALISE STORAGE
# ============================================

all_chain_data = []


# ============================================
# 04. LOOP THROUGH EACH CHAIN
# ============================================
# Pull historical TVL for each chain from DeFiLlama
# Convert timestamps, sort by date, rename columns,
# and append each chain to one master list

for chain in chains:
    url = f"https://api.llama.fi/v2/historicalChainTvl/{chain}"
    response = requests.get(url, timeout=30)
    response.raise_for_status()

    data = response.json()
    temp_df = pd.DataFrame(data)
    temp_df["date"] = pd.to_datetime(temp_df["date"], unit="s")
    temp_df = temp_df.sort_values("date").reset_index(drop=True)
    temp_df = temp_df.rename(columns={"tvl": "chain_tvl_usd"})
    temp_df["chain"] = chain.capitalize()

    all_chain_data.append(temp_df)
    print(f"Downloaded: {chain}")

    # Small pause to avoid hitting the API too quickly
    time.sleep(0.5)


# ============================================
# 05. COMBINE ALL CHAINS
# ============================================

chains_df = pd.concat(all_chain_data, ignore_index=True)


# ============================================
# 06. SAVE RAW OUTPUT
# ============================================

chains_df.to_csv("../data/raw/chains_historical_tvl.csv", index=False)


# ============================================
# 07. PREVIEW OUTPUT
# ============================================

print(chains_df.head())
print("Saved: ../data/raw/chains_historical_tvl.csv")
