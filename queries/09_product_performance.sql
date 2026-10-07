
SELECT item.item_name
      ,COUNTIF(event_name ='view_item') views
      ,COUNTIF(event_name ='add_to_cart') added_to_card
      ,COUNTIF(event_name ='begin_checkout') checked_out
      ,SUM( CASE WHEN
        event_name = 'purchase' THEN item.quantity ELSE 0 END) item_purchased
      ,SUM( CASE WHEN
        event_name = 'purchase' THEN CAST(item.price * item.quantity AS INT64) 
        ELSE 0 END) item_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
,UNNEST(items) item
GROUP BY item.item_name
ORDER BY views desc;
