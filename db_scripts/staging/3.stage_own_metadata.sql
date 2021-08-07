drop table if exists stage_own.metadata;

create table stage_own.metadata(
batch_identifier integer not null,
asin	character varying(100),
title	character varying,
price	numeric,
imUrl	character varying,
brand 	character varying
--CONSTRAINT metadata_pkey PRIMARY KEY (asin)
);
