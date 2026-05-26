# Fintech Servicing Operations Analytics
### Datawell Consultancy

---

## Business Problem

A fintech company operating a multi-channel customer support function had no
unified view of its servicing performance. Ticket records, agent profiles, customer
demographics, and channel interaction logs existed across four separate systems
that had never been connected or audited. The business could not reliably answer
basic operational questions:

- What is our SLA compliance rate across channels and priority levels?
- Which issue types take the longest to resolve and drive the most escalations?
- How are individual agent teams performing against key metrics?
- Which channel delivers the best resolution rate and customer satisfaction?
- Is our chatbot actually resolving issues or just routing customers to agents?

**Our engagement:** Profile, clean, and unify all four data sources into a single
analytics layer that answers these questions reliably.

---

## Dataset

| File | Records | Description |
|------|---------|-------------|
| `tickets.csv` | 15,000 | Support tickets — channel, issue, priority, SLA, satisfaction |
| `agents.csv` | 100 | Agent master data — team, shift, experience, specialisation |
| `customers.csv` | 5,000 | Customer profiles — segment, account type, region, tenure |
| `channel_interactions.csv` | 15,000 | Interaction details — duration, messages, bot handling, sentiment |

**Channels covered:** Inbound Call, Outbound Call, Live Chat, Email, Chatbot, Social Media

**Issue types:** Transaction Dispute, Payment Failure, Account Locked, Card Blocked,
Fraud Alert, KYC Verification, Loan Query, App Technical Issue, Refund Request,
Statement Request

---

## Key Findings

| Area | Finding |
|------|---------|
| SLA Compliance | 22% breach rate uniform across all priority levels — Critical tickets treated same as Low priority |
| Channel Breach Rate | Chatbot highest at 23%, Email lowest at 21% — 2 point spread across all channels |
| Channel Volume | Live Chat and Inbound Call dominate at 3,800 tickets each — Chatbot lowest at 1,700 |
| Satisfaction | Uniform 3.0 out of 5 across all channels and customer segments — systemic quality issue |
| Issue Resolution | Statement Request takes longest at 20.8 hours — Transaction Dispute has highest SLA breach rate |
| Agent Performance | All teams and all experience tiers perform identically — no differentiation between Junior and Expert |
| Chatbot Effectiveness | 42% transfer rate to human agents — chatbot functioning as router not resolver |
| Retail Segment | Generates 7,200 tickets — nearly 3x any other segment — at same 3.0 satisfaction score |
| SLA Trend | Breach rate rising from 21.2% in 2022 to 22.5% in 2024 on flat ticket volume |
| Hourly Volume | Flat distribution across all 24 hours — 600 to 650 tickets per hour — 24x7 staffing required |

---

## Project Structure

```
servicing-operations-analytics/
├── data/
│   ├── raw/
│   │   ├── tickets.csv
│   │   ├── agents.csv
│   │   ├── customers.csv
│   │   └── channel_interactions.csv
│   └── cleaned/
│       ├── tickets_cleaned.csv
│       ├── agents_cleaned.csv
│       ├── customers_cleaned.csv
│       ├── interactions_cleaned.csv
│       ├── master_dataset.csv
│       └── kpi_*.csv
├── notebooks/
│   ├── 01_data_quality.ipynb
│   └── 02_analysis_kpis.ipynb
├── sql/
│   ├── 01_cleaning_logic.sql
│   └── 02_kpi_aggregations.sql
├── dashboard/
│   ├── sla_compliance.png
│   ├── channel_performance.png
│   ├── issue_type_analysis.png
│   ├── agent_performance.png
│   ├── customer_segment_analysis.png
│   ├── chatbot_analysis.png
│   └── volume_trends.png
└── docs/
    └── case_study.md
```

---

## How to Run

**Prerequisites:**
```bash
pip install pandas numpy matplotlib seaborn duckdb faker
```

**Run in order:**
```
1. notebooks/01_data_quality.ipynb
2. notebooks/02_analysis_kpis.ipynb
```

---

## Technology Stack

| Tool | Purpose |
|------|---------|
| Python / Pandas | Data cleaning and transformation |
| DuckDB | SQL queries on dataframes and CSV files |
| Matplotlib / Seaborn | Charts and visualisations |
| Jupyter Notebook | Analysis and portfolio presentation |
| GitHub | Version control and portfolio |

---

## About Datawell Consultancy

We help fintech, servicing, and healthcare businesses organise their data,
build reliable dashboards, and make better decisions.

datawellconsultants@gmail.com
datawellconsultancy.com

---

*Data used in this project is synthetically generated for portfolio demonstration
purposes. All client references are illustrative.*
