# Product Performance & Revenue Concentration Analysis

## Overview

This project analyses **product-level sales performance**, focusing on how revenue is distributed across products and how unit sales translate into commercial value.

The goal is to move beyond simple totals and understand:

* which products drive the most revenue
* how sales volume relates to profitability
* whether revenue is diversified or concentrated
* where commercial focus should be prioritised

Built using **Power BI**, this dashboard reflects real-world **e-commerce and marketplace analytics use cases**, similar to platforms such as Shopee.

---

## Dashboard Preview

![Product Analysis Dashboard](./powerbi/product_analysis_dashboard.png)

---

## Key Metrics

* **Total Product Revenue:** 1.35M
* **Total Units Sold:** 337K
* **Average Revenue per Product:** 67.48K

These provide a high-level view of overall product performance and sales scale.

---

## Key Insights

### 1. Revenue is highly concentrated in a small number of products

A small group of products generates a disproportionately large share of total revenue.

Top-performing products include:

* DOTCOM POSTAGE
* REGENCY CAKESTAND
* WHITE HANGING HEART
* PARTY BUNTING

**Implication:**

* revenue is driven by a limited product set
* product concentration risk exists
* business performance depends heavily on top SKUs

---

### 2. High unit sales do not always translate to highest revenue

The scatter plot shows that:

* some products sell large volumes but generate moderate revenue
* others generate strong revenue with fewer units sold

**Implication:**

* pricing and product mix matter as much as volume
* high-volume products are not always the most valuable
* margin analysis would be a valuable next step

---

### 3. Long-tail product distribution

Most products contribute relatively small amounts of revenue individually, forming a **long-tail distribution**.

**Implication:**

* large product catalogue with uneven performance
* opportunity to optimise:

  * product assortment
  * promotions
  * bundling strategies

---

### 4. Clear separation between top-tier and mid-tier products

There is a visible gap between the highest-performing products and the rest of the catalogue.

**Implication:**

* products can be segmented into tiers:

  * top performers
  * mid-tier contributors
  * long-tail products
* targeted strategies can be applied to each segment

---

### 5. Unit economics vary significantly across products

Products with similar unit sales can generate very different revenue levels.

**Implication:**

* pricing strategy plays a key role
* revenue per unit varies across products
* useful for:

  * pricing optimisation
  * promotion planning
  * inventory decisions

---

## Dashboard Breakdown

### 🔹 KPI Overview

* Total revenue
* Total units sold
* Average revenue per product

Provides a quick snapshot of product performance.

---

### 🔹 Products Revenue Distribution

Shows how revenue and unit sales are spread across products.

Used to:

* identify top-performing SKUs
* understand distribution patterns

---

### 🔹 Product Revenue vs Units Sold (Scatter Plot)

Visualises relationship between:

* units sold
* revenue generated

Used to:

* identify high-value products
* detect outliers
* compare product performance

---

### 🔹 Product Table

Detailed breakdown of:

* product description
* total revenue
* units sold

Used for:

* ranking products
* deeper analysis
* operational decision-making

---

## Business Relevance

This analysis is highly relevant for:

* **E-commerce platforms (Shopee, Lazada)**
* **Marketplace analytics teams**
* **Commercial and merchandising teams**
* **Operations and inventory planning**

It helps businesses:

* identify top-performing products
* understand revenue concentration
* optimise pricing and product strategy
* improve inventory and assortment decisions

---

## Tools Used

* **Power BI** for dashboard development and visualisation
* **SQL / Python** for data preparation and transformation

---

## Project Structure

```bash
product-performance-analysis/
│
├── data/              # Product-level sales datasets
├── sql/               # Data extraction and aggregation queries
├── python/            # Data cleaning and feature engineering
├── powerbi/           # Dashboard files / screenshots
└── README.md
```

---

## Conclusion

This project demonstrates how product-level data can be transformed into **clear commercial insights**, showing that:

* revenue is concentrated among a small number of products
* volume alone does not determine value
* product mix and pricing play a critical role in performance

This reflects real-world use cases in **e-commerce and marketplace environments**, where understanding product performance is essential for growth and profitability.

---

## Why this project is relevant for SG recruiters

This project demonstrates the ability to:

* analyse product-level data for business insights
* identify key revenue drivers and risks
* understand commercial performance in a marketplace setting
* present insights clearly for decision-making

This is directly applicable to **Data Analyst, BI Analyst, and Marketplace Analytics roles in Singapore**.
