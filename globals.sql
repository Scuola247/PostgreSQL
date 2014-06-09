SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE scuola247;
ALTER ROLE scuola247 WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION VALID UNTIL 'infinity';
CREATE ROLE scuola247_manager;
ALTER ROLE scuola247_manager WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION VALID UNTIL 'infinity';


--
-- Role memberships
--

GRANT scuola247_manager TO postgres GRANTED BY postgres;
GRANT scuola247 TO postgres GRANTED BY postgres;

