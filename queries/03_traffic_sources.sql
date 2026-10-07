with data as (
SELECT
  CONCAT(user_pseudo_id, '-',
           CAST((SELECT value.int_value FROM UNNEST(event_params) 
           WHERE key='ga_session_id') AS STRING)
           ) session_keys 
  ,traffic_source.source session_source
  ,traffic_source.medium session_medium
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'session_start' 
)
select  
       session_source
       ,session_medium
       ,count(distinct session_keys) sessions
       , ROUND(
        SAFE_DIVIDE(COUNT(DISTINCT session_keys),
        SUM(COUNT(DISTINCT session_keys))OVER())*100 
       ,2 )pct_sessions
FROM data
GROUP BY session_source,session_medium
ORDER BY sessions DESC;
