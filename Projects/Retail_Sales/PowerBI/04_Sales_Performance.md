# Sales Performance Analysis

## Overview

This project analyses **sales performance across countries**, focusing on how revenue and order volume are distributed geographically.

The dashboard is designed to answer key commercial questions:

* Which markets generate the most revenue?
* How does order volume vary by country?
* Where is revenue concentrated?
* How does customer value differ across regions?

Built using **Power BI**, this project reflects real-world **e-commerce and marketplace analytics**, similar to platforms such as Shopee.

---

## Dashboard Preview

![Sales Performance Dashboard](./powerbi/sales_performance_dashboard.png)

---

## Key Metrics

* **Total Orders:** 26K
* **Average Revenue per Country:** 256.52K

These provide a high-level view of global performance and market distribution.

---

## Key Insights

### 1. Revenue is heavily concentrated in a single market

The **United Kingdom dominates both revenue and units sold**, significantly outperforming all other countries.

**Implication:**

* strong reliance on one primary market
* geographic concentration risk
* business performance is highly dependent on UK demand

---

### 2. Other markets contribute significantly less

Most other countries generate relatively **moderate to low sales volumes and revenue** compared to the UK.

**Implication:**

* growth opportunity in underpenetrated markets
* current expansion outside core market is limited
* potential to scale internationally

---

### 3. Clear gap between top and mid-tier markets

There is a visible separation between:

* the leading market (UK)
* mid-tier European markets
* smaller long-tail markets

**Implication:**

* markets can be segmented into tiers:

  * primary (core revenue driver)
  * secondary (growth opportunities)
  * long-tail (low contribution)

---

### 4. Revenue and volume are positively correlated

The scatter plot shows a strong relationship between:

* units sold
* revenue per country

**Implication:**

* higher volume markets tend to generate higher revenue
* demand scale is a key driver of performance
* however, further analysis could explore differences in pricing or order value

---

### 5. Average order value varies across countries

The bar chart shows significant variation in **average revenue per order across regions**.

For example:

* some countries generate higher value per transaction
* others rely on higher volume but lower value

**Implication:**

* pricing and purchasing behaviour differ by market
* localisation strategies may be required
* useful for:

  * pricing optimisation
  * marketing strategy
  * regional targeting

---

## Dashboard Breakdown

### 🔹 KPI Overview

* Total orders
* Average revenue per country

Provides a quick snapshot of global performance.

---

### 🔹 Monthly Sales Table

Displays:

* monthly orders
* monthly revenue

Used to track performance over time and identify trends.

---

### 🔹 Average Order Value by Country

Bar chart comparing revenue per order across countries.

Used to:

* understand regional purchasing behaviour
* identify high-value markets

---

### 🔹 Revenue vs Units Sold (Scatter Plot)

Visualises:

* units sold
* revenue by country

Used to:

* compare market performance
* identify outliers
* understand scale vs value

---

### 🔹 Country Filters

Interactive filtering allows analysis of specific regions or markets.

---

## Business Relevance

This analysis is highly relevant for:

* **E-commerce platforms (Shopee, Lazada)**
* **Marketplace expansion teams**
* **Commercial and growth analytics**
* **Regional performance analysis**

It helps businesses:

* identify core and emerging markets
* assess geographic concentration risk
* optimise expansion strategies
* tailor pricing and marketing by region

---

## Tools Used

* **Power BI** for dashboard development and visualisation
* **SQL / Python** for data preparation and transformation

---

## Project Structure

```bash id="6h8k2m"
sales-performance-analysis/
│
├── data/              # Sales datasets with country-level information
├── sql/               # Data extraction and aggregation queries
├── python/            # Data cleaning and feature engineering
├── powerbi/           # Dashboard files / screenshots
└── README.md
```

---

## Conclusion

This project demonstrates how geographic sales data can be transformed into **actionable business insights**, showing that:

* revenue is highly concentrated in a single market
* other regions present growth opportunities
* market behaviour varies significantly across countries

This reflects real-world use cases in **global e-commerce and marketplace environments**, where understanding regional performance is critical for scaling.

---

## Why this project is relevant for SG recruiters

This project demonstrates the ability to:

* analyse geographic performance and market distribution
* identify revenue concentration and growth opportunities
* translate data into commercial insights
* build dashboards aligned with real business use cases

This is directly applicable to **Data Analyst, BI Analyst, and Marketplace Analytics roles in Singapore**.
