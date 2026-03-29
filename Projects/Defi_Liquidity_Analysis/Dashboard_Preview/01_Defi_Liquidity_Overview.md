# DeFi Liquidity & Capital Flow Dashboard

## Overview

This project analyses **DeFi liquidity, capital flows, and chain dominance** using on-chain data to understand how capital moves across ecosystems.

Rather than focusing purely on price, this dashboard highlights **Total Value Locked (TVL), liquidity rotation, and capital inflows/outflows**, providing insight into **market structure and behaviour**.

Built using **Python, SQL, and Power BI**, this project demonstrates an end-to-end analytics workflow from raw blockchain data to actionable insights.

---

## Dashboard Preview

![DeFi Dashboard](./powerbi/defi_dashboard.png)

---

## Objectives

* Track **Total Value Locked (TVL)** across major chains
* Analyse **weekly capital flows (7D Flow)**
* Measure **market breadth and protocol performance**
* Identify **liquidity rotation between ecosystems**
* Understand how **capital behaves during different market conditions**

---

## Key Insights

* **Liquidity is actively rotating across chains**, rather than remaining static
* Despite high total TVL (~127B), **short-term flows show contraction (-5.5%)**, indicating potential risk-off behaviour
* **Ethereum dominates liquidity**, maintaining the largest share of capital
* **Capital flows vary significantly across chains**, with some ecosystems experiencing strong inflows while others decline
* **Volatility in TVL growth (30D ROC)** highlights unstable liquidity conditions across DeFi markets
* **Market breadth remains low (~8.7%)**, suggesting limited participation across protocols

---

## Dashboard Breakdown

### 🔹 KPI Overview

* Total Chain TVL
* 7-Day Capital Flow
* Positive Breadth %
* Current Market Value Locked

### 🔹 Liquidity Growth Trends

* 30-day rate of change (ROC) across major chains
* Highlights volatility and trend shifts in liquidity

### 🔹 Chain Dominance

* Comparison of TVL across top ecosystems
* Identifies leading and lagging chains

### 🔹 Capital Flow Table

* Chain-level breakdown of:

  * 7-day inflows/outflows
  * Total liquidity

### 🔹 Liquidity Rotation

* Visualises how capital shifts between chains over time

---

## Data Pipeline

1. **Data Collection**

   * Sourced from open DeFi datasets (TVL, chain metrics, protocol-level data)

2. **Data Cleaning (Python)**

   * Time-series formatting
   * Handling missing values
   * Standardising chain-level data

3. **Transformation & Modelling (SQL / Python)**

   * Aggregating TVL by chain
   * Calculating 7D flows and percentage changes
   * Creating derived metrics (market share, ROC, breadth)

4. **Visualisation (Power BI)**

   * Built interactive dashboard for exploration of liquidity trends and flows

---

## Business / Market Relevance

This analysis is relevant for:

* **Market Analysis**
  Understanding where capital is flowing within DeFi

* **Risk Monitoring**
  Detecting early signs of liquidity contraction

* **Investment Research**
  Identifying emerging or declining ecosystems

* **Quantitative Analysis**
  Studying capital rotation as a leading indicator

---

## Tech Stack

* Python (Pandas, NumPy, time-series analysis)
* SQL (data transformation and structuring)
* Power BI (dashboard and visualisation)

---

## Project Structure

```
defi-liquidity-dashboard/
│
├── data/              # Raw and processed datasets
├── python/            # Data cleaning and analysis
├── sql/               # Queries and transformations
├── powerbi/           # Dashboard files / screenshots
└── README.md
```

---

## Conclusion

This project demonstrates how **on-chain data can be transformed into meaningful insights**, with a focus on **liquidity movement rather than price alone**.

By analysing **capital flows, TVL trends, and ecosystem dominance**, this dashboard provides a clearer view of how **DeFi markets evolve and where capital is concentrating**.

---

## Author

Built as part of a broader analytics portfolio focused on **operations, financial data, and market behaviour**, combining **SQL, Python, and BI tools** to deliver data-driven insights.

