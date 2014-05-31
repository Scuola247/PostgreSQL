--
-- PostgreSQL database cluster dump
--

-- Started on 2014-05-30 19:19:49

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "fol@scuola247.org";
ALTER ROLE "fol@scuola247.org" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION VALID UNTIL 'infinity';
CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION PASSWORD 'password' VALID UNTIL 'infinity';
CREATE ROLE scuola247;
ALTER ROLE scuola247 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION VALID UNTIL 'infinity';
CREATE ROLE scuola247_manager;
ALTER ROLE scuola247_manager WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION VALID UNTIL 'infinity';


--
-- Role memberships
--

GRANT scuola247_manager TO "fol@scuola247.org" GRANTED BY postgres;




-- Completed on 2014-05-30 19:19:49

--
-- PostgreSQL database cluster dump complete
--

