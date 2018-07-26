--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "employee-a@scuola-1.it";
ALTER ROLE "employee-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "employee-b@scuola-1.it";
ALTER ROLE "employee-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "employee-c@scuola-2.it";
ALTER ROLE "employee-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "employee-d@scuola-2.it";
ALTER ROLE "employee-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "employee-e@scuola-28961.it";
ALTER ROLE "employee-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "employee-f@scuola-28961.it";
ALTER ROLE "employee-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-a@scuola-1.it";
ALTER ROLE "executive-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-b@scuola-1.it";
ALTER ROLE "executive-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-c@scuola-2.it";
ALTER ROLE "executive-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-d@scuola-2.it";
ALTER ROLE "executive-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-e@scuola-28961.it";
ALTER ROLE "executive-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "executive-f@scuola-28961.it";
ALTER ROLE "executive-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "federico.tomelleri@gmail.com";
ALTER ROLE "federico.tomelleri@gmail.com" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md50005a4b0ccaccbd18bcf64e90e242c90' VALID UNTIL 'infinity';
CREATE ROLE postgrest;
ALTER ROLE postgrest WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE postgrest IS 'Role usato dal tools PostGREST (un Rest Server) per l''impersonificazione delle richieste anonime';
CREATE ROLE "relative-a@scuola-1.it";
ALTER ROLE "relative-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "relative-b@scuola-1.it";
ALTER ROLE "relative-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "relative-c@scuola-2.it";
ALTER ROLE "relative-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "relative-d@scuola-2.it";
ALTER ROLE "relative-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "relative-e@scuola-28961.it";
ALTER ROLE "relative-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE "relative-f@scuola-28961.it";
ALTER ROLE "relative-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;
CREATE ROLE scuola247_employee;
ALTER ROLE scuola247_employee WITH NOSUPERUSER INHERIT CREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_employee IS 'Group for the school''s employees';
CREATE ROLE scuola247_executive;
ALTER ROLE scuola247_executive WITH NOSUPERUSER INHERIT CREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_executive IS 'Group for the school''s executive';
CREATE ROLE scuola247_relative;
ALTER ROLE scuola247_relative WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_relative IS 'Group for the school''s relative';
CREATE ROLE scuola247_student;
ALTER ROLE scuola247_student WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_student IS 'Group for the school''s student';
CREATE ROLE scuola247_supervisor;
ALTER ROLE scuola247_supervisor WITH NOSUPERUSER INHERIT CREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_supervisor IS 'Group for the system''s administratiom';
CREATE ROLE scuola247_teacher;
ALTER ROLE scuola247_teacher WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_teacher IS 'Group for the school''s teachers';
CREATE ROLE scuola247_user;
ALTER ROLE scuola247_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_user IS 'Group for the school''s users';
CREATE ROLE "student-a@scuola-1.it";
ALTER ROLE "student-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5cda715bfeb961da961fdea219efe9c1c';
CREATE ROLE "student-b@scuola-1.it";
ALTER ROLE "student-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md526fd36c6ccb29176bca8840212aca4f8';
CREATE ROLE "student-c@scuola-2.it";
ALTER ROLE "student-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5bb28ad8339bc91c6c46d94e73dd69dd0';
CREATE ROLE "student-d@scuola-2.it";
ALTER ROLE "student-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md50f287dd85c6ddcdd74aaf0f950ac68c5';
CREATE ROLE "student-e@scuola-28961.it";
ALTER ROLE "student-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5f47aad6c3251a068f5e5cb4eb9b39f00';
CREATE ROLE "student-f@scuola-28961.it";
ALTER ROLE "student-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5313cfdd75c782474082a774384c31067';
CREATE ROLE "supervisor@scuola.it";
ALTER ROLE "supervisor@scuola.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "teacher-a@scuola-1.it";
ALTER ROLE "teacher-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md57b25b2722ec8adb05d4a242ad5921e96';
CREATE ROLE "teacher-b@scuola-1.it";
ALTER ROLE "teacher-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md593e8c97cef02d3df89b35ba61cbe43e6';
CREATE ROLE "teacher-c@scuola-2.it";
ALTER ROLE "teacher-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5d4faa920efba56722873075f8ee7315a';
CREATE ROLE "teacher-d@scuola-2.it";
ALTER ROLE "teacher-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md56747b718387af4ea328e35a24e6c36e3';
CREATE ROLE "teacher-e@scuola-28961.it";
ALTER ROLE "teacher-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5a734b43a2921b0053ac14091bce6b067';
CREATE ROLE "teacher-f@scuola-28961.it";
ALTER ROLE "teacher-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5dc988a1b8e947aff061d7697624edcc2';
CREATE ROLE "user@scuola.it";
ALTER ROLE "user@scuola.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE workshop;
ALTER ROLE workshop WITH SUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5401c132cc918af82ce98bc5b888184fb';


--
-- Role memberships
--

GRANT postgrest TO postgres GRANTED BY postgres;
GRANT scuola247_employee TO "employee-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_employee TO "employee-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_employee TO "employee-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_employee TO "employee-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_employee TO "employee-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_employee TO "employee-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_employee TO postgres GRANTED BY postgres;
GRANT scuola247_employee TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_executive TO "executive-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_executive TO "executive-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_executive TO "executive-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_executive TO "executive-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_executive TO "executive-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_executive TO "executive-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_executive TO postgres GRANTED BY postgres;
GRANT scuola247_executive TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_relative TO postgres GRANTED BY postgres;
GRANT scuola247_relative TO "relative-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "relative-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "relative-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "relative-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "relative-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO "relative-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_student TO postgres GRANTED BY postgres;
GRANT scuola247_student TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_student TO "student-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_student TO "student-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_student TO "student-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_student TO "student-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_student TO "student-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_student TO "student-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_supervisor TO "federico.tomelleri@gmail.com" GRANTED BY postgres;
GRANT scuola247_supervisor TO postgres GRANTED BY postgres;
GRANT scuola247_supervisor TO "supervisor@scuola.it" GRANTED BY postgres;
GRANT scuola247_teacher TO postgres GRANTED BY postgres;
GRANT scuola247_teacher TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_teacher TO "teacher-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_user TO postgres GRANTED BY postgres;
GRANT scuola247_user TO scuola247_employee GRANTED BY postgres;
GRANT scuola247_user TO scuola247_executive GRANTED BY postgres;
GRANT scuola247_user TO scuola247_relative GRANTED BY postgres;
GRANT scuola247_user TO scuola247_student GRANTED BY postgres;
GRANT scuola247_user TO scuola247_supervisor GRANTED BY postgres;
GRANT scuola247_user TO scuola247_teacher GRANTED BY postgres;




--
-- PostgreSQL database cluster dump complete
--

