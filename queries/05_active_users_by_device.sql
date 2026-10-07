select device.category
      , count (distinct user_pseudo_id) active_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
GROUP BY device.category

