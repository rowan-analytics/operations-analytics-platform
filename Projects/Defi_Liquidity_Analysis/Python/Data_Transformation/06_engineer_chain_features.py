# ============================================
# 01. CREATE WORKING COPY
# ============================================

chains_clean = chains_df.copy()
chains_clean = chains_clean.sort_values(["chain", "date"]).reset_index(drop=True)


# ============================================
# 02. CALCULATE 1-DAY TVL CHANGE
# ============================================
# Daily absolute and percentage change by chain

chains_clean["tvl_change_1d_usd"] = chains_clean.groupby("chain")["chain_tvl_usd"].diff()
chains_clean["tvl_change_1d_pct"] = chains_clean.groupby("chain")["chain_tvl_usd"].pct_change() * 100


# ============================================
# 03. CALCULATE 7-DAY TVL CHANGE
# ============================================
# Weekly absolute and percentage change by chain

chains_clean["tvl_change_7d_usd"] = (
    chains_clean["chain_tvl_usd"] -
    chains_clean.groupby("chain")["chain_tvl_usd"].shift(7)
)

chains_clean["tvl_change_7d_pct"] = (
    chains_clean["chain_tvl_usd"] /
    chains_clean.groupby("chain")["chain_tvl_usd"].shift(7) - 1
) * 100


# ============================================
# 04. SAVE PROCESSED OUTPUT
# ============================================

chains_clean.to_csv("../data/processed/chains_historical_tvl_clean.csv", index=False)


# ============================================
# 05. PREVIEW OUTPUT
# ============================================

print(chains_clean.head(15))
print("Saved: ../data/processed/chains_historical_tvl_clean.csv")
