-- =====================================================================
-- SQL practice: questions with answers
-- Run AFTER 01_schema_and_data.sql
-- =====================================================================
USE `Transaction`;

-- Q1. List the first name, last name, and email of all customers from
--     "Canada", ordered by subscription date (most recent first).
SELECT first_name, last_name, email
FROM customers
WHERE country = 'Canada'
ORDER BY subscription_date DESC;


-- Q2. Find the top 5 countries by total number of customers.
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC, country ASC
LIMIT 5;


-- Q3. Count how many customers subscribed in each year, ordered
--     chronologically.
SELECT
    YEAR(subscription_date) AS subscription_year,
    COUNT(*) AS total_customers
FROM customers
GROUP BY YEAR(subscription_date)
ORDER BY subscription_year ASC;


-- Q4a. Which lead owner manages the most leads, and how many?
--      (Returns all owners if there is a tie.)
SELECT lead_owner, COUNT(*) AS total_leads
FROM leads
GROUP BY lead_owner
HAVING COUNT(*) = (
    SELECT MAX(owner_total)
    FROM (
        SELECT COUNT(*) AS owner_total
        FROM leads
        GROUP BY lead_owner
    ) AS t
)
ORDER BY lead_owner;

-- Q4b. How many owners have exactly one lead?
SELECT COUNT(*) AS owners_with_exactly_one_lead
FROM (
    SELECT lead_owner
    FROM leads
    GROUP BY lead_owner
    HAVING COUNT(*) = 1
) AS single_lead_owners;


-- Q5a. Find all leads whose company name contains "Group" or "LLC".
SELECT *
FROM leads
WHERE company LIKE '%Group%'
   OR company LIKE '%LLC%';

-- Q5b. Count how many of each type exist.
--      (A company containing both words is counted in both columns.)
SELECT
    SUM(company LIKE '%Group%') AS group_count,
    SUM(company LIKE '%LLC%')   AS llc_count,
    COUNT(*)                    AS total_matching_leads
FROM leads
WHERE company LIKE '%Group%'
   OR company LIKE '%LLC%';


-- Q6. Using vw_all_contacts, return the total count of contacts by
--     record_type (lead vs customer).
SELECT record_type, COUNT(*) AS total_contacts
FROM vw_all_contacts
GROUP BY record_type;


-- Q7. Extract the email domain (part after @) for all customers and
--     find the 5 most common domains.
SELECT
    SUBSTRING_INDEX(email, '@', -1) AS email_domain,
    COUNT(*) AS total_customers
FROM customers
GROUP BY email_domain
ORDER BY total_customers DESC, email_domain ASC
LIMIT 5;


-- Q8. Find customers and leads (via vw_all_contacts) whose website is
--     NULL, and count them by record_type.
--     (Empty strings are treated as missing too.)
SELECT record_type, COUNT(*) AS total_contacts
FROM vw_all_contacts
WHERE website IS NULL OR website = ''
GROUP BY record_type;


-- Q9. Find all customers whose subscription_date falls in the second
--     half of 2021 (July - December), sorted by subscription date.
SELECT *
FROM customers
WHERE subscription_date BETWEEN '2021-07-01' AND '2021-12-31'
ORDER BY subscription_date ASC;


-- Q10. Find leads where notes contain the word "government"
--      (case-insensitive) and whose company includes "Inc" or "PLC".
--      Return first_name, last_name, company, and notes.
SELECT first_name, last_name, company, notes
FROM leads
WHERE LOWER(notes) LIKE '%government%'
  AND (company LIKE '%Inc%' OR company LIKE '%PLC%');
