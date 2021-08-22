BEGIN;

--Load Fac Review
insert into dwh_own.fac_review (reviewer_key,product_key,helpful_score,helpful_total,summary,review_text,overall,review_date,batch_identifier,sequence_number)
SELECT distinct 
       reviewer_key, 
       product_key, 
       helpful_score, 
       helpful_total, 
       summary, 
       review_text, 
       overall, 
       To_char(review_time, 'yyyymmdd') :: INTEGER as review_date,
       1 as batch_identifier,
	(select coalesce(max(sequence_number),0)+1 as next_sequence_number from dwh_own.fac_review where batch_identifier=1)
FROM   stage_own.review r join
dwh_own.dim_product p on product_id=asin and p.active_flag='Y' join
dwh_own.dim_reviewer dr on r.reviewer_id=dr.reviewer_id and dr.active_flag='Y'






-- Load Error log for Product Referential Integrity check 
insert into auditing_own.error_log
(batch_identifier,process_identifier,process_start_time,source_system_name,source_file_name,primary_key_columns,
primary_key_columns_value,error_column,error_column_value,error_description,flag)
select 1 batch_identifier,
1 process_identifier,
now() process_start_time,
'azdwh' source_system_name,
'review.json.gz' source_file_name,
'asin' primary_key_columns,
asin ,
'asin' error_column,
asin error_column_value,
'Referencial Integrity Failed',
'REFINT' error_flag
from
(SELECT distinct asin
FROM   stage_own.review r left join 
dwh_own.dim_product p on product_id=asin and p.active_flag='Y' 
where 
product_key is null)a ;




-- Load Error log for Reviewer Referential Integrity check 
insert into auditing_own.error_log
(batch_identifier,process_identifier,process_start_time,source_system_name,source_file_name,primary_key_columns,
primary_key_columns_value,error_column,error_column_value,error_description,flag)
select 1 batch_identifier,
1 process_identifier,
now() process_start_time,
'azdwh' source_system_name,
'review.json.gz' source_file_name,
'reviewer_id' primary_key_columns,
reviewer_id ,
'reviewer_id' error_column,
reviewer_id error_column_value,
'Referencial Integrity Failed',
'REFINT' error_flag
from
(SELECT distinct r.reviewer_id
FROM   stage_own.review r left join 
dwh_own.dim_reviewer dr on r.reviewer_id=dr.reviewer_id and dr.active_flag='Y' 
where 
dr.reviewer_key is null)a ;


END;