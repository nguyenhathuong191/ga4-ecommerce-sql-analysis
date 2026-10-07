SELECT device. operating_system os
     ,device.web_info.browser browser
     ,count (distinct user_pseudo_id) active_users
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY device. operating_system
     ,device.web_info.browser
ORDER BY active_users desc;
