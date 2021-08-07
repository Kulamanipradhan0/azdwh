drop table if exists stage_own.review;

create table stage_own.review(
batch_identifier integer not null,
reviewer_id character varying(100),
asin	character varying(100),
reviewer_name	character varying,
helpful_score	smallint,
helpful_total smallint,
review_text	character varying,
overall	numeric,
summary	character varying,
unix_review_time	bigint,
review_time	character varying
);