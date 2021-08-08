drop table if exists dwh_own.dim_reviewer CASCADE;

create table dwh_own.dim_reviewer(
reviewer_key	bigserial not null,
batch_identifier integer not null,
record_start_date integer not null ,
record_end_date integer default 99991231 not null,
insert_datetime timestamp without time zone  not null,
last_update_datetime timestamp without time zone  not null,
active_flag char(1) default 'Y' not null,
reviewer_id character varying(100) not null,
reviewer_name character varying,
CONSTRAINT dim_reviewer_pkey PRIMARY KEY (reviewer_key)
);

create index dim_reviewer_ix_01 on dwh_own.dim_reviewer (active_flag,reviewer_id);

create index dim_reviewer_ix_02 on dwh_own.dim_reviewer (record_start_date,record_end_date,reviewer_id);