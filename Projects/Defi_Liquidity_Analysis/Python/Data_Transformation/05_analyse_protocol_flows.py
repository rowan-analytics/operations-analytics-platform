# ============================================
# 01. TOP PROTOCOLS BY TVL
# ============================================
# Identify the largest protocols by total value locked

top_tvl = protocols_clean.sort_values("tvl", ascending=False).head(10)
print("Top 10 protocols by TVL")
print(top_tvl[["name", "category", "tvl"]])


# ============================================
# 02. FILTER SMALL PROTOCOLS
# ============================================
# Remove very small protocols to reduce noise in flow analysis

filtered = protocols_clean[protocols_clean["tvl"] >= 10_000_000].copy()


# ============================================
# 03. ANALYSE 7-DAY FLOWS
# ============================================
# Find strongest positive and negative short-term movers

if "change_7d" in filtered.columns:
    print("\nTop 10 7d inflows")
    print(filtered.sort_values("change_7d", ascending=False)[["name", "tvl", "change_7d"]].head(10))

    print("\nTop 10 7d outflows")
    print(filtered.sort_values("change_7d", ascending=True)[["name", "tvl", "change_7d"]].head(10))
