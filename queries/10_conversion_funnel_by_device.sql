with base as (
SELECT device.category device_category
      , event_name
      ,CONCAT(user_pseudo_id, '-',
           CAST((SELECT value.int_value FROM UNNEST(event_params) 
           WHERE key='ga_session_id') AS STRING)
           ) session_keys 
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
)
,metrics as(
SELECT base.device_category
      ,count(distinct session_keys) session
      ,count(distinct
      CASE WHEN event_name = 'begin_checkout' THEN base.session_keys
       ELSE null END) session_begin_checkout
       ,count(distinct
      CASE WHEN event_name = 'add_shipping_info' THEN session_keys
       ELSE null END) session_add_shipping
       ,count(distinct
      CASE WHEN event_name = 'add_payment_info' THEN session_keys
       ELSE null END) session_add_payment
       ,count(distinct
      CASE WHEN event_name = 'purchase' THEN session_keys
       ELSE null END) session_purchase
FROM base
GROUP BY base.device_category
)
SELECT device_category
      ,session_begin_checkout
      ,session_add_shipping
      ,session_add_payment
      ,session_purchase
       , ROUND(SAFE_DIVIDE(session_add_payment,session_begin_checkout), 2)add_payment_rate
       , ROUND(SAFE_DIVIDE(session_purchase,session_add_payment),2) purchase_rate
FROM metrics
