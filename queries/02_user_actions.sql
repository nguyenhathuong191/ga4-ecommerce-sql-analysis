
with data as (
SELECT 
  parse_date('%Y%m%d',event_date) event_date
  ,event_name
  , user_pseudo_id
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
)
SELECT 
  event_date
  ,event_name
  ,count (*) as event_count
  ,safe_divide (
    count (*), 
    sum(count(*)) over(PARTITION BY event_date))
     as event_percent
  ,count(distinct user_pseudo_id) active_users
FROM data
GROUP BY event_name, event_date 
ORDER BY event_date, event_count desc;
