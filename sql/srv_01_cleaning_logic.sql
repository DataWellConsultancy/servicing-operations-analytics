-- ============================================================
-- Datawell Consultancy
-- Project: Fintech Servicing Operations Analytics
-- File: 01_cleaning_logic.sql
-- Purpose: Cleaning and transformation logic for all four tables
-- ============================================================


-- ─────────────────────────────────────────
-- TICKETS TABLE — Cleaning Logic
-- ─────────────────────────────────────────

SELECT
    Ticket_ID,
    Customer_ID,
    Agent_ID,
    Channel,
    Issue_Type,
    Priority,
    Status,
    CAST(Created_Date AS DATE)                                             AS Created_Date,
    Created_Hour,
    Created_Year,
    Created_Month,
    Created_Quarter,
    Resolution_Time_Hours,
    SLA_Target_Hours,

    -- Derived: SLA deviation
    ROUND(Resolution_Time_Hours - SLA_Target_Hours, 2)                    AS SLA_Deviation_Hours,

    SLA_Breached,
    Escalated,
    First_Contact_Resolved,
    Satisfaction_Score,
    Repeat_Contact,

    -- Derived: Is resolved
    CASE WHEN Status IN ('Resolved', 'Closed') THEN 1 ELSE 0 END         AS Is_Resolved,

    -- Derived: Resolution speed tier
    CASE
        WHEN Resolution_Time_Hours <= 2  THEN 'Within 2hrs'
        WHEN Resolution_Time_Hours <= 8  THEN 'Within 8hrs'
        WHEN Resolution_Time_Hours <= 24 THEN 'Within 24hrs'
        WHEN Resolution_Time_Hours <= 48 THEN 'Within 48hrs'
        ELSE 'Beyond 48hrs'
    END                                                                    AS Resolution_Speed_Tier,

    -- Derived: Time of day
    CASE
        WHEN Created_Hour BETWEEN 0  AND 6  THEN 'Night (0-6)'
        WHEN Created_Hour BETWEEN 7  AND 12 THEN 'Morning (6-12)'
        WHEN Created_Hour BETWEEN 13 AND 18 THEN 'Afternoon (12-18)'
        ELSE 'Evening (18-24)'
    END                                                                    AS Time_Of_Day

FROM read_csv_auto('data/raw/tickets.csv')
WHERE Resolution_Time_Hours > 0;


-- ─────────────────────────────────────────
-- AGENTS TABLE — Cleaning Logic
-- ─────────────────────────────────────────

SELECT
    Agent_ID,
    Agent_Name,
    Team,
    Shift,
    Experience_Years,
    Specialisation,
    CAST(Hire_Date AS DATE)                                                AS Hire_Date,
    Is_Senior,

    -- Derived: Experience tier
    CASE
        WHEN Experience_Years <= 2 THEN 'Junior'
        WHEN Experience_Years <= 5 THEN 'Mid'
        WHEN Experience_Years <= 8 THEN 'Senior'
        ELSE 'Expert'
    END                                                                    AS Experience_Tier

FROM read_csv_auto('data/raw/agents.csv');


-- ─────────────────────────────────────────
-- CUSTOMERS TABLE — Cleaning Logic
-- ─────────────────────────────────────────

SELECT
    Customer_ID,
    Customer_Name,
    Customer_Segment,
    Account_Type,
    Tenure_Years,
    Region,
    Is_Premium,
    Monthly_Txn_Count,
    Credit_Score_Band,

    -- Derived: Tenure tier
    CASE
        WHEN Tenure_Years <= 1 THEN 'New (0-1yr)'
        WHEN Tenure_Years <= 3 THEN 'Growing (1-3yr)'
        WHEN Tenure_Years <= 7 THEN 'Established (3-7yr)'
        ELSE 'Loyal (7yr+)'
    END                                                                    AS Tenure_Tier,

    -- Derived: Activity tier
    CASE
        WHEN Monthly_Txn_Count <= 10 THEN 'Low'
        WHEN Monthly_Txn_Count <= 25 THEN 'Medium'
        WHEN Monthly_Txn_Count <= 40 THEN 'High'
        ELSE 'Very High'
    END                                                                    AS Activity_Tier

FROM read_csv_auto('data/raw/customers.csv');


-- ─────────────────────────────────────────
-- CHANNEL INTERACTIONS TABLE — Cleaning Logic
-- ─────────────────────────────────────────

SELECT
    Interaction_ID,
    Ticket_ID,
    Channel,
    CAST(Interaction_Date AS DATE)                                         AS Interaction_Date,
    Duration_Minutes,
    Messages_Exchanged,
    Bot_Handled,
    Transferred_To_Agent,
    Resolution_Achieved,
    Hold_Time_Minutes,
    Sentiment_Score,

    -- Derived: Duration tier
    CASE
        WHEN Duration_Minutes <= 5  THEN 'Quick (0-5m)'
        WHEN Duration_Minutes <= 15 THEN 'Standard (5-15m)'
        WHEN Duration_Minutes <= 30 THEN 'Extended (15-30m)'
        ELSE 'Long (30m+)'
    END                                                                    AS Duration_Tier,

    -- Derived: Sentiment tier
    CASE
        WHEN Sentiment_Score < -0.3 THEN 'Negative'
        WHEN Sentiment_Score <= 0.3 THEN 'Neutral'
        ELSE 'Positive'
    END                                                                    AS Sentiment_Tier

FROM read_csv_auto('data/raw/channel_interactions.csv');
