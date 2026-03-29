# ============================================
# 01. INITIAL DATA CHECK
# ============================================

print("Shape:", protocols_df.shape)
print("\nColumns:")
for col in protocols_df.columns:
    print(col)


# ============================================
# 02. CREATE WORKING COPY
# ============================================

protocols_clean = protocols_df.copy()


# ============================================
# 03. STANDARDISE COLUMN NAMES
# ============================================
# Convert names to lowercase and replace spaces with underscores

protocols_clean.columns = [
    c.strip().lower().replace(" ", "_") for c in protocols_clean.columns
]


# ============================================
# 04. KEEP RELEVANT COLUMNS ONLY
# ============================================
# Select the fields needed for downstream analysis

wanted_cols = [
    "name", "slug", "category", "chain", "chains",
    "tvl", "change_1d", "change_7d", "change_1m"
]

existing_cols = [c for c in wanted_cols if c in protocols_clean.columns]
protocols_clean = protocols_clean[existing_cols].copy()


# ============================================
# 05. CONVERT NUMERIC FIELDS
# ============================================
# Force key metric columns into numeric format

for col in ["tvl", "change_1d", "change_7d", "change_1m"]:
    if col in protocols_clean.columns:
        protocols_clean[col] = pd.to_numeric(protocols_clean[col], errors="coerce")


# ============================================
# 06. REMOVE INVALID OR MISSING RECORDS
# ============================================
# Keep only rows with valid protocol names and non-negative TVL

if "name" in protocols_clean.columns:
    protocols_clean = protocols_clean[protocols_clean["name"].notna()]

if "tvl" in protocols_clean.columns:
    protocols_clean = protocols_clean[protocols_clean["tvl"].notna()]
    protocols_clean = protocols_clean[protocols_clean["tvl"] >= 0]


# ============================================
# 07. CREATE TVL SIZE BUCKETS
# ============================================
# Group protocols by size to support segmentation analysis

if "tvl" in protocols_clean.columns:
    bins = [-1, 10_000_000, 100_000_000, 1_000_000_000, float("inf")]
    labels = ["<10m", "10m-100m", "100m-1b", ">1b"]
    protocols_clean["tvl_bucket"] = pd.cut(protocols_clean["tvl"], bins=bins, labels=labels)


# ============================================
# 08. SAVE CLEAN OUTPUT
# ============================================

protocols_clean.to_csv("../data/processed/protocols_clean.csv", index=False)


# ============================================
# 09. PREVIEW OUTPUT
# ============================================

print(protocols_clean.head())
print("Saved: ../data/processed/protocols_clean.csv")
