SELECT 
    (SELECT
      value.string_value
       FROM UNNEST(event_params)
       WHERE key ='page_location' 
        ) page_path
    ,COUNT(*) views
    ,count (distinct user_pseudo_id) active_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'page_view'
GROUP BY page_path
ORDER BY views desc;
