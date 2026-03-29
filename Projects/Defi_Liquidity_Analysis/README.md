# DeFi Liquidity & TVL Analysis

## Overview

This project explores **Decentralized Finance (DeFi) liquidity dynamics** using on-chain data, focusing on how **Total Value Locked (TVL), token flows, and chain activity** evolve over time.

The goal is to move beyond surface-level metrics and identify **how liquidity shifts across ecosystems**, helping explain **market behaviour, capital rotation, and risk conditions**.

This project combines **Python (data analysis), SQL (data structuring), and Power BI (visualisation)** to build a clear, end-to-end analytics workflow.

---

## Objectives

* Analyse **TVL trends across major blockchains**
* Identify **capital inflows and outflows**
* Compare **chain dominance and market share changes**
* Detect **liquidity shifts during different market conditions**
* Translate raw on-chain data into **actionable insights**

---

## Key Insights

* **Liquidity is highly dynamic** — capital frequently rotates between chains rather than remaining static
* **TVL concentration reveals dominance** — a small number of chains consistently control the majority of liquidity
* **Sharp TVL drops often align with market stress**, indicating risk-off behaviour
* **Emerging chains show rapid growth phases**, but often struggle to sustain long-term liquidity
* **Capital flows act as a leading indicator**, often shifting before price movements fully reflect changes

---

## Data Pipeline

1. **Data Collection**

   * Sourced from open DeFi datasets (TVL, chain-level metrics, protocol data)

2. **Data Cleaning & Transformation (Python)**

   * Time-series structuring
   * Handling missing values and inconsistencies
   * Aggregating TVL by chain and date
   * Calculating percentage changes and growth rates

3. **Data Modelling (SQL / Python)**

   * Creating structured datasets for analysis
   * Building derived metrics (e.g. chain dominance, TVL share)

4. **Visualisation (Power BI)**

   * Interactive dashboards showing:

     * TVL trends over time
     * Chain comparisons
     * Liquidity distribution
     * Market share shifts

---

## Dashboard Features

* **TVL Trend Analysis**

  * Track total liquidity over time across chains

* **Chain Comparison**

  * Compare performance and dominance across ecosystems

* **Market Share Breakdown**

  * Identify which chains control the most capital

* **Liquidity Flow Indicators**

  * Highlight periods of inflow and outflow

---

## Business / Market Relevance

Understanding liquidity flows is critical for:

* **Risk Management**
  Identifying when capital is exiting the market

* **Market Analysis**
  Understanding where liquidity is concentrating

* **Investment Decisions**
  Tracking emerging ecosystems and declining ones

* **DeFi Research**
  Analysing how capital behaves in decentralised systems

---

## Tech Stack

* Python (Pandas, NumPy, time-series analysis)
* SQL (data structuring and transformation)
* Power BI (dashboard development and visualisation)

---

## Project Structure

```id="defi-structure"
defi-liquidity-analysis/
│
├── data/              # Raw and processed datasets
├── python/            # Data cleaning and analysis scripts
├── sql/               # Queries and transformations
├── powerbi/           # Dashboard screenshots / files
└── README.md
```

---

## Conclusion

This project demonstrates how **on-chain data can be transformed into meaningful insights**, highlighting the importance of **liquidity movement as a core driver of market behaviour**.

Rather than focusing purely on price, this analysis emphasises **capital flow, structure, and market dynamics**, which are critical for both **data-driven decision making and quantitative research**.

---

## Author

Built as part of a broader analytics portfolio focused on **operations, financial data, and market behaviour**, combining **SQL, Python, and BI tools** to solve real-world analytical problems.
