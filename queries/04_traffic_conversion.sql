select 
  traffic_source.source session_source
  , traffic_source.medium session_medium
  , count(distinct CASE WHEN e.event_name = 'session_start' 
  THEN e.user_pseudo_id END) sessions
  ,count(CASE WHEN e.event_name = 'view_item'
  THEN 1 ELSE null END) item_view_events
  , count (CASE WHEN e.event_name = 'begin_checkout'
  THEN 1 ELSE null END) checkouts
  , count(CASE WHEN e.event_name = 'purchase'
  THEN 1 ELSE null END) ecommerce_purchase
  ,countif(event_name ='first_visit' AND EXISTS(
       SELECT 1 
        FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` p
        WHERE p.user_pseudo_id = e.user_pseudo_id
        AND p.event_name = 'purchase'
      )) first_time_purchasers
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
GROUP BY session_source, session_medium
ORDER BY sessions desc

      
