--roles for stage_own schema 
drop role if exists ro_stage_s,ro_stage_suid;
create role ro_stage_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_stage_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create user stage_own;


--roles for dwh_own schema 
drop role if exists ro_dwh_s,ro_dwh_suid;
create role ro_dwh_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_dwh_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create user dwh_own;

--roles for auditing schema 
drop role if exists ro_auditing_s,ro_auditing_suid;
create role ro_auditing_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_auditing_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create user auditing_own;

create role stage_own NOSUPERUSER,NOCREATEDB
create tablespace azdwh_tb LOCATION '/var/lib/postgresql/azdwh_data';
create tablespace azdwh_ix LOCATION '/var/lib/postgresql/azdwh_data';

create user azdwh_usr with CREATEDB LOGIN ENCRYPTED password 'azdwhusr123';
create database azdwh with owner=azdwh_usr tablespace=azdwh_tb connection limit=200;

