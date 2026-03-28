# DeFi Liquidity & Capital Flow Analysis  
**(Macro-Driven Liquidity, Market Structure & Cross-Chain Capital Rotation)**

This project analyses how **DeFi liquidity behaves as a function of broader crypto market conditions**, with a focus on:

- Macro dependency (BTC-driven cycles)
- Ethereum dominance vs emerging chains
- Short-term capital flows and rotation dynamics

The goal is to answer a key question:

> Is DeFi growth structural, or simply leveraged exposure to crypto markets?

---

## Project Objective (Hedge Fund Lens)

This analysis is framed from a **buy-side perspective**:

- Identify whether DeFi represents **independent alpha** or **market beta**
- Track **capital rotation across chains**
- Distinguish between:
  - Structural growth (adoption)
  - Cyclical growth (risk-on behaviour)

---

## Data Pipeline

### 1. Data Collection & Structuring

- Historical TVL data across multiple chains
- BTC price data as macro benchmark
- Standardised datasets into consistent time-series format

---

### 2. Data Cleaning (Python Approach)

Key steps:

- Normalised date formats across datasets  
- Removed nulls and duplicates  
- Restructured wide → long format for time-series analysis  
- Aligned all data to a consistent daily frequency  
- Engineered features:
  - Daily TVL  
  - % changes (1D, 7D, 30D)  
  - Rolling metrics  

**Result:** clean, analysis-ready dataset with aligned time indices

---

### 3. Data Modelling (Power BI + DAX)

Built analytical measures using DAX:

- Total TVL (market level)
- Chain-level TVL
- ETH vs Non-ETH share
- Rolling 30-day correlation (BTC vs TVL)
- 7-day capital flows
- Market breadth (% of chains growing)

Used DAX for:

- Context-aware aggregation  
- Time intelligence (rolling windows)  
- Share and dominance calculations  

**Result:** dynamic model supporting real-time analytical views

---

## Dashboard Overview

---

### 1. BTC vs DeFi Correlation  
**(Is DeFi independent or market-driven?)**

**Visuals:**
- BTC price vs Total TVL (time series)
- Scatter plot (TVL vs BTC)
- Rolling correlation

**Key Insights:**

- Strong positive correlation between BTC and DeFi TVL  
- Liquidity expands during BTC uptrends (risk-on behaviour)  
- TVL contracts during BTC drawdowns  
- TVL consistently **follows BTC**, not leads  

**Interpretation:**

DeFi currently behaves as **leveraged crypto beta**, not an independent asset class.

---

### 2. Ethereum Dominance vs Emerging Chains  
**(Is market share shifting?)**

**Visuals:**
- ETH dominance vs non-ETH share  
- TVL by chain  
- Ex-ETH liquidity trends  

**Key Insights:**

- Ethereum maintains **dominant share (~70–80%)**  
- Non-ETH share is increasing gradually  
- Growth is **fragmented across multiple chains**  

**Interpretation:**

DeFi is expanding beyond Ethereum, but dominance is **declining slowly, not being disrupted**.

---

### 3. Liquidity & Capital Flow Analysis  
**(Where is capital actually moving?)**

**Visuals:**
- 7-day capital flows  
- Positive breadth (% of chains growing)  
- Chain-level rankings  
- 30-day growth trends  

**Key Insights:**

- Capital flows are **cyclical and volatile**  
- Growth is not broad → low breadth environments  
- Liquidity rotates between chains rather than expanding evenly  

**Interpretation:**

DeFi operates as a **rotation-driven market**, not a uniform growth market.

---

## Core Takeaways

- DeFi liquidity is **strongly driven by BTC and market conditions**
- Ethereum remains the **core liquidity hub**
- Emerging chains are growing, but **not replacing ETH**
- Capital flows are **selective, not broad-based**
- DeFi behaves like:
  > High-beta exposure to crypto markets

---

## Why This Matters (Hedge Fund Perspective)

This framework helps:

- Identify whether opportunities are **structural or cyclical**
- Track **relative strength between chains**
- Understand **capital allocation trends**
- Separate **signal (flows, structure)** from noise (price)

---

## Tools Used

- Power BI (dashboarding & modelling)
- DAX (time-series metrics & KPIs)
- Python-style data cleaning approach
- CSV / Excel (data handling)

---

## What This Project Demonstrates

- Time-series financial analysis  
- Data cleaning and transformation  
- Analytical data modelling (DAX)  
- KPI design aligned with investment thinking  
- Ability to translate data into **clear market insights**

---

## Future Improvements

- Add protocol-level analysis (Uniswap, Aave, etc.)
- Compare L1 vs L2 ecosystems directly
- Introduce ML for regime detection
- Automate data ingestion via APIs

---

## Summary

This project shows:

- DeFi growth is **not independent**
- Liquidity follows **macro crypto cycles**
- Capital rotates **between chains, not evenly into the ecosystem**

From an investment perspective:

> Understanding liquidity flows and structure is more valuable than price alone.

---

## Author

Rowan  
Data Analytics | Markets | DeFi Research  
