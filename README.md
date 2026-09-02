# 🏠 Affordable Housing & Tenant Matching System

A relational database system for managing **tenants, landlords, properties, preferences, payments, complaints, legal documents, and property matching** using SQL and PL/SQL.

## 🚀 Overview

The system models the complete housing-management workflow:

```text
Users
 ↓
Tenants / Landlords
 ↓
Properties + Preferences
 ↓
Tenant–Property Matching
 ↓
Payments / Complaints / Documents
 ↓
Reporting
```

## 🔑 Features

* Designed a normalized relational database for housing management.
* Tenant-property matching based on **budget, bedrooms, location, and property availability**.
* Property listing and availability management.
* Rent payment tracking and monthly collection analysis.
* Tenant complaint registration and resolution tracking.
* Legal document management.
* Reporting queries for tenants, properties, landlords, rent, and complaints.
* PL/SQL **procedures, functions, triggers, and cursors** for automation and validation.

### Example PL/SQL Components

* `register_user`
* `register_complaint`
* `notify_overdue_rent`
* `get_total_rent`
* `is_match_found`
* `is_tenant_default`
* `avg_res_time`
* `match_count`

The project also uses triggers for rules such as minimum rent validation, automatic complaint timestamps, and duplicate phone-number prevention.

## 📊 Project Highlights

* **20+ entities**
* **45+ relationships**
* **60+ attributes**
* **25+ PL/SQL procedures, functions, triggers and views**
* **30+ SQL queries**
* Resume-reported query optimization from **1.2s → 0.54s**
* Resume-reported reduction in manual processing of approximately **60%**.

## 🛠️ Tech Stack

`SQL` `PL/SQL` `Oracle` `ER Modeling` `Database Design`

## 📁 Structure

```text
affordable-housing-tenant-matching/
├── DBMS_Project.sql
├── Extra Queries.sql
├── Extra plsql functions.sql
├── README.md
└── docs/
    └── ER_Diagram.png
```

## ▶️ Run

Execute the SQL scripts in an Oracle-compatible SQL/PLSQL environment.

```text
1. DBMS_Project.sql
2. Extra Queries.sql
3. Extra plsql functions.sql
```

The main script creates the schema, inserts sample data, and contains the primary SQL/PLSQL implementation.

