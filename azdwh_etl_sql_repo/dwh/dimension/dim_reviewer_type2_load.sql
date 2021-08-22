--Upsert Case

BEGIN;



-- New Reviews Load to Dimension
with src as(
SELECT DISTINCT reviewer_id COLLATE "C" AS reviewer_id_src, 
                reviewer_name AS reviewer_name_src
                --To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date, 
                --To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime, 
                --'N' AS inactive_flag ,
                --1 as batch_identifier
FROM   stage_own.review )  ,
tgt as (
SELECT reviewer_id COLLATE "C" AS reviewer_id_tgt, 
       reviewer_name           AS reviewer_name_tgt, 
       reviewer_key 
FROM   dwh_own.dim_reviewer 
WHERE  active_flag = 'Y')
insert into dwh_own.dim_reviewer (reviewer_id,reviewer_name,record_start_date, insert_datetime, last_update_datetime,batch_identifier)
select 
src.reviewer_id_src,
src.reviewer_name_src,
To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS last_update_datetime,
1 batch_identifier
from 
src left join tgt on
src.reviewer_id_src=tgt.reviewer_id_tgt
where tgt.reviewer_id_tgt is null;




-- Insert changed review as a new record 
with src as(
SELECT DISTINCT reviewer_id COLLATE "C" AS reviewer_id_src, 
                reviewer_name AS reviewer_name_src
                --To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date, 
                --To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime, 
                --'N' AS inactive_flag ,
                --1 as batch_identifier
FROM   stage_own.review )  ,
tgt as (
SELECT reviewer_id COLLATE "C" AS reviewer_id_tgt, 
       reviewer_name           AS reviewer_name_tgt, 
       reviewer_key 
FROM   dwh_own.dim_reviewer 
WHERE  active_flag = 'Y')
insert into dwh_own.dim_reviewer (reviewer_id,reviewer_name,record_start_date, insert_datetime, last_update_datetime,batch_identifier)
select 
src.reviewer_id_src,
src.reviewer_name_src,
To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime,
To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS last_update_datetime,
1 batch_identifier
from 
src join tgt on
src.reviewer_id_src=tgt.reviewer_id_tgt
where (tgt.reviewer_id_tgt is not null and md5(src.reviewer_name_src)!=md5(tgt.reviewer_name_tgt));


-- Update changed review to inactive 
with src as(
SELECT DISTINCT reviewer_id COLLATE "C" AS reviewer_id_src, 
                reviewer_name AS reviewer_name_src
                --To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER AS start_date, 
                --To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::  timestamp AS insert_datetime, 
                --'N' AS inactive_flag ,
                --1 as batch_identifier
FROM   stage_own.review )  ,
tgt as (
SELECT reviewer_id COLLATE "C" AS reviewer_id_tgt, 
       reviewer_name           AS reviewer_name_tgt, 
       reviewer_key 
FROM   dwh_own.dim_reviewer 
WHERE  active_flag = 'Y')
update dwh_own.dim_reviewer main
set last_update_datetime=To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms')::  timestamp, active_flag='N', record_end_date=To_char(CURRENT_TIMESTAMP, 'yyyymmdd') :: INTEGER 
from 
src join tgt on
src.reviewer_id_src=tgt.reviewer_id_tgt
where (tgt.reviewer_id_tgt is not null and md5(src.reviewer_name_src)!=md5(tgt.reviewer_name_tgt) and main.reviewer_key=tgt.reviewer_key);


END;