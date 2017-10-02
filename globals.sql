/* 
Copyright (C) 2014-2017 FULCRO SRL (http://www.fulcro.net)
  
This file is part of Scuola247 project (http://www.scuola247.org).

Scuola247 is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License version 3
as published by the Free Software Foundation.

Scuola247 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>.
*/

/*
PLEASE 
PLEASE
PLEASE

Note that the password: 'md5 xxxxxx' is NOT a valid password.
please set a newone before to run the script

PLEASE 
PLEASE
PLEASE
*/

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "manager-a@scuola-1.it";
ALTER ROLE "manager-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "manager-b@scuola-1.it";
ALTER ROLE "manager-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "manager-c@scuola-2.it";
ALTER ROLE "manager-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "manager-d@scuola-2.it";
ALTER ROLE "manager-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "manager-e@scuola-28961.it";
ALTER ROLE "manager-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "manager-f@scuola-28961.it";
ALTER ROLE "manager-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-a@scuola-1.it";
ALTER ROLE "parent-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-b@scuola-1.it";
ALTER ROLE "parent-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-c@scuola-2.it";
ALTER ROLE "parent-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-d@scuola-2.it";
ALTER ROLE "parent-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-e@scuola-28961.it";
ALTER ROLE "parent-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "parent-f@scuola-28961.it";
ALTER ROLE "parent-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE postgrest;
ALTER ROLE postgrest WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE postgrest IS 'Role usato dal tools PostGREST (un Rest Server) per l''impersonificazione delle richieste anonime';
CREATE ROLE scuola247_employee;
ALTER ROLE scuola247_employee WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_employee IS 'Group for the school''s employees';
CREATE ROLE scuola247_executive;
ALTER ROLE scuola247_executive WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_executive IS 'Group for the school''s executive';
CREATE ROLE scuola247_relative;
ALTER ROLE scuola247_relative WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_relative IS 'Group for the school''s relative';
CREATE ROLE scuola247_student;
ALTER ROLE scuola247_student WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_student IS 'Group for the school''s student';
CREATE ROLE scuola247_supervisor;
ALTER ROLE scuola247_supervisor WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_supervisor IS 'Group for the system''s administratiom';
CREATE ROLE scuola247_teacher;
ALTER ROLE scuola247_teacher WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_teacher IS 'Group for the school''s teachers';
CREATE ROLE scuola247_user;
ALTER ROLE scuola247_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS;
COMMENT ON ROLE scuola247_user IS 'Group for the school''s users';
CREATE ROLE "student-a@scuola-1.it";
ALTER ROLE "student-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "student-b@scuola-1.it";
ALTER ROLE "student-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "student-c@scuola-2.it";
ALTER ROLE "student-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "student-d@scuola-2.it";
ALTER ROLE "student-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "student-e@scuola-28961.it";
ALTER ROLE "student-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "student-f@scuola-28961.it";
ALTER ROLE "student-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-a@scuola-1.it";
ALTER ROLE "teacher-a@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-b@scuola-1.it";
ALTER ROLE "teacher-b@scuola-1.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-c@scuola-2.it";
ALTER ROLE "teacher-c@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-d@scuola-2.it";
ALTER ROLE "teacher-d@scuola-2.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-e@scuola-28961.it";
ALTER ROLE "teacher-e@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';
CREATE ROLE "teacher-f@scuola-28961.it";
ALTER ROLE "teacher-f@scuola-28961.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5 xxxxxx';

--
-- Role memberships
--

GRANT postgrest TO postgres GRANTED BY postgres;
GRANT scuola247_employee TO postgres GRANTED BY postgres;
GRANT scuola247_executive TO "manager-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_executive TO "manager-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_executive TO "manager-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_executive TO "manager-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_executive TO "manager-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_executive TO "manager-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_executive TO postgres GRANTED BY postgres;
GRANT scuola247_relative TO "parent-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "parent-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "parent-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "parent-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "parent-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO "parent-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO postgres GRANTED BY postgres;
GRANT scuola247_relative TO "student-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "student-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "student-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "student-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "student-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO "student-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-a@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-b@scuola-1.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-c@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-d@scuola-2.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-e@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_relative TO "teacher-f@scuola-28961.it" GRANTED BY postgres;
GRANT scuola247_student TO postgres GRANTED BY postgres;
GRANT scuola247_supervisor TO postgres GRANTED BY postgres;
GRANT scuola247_teacher TO postgres GRANTED BY postgres;
GRANT scuola247_user TO postgres GRANTED BY postgres;
GRANT scuola247_user TO scuola247_executive GRANTED BY postgres;
