BEGIN;

--Insert new Category name 
with src as
(select category_name,price_bucket_key from (
(SELECT  category_name,
case when coalesce(max(price),0)<=100 then 100
when coalesce(max(price),0)<=500 then 500
when coalesce(max(price),0)<=1000 then 1000
when coalesce(max(price),0)<=500 then 5000
when coalesce(max(price),0)<=10000 then 10000
else 20000
end as max_price_reference
FROM   stage_own.categories c join
stage_own.metadata m on m.asin=c.asin 
group by category_name) cat
left join 
dwh_own.dim_price_bucket on cat.max_price_reference=reference_price)),
tgt as (
SELECT category_name ,category_key,
price_bucket_key 
FROM   dwh_own.dim_category 
)
insert into dwh_own.dim_category(category_name, price_bucket_key, insert_datetime,last_update_datetime, batch_identifier)
select src.category_name,
src.price_bucket_key,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::timestamp,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::timestamp,
1 batch_identifier
from src left join tgt on src.category_name=tgt.category_name
where tgt.category_name is null;


-- Update if there is a change in Price_bucket_key
with src as
(select category_name,price_bucket_key from (
(SELECT  category_name,
case when coalesce(max(price),0)<=100 then 100
when coalesce(max(price),0)<=500 then 500
when coalesce(max(price),0)<=1000 then 1000
when coalesce(max(price),0)<=500 then 5000
when coalesce(max(price),0)<=10000 then 10000
else 20000
end as max_price_reference
FROM   stage_own.categories c join
stage_own.metadata m on m.asin=c.asin 
group by category_name) cat
left join 
dwh_own.dim_price_bucket on cat.max_price_reference=reference_price)),
tgt as (
SELECT category_name ,category_key,
price_bucket_key 
FROM   dwh_own.dim_category 
)
update dwh_own.dim_category main
set last_update_datetime=To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms')::  timestamp, price_bucket_key=src.price_bucket_key
from src join tgt on src.category_name=tgt.category_name
where tgt.category_name is not null and tgt.price_bucket_key!=src.price_bucket_key and main.category_key=tgt.category_key;

END;
