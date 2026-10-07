
with raw_data as (
SELECT 
       parse_date('%Y%m%d', event_date) event_date
       , event_name
--- unique session keys
      , CONCAT(user_pseudo_id, '-',
           CAST((SELECT value.int_value FROM UNNEST(event_params) 
           WHERE key='ga_session_id') AS STRING)
           ) session_keys 
      , ecommerce. purchase_revenue AS purchase_revenue
      ,ecommerce.transaction_id AS transaction_id
      ,ecommerce.total_item_quantity
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
GROUP BY event_date,ecommerce. purchase_revenue,transaction_id,ecommerce.total_item_quantity, event_name,user_pseudo_id,event_params
ORDER BY event_date)
, metrics as (
select event_date
      , count (distinct session_keys) session 
-- view_item_sessions
      , count(distinct 
         CASE WHEN event_name = 'view_item' THEN session_keys ELSE null 
         END) as view_item_sessions
-- cart_sessions
      , count (distinct 
         CASE 
         WHEN  event_name = 'add_to_cart' THEN session_keys ELSE null  
         END) AS cart_sessions 
-- purchase_sessions
      , count (distinct 
         CASE 
         WHEN event_name = 'purchase' THEN session_keys ELSE null  
         END )AS purchase_sessions 
-- cnt_transactions
      , count (DISTINCT CASE
         WHEN event_name = 'purchase' THEN session_keys
        END) AS ecommerce_purchase 
-- total_revenue
      , sum (CASE
         WHEN event_name = 'purchase' THEN purchase_revenue ELSE null  
         END) AS purchase_revenue
-- total_basket_qty
      , sum (CASE
         WHEN event_name = 'purchase' THEN total_item_quantity
          ELSE null END) AS basket_qty
FROM raw_data 
GROUP BY event_date
)
SELECT metrics.event_date
   ,metrics.session
-- view_product_rate
   ,safe_divide(metrics.view_item_sessions, metrics.session) view_product_rate
-- view_to_cart_rate
   , safe_divide(cart_sessions, metrics.view_item_sessions) 
   view_to_cart_rate
-- cart_to_purchase_rate
   , safe_divide (metrics.purchase_sessions, metrics.cart_sessions) cart_to_purchase_rate
-- purchase_rate
   , safe_divide(metrics.purchase_sessions, metrics.session) purchase_rate
   , ecommerce_purchase
   , metrics.purchase_revenue
--avg_purchase_revenue
   , safe_divide(metrics.purchase_revenue,ecommerce_purchase) avg_purchase_revenue
--avg_basket_size
   , safe_divide(basket_qty,ecommerce_purchase) avg_basket_size
--revenue_per_user
   , safe_divide(metrics.purchase_revenue,metrics.session) revenue_per_user
FROM metrics
ORDER BY event_date;
