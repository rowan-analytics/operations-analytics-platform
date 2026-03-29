# 🧠 Retail Sales SQL Analytics

End-to-end SQL analytics project transforming raw transactional data into **actionable business insights**.

This project demonstrates how SQL can be used not just for querying data, but for **building a full analytical workflow** — from raw data exploration to KPI reporting and business-level insights.

---

## 📊 Overview

Using a real-world retail dataset, this project focuses on:

* understanding sales performance
* identifying key revenue drivers
* analysing customer and product behaviour
* building structured outputs for reporting

The analysis follows a **typical analytics pipeline used in industry**, making it directly relevant for **Data Analyst and BI roles**.

---

## 🗂️ Dataset

Online retail transactional dataset containing:

* **541,909 rows**
* **25,900 orders**
* **4,373 customers**
* Data spanning **2010–2011**

### Key Fields

* `InvoiceNo` – Transaction identifier
* `StockCode` – Product ID
* `Description` – Product name
* `Quantity` – Units sold (negative = returns)
* `InvoiceDate` – Transaction timestamp
* `UnitPrice` – Price per unit
* `CustomerID` – Customer identifier
* `Country` – Customer location

---

## ⚙️ SQL Workflow

The project is structured as a **step-by-step SQL pipeline**, similar to real-world data workflows:

### 🔹 01. Data Exploration

* Initial inspection of dataset structure
* Identification of missing values and anomalies
* Detection of returns (negative quantities)

### 🔹 02. Data Cleaning

* Removed null `CustomerID` records
* Filtered invalid transactions
* Standardised data types and formats

### 🔹 03. Feature Engineering

* Created key metrics such as:

  * `total_revenue = Quantity * UnitPrice`
  * order-level aggregations
* Extracted time-based features:

  * month
  * year

### 🔹 04. KPI Generation

* Total revenue
* Total orders
* Total customers
* Average order value

### 🔹 05. Customer Analysis

* Revenue by customer
* Order frequency
* Identification of high-value customers

### 🔹 06. Product Performance Analysis

* Revenue by product
* Units sold by product
* Identification of top-performing SKUs

### 🔹 07. Time-Series Analysis

* Monthly revenue trends
* Seasonality detection
* Peak performance periods

### 🔹 08. Reporting Views

* Created reusable SQL views for:

  * dashboard integration
  * automated reporting
  * consistent KPI tracking

---

## 🔍 Key Insights

### 📈 1. Strong seasonal revenue pattern

Revenue peaks in **November 2011**, indicating:

* strong seasonal demand
* likely influence of holiday shopping periods
* importance of peak-period inventory and operations

---

### 👥 2. Customer concentration drives revenue

A small number of customers contribute a **disproportionate share of total revenue**.

**SQL insight:**

* ranking customers by revenue quickly reveals concentration patterns
* useful for retention and segmentation strategies

---

### 📦 3. Product performance is highly uneven

A limited number of products generate the majority of sales.

**SQL insight:**

* grouping by product highlights revenue concentration
* enables identification of top-performing SKUs

---

### 🔁 4. Returns impact revenue and require handling

Negative quantities represent returned items.

**SQL insight:**

* filtering or separately analysing returns is essential
* failure to handle returns can distort KPIs

---

### 📊 5. Revenue trends are not linear

Monthly analysis shows fluctuations with a strong upward trend into peak season.

**SQL insight:**

* time-based aggregation (`GROUP BY month`) reveals trends not visible at transaction level

---

## 🧠 Why SQL Matters Here

This project demonstrates that SQL is not just for querying data — it is used to:

* structure raw datasets into analysis-ready formats
* generate consistent business metrics
* create reusable reporting layers
* support dashboard development

This reflects how SQL is used in **real analytics teams and data pipelines**.

---

## 🛠️ Tech Stack

* **SQL** (core analysis and transformation)
* **Power BI** (dashboard and visualisation)
* **Python / Excel** (optional data preparation and validation)

---

## 📁 Project Structure

```bash
retail-sql-analytics/
│
├── sql/
│   ├── 01_data_exploration.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_feature_engineering.sql
│   ├── 04_kpis.sql
│   ├── 05_customer_analysis.sql
│   ├── 06_product_analysis.sql
│   ├── 07_time_series.sql
│   └── 08_reporting_views.sql
│
├── data/              # Raw and processed datasets
├── powerbi/           # Dashboard outputs
└── README.md
```

---

## 🎯 Business Value

This project reflects real-world use cases in:

* **E-commerce analytics (Shopee, Lazada)**
* **Business Intelligence reporting**
* **Operations and commercial analysis**

It helps answer:

* Where is revenue coming from?
* Who are the most valuable customers?
* Which products drive performance?
* When does demand peak?

---

## 🚀 Conclusion

This project demonstrates how SQL can be used to move from:

> raw transactional data

to

> structured insights that support real business decisions

It highlights the importance of **data cleaning, aggregation, and analytical thinking** in building reliable and meaningful outputs.

---

## 💼 Relevance for SG Roles

This project showcases:

* strong SQL fundamentals
* ability to structure analytical workflows
* business-focused thinking
* experience working with real-world datasets

Directly relevant for:

**Data Analyst | BI Analyst | Operations Analyst | Marketplace Analytics (Shopee-style roles)**
