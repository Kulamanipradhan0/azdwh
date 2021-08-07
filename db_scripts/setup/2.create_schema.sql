--Create schema for staging
create schema IF NOT EXISTS stage_own;

grant all on schema stage_own to stage_own,azdwh_usr;

--Create schema for dwh
create schema IF NOT EXISTS dwh_own;

grant all on schema dwh_own to dwh_own,azdwh_usr;


--Create schema for auditing
create schema IF NOT EXISTS auditing_own;

grant all on schema auditing_own to auditing_own,azdwh_usr;