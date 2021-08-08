﻿DROP TABLE if exists dwh_own.dim_calendar_date cascade;

CREATE TABLE dwh_own.dim_calendar_date
(
  date_key integer not null,
  batch_identifier integer not null,
  date date,
  year double precision,
  month double precision,
  month_name text,
  day double precision,
  day_of_year double precision,
  week_day_name text,
  calendar_week double precision,
  quartal text,
  year_quartal text,
  year_month text,
  year_calendar_week text,
  week_end text,
  american_holiday text,
  period text,
  cweek_start date,
  cweek_end date,
  month_start date,
  month_end timestamp without time zone,
  constraint dim_calendar_date_pkey PRIMARY KEY (date_key)
);