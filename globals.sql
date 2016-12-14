--
-- PostgreSQL database cluster dump
--
--
-- l'utente postgres è stato tolto
-- nessun utente ha la password
--

-- Started on 2016-12-14 06:52:45

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE "fol@scuola247.it";
ALTER ROLE "fol@scuola247.it" WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE "manager@scuola247.it";
ALTER ROLE "manager@scuola247.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
CREATE ROLE scuola247_manager;
ALTER ROLE scuola247_manager WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
COMMENT ON ROLE scuola247_manager IS 'Tutte le autorizzazioni tolte al ruolo public per il database scuola247 sono date a questo ruolo che contiene gli utenti gestori';
CREATE ROLE scuola247_user;
ALTER ROLE scuola247_user WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB NOLOGIN NOREPLICATION NOBYPASSRLS VALID UNTIL 'infinity';
COMMENT ON ROLE scuola247_user IS 'Sul database scuola247 è tolto al ruolo predefinito PUBLIC qualsiasi autorizzazione.
Questo ruolo abilita al login e al richiamo delle funzioni a cui è delegato il controllo della sicurezza.
Concettualmente quindi il singolo utente non accede mai direttamente alle tabelle o alle viste ma solo tramite funzioni.
';
CREATE ROLE "teacher@scuola247.it";
ALTER ROLE "teacher@scuola247.it" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md547a6b361760f88a0422c2789806a6151' VALID UNTIL 'infinity';

--
-- Role memberships
--

GRANT scuola247_manager TO "fol@scuola247.it" GRANTED BY postgres;
GRANT scuola247_manager TO "manager@scuola247.it" GRANTED BY postgres;
GRANT scuola247_user TO "fol@scuola247.it" GRANTED BY postgres;
GRANT scuola247_user TO "manager@scuola247.it" GRANTED BY postgres;
GRANT scuola247_user TO "teacher@scuola247.it" GRANTED BY postgres;


-- Completed on 2016-12-14 06:52:45

--
-- PostgreSQL database cluster dump complete
--
