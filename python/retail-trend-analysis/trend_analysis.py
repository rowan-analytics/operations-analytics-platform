import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

# -----------------------------
# Load Data
# -----------------------------

DATA_PATH = Path(__file__).resolve().parent / "data" / "monthly_orders.csv"

df = pd.read_csv(DATA_PATH)
df["date"] = pd.to_datetime(df["date"])
df = df.sort_values("date")

# -----------------------------
# Create Rolling Trend
# -----------------------------

df["rolling_revenue"] = df["revenue"].rolling(window=3).mean()

# -----------------------------
# Plot Trend
# -----------------------------

plt.figure(figsize=(10, 5))

plt.plot(df["date"], df["revenue"], marker="o", label="Monthly Revenue")
plt.plot(df["date"], df["rolling_revenue"], linestyle="--", label="3-Month Rolling Avg")

plt.title("Revenue Trend & Rolling Average (2024)")
plt.xlabel("Month")
plt.ylabel("Revenue")
plt.legend()
plt.grid(alpha=0.3)

plt.tight_layout()

# Save image for GitHub preview
OUTPUT_PATH = Path(__file__).resolve().parent / "revenue_trend.png"
plt.savefig(OUTPUT_PATH, dpi=300)

plt.show()
