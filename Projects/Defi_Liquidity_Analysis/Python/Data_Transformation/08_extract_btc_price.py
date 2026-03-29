# ============================================
# 01. IMPORT LIBRARIES
# ============================================

import yfinance as yf
import pandas as pd


# ============================================
# 02. DOWNLOAD BTC PRICE DATA
# ============================================
# Pull daily BTC-USD historical data from Yahoo Finance

btc = yf.download("BTC-USD", start="2019-01-01", interval="1d", auto_adjust=False)


# ============================================
# 03. RESET INDEX
# ============================================
# Move Date out of the index into a normal column

btc = btc.reset_index()


# ============================================
# 04. FLATTEN COLUMNS IF NEEDED
# ============================================
# yfinance can sometimes return a MultiIndex column structure

if isinstance(btc.columns, pd.MultiIndex):
    btc.columns = [col[0] if col[0] else col[1] for col in btc.columns]


# ============================================
# 05. KEEP REQUIRED FIELDS
# ============================================
# Keep only date and closing price for correlation analysis

btc = btc[["Date", "Close"]]
btc.columns = ["date", "btc_price"]


# ============================================
# 06. SAVE RAW OUTPUT
# ============================================

btc.to_csv("../data/raw/btc_price.csv", index=False)


# ============================================
# 07. PREVIEW OUTPUT
# ============================================

print(btc.head())
print(btc.tail())
print("Saved ../data/raw/btc_price.csv")
