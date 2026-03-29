# ============================================
# 01. SELECT TOP PROTOCOLS
# ============================================
# Use the highest TVL protocols as the focus group for historical analysis

top_protocols = (
    protocols_clean
    .sort_values("tvl", ascending=False)
    .head(10)
)


# ============================================
# 02. INITIALISE STORAGE
# ============================================

protocol_history_list = []


# ============================================
# 03. LOOP THROUGH TOP PROTOCOLS
# ============================================
# Pull historical TVL for each protocol using its slug

for _, row in top_protocols.iterrows():
    if "slug" not in row or pd.isna(row["slug"]):
        continue

    slug = row["slug"]
    url = f"https://api.llama.fi/protocol/{slug}"

    try:
        response = requests.get(url, timeout=30)
        response.raise_for_status()
        protocol_data = response.json()

        if "tvl" in protocol_data:
            hist_df = pd.DataFrame(protocol_data["tvl"])
            hist_df["date"] = pd.to_datetime(hist_df["date"], unit="s")
            hist_df["protocol"] = slug
            protocol_history_list.append(hist_df)
            print(f"Downloaded history: {slug}")

    except Exception as e:
        print(f"Failed: {slug} -> {e}")


# ============================================
# 04. COMBINE AND SAVE OUTPUT
# ============================================

protocol_history_df = pd.concat(protocol_history_list, ignore_index=True)
protocol_history_df.to_csv("../data/processed/top_protocols_history.csv", index=False)


# ============================================
# 05. PREVIEW OUTPUT
# ============================================

print(protocol_history_df.head())
print("Saved: ../data/processed/top_protocols_history.csv")
