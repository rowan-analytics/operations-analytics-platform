# Retail Sales Performance Dashboard

## Overview

This project analyses **retail sales performance, customer value, and product contribution** using **Power BI** to turn transaction-level data into clear commercial insights.

The dashboard focuses on the key questions a business would care about:

* How is revenue trending over time?
* Which products drive the most sales?
* Which customers contribute the most value?
* What does order behaviour say about commercial performance?

Built as part of an analytics portfolio using **SQL, Python, Excel, and Power BI**, this project demonstrates how raw sales data can be transformed into a dashboard designed for **decision-making and performance monitoring**.

---

## Dashboard Preview

![Retail Sales Dashboard](./powerbi/retail_sales_executive_overview.png)

---

## Key Metrics

* **Total Revenue:** 9.75M
* **Total Orders:** 26K
* **Total Customers:** 4K
* **Average Order Value:** 376.36

These KPIs provide a high-level commercial snapshot and support fast performance tracking at management level.

---

## Key Insights

### 1. Revenue shows strong late-period acceleration

Monthly revenue trends remain relatively stable in the earlier months before rising sharply from **September onward**, with the strongest performance visible in **November**.

**What this suggests:**

* stronger seasonal demand
* improved sales momentum in later periods
* potential promotional or peak-season effects driving revenue expansion

---

### 2. Revenue is concentrated in a small number of products

A small group of products generates a disproportionate share of revenue, led by top-performing items such as:

* DOTCOM POSTAGE
* REGENCY CAKES
* WHITE HANGING HEART
* PARTY BUNTING

**What this suggests:**

* sales performance is highly influenced by a concentrated top-product mix
* leading SKUs have outsized commercial importance
* inventory and promotion decisions should prioritise top revenue drivers

---

### 3. Customer value is unevenly distributed

The customer table shows a clear concentration in revenue contribution, with a small set of customers generating significantly more value than others.

For example, the top customer contributes **1.45M+** in revenue, well above the rest of the customer base.

**What this suggests:**

* high-value customer segmentation is important
* customer concentration risk may exist
* loyalty, retention, and relationship management strategies could materially affect performance

---

### 4. Average order value supports strong basket economics

An **average order value of 376.36** indicates relatively strong revenue generated per transaction.

**What this suggests:**

* basket size is commercially healthy
* upselling and bundling strategies may already be effective
* future analysis could explore which products or customer groups drive higher order values

---

### 5. Orders alone do not explain customer value

Some customers generate high order counts but not necessarily the highest revenue, while others produce strong revenue from fewer transactions.

**What this suggests:**

* customer quality matters more than pure order volume
* combining order frequency with revenue value gives a better view of customer performance
* useful next steps would include RFM segmentation or cohort analysis

---

## Dashboard Breakdown

### KPI Cards

The top row provides an executive overview of the most important business metrics:

* Total revenue
* Total orders
* Total customers
* Average order value

These support quick monitoring and fast performance reviews.

### Monthly Revenue Trend

A time-series line chart showing how revenue changes by month.

This is useful for:

* trend analysis
* seasonality detection
* commercial performance tracking over time

### Top Products by Revenue

A ranked bar chart showing the highest revenue-generating products.

This is useful for:

* product prioritisation
* inventory focus
* identifying core revenue drivers

### Top Customers Table

A detailed customer-level breakdown showing:

* customer ID
* total orders
* total revenue

This is useful for:

* identifying high-value customers
* assessing customer concentration
* supporting retention strategy

---

## Business Relevance

This type of dashboard is highly relevant for roles involving:

* **Business Intelligence**
* **Commercial Analytics**
* **Operations Analytics**
* **Marketplace Performance Analysis**
* **E-commerce Reporting**

For Singapore companies such as **Shopee**, this kind of analysis is useful because it helps teams monitor:

* revenue growth
* product performance
* customer concentration
* seasonal demand patterns
* commercial decision-making

---

## Tools Used

* **Power BI** for dashboard development and visualisation
* **SQL** for querying and preparing structured sales data
* **Python / Excel** for cleaning, transformation, and exploratory analysis

---

## Project Structure

```bash
retail-sales-performance-dashboard/
│
├── data/              # Raw and cleaned sales datasets
├── sql/               # SQL queries and transformations
├── python/            # Data cleaning / analysis scripts
├── powerbi/           # Dashboard screenshots / PBIX file
└── README.md
```

---

## Conclusion

This dashboard demonstrates how retail transaction data can be transformed into a **clear executive performance view**, moving beyond simple reporting to highlight:

* where revenue is growing
* which products matter most
* which customers drive value
* where commercial focus should sit

It reflects the type of analysis used in **e-commerce, retail, and marketplace environments**, where strong data visibility supports better business decisions.

---

## Why this project is relevant for SG recruiters

This project demonstrates practical capability in:

* turning raw sales data into structured reporting
* identifying commercial trends and revenue drivers
* presenting insights clearly for business stakeholders
* using BI tools to support operational and strategic decisions

This is especially relevant for **data analyst, BI analyst, commercial analyst, and marketplace analytics roles in Singapore**.

