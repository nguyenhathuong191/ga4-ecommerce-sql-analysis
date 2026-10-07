# ga4-ecommerce-sql-analysis
## Project Overview

This project analyzes e-commerce user behavior using the Google Analytics 4 (GA4) public sample dataset in Google BigQuery.

The objective is to use SQL to explore website traffic, user behavior, conversion funnels, product performance, and purchasing patterns, and to translate business questions into measurable data insights.

## Dataset

This project uses the Google Analytics 4 public e-commerce sample dataset from the Google Merchandise Store.

**BigQuery dataset:**
`bigquery-public-data.ga4_obfuscated_sample_ecommerce`

**Main table:**
`events_*`

Each row represents a user event, such as:
- `session_start`
- `page_view`
- `view_item`
- `add_to_cart`
- `begin_checkout`
- `add_shipping_info`
- `add_payment_info`
- `purchase`

## Business Questions

The analysis consists of 10 SQL queries covering:

1. Overall e-commerce performance metrics
2. User actions and event distribution
3. Traffic source and medium performance
4. Conversion behavior by traffic source
5. Active users by device category
6. Active users by country
7. Active users by operating system and browser
8. Page view performance
9. Product performance
10. Conversion funnel performance by device category

## SQL Skills Demonstrated

- Common Table Expressions (CTEs)
- Conditional aggregation
- `COUNT(DISTINCT)`
- `CASE WHEN`
- `SAFE_DIVIDE`
- Window functions
- GA4 session construction
- STRUCT and ARRAY data
- `UNNEST`
- Conversion funnel analysis

## Tools

- Google BigQuery
- SQL
- Google Analytics 4 (GA4)

## Repository Structure

```text
queries/
├── 01_overview_metrics.sql
├── 02_user_actions.sql
├── 03_traffic_sources.sql
├── 04_conversion_by_traffic_source.sql
├── 05_active_users_by_device.sql
├── 06_active_users_by_country.sql
├── 07_active_users_by_os_browser.sql
├── 08_page_views_performance.sql
├── 09_product_performance.sql
└── 10_conversion_funnel_by_device.sql
