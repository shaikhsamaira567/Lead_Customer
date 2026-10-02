# SQL Practice Questions

Database: `Transaction` (tables: `customers`, `leads`; views: `vw_all_contacts`, `vw_lead_owner_summary`, `vw_customer_country_summary`)

1. List the first name, last name, and email of all customers from "Canada", ordered by subscription date (most recent first).
2. Find the top 5 countries by total number of customers.
3. Count how many customers subscribed in each year (extract the year from `subscription_date`), ordered chronologically.
4. Find which lead owner manages the most leads, and how many owners have exactly 1 lead.
5. Find all leads whose company name contains "Group" or "LLC", and count how many of each type exist.
6. Using `vw_all_contacts`, write a query that returns the total count of contacts by `record_type` (lead vs customer).
7. Extract the email domain (the part after `@`) for all customers, and find the 5 most common domains.
8. Find customers and leads (via `vw_all_contacts`) whose `website` field is NULL, and count them by `record_type`.
9. Find all customers whose `subscription_date` falls in the second half of 2021 (July-December 2021), sorted by subscription date.
10. Find leads where the `notes` field contains the word "government" (case-insensitive) and whose company includes "Inc" or "PLC". Return `first_name`, `last_name`, `company`, and `notes`.
