drop table if exists dwh_own.dim_category CASCADE;
DROP MATERIALIZED VIEW  IF EXISTS dwh_own.mview_review_olap CASCADE;
drop table if exists dwh_own.dim_price_bucket ;

create table dwh_own.dim_price_bucket(
price_bucket_key	serial not null,
batch_identifier integer not null,
insert_datetime timestamp without time zone default To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::timestamp not null,
reference_price numeric,
first_interval integer,
second_interval integer,
third_interval integer,
fourth_interval integer,
CONSTRAINT dim_price_bucket_pkey PRIMARY KEY (price_bucket_key)
);
create index dim_price_bucket_ix_01 on dwh_own.dim_price_bucket (price_bucket_key);

