# Case Study — Fintech Servicing Operations Analytics

**Prepared by:** Datawell Consultancy
**Sector:** Fintech — Customer Support Operations
**Scope:** Multi-Channel Servicing Analytics, SLA Compliance & Agent Performance

---

## 1. The Situation

A fintech company operating a growing customer support function handled thousands
of tickets monthly across six channels — inbound calls, outbound calls, live chat,
email, chatbot, and social media. Despite the volume, the business had no unified
view of its support performance. Ticket records, agent profiles, customer data,
and channel interaction logs existed in four separate systems that had never been
formally connected or audited.

Operational leaders could not reliably measure SLA compliance, identify which
issue types were driving delays and escalations, compare channel effectiveness,
or understand whether the recently deployed chatbot was genuinely resolving issues
or simply adding a layer before a human agent. The SLA breach rate was known to
be high but nobody could pinpoint where, why, or whether it was getting better
or worse over time.

**The business needed answers to these questions:**

- What percentage of tickets are breaching SLA and does it differ by priority level?
- Which channels have the worst breach rates and the lowest customer satisfaction?
- Which issue types take the longest to resolve and generate the most escalations?
- Are experienced agents actually outperforming junior agents on key metrics?
- Is the chatbot reducing agent workload or creating an extra routing step?
- Which customer segments are generating the most tickets and where are the gaps?

---

## 2. Our Approach

| Phase | Focus | What Was Delivered |
|-------|-------|-------------------|
| Phase 1 | Data Quality and Engineering | Full audit of all four datasets. Cleaning pipeline in Python and DuckDB. Twelve derived analytical columns engineered including SLA deviation, resolution speed tier, time of day, experience tier, tenure tier, duration tier, and sentiment tier. All four tables joined into a unified master dataset of 45+ columns. |
| Phase 2 | KPI Analytics and Insights | Eight KPI modules covering SLA compliance by priority and channel, channel performance, issue type analysis, agent team performance, customer segment analysis, chatbot effectiveness, and volume and SLA trends across three years. |

### Data Sources

| File | Records | Content |
|------|---------|---------|
| `tickets.csv` | 15,000 | Tickets with channel, issue, priority, SLA, satisfaction |
| `agents.csv` | 100 | Agent team, shift, experience, specialisation |
| `customers.csv` | 5,000 | Segment, account type, region, tenure, activity |
| `channel_interactions.csv` | 15,000 | Duration, messages, bot handling, sentiment score |

---

## 3. At a Glance

| Metric | Value |
|--------|-------|
| Total Tickets Analysed | 15,000 across 2022 to 2024 |
| Channels Monitored | 6 — Inbound Call, Outbound Call, Live Chat, Email, Chatbot, Social Media |
| Overall SLA Breach Rate | approximately 22% — uniform across all priorities |
| Highest Breach Channel | Chatbot at approximately 23% |
| Lowest Breach Channel | Email at approximately 21% |
| Avg Satisfaction Score | 3.0 out of 5 — uniform across all channels and segments |
| Chatbot Transfer Rate | 42% of chatbot interactions transferred to human agents |
| Retail Ticket Share | 7,200 of 15,000 tickets — nearly 3x any other segment |
| SLA Breach Trend | Rising from 21.2% in 2022 to 22.5% in 2024 on flat volume |
| Hourly Ticket Distribution | Flat — 600 to 650 per hour across all 24 hours |

---

## 4. Findings and Recommendations

---

### Finding 01 — SLA Breach Rate is Uniform Across All Priority Levels — A Critical Process Failure

The SLA compliance chart reveals the most operationally significant finding in this
dataset. Critical priority tickets with a 2-hour SLA target are breaching at
approximately 23%. High priority tickets breach at 22%, Medium at 21%, and Low at
22%. The breach rate is virtually identical regardless of urgency level. This means
the support operation is not triaging or prioritising tickets differently based on
priority. A Critical ticket is being processed at the same speed as a Low ticket —
defeating the entire purpose of having a priority system.

**Recommendation:** The uniformity of breach rates across all priority levels
confirms this is a process problem not a capacity problem. The team is almost
certainly working through a single undifferentiated queue. Implementing strict
priority-based queue routing where Critical tickets surface automatically to the
next available agent — ahead of all Medium and Low tickets — would immediately
differentiate resolution speed by urgency. This single operational change would
have the highest impact of any recommendation in this engagement.

---

### Finding 02 — Chatbot Has the Highest SLA Breach Rate of All Six Channels

The channel breach rate chart shows Chatbot at approximately 23% — the highest
breach rate of all six channels. Live Chat follows at approximately 22.5%, Inbound
Call at approximately 22%, Outbound Call and Social Media at approximately 21.5%,
and Email at the lowest at approximately 21%. The spread between highest and lowest
is approximately 2 percentage points — confirming the problem is systemic across
the entire operation rather than isolated to any single channel.

**Recommendation:** A chatbot generating the highest SLA breach rate is
counterintuitive — automation should accelerate resolution not slow it. This
suggests the bot is spending excessive time in diagnostic conversation loops
before either resolving or transferring. Auditing the chatbot conversation flows
to identify where time is being lost and setting a maximum bot interaction time
of 5 minutes before automatic transfer to a human agent would reduce chatbot SLA
breaches and improve the overall customer experience.

---

### Finding 03 — All Channels Show Identical Satisfaction Score of 3.0 — A Systemic Quality Issue

The channel performance chart shows Live Chat and Inbound Call as the highest
volume channels at approximately 3,800 tickets each. All remaining channels handle
between 1,700 and 2,000 tickets. Average resolution time is approximately 20 hours
across all channels with virtually no differentiation. Most critically all channels
show an identical satisfaction score of approximately 3.0 out of 5 — with no
channel performing noticeably better or worse than any other.

**Recommendation:** A uniform 3.0 satisfaction score across all channels means
the problem is not channel design — it is service quality. No channel is
differentiating itself positively. The issue is most likely in resolution quality,
agent communication standards, or first contact resolution rates. Setting a minimum
acceptable threshold of 3.5 satisfaction score across all channels as a defined
operational KPI and conducting agent communication training focused on resolution
confidence and customer empathy would move the needle on this metric.

---

### Finding 04 — Statement Request and KYC Verification Take the Longest to Resolve While Transaction Dispute Has the Highest Breach Rate

The issue type resolution time chart shows Statement Request at approximately 20.8
hours — the highest of all ten issue types — followed by KYC Verification and App
Technical Issue. Transaction Dispute has the lowest average resolution time at
approximately 20 hours but shows the highest SLA breach rate at approximately 22.5%.
All ten issue types show near-identical escalation rates at approximately 20%.

**Recommendation:** Statement Request and KYC Verification are largely administrative
tasks that should not require 20+ hours. Introducing customer self-service statement
download and automated KYC document verification would significantly reduce agent
handling time for both. Transaction Dispute requires separate attention — it resolves
relatively quickly but keeps breaching SLA, suggesting its SLA target is set too
tightly for the complexity of the investigation. A review of Transaction Dispute
SLA targets aligned to actual resolution patterns is recommended.

---

### Finding 05 — No Performance Differentiation Exists Between Junior and Expert Agents

The agent performance chart shows all five teams — Cards and Payments, Fraud and
Security, KYC and Compliance, Technical Support, and Transactions — averaging
approximately 20 hours resolution time with no meaningful differentiation between
them. Satisfaction scores are identical at approximately 3.0 across all teams.
The SLA breach rate chart shows all four experience tiers — Junior, Mid, Senior,
and Expert — breaching at an identical rate of approximately 22%.

**Recommendation:** The complete absence of performance differentiation between
Junior and Expert agents is a significant finding that indicates either a lack of
experience-based routing or a lack of performance management that creates
accountability for differentiation. Introducing experience-based ticket routing —
where complex multi-step issues go to Senior and Expert agents and straightforward
queries go to Junior agents — would create measurable performance differences that
can then be tracked, rewarded, and improved over time.

---

### Finding 06 — Chatbot Transfers 42% of Interactions to Human Agents — Functioning as Router Not Resolver

The chatbot analysis chart shows the Chatbot channel handling 100% of its volume
through the bot as expected. However the transfer to agent rate is approximately
42% — the highest of all six channels by a significant margin. Other channels
show transfer rates of approximately 32% to 34%. The resolution rate for
bot-handled interactions and human-handled interactions is virtually identical
at approximately 73% to 74%.

**Recommendation:** A 42% transfer rate means nearly half of all chatbot
interactions end up with a human agent anyway — making the chatbot a routing
layer rather than a resolution tool. The equal resolution rate between bot and
human suggests the chatbot quality is comparable when it does resolve. Expanding
the chatbot resolution capability for the five most common issue types — Statement
Request, Account Locked, Card Blocked, Payment Failure status, and Transaction
status queries — would reduce the transfer rate, free significant agent capacity,
and allow the chatbot to deliver on its core promise of automated resolution.

---

### Finding 07 — Retail Segment Generates 7,200 Tickets at the Same 3.0 Satisfaction Score as Every Other Segment

The customer segment chart shows the Retail segment generating approximately 7,200
tickets — nearly three times the volume of Corporate, SME, and Premium segments
which each generate approximately 2,500 tickets. Despite generating the most
tickets by a wide margin, the Retail segment receives the same 3.0 satisfaction
score as all other segments. The regional breach rate analysis shows the East
region at approximately 23% — the highest of five regions — and West at
approximately 21% as the lowest.

**Recommendation:** The Retail segment driving nearly 50% of total ticket volume
at a mediocre satisfaction score represents the single largest customer retention
risk in this operation. Retail customers have the most alternatives and the lowest
switching cost. Introducing a dedicated Retail fast-track queue with a stricter
SLA target and a satisfaction score target of 3.5 or above would have the highest
customer retention impact of any operational change. The East region's elevated
breach rate warrants specific investigation into whether it reflects a staffing,
issue-type concentration, or routing issue.

---

### Finding 08 — SLA Breach Rate Has Been Rising Consistently from 21.2% in 2022 to 22.5% in 2024

The volume trends chart shows ticket volume holding entirely flat at approximately
5,000 tickets per year across 2022, 2023, and 2024. Volume is not growing. However
the SLA breach rate has risen consistently from approximately 21.2% in 2022 to
22.4% in 2023 to approximately 22.5% in 2024. The hourly volume distribution is
completely flat at approximately 600 to 650 tickets per hour across all 24 hours
with no peak or trough pattern.

**Recommendation:** A rising SLA breach rate on completely flat ticket volume is
the most operationally alarming trend in this dataset. The team is handling the
exact same number of tickets each year but resolving a smaller proportion within
SLA. This is a process and quality degradation — not a capacity issue. An immediate
review of resolution workflows, agent training refreshes, and SLA target calibration
should be initiated. The flat 24-hour volume distribution confirms this operation
requires genuine 24x7 staffing coverage with consistent team capacity across all
shifts — no single shift can be deprioritised or under-resourced.

---

## 5. Deliverables

| Deliverable | Format |
|-------------|--------|
| Data Quality Audit | `notebooks/01_data_quality.ipynb` |
| Cleaned Master Dataset | `data/cleaned/master_dataset.csv` — 45+ columns, four sources joined |
| SQL Cleaning Scripts | `sql/01_cleaning_logic.sql` |
| SQL KPI Scripts | `sql/02_kpi_aggregations.sql` |
| KPI Analysis Notebook | `notebooks/02_analysis_kpis.ipynb` — 8 modules with charts |
| Dashboard Chart Exports | `dashboard/*.png` — 7 professional charts |
| Executive Case Study | This document |

---

## 6. Technology Stack

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
