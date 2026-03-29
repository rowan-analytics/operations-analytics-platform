# Customer Revenue & Order Distribution Analysis

## Overview

This project focuses on **customer-level revenue distribution and order behaviour**, analysing how value is concentrated across the customer base.

Rather than treating all customers equally, this analysis highlights:

* how revenue is distributed
* which customers drive the most value
* how order frequency relates to revenue
* where concentration risk exists

Built using **Power BI**, this dashboard is designed to support **commercial decision-making, customer segmentation, and performance optimisation**.

---

## Dashboard Preview

![Customer Insights Dashboard](./powerbi/customer_revenue_insights.png)

---

## Key Insight (Executive Summary)

Revenue is highly concentrated among a small number of customers.

* The **largest customer contributes ~15% of total revenue**
* The **top 10 customers generate over 40% of total sales**

This highlights a **high dependency on a small group of high-value customers**, which has important implications for risk and growth strategy.

---

## Detailed Insights

### 1. Strong customer concentration

Revenue is not evenly distributed — a small number of customers dominate total sales.

**Implication:**

* High-value customers are critical to overall performance
* Loss of key customers could significantly impact revenue
* Focus on retention and relationship management is essential

---

### 2. Order volume does not equal customer value

The scatter plot shows that:

* Some customers place many orders but generate moderate revenue
* Others generate high revenue with fewer transactions

**Implication:**

* Customer quality matters more than order count
* Businesses should prioritise **high-value customers**, not just frequent ones

---

### 3. Long-tail customer distribution

The majority of customers fall into a **low order / low revenue segment**, forming a long-tail distribution.

**Implication:**

* Large customer base contributes smaller individual value
* Opportunity to increase value through upselling or bundling
* Marketing strategies can target conversion of mid-tier customers

---

### 4. Top customer dominance

The leading customer significantly outperforms others, with:

* Revenue exceeding **1.4M**
* Significantly higher order contribution compared to peers

**Implication:**

* Heavy reliance on a single or small group of customers
* Potential concentration risk in revenue streams

---

## Dashboard Breakdown

### 🔹 Executive Insight Panel

Provides a high-level summary of customer concentration and revenue distribution.

### 🔹 Customer Orders Distribution

Shows how order volume is distributed across customers, highlighting variability and long-tail behaviour.

### 🔹 Customer Revenue vs Orders (Scatter Plot)

Visualises the relationship between:

* number of orders
* total revenue

Used to identify:

* high-value customers
* high-frequency customers
* outliers

### 🔹 Top Customers by Revenue

Ranks customers by total revenue contribution, helping identify key accounts.

### 🔹 Interactive Filters

* Revenue range filter
* Order range filter

Allows focused analysis on specific customer segments.

---

## Business Relevance

This type of analysis is highly relevant for:

* **E-commerce platforms (Shopee, Lazada)**
* **Marketplace analytics teams**
* **Commercial and growth teams**
* **Customer segmentation and CRM strategy**

It helps businesses:

* identify key revenue drivers
* understand customer concentration risk
* optimise retention strategies
* improve targeting and monetisation

---

## Tools Used

* **Power BI** for dashboard development and visualisation
* **SQL / Python** for data preparation and transformation

---

## Project Structure

```bash
customer-revenue-analysis/
│
├── data/              # Customer transaction datasets
├── sql/               # Data extraction and aggregation queries
├── python/            # Data cleaning and feature engineering
├── powerbi/           # Dashboard files / screenshots
└── README.md
```

---

## Conclusion

This project demonstrates how customer-level data can be transformed into **actionable commercial insights**, showing that:

* revenue is concentrated among a small group of customers
* customer value varies significantly beyond order count
* understanding distribution is critical for business strategy

This type of analysis reflects real-world use cases in **e-commerce and marketplace environments**, where identifying and managing high-value customers is essential for growth and stability.

---

## Why this project is relevant for SG recruiters

This project demonstrates the ability to:

* analyse customer-level data for business insights
* identify key revenue drivers and risks
* translate data into clear, decision-focused insights
* build dashboards aligned with real commercial use cases

This is directly applicable to **Data Analyst, BI Analyst, and Marketplace Analytics roles in Singapore**.
