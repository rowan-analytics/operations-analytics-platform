# DeFi Market Structure: Ethereum Dominance vs Emerging Chains

## Overview

This project analyses **Ethereum’s dominance within DeFi** and how liquidity is shifting toward **alternative (non-ETH) ecosystems** over time.

By focusing on **TVL distribution, dominance ratios, and liquidity rotation**, this dashboard highlights how market structure evolves as capital moves across chains.

Built using **Python, SQL, and Power BI**, this project explores how **capital concentration and diversification trends** shape the DeFi landscape.

---

## Dashboard Preview

![ETH Dominance Dashboard](./powerbi/eth_dominance_dashboard.png)

---

## Objectives

* Measure **Ethereum’s share of total DeFi liquidity**
* Compare **ETH vs Non-ETH capital distribution**
* Track **liquidity rotation across major chains (ex-ETH)**
* Analyse **growth of alternative ecosystems over time**
* Understand how **market structure shifts during different cycles**

---

## Key Insights

* **Ethereum remains dominant (~79% of TVL)**, maintaining strong control over DeFi liquidity
* **Non-ETH ecosystems account for ~21%**, showing gradual but consistent expansion
* **Alternative chains exhibit cyclical growth**, often driven by market narratives and incentives
* **Liquidity rotation across chains is highly volatile**, with sharp inflows followed by rapid declines
* **Non-ETH share has steadily increased over time**, indicating gradual market diversification
* Despite growth elsewhere, **Ethereum remains the core liquidity hub of DeFi**

---

## Dashboard Breakdown

### 🔹 KPI Overview

* ETH Dominance %
* Non-ETH Share %
* ETH TVL
* Non-ETH TVL

### 🔹 Liquidity Rotation (Ex-Ethereum)

* Tracks TVL changes across:

  * Arbitrum
  * Base
  * BSC
  * Solana
* Highlights capital movement between alternative ecosystems

### 🔹 Chain Comparison

* TVL distribution across major chains
* Shows relative size and dominance

### 🔹 Market Share Trend

* Non-ETH share over time
* Identifies long-term diversification trends

---

## Data Pipeline

1. **Data Collection**

   * Sourced from open DeFi datasets (TVL by chain, historical metrics)

2. **Data Cleaning (Python)**

   * Time-series alignment across chains
   * Handling missing or inconsistent data
   * Normalising TVL values

3. **Transformation & Modelling (SQL / Python)**

   * Calculating dominance ratios (ETH vs Non-ETH)
   * Aggregating chain-level TVL
   * Building time-series datasets for trend analysis

4. **Visualisation (Power BI)**

   * Interactive dashboard highlighting dominance and liquidity rotation

---

## Business / Market Relevance

This analysis is useful for:

* **Market Structure Analysis**
  Understanding concentration vs diversification in DeFi

* **Investment Research**
  Identifying growth in alternative ecosystems

* **Risk Assessment**
  Evaluating dependency on Ethereum as a core liquidity hub

* **Quantitative Analysis**
  Studying capital rotation and dominance trends over time

---

## Tech Stack

* Python (Pandas, NumPy, time-series analysis)
* SQL (data modelling and aggregation)
* Power BI (dashboard and visualisation)

---

## Project Structure

```id="rj0dfx"
defi-eth-dominance-analysis/
│
├── data/              # Raw and processed datasets
├── python/            # Data cleaning and analysis
├── sql/               # Queries and transformations
├── powerbi/           # Dashboard files / screenshots
└── README.md
```

---

## Conclusion

This project demonstrates how **DeFi market structure is evolving**, with Ethereum maintaining dominance while **alternative chains gradually gain share**.

By analysing **liquidity distribution, dominance ratios, and capital rotation**, this dashboard provides insight into **how decentralised markets mature over time**.

---

## Author

Built as part of a broader analytics portfolio focused on **financial data, market structure, and quantitative analysis**, combining **SQL, Python, and BI tools** to generate actionable insights.
