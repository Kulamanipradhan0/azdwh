--Upsert Case

BEGIN;



-- New Product Load to Dimension
with src as(
SELECT DISTINCT asin,title, 
                price,
                imurl
FROM   stage_own.metadata )  ,
tgt as (
SELECT product_id,
       title, 
       product_price,
       imurl
       product_key 
FROM   dwh_own.dim_product 
WHERE  active_flag = 'Y')
insert into dwh_own.dim_product (product_id,title,product_price,imurl,record_start_date, insert_datetime, last_update_datetime,batch_identifier)
select 
src.asin,
src.title,
src.price,
src.imurl,
To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS last_update_datetime,
1 batch_identifier
from 
src left join tgt on
src.asin=tgt.product_id
where tgt.product_id is null;




-- Insert changed Product as a new record 
with src as(
SELECT DISTINCT asin,title, 
                price,
                imurl
FROM   stage_own.metadata )  ,
tgt as (
SELECT product_id,
       title, 
       product_price,
       imurl,
       product_key 
FROM   dwh_own.dim_product 
WHERE  active_flag = 'Y')
insert into dwh_own.dim_product (product_id,title,product_price,imurl,record_start_date, insert_datetime, last_update_datetime,batch_identifier)
select 
src.asin,
src.title,
src.price,
src.imurl,
To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS last_update_datetime,
1 batch_identifier
from 
src left join tgt on
src.asin=tgt.product_id
where (tgt.product_id is not null and md5(src.title||','||src.imurl||','||src.price)!=md5(tgt.title||','|| tgt.imurl||','|| tgt.product_price));


-- Update changed review to inactive 
with src as(
SELECT DISTINCT asin,title, 
                price,
                imurl
FROM   stage_own.metadata )  ,
tgt as (
SELECT product_id,
       title, 
       product_price,
       imurl,
       product_key 
FROM   dwh_own.dim_product 
WHERE  active_flag = 'Y')
update dwh_own.dim_product main
set last_update_datetime=To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms')::  timestamp, active_flag='N', record_end_date=To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER 
from 
src join tgt on
src.asin=tgt.product_id
where (tgt.product_id is not null and md5(src.title||','||src.imurl||','||src.price)!=md5(tgt.title||','|| tgt.imurl||','|| tgt.product_price) and main.product_key=tgt.product_key);


END;