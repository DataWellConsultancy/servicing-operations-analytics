-- ============================================================
-- Datawell Consultancy
-- Project: Fintech Servicing Operations Analytics
-- File: 02_kpi_aggregations.sql
-- Purpose: Core KPI calculations on the unified master dataset
-- ============================================================


-- ─────────────────────────────────────────
-- KPI 1: Executive Summary
-- ─────────────────────────────────────────

SELECT
    COUNT(*)                                                               AS total_tickets,
    COUNT(DISTINCT Agent_ID)                                               AS unique_agents,
    COUNT(DISTINCT Customer_ID)                                            AS unique_customers,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_rate_pct,
    ROUND(AVG(First_Contact_Resolved)*100, 2)                              AS fcr_rate_pct,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(Repeat_Contact)*100, 2)                                      AS repeat_contact_rate_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction_score,
    ROUND(AVG(Is_Resolved)*100, 2)                                         AS resolution_rate_pct,
    ROUND(AVG(Duration_Minutes), 2)                                        AS avg_interaction_duration_mins,
    ROUND(AVG(Sentiment_Score), 4)                                         AS avg_sentiment_score
FROM master;


-- ─────────────────────────────────────────
-- KPI 2: SLA Compliance by Priority and Channel
-- ─────────────────────────────────────────

SELECT
    Priority,
    Channel,
    SLA_Target_Hours,
    COUNT(*)                                                               AS total_tickets,
    SUM(SLA_Breached)                                                      AS breached_count,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS breach_rate_pct,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Deviation_Hours), 2)                                     AS avg_sla_deviation_hours
FROM master
GROUP BY Priority, Channel, SLA_Target_Hours
ORDER BY Priority, breach_rate_pct DESC;


-- ─────────────────────────────────────────
-- KPI 3: Channel Performance
-- ─────────────────────────────────────────

SELECT
    Channel,
    COUNT(*)                                                               AS total_tickets,
    ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(), 2)                         AS volume_share_pct,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_pct,
    ROUND(AVG(First_Contact_Resolved)*100, 2)                              AS fcr_rate_pct,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction,
    ROUND(AVG(Duration_Minutes), 2)                                        AS avg_duration_mins,
    ROUND(AVG(Sentiment_Score), 4)                                         AS avg_sentiment,
    ROUND(AVG(Bot_Handled)*100, 2)                                         AS bot_handled_pct,
    ROUND(AVG(Transferred_To_Agent)*100, 2)                               AS transfer_to_agent_pct
FROM master
GROUP BY Channel
ORDER BY total_tickets DESC;


-- ─────────────────────────────────────────
-- KPI 4: Issue Type Analysis
-- ─────────────────────────────────────────

SELECT
    Issue_Type,
    COUNT(*)                                                               AS total_tickets,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_pct,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(First_Contact_Resolved)*100, 2)                              AS fcr_rate_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction
FROM master
GROUP BY Issue_Type
ORDER BY avg_resolution_hours DESC;


-- ─────────────────────────────────────────
-- KPI 5: Agent Team Performance
-- ─────────────────────────────────────────

SELECT
    Team,
    Shift,
    Experience_Tier,
    COUNT(*)                                                               AS total_tickets,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_pct,
    ROUND(AVG(First_Contact_Resolved)*100, 2)                              AS fcr_rate_pct,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction
FROM master
WHERE Team IS NOT NULL
GROUP BY Team, Shift, Experience_Tier
ORDER BY Team, Shift;


-- ─────────────────────────────────────────
-- KPI 6: Customer Segment Analysis
-- ─────────────────────────────────────────

SELECT
    Customer_Segment,
    Region,
    Is_Premium,
    COUNT(*)                                                               AS total_tickets,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(Repeat_Contact)*100, 2)                                      AS repeat_contact_pct
FROM master
WHERE Customer_Segment IS NOT NULL
GROUP BY Customer_Segment, Region, Is_Premium
ORDER BY total_tickets DESC;


-- ─────────────────────────────────────────
-- KPI 7: Chatbot and Automation Analysis
-- ─────────────────────────────────────────

SELECT
    Channel,
    Bot_Handled,
    COUNT(*)                                                               AS total_interactions,
    ROUND(AVG(Resolution_Achieved)*100, 2)                                 AS resolution_rate_pct,
    ROUND(AVG(Duration_Minutes), 2)                                        AS avg_duration_mins,
    ROUND(AVG(Transferred_To_Agent)*100, 2)                               AS transfer_rate_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction,
    ROUND(AVG(Sentiment_Score), 4)                                         AS avg_sentiment
FROM master
WHERE Bot_Handled IS NOT NULL
GROUP BY Channel, Bot_Handled
ORDER BY Channel, Bot_Handled;


-- ─────────────────────────────────────────
-- KPI 8: Yearly Trend
-- ─────────────────────────────────────────

SELECT
    Created_Year,
    COUNT(*)                                                               AS total_tickets,
    ROUND(AVG(SLA_Breached)*100, 2)                                        AS sla_breach_pct,
    ROUND(AVG(Satisfaction_Score), 2)                                      AS avg_satisfaction,
    ROUND(AVG(First_Contact_Resolved)*100, 2)                              AS fcr_rate_pct,
    ROUND(AVG(Escalated)*100, 2)                                           AS escalation_rate_pct,
    ROUND(AVG(Resolution_Time_Hours), 2)                                   AS avg_resolution_hours
FROM master
WHERE Created_Year IS NOT NULL
GROUP BY Created_Year
ORDER BY Created_Year;
