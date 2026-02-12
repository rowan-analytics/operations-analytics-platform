import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

# --- Load data ---
DATA_PATH = Path(__file__).resolve().parents[1] / "data" / "monthly_orders.csv"
df = pd.read_csv(DATA_PATH)
df["date"] = pd.to_datetime(df["date"])
df = df.sort_values("date")

# --- Variance analysis ---
df["mom_change"] = df["order_volume"].diff()
df["mom_pct_change"] = df["order_volume"].pct_change() * 100

# --- Rolling trend ---
df["rolling_3m_avg"] = df["order_volume"].rolling(3).mean()

# --- Chart output folder ---
OUT_DIR = Path(__file__).resolve().parents[1] / "outputs"
OUT_DIR.mkdir(exist_ok=True)

# --- Plot ---
plt.figure(figsize=(10, 5))
plt.plot(df["date"], df["order_volume"], label="Order volume")
plt.plot(df["date"], df["rolling_3m_avg"], label="3-month rolling avg")
plt.title("Order Volume Trend (Monthly)")
plt.xlabel("Date")
plt.ylabel("Order volume")
plt.legend()
plt.tight_layout()

chart_path = OUT_DIR / "order_volume_trend.png"
plt.savefig(chart_path, dpi=200)

# --- Quick insights ---
latest = df.iloc[-1]
print("Key insights:")
print(f"- Latest month order volume: {latest['order_volume']:.0f}")
print(f"- MoM change: {latest['mom_change']:.0f} ({latest['mom_pct_change']:.1f}%)")
print("- Rolling average smooths volatility for planning signals.")
print(f"- Chart saved to: {chart_path}")
