
drop table if exists stage_own.related_metadata;

create table stage_own.related_metadata(
batch_identifier integer not null,
asin	character varying(100),
related_type	character varying(50),
related_asin character varying(100)
--CONSTRAINT related_metadata_pkey PRIMARY KEY (asin, related_type, related_asin)
);