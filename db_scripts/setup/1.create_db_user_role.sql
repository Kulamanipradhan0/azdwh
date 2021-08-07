--roles for stage_own schema 
drop role if exists ro_stage_s,ro_stage_suid;
create role ro_stage_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_stage_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
drop user if exists stage_own;
create user stage_own;


--roles for dwh_own schema 
drop role if exists ro_dwh_s,ro_dwh_suid;
create role ro_dwh_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_dwh_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
drop user if exists dwh_own;
create user dwh_own;

--roles for auditing schema 
drop role if exists ro_auditing_s,ro_auditing_suid;
create role ro_auditing_s WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
create role ro_auditing_suid WITH NOSUPERUSER NOCREATEDB NOCREATEROLE NOLOGIN;
drop user if exists auditing_own;
create user auditing_own;

drop role if exists stage_own;
create role stage_own NOSUPERUSER NOCREATEDB;


drop user if exists azdwh_usr;
create user azdwh_usr with CREATEDB LOGIN ENCRYPTED password 'azdwhusr123';