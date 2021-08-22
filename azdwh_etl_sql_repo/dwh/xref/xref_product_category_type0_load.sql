BEGIN;

with src as
(SELECT distinct product_key,
d.category_key
FROM   stage_own.categories c join 
dwh_own.dim_product on asin=product_id and active_flag='Y' join
dwh_own.dim_category d on c.category_name=d.category_name
where 
c.category_name is not null and
c.asin is not null),
tgt as 
(SELECT
  product_key ,
  category_key 
FROM dwh_own.xref_product_category)
insert into dwh_own.xref_product_category(product_key,category_key)
select src.product_key,
src.category_key
from src left join tgt
on src.product_key=tgt.product_key and src.category_key=tgt.category_key
where tgt.product_key is null and tgt.category_key is null;



-- Load Error log for Product Referential Integrity check 
insert into auditing_own.error_log
(batch_identifier,process_identifier,process_start_time,source_system_name,source_file_name,primary_key_columns,
primary_key_columns_value,error_column,error_column_value,error_description,flag)
select 1 batch_identifier,
1 process_identifier,
now() process_start_time,
'azdwh' source_system_name,
'metadata.json.gz' source_file_name,
'asin' primary_key_columns,
asin ,
'asin' error_column,
asin error_column_value,
'Referencial Integrity Failed',
'REFINT' error_flag
from
(SELECT distinct asin
FROM   stage_own.categories c left join 
dwh_own.dim_product on asin=product_id and active_flag='Y'
where 
product_key is null)a ;



-- Load Error log for Category Referential Integrity check 
insert into auditing_own.error_log
(batch_identifier,process_identifier,process_start_time,source_system_name,source_file_name,primary_key_columns,
primary_key_columns_value,error_column,error_column_value,error_description,flag)
select 1 batch_identifier,
1 process_identifier,
now() process_start_time,
'azdwh' source_system_name,
'metadata.json.gz' source_file_name,
'category_name' primary_key_columns,
category_name ,
'category_name' error_column,
category_name error_column_value,
'Referencial Integrity Failed',
'REFINT' error_flag
from
(SELECT distinct c.category_name
FROM   stage_own.categories c left join 
dwh_own.dim_category d on c.category_name=d.category_name
where 
category_key is null)a ;


END;