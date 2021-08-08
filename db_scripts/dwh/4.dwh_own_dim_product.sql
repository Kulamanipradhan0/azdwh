drop table if exists dwh_own.dim_product CASCADE;

create table dwh_own.dim_product(
product_key	bigserial not null,
batch_identifier integer not null,
record_start_date integer not null ,
record_end_date integer default 99991231 not null,
insert_datetime timestamp without time zone  not null,
last_update_datetime timestamp without time zone  not null,
active_flag char(1) default 'Y' not null,
product_id character varying(100) not null,
title character varying,
imurl character varying,
product_price numeric,
CONSTRAINT dim_product_pkey PRIMARY KEY (product_key)
);


create index dim_product_ix_01 on dwh_own.dim_product (active_flag,product_id);

create index dim_product_ix_02 on dwh_own.dim_product (record_start_date,record_end_date,product_id);