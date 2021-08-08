drop table if exists dwh_own.fac_review CASCADE;

create table dwh_own.fac_review(
reviewer_key	bigint REFERENCES dwh_own.dim_reviewer,
product_key bigint REFERENCES dwh_own.dim_product,
batch_identifier integer not null,
insert_datetime timestamp without time zone default To_char(CURRENT_TIMESTAMP, 'yyyy-mm-dd hh:mi:ss.ms') ::timestamp not null,
active_flag char(1)  not null default 'Y',
sequence_number integer not null,
helpful_score smallint,
helpful_total smallint,
overall numeric,
summary character varying,
review_text character varying,
review_date integer ,
CONSTRAINT fac_review_pkey PRIMARY KEY (reviewer_key,product_key,insert_datetime)
);

create index fac_review_ix_01 on dwh_own.fac_review (batch_identifier);