--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.0
-- Dumped by pg_dump version 9.3.0
-- Started on 2014-05-30 19:19:21

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 272 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 3298 (class 0 OID 0)
-- Dependencies: 272
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 274 (class 3079 OID 3917557)
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- TOC entry 3299 (class 0 OID 0)
-- Dependencies: 274
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- TOC entry 273 (class 3079 OID 3918079)
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- TOC entry 3300 (class 0 OID 0)
-- Dependencies: 273
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = public, pg_catalog;

--
-- TOC entry 1247 (class 1247 OID 3918100)
-- Name: anno_corso; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN anno_corso AS smallint
	CONSTRAINT anno_corso_range CHECK (((VALUE >= 1) AND (VALUE <= 6)));


ALTER DOMAIN public.anno_corso OWNER TO postgres;

--
-- TOC entry 1251 (class 1247 OID 3918102)
-- Name: giorno_settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN giorno_settimana AS smallint
	CONSTRAINT giorno_settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN public.giorno_settimana OWNER TO postgres;

--
-- TOC entry 1253 (class 1247 OID 3918105)
-- Name: lingua; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lingua AS ENUM (
    'it',
    'en',
    'de'
);


ALTER TYPE public.lingua OWNER TO postgres;

--
-- TOC entry 1255 (class 1247 OID 3918111)
-- Name: periodo_lezione; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN periodo_lezione AS smallint
	CONSTRAINT periodo_lezione_range CHECK (((VALUE >= 1) AND (VALUE <= 24)));


ALTER DOMAIN public.periodo_lezione OWNER TO postgres;

--
-- TOC entry 1257 (class 1247 OID 3918114)
-- Name: relazione_personale; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE relazione_personale AS ENUM (
    'Padre/Madre',
    'Fratello/Sorella',
    'Nonno/a',
    'Zio/a',
    'Tutore'
);


ALTER TYPE public.relazione_personale OWNER TO postgres;

--
-- TOC entry 1259 (class 1247 OID 3918126)
-- Name: ripartizione_geografica; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ripartizione_geografica AS ENUM (
    'Nord-ovest',
    'Nord-est',
    'Centro',
    'Sud',
    'Isole'
);


ALTER TYPE public.ripartizione_geografica OWNER TO postgres;

--
-- TOC entry 1260 (class 1247 OID 3918138)
-- Name: ruolo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ruolo AS ENUM (
    'Alunno',
    'Impiegato',
    'Dirigente',
    'Docente',
    'Famigliare',
    'Gestore'
);


ALTER TYPE public.ruolo OWNER TO postgres;

--
-- TOC entry 1262 (class 1247 OID 3918152)
-- Name: sesso; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sesso AS ENUM (
    'M',
    'F'
);


ALTER TYPE public.sesso OWNER TO postgres;

--
-- TOC entry 1249 (class 1247 OID 3918157)
-- Name: settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN settimana AS smallint
	CONSTRAINT settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 4)));


ALTER DOMAIN public.settimana OWNER TO postgres;

--
-- TOC entry 1254 (class 1247 OID 3918160)
-- Name: stato_civile; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE stato_civile AS ENUM (
    'Celibe/Nubile',
    'Coniugato/a',
    'Vedovo/a',
    'Separato/a Divorziato/a'
);


ALTER TYPE public.stato_civile OWNER TO postgres;

--
-- TOC entry 1258 (class 1247 OID 3918170)
-- Name: tipo_giustificazione; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_giustificazione AS ENUM (
    'assenza',
    'ritardo',
    'uscita'
);


ALTER TYPE public.tipo_giustificazione OWNER TO postgres;

--
-- TOC entry 1261 (class 1247 OID 3918178)
-- Name: tipo_indirizzo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_indirizzo AS ENUM (
    'Domicilio',
    'Lavoro',
    'Residenza'
);


ALTER TYPE public.tipo_indirizzo OWNER TO postgres;

--
-- TOC entry 1263 (class 1247 OID 3918186)
-- Name: tipo_qualifica; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_qualifica AS ENUM (
    'Root',
    'Asse',
    'Competenza',
    'Conoscenza',
    'Abilità'
);


ALTER TYPE public.tipo_qualifica OWNER TO postgres;

--
-- TOC entry 1264 (class 1247 OID 3918198)
-- Name: tipo_soggetto; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_soggetto AS ENUM (
    'Persona fisica',
    'Persona giuridica'
);


ALTER TYPE public.tipo_soggetto OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 3918203)
-- Name: alunni_by_classe(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION alunni_by_classe(p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
	cur refcursor;
	function_name varchar = 'alunni_by_classe';
BEGIN 
	IF in_uno_dei_ruoli('{"Gestore","Dirigente","Docente"}') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
	--		       p.foto_miniatura
			       encode(foto_miniatura,'base64') as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone p ON ca.alunno = p.persona
			 WHERE ca.classe = p_classe
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF nel_ruolo('Famigliare') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
	--		       p.foto_miniatura
			       encode(foto_miniatura,'base64') as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone p ON ca.alunno = p.persona
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
			 WHERE ca.classe = p_classe
			   AND rel.persona_relazionata = session_utente()
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF nel_ruolo('Alunno') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
	--		       p.foto_miniatura
			       encode(foto_miniatura,'base64') as foto_miniatura
			  FROM classi_alunni ca
		          JOIN persone p ON ca.alunno = p.persona
			 WHERE ca.classe = p_classe
			   AND ca.alunno = session_utente()
		      ORDER BY cognome, nome, codice_fiscale;
	ELSE
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = messaggi_sistema_locale(function_name,1),
		DETAIL = format(messaggi_sistema_locale(function_name,2), session_user),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
	RETURN cur;	        
END;
$$;


ALTER FUNCTION public.alunni_by_classe(p_classe bigint) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 3918204)
-- Name: anni_scolastici_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messaggi di sistema utilizzati dalla funzione 
 
DELETE FROM messaggi_sistema WHERE function_name = 'anni_scolastici_del';


INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_del',1,'it','Non è stata trovata nessuna riga nella tabella ''anni_scolastici'' con: ''revisione'' = ''%s'',  ''anno_scolastico'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_del',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_del',3,'it','Controllare il valore di: ''revisione'', ''anno_scolastico'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'anni_scolastici_del';

BEGIN
    DELETE FROM anni_scolastici t
	      WHERE t.anno_scolastico = p_anno_scolastico AND
	            xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_anno_scolastico),
	     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	     HINT = messaggi_sistema_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 3918205)
-- Name: anni_scolastici_ins(bigint, character varying, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'anni_scolastici_ins';

BEGIN 

    INSERT INTO anni_scolastici (istituto, descrizione, inizio, fine_lezioni)
         VALUES (p_istituto, p_descrizione, p_inizio, p_fine_lezioni);
         
    SELECT currval('pk_seq') INTO p_anno_scolastico;
    SELECT xmin::text::bigint INTO p_rv FROM anni_scolastici WHERE anno_scolastico = p_anno_scolastico;
END;
$$;


ALTER FUNCTION public.anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 3918206)
-- Name: anni_scolastici_ins(bigint, character varying, date, date, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'anni_scolastici_ins';

BEGIN 

    INSERT INTO anni_scolastici (istituto, descrizione, inizio, fine_lezioni, inizio_lezioni, fine)
         VALUES (p_istituto, p_descrizione, p_inizio, p_fine_lezioni, p_inizio_lezioni, p_fine);
         
    SELECT currval('pk_seq') INTO p_anno_scolastico;
    SELECT xmin::text::bigint INTO p_rv FROM anni_scolastici WHERE anno_scolastico = p_anno_scolastico;
END;
$$;


ALTER FUNCTION public.anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) OWNER TO postgres;

--
-- TOC entry 494 (class 1255 OID 3918207)
-- Name: anni_scolastici_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_list(p_istituto bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'anni_scolastici_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, anno_scolastico, istituto, descrizione, inizio, fine, inizio_lezioni, fine_lezioni 
		       FROM anni_scolastici 
		      WHERE istituto = p_istituto
		   ORDER BY descrizione;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.anni_scolastici_list(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 3918208)
-- Name: anni_scolastici_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione
 
DELETE FROM messaggi_sistema WHERE function_name = 'anni_scolastici_sel';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_sel',1,'it','Non è stata trovata nessuna riga nella tabella ''anni_scolastici'' con:  ''anno_scolastico'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_sel',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_sel',3,'it','Controllare il valore di: ''anno_scolastico'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'anni_scolastici_sel';

BEGIN

	SELECT xmin::text::bigint, anno_scolastico, istituto, descrizione, inizio, fine_lezioni, inizio_lezioni, fine
	INTO p_rv, p_anno_scolastico, p_istituto, p_descrizione, p_inizio, p_fine_lezioni, p_inizio_lezioni, p_fine
	FROM anni_scolastici
	WHERE anno_scolastico = p_anno_scolastico;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_anno_scolastico),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 3918209)
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'anni_scolastici_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''anni_scolastici'' con: ''revisione'' = ''%s'',  ''anno_scolastico'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',3,'it','Controllare il valore di: ''revisione'', ''anno_scolastico'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'anni_scolastici_upd';

BEGIN

	UPDATE anni_scolastici SET anno_scolastico = p_anno_scolastico,istituto = p_istituto,descrizione = p_descrizione,inizio = p_inizio,fine_lezioni = p_fine_lezioni
    	WHERE anno_scolastico = p_anno_scolastico AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_anno_scolastico),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 3918210)
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'anni_scolastici_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''anni_scolastici'' con: ''revisione'' = ''%s'',  ''anno_scolastico'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('anni_scolastici_upd',3,'it','Controllare il valore di: ''revisione'', ''anno_scolastico'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'anni_scolastici_upd';

BEGIN

	UPDATE anni_scolastici SET anno_scolastico = p_anno_scolastico,istituto = p_istituto,descrizione = p_descrizione,inizio = p_inizio,fine_lezioni = p_fine_lezioni,inizio_lezioni = p_inizio_lezioni,fine = p_fine
    	WHERE anno_scolastico = p_anno_scolastico AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_anno_scolastico),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) OWNER TO postgres;

--
-- TOC entry 445 (class 1255 OID 3918211)
-- Name: argomenti_by_materia_classe(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION argomenti_by_materia_classe(p_materia bigint, p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT a.xmin::text::bigint AS rv,
		       a.argomento,
		       a.descrizione
		  FROM argomenti a, classi c 
		 WHERE c.classe = p_classe
		   AND a.materia = p_materia
		   AND a.anno_corso = c.anno_corso
		   AND a.indirizzo_scolastico = c.indirizzo_scolastico  
	      ORDER BY a.descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.argomenti_by_materia_classe(p_materia bigint, p_classe bigint) OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 3918212)
-- Name: classe_alunni_ex(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classe_alunni_ex(p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT classe,
		       alunno,
		       COALESCE(foto_miniatura,foto_miniatura_default()) as foto_miniatura,
		       codice_fiscale,
		       nome,
		       cognome,
		       sesso,
		       nato,
		       comune_nascita_descrizione,
		       assenze,
		       assenze_non_giustificate,
		       ritardi,
		       ritardi_non_giustificati,
		       uscite,
		       uscite_non_giustificate,
		       fuori_classi,
		       note
		  FROM classi_alunni_ex
		 WHERE classe = p_classe
	      ORDER BY cognome, nome, codice_fiscale;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.classe_alunni_ex(p_classe bigint) OWNER TO postgres;

--
-- TOC entry 446 (class 1255 OID 3918213)
-- Name: classi_alunni_indirizzi_ex_by_classe(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_alunni_indirizzi_ex_by_classe(p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT classe,
                       alunno,
                       nome,
                       cognome,
                       codice_fiscale,
                       sesso,
                       nato,
                       comune_nascita,
                       via,
                       cap,
                       comune,
                       provincia,
                       assenze
		  FROM classi_alunni_indirizzi_ex
		 WHERE classe = p_classe
	      ORDER BY cognome, nome, codice_fiscale;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.classi_alunni_indirizzi_ex_by_classe(p_classe bigint) OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 3918214)
-- Name: classi_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_del(p_rv bigint, p_classe bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messaggi di sistema utilizzati dalla funzione 
 
DELETE FROM messaggi_sistema WHERE function_name = 'classi_del';


INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_del',1,'it','Non è stata trovata nessuna riga nella tabella ''classi'' con: ''revisione'' = ''%s'',  ''classe'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_del',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_del',3,'it','Controllare il valore di: ''revisione'', ''classe'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'classi_del';

BEGIN
    DELETE FROM classi t
	      WHERE t.classe = p_classe AND
	            xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_classe),
	     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	     HINT = messaggi_sistema_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.classi_del(p_rv bigint, p_classe bigint) OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 3918215)
-- Name: classi_ins(bigint, bigint, character varying, smallint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'classi_ins';

BEGIN 

    INSERT INTO classi (anno_scolastico, indirizzo_scolastico, sezione, anno_corso, descrizione, plesso)
         VALUES (p_anno_scolastico, p_indirizzo_scolastico, p_sezione, p_anno_corso, p_descrizione, p_plesso);
         
    SELECT currval('pk_seq') INTO p_classe;
    SELECT xmin::text::bigint INTO p_rv FROM classi WHERE classe = p_classe;
END;
$$;


ALTER FUNCTION public.classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 3918216)
-- Name: classi_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_list(p_anno_scolastico bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'classi_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, classe, anno_scolastico, indirizzo_scolastico, sezione, anno_corso, descrizione, plesso
		       FROM classi
	              WHERE anno_scolastico = p_anno_scolastico
	           ORDER BY descrizione;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.classi_list(p_anno_scolastico bigint) OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 3918217)
-- Name: classi_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione
 
DELETE FROM messaggi_sistema WHERE function_name = 'classi_sel';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_sel',1,'it','Non è stata trovata nessuna riga nella tabella ''classi'' con:  ''classe'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_sel',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_sel',3,'it','Controllare il valore di: ''classe'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'classi_sel';

BEGIN

	SELECT xmin::text::bigint, classe, anno_scolastico, indirizzo_scolastico, sezione, anno_corso, descrizione, plesso
	INTO p_rv, p_classe, p_anno_scolastico, p_indirizzo_scolastico, p_sezione, p_anno_corso, p_descrizione, p_plesso
	FROM classi
	WHERE classe = p_classe;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_classe),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 3918218)
-- Name: classi_upd(bigint, bigint, bigint, bigint, character varying, smallint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'classi_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''classi'' con: ''revisione'' = ''%s'',  ''classe'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('classi_upd',3,'it','Controllare il valore di: ''revisione'', ''classe'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'classi_upd';

BEGIN

	UPDATE classi SET classe = p_classe,anno_scolastico = p_anno_scolastico,indirizzo_scolastico = p_indirizzo_scolastico,sezione = p_sezione,anno_corso = p_anno_corso,descrizione = p_descrizione,plesso = p_plesso
    	WHERE classe = p_classe AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_classe),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 3918219)
-- Name: docenti_by_istituto(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION docenti_by_istituto(p_istituto bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
	IF in_uno_dei_ruoli('{"Gestore","Dirigente","Impiegato"}')  THEN
		OPEN cur FOR SELECT p.persona AS docente,
				    p.cognome,
				    p.nome,
				    p.codice_fiscale,
				    COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
		               FROM persone p
			       JOIN persone_ruoli pr ON p.persona = pr.persona
			      WHERE istituto = p_istituto
				AND pr.ruolo = 'Docente'
			   ORDER BY cognome, nome, codice_fiscale;
	ELSEIF nel_ruolo('Docente') THEN
		OPEN cur FOR SELECT p.persona AS docente,
				    p.cognome,
				    p.nome,
				    p.codice_fiscale,
				    COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
		               FROM persone p
			       JOIN persone_ruoli pr ON p.persona = pr.persona
			      WHERE istituto = p_istituto
			        AND p.persona = session_persona(p_istituto)
				AND pr.ruolo = 'Docente'
			   ORDER BY cognome, nome, codice_fiscale;
	ELSE
		OPEN cur FOR SELECT p.persona AS docente,
				    p.cognome,
				    p.nome,
				    p.codice_fiscale,
				    COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
		               FROM persone p
			       JOIN persone_ruoli pr ON p.persona = pr.persona
			      WHERE 1=0;
	END IF;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.docenti_by_istituto(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 3918220)
-- Name: famigliari_by_classe(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION famigliari_by_classe(p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
	cur refcursor;
	function_name varchar = 'famigliari_by_classe';
BEGIN 
	IF in_uno_dei_ruoli('{"Gestore","Dirigente","Docente"}')  THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
		          JOIN persone p ON rel.persona_relazionata = p.persona
			 WHERE ca.classe = p_classe
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF nel_ruolo('Famigliare') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
		          JOIN persone p ON rel.persona_relazionata = p.persona
			 WHERE ca.classe = p_classe
			   AND rel.persona_relazionata = session_utente()
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF nel_ruolo('Alunno') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       COALESCE(p.foto_miniatura,foto_miniatura_default()) as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
		          JOIN persone p ON rel.persona_relazionata = p.persona
			 WHERE ca.classe = p_classe
			   AND ca.alunno = session_utente()
		      ORDER BY cognome, nome, codice_fiscale;
	ELSE
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = messaggi_sistema_locale(function_name,1),
		DETAIL = format(messaggi_sistema_locale(function_name,2), session_user),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
	RETURN cur;	        
END;
$$;


ALTER FUNCTION public.famigliari_by_classe(p_classe bigint) OWNER TO postgres;

--
-- TOC entry 443 (class 1255 OID 3918221)
-- Name: firme_by_docente_classe(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION firme_by_docente_classe(p_docente bigint, p_classe bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT giorno,
		       ora
		  FROM firme
		 WHERE docente = p_docente
		   AND classe = p_classe
	      ORDER BY giorno, ora;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.firme_by_docente_classe(p_docente bigint, p_classe bigint) OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 3918222)
-- Name: foto_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION foto_default() RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $$

BEGIN
	RETURN  decode('/9j/4AAQSkZJRgABAQEAWQBZAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
			ODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2Nj
			Y2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCAGQASwDASIA
			AhEBAxEB/8QAGwABAAIDAQEAAAAAAAAAAAAAAAUGAQIEAwf/xAAzEAEAAgICAAQEBAUDBQAAAAAA
			AQIDBAURITFBUQYSImETIzJxFENSgaEzQmIlcoKRsf/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAU
			EQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwD6AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAADm2t7Bq17y3iJ9vUHS1tatY7tMRH3V7b+Ib27rr0+WPeUTm3djPP5mW0/
			3BbsvI6mL9Wav9nLfntOs+E2t+yqeYCzz8Ra3pS7avxDqz51tCrALhi5nTyfzOp+7rx7GHL/AKeS
			tv7qI2pkvSe6Wms/aQX1lUNbmdvBMd3+evtKZ1Od18/Vcv5dvv5AlhrW1b17rMTHvDYAAAAAAAAA
			AAAAAAAAAAAAABpkyUxUm17RWsesvLb28Wpim+S3XtHuqnIcll3ck9zNaelYBI8jz0zM49Xwj+pB
			5Ml8tpte02mfdqAAAAAAAAAAA7NPktjUtHy2ma/0ysuhymHcrERPy39aypzal7UtFqTMTHrAL6yg
			+J5mMnWHZnq3pb3TcT3HcAyAAAAAAAAAAAAAAAAAA59zbx6eGcmSf2j3embLTDitkvPVYhT+S3r7
			uxNpn6I/TANN3cybmab3nw9I9nMAAAAAAAAAAAAAAAET1PcLDwvLd9a+xb/ttKvETMT3HmC/sofg
			+SjYx/g5Z/Mr5fdMAAAAAAAAAAAAAAAMMuHlduNTTtaJ+u3hUERz+/8AiZP4fHP01/V16yhGbWm1
			ptM9zLAAAAAAAAAAAAAAAAAAAN8OW2DLXJSeprPa6aG1Xb1q5Kz4+sfdSEpwW7OvtRjtP0X8AWwY
			ZAAAAAAAAAAAABhU+d252NyaRP0U8IWPkdiNbTyZO/HrqFKtabWm0+cz2DAAAAAAAAAAAAAAAAAA
			AADMTNZiY84YAXLiNr+K0q2mfqr4S7lW+Hdr8LanFafpv/8AVpAAAAAAAAAAABgED8TZ+q48MT5+
			Mq87+Zzfjchk8fCvhDgAAAAAAAAAAAAAAAAAAAAAAB6a+ScWel4/2yvOG8ZMVbx5WjtQlu4LN+Lx
			9e57mvgCSAAAAAAAAAAaZbfJivb2jtu5eSv8mhln/iCmZrzfNe0+sy0AAAAAAAAAAAAAAAAAAAAA
			AABYPhjL4ZcU/vCvpb4cv8u9Nf6qgtQAAAAAAAAACO5yeuMyJFGc/P8A0637gqQAAAAAAAAAAAAA
			AAAAAAAAAACQ4OeuTxo928PPXI4v3BcwAAAAAAAAAEbz0d8bf7JJxcvT5+Oyx9uwUwAAAAAAAAAA
			AAAAAAAAAAAAAB3cLHfJYnCk/h+nzcjWf6Y7BbQAAAAAAAAAHjtU+fWyV96y9mJjuJgFBtHy2mPa
			WHTyOL8Hey0+7mAAAAAAAAAAAAAAAAAAAAAAATnwzj7z5L+0dINaPhzF8mlN587SCYAAAAAAAAAA
			ABWPiTB8m1XLEeF4Qy287rfj6MzEfVTxVIAAAAAAAAAAAAAAAAAAAAAAGa1m1orHnM9LvoYYwaeP
			H7QqvD687G9SOvCvjK4+QMgAAAAAAAAAAA1vWL0ms+Ux0pW/rzrbeTHMeHfgu6F+IdP8TDGekfVT
			z/YFZAAAAAAAAAAAAAAAAAAAAB0aGtO1tUxxHhM+P7An/h3V/C1pzWj6r+X7Jlpix1xY60rHUVjp
			uAAAAAAAAAAAAA1yUrkpNLR3Ex1LYBS+T07ae1avX0z41lxrlymjXd15j/fXxrKn5MdsWSaXjq0T
			1INQAAAAAAAAAAAAAAAAAPNauC0P4fB+NePrv/iEVwnHTs5Yy5I/LrP/ALWqIiI6jyBkAAAAAAAA
			AAAAAAABD81xf8RWc2GPzI8490wwCg2rNZmJjqYYWbl+HjP3mwR1f1j3Vu9LUtNbRMTHpINQAAAA
			AAAAAAAAAHbxvH5N3NERHVI85Z47jcu7k8I6xx52WzV1serhjHjjqI/yDbBhpgxVx446iIegAAAA
			AAAAAAAAAAAAAAAwj+R4nFuRNq/Rk949UiAo+3p5tTJNctZj2n0lzr5mwY89JrlpFo+6D3vh/wA7
			6s/+Mgr49s+rm17dZcc1/s8QAAAAAABmIm09REzP2d+pw+zszEzX5K+8g4IiZnqI7lMcbwd83WTY
			+mnt6yl9LidfUiJ+X57+8u8GmLFTDjimOsVrHs9AAAAAAAAAAAAAAAAYmYrHcz1ENcuWmGk3yWit
			Y91Y5TmL7MzjwzNcfv7g7eS52Mczj1vG3rZ7cPy0bMfhZpiMseU+6rNqXtS0WrPUx5SC+sobieYr
			niMWeflyek+6YBkAAAGmTFjy16yUi0feEdscFqZe5rE0n7JQBW8vw5ljv8PLE/u5L8Ju1nwxxb9l
			vAUyeJ3I/ky2rw+7b+UuICq4vh/av+qa1duD4cxxPebJNvtCdAcmvx2rr/6eKO/eXUyAAAAAPLPn
			pr4pyZJ6rDGzs4tXFOTLaIiPT3VPkuSybuTr9OOPKAddufzRtzeI7xf0p3S3sO5j+bHbx9a+sKS9
			dfYya2SL4rTEwC9iN4zlce5WK2mK5Y9PdIgyAAAAAA88+amDFOTJbqsGbLTBitkyT1WFS5Tkr7uW
			YiZjHHlAHJ8lk3csxEzGOPKHAAAAMxMxPcT1Kb4znJxxGLZ8a+lkGAvuPJTLSLUtFqz6w3UvR5HP
			pW+i3dfWsrHo8xr7URW0/Jf2kEiMRPfkyAAAAAAAAAAADyz7GLXpNst4rAPRw7/KYdOsxM/Nk9Kw
			i9/n5vE01o6j+qUJe9r2m15mZn1kHvu7uXcyzfJPh6R7OYAAAbUvbHaLUmYmPWFn4fla7NYxZp6y
			x5T7qs2pe2O0WrPUx5SC+sonh+VrtUjFlnrLH+UsAAAxMxWJmZ6iBA89yXy962GfH/dMA4+a5Kdr
			LOLHP5Vf8ooAAAAAAACJmJ7iegBIanMbOt1E2+evtKb1Oc1s/UZPy7fdVAF9plx5I7petv2luoeP
			PlxT3jyWr+0u/Dzm3ijqbRePuC2ivYviSf5mH+8OivxFrT50vAJkRMc/qT/VDFviHVjyraQS4g8n
			xHiiPoxTP7uTL8RbFv0UrUFmmYjznpzZ+Q1teJm+WvcekKpn5Laz/ryz17Q5ZmZnuZmf3BO7fxDa
			e661Ov8AlKGz7OXYt82W82l5AAAAAAAAAN8WS2LJF6T1aJ8Fv4vfru4I7nrJX9UKa6NLavqZ65KT
			+8e4LwPDU2KbWCuWk+EvcHFym7XT1bW7+ufCsKdkvbJeb2nuZnuXXym9O7szbv6I8Kw4gAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAASvBb/APDZ/wAK8/l3/wAStUeMdwoET1PcLFx/OYqa1abEz89f
			DsFdAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
			AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//2Q==','base64');
END;
$$;


ALTER FUNCTION public.foto_default() OWNER TO postgres;

--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION foto_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION foto_default() IS 'Restituisce l''immagine di default per la foto della persona
****************************************
* Questa funzione è definita IMMUTABLE *
****************************************';


--
-- TOC entry 512 (class 1255 OID 3918224)
-- Name: foto_miniatura_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION foto_miniatura_default() RETURNS bytea
    LANGUAGE plpgsql IMMUTABLE
    AS $$

BEGIN
	RETURN  decode('/9j/4AAQSkZJRgABAQEAFgAWAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
			ODdASFxOQERXRTc4UG1RV19iZ2hnPk1xeXBkeFxlZ2P/2wBDARESEhgVGC8aGi9jQjhCY2NjY2Nj
			Y2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2NjY2P/wAARCABkAEsDASIA
			AhEBAxEB/8QAGwABAAMBAQEBAAAAAAAAAAAAAAQFBgMBAgf/xAAyEAACAgECAwYDBwUAAAAAAAAA
			AQIDBAURITFRBhIiQWFxE4HRFEJSscHh8SMyM2KR/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQR
			AQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AP0AAAADjkZVGNHe+2MPRvi/kB2BVS7QYKey
			dkvVRJGPq2FkPuwvSl0n4fzAmg8PQAAAAEfOyViYllz5xXBdX5AQNY1f7HvRRs72uL8ofuZiyyds
			3OyTnJ823uLJysslObcpSe7b8z5AAAC10vWbMSSrvk50cuPFx9voamEozgpRacZLdNeZgTRdmsxy
			jPEnLfu+KG/TzQF8AABRdqLWqaKV96Tk/l/Jemb7UJ/Hofl3X+YFGAAAAAEvSrXTqVE1+NRfs+H6
			kQ6YybyakuffW3/QN4AABSdp6e9i1XJf2S2fs/4Ls5ZNEcnHspnymtvb1AwgOmRRPGvnTatpRezO
			YAAACbo9Px9TpjtwjLvv5cSEafs7guiiWRYtp2rwrpH9wLkAAAc7rq6KpWWyUYR5tmX1DWr8i9Oi
			cqq4PeKT4v1f0AvNU0uvPr3W0Lorwy6+jMtlYd+JZ3L63Ho/J+zNJpmtU5UY13tV3cuPKXsWcoxn
			FxklJPmmtwMCexjKclGKcm+SS3NpLTMGT3eLV8o7HanHpo/w1Qr3592KQFFpWhScldmx2iuKr6+/
			0NCcMvNow6+/fNLpFc37IzOVrOVdlK2qbrjB+GCfD59QNcCBpmp159e3CN0V4ofqvQngZPXNR+13
			/Cqf9Gt8P9n1KsAATMbVMzF2VdzcV92fFEMAXMe0mUl4qqW+uz+pxu17Oti0pQr3/BH6lYAPqdk7
			JOVk5Tk+bk92fIAHTHvnjXwuqe04vdGux9VxLqIWSuhXKS4xk+KZjQAAAAAAAAAAAAAAf//Z','base64');
END;
$$;


ALTER FUNCTION public.foto_miniatura_default() OWNER TO postgres;

--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 512
-- Name: FUNCTION foto_miniatura_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION foto_miniatura_default() IS 'Restituisce l''immagine di default per la miniatura della foto della persona
****************************************
* Questa funzione è definita IMMUTABLE *
****************************************';


--
-- TOC entry 451 (class 1255 OID 3918225)
-- Name: function_sqlcode(character varying, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION function_sqlcode(p_function character varying, p_id character) RETURNS character
    LANGUAGE plpgsql IMMUTABLE
    AS $$

BEGIN
--
-- questi codice vengono gestiti manualmente (prefisso UM)
-- 
  IF p_function = 'istituti_sel_logo' THEN RETURN 'UM01' || p_id; END IF;
  IF p_function = 'tr_utenti_iu' THEN RETURN 'UM02'|| p_id; END IF;
  IF p_function = 'istituti_upd_logo' THEN RETURN 'UM03' || p_id; END IF;
  IF p_function = 'tr_valutazioni_iu' THEN RETURN 'UM04'|| p_id; END IF;
  IF p_function = 'persone_sel_foto_tmb' THEN RETURN 'UM05'|| p_id; END IF;
  IF p_function = 'tr_mezzi_comunicazione_iu' THEN RETURN 'UM06'|| p_id; END IF;
  IF p_function = 'tr_assenze_iu' THEN RETURN 'UM07'|| p_id; END IF;
  IF p_function = 'alunni_by_classe' THEN RETURN 'UM08'|| p_id; END IF;
  IF p_function = 'famigliari_by_classe' THEN RETURN 'UM09'|| p_id; END IF;
  IF p_function = 'tr_classi_iu' THEN RETURN 'UM10'|| p_id; END IF;
  IF p_function = 'tr_classi_alunni_iu' THEN RETURN 'UM11'|| p_id; END IF;
  IF p_function = 'tr_colloqui_iu' THEN RETURN 'UM12'|| p_id; END IF;
  IF p_function = 'tr_conversazioni_invitati_iu' THEN RETURN 'UM13'|| p_id; END IF;
  IF p_function = 'tr_firme_iu' THEN RETURN 'UM14'|| p_id; END IF;
  IF p_function = 'tr_scrutini_valutazioni_iu' THEN RETURN 'UM15'|| p_id; END IF;
  IF p_function = 'tr_valutazioni_qualifiche_iu' THEN RETURN 'UM16'|| p_id; END IF;
  IF p_function = '****************da riutilizzare*****************' THEN RETURN 'UM17'|| p_id; END IF;
  IF p_function = 'tr_scrutini_valutazioni_qualifiche_iu' THEN RETURN 'UM18'|| p_id; END IF;
  IF p_function = 'tr_scrutini_valutazioni_d' THEN RETURN 'UM19'|| p_id; END IF;
  IF p_function = 'tr_scrutini_valutazioni_qualifiche_d' THEN RETURN 'UM20'|| p_id; END IF;
  IF p_function = 'tr_scrutini_i' THEN RETURN 'UM21'|| p_id; END IF;
  IF p_function = 'tr_fuori_classi_iu' THEN RETURN 'UM22'|| p_id; END IF;
  IF p_function = 'tr_ritardi_iu' THEN RETURN 'UM23'|| p_id; END IF;
  IF p_function = 'tr_uscite_iu' THEN RETURN 'UM24'|| p_id; END IF;
  IF p_function = 'tr_note_iu' THEN RETURN 'UM25'|| p_id; END IF;
  IF p_function = 'tr_giustificazioni_iu' THEN RETURN 'UM26'|| p_id; END IF;
  IF p_function = 'valutazioni_upd_voto' THEN RETURN 'UM27'|| p_id; END IF;
  IF p_function = 'tr_lezioni_iu' THEN RETURN 'UM28'|| p_id; END IF;
  IF p_function = 'tr_mancanze_iu' THEN RETURN 'UM29'|| p_id; END IF;
  IF p_function = 'tr_messaggi_iu' THEN RETURN 'UM30'|| p_id; END IF;
  IF p_function = 'tr_note_docenti_iu' THEN RETURN 'UM31'|| p_id; END IF;
  IF p_function = 'tr_note_visti_iu' THEN RETURN 'UM32'|| p_id; END IF;
--
-- questi codici vengono generati con un template apposito da Fulcro Code Generator
--
  IF p_function = 'indirizzi_scolastici_sel' THEN RETURN 'U001'|| p_id; END IF;
  IF p_function = 'indirizzi_scolastici_ins' THEN RETURN 'U002'|| p_id; END IF;
  IF p_function = 'indirizzi_scolastici_upd' THEN RETURN 'U003'|| p_id; END IF;
  IF p_function = 'indirizzi_scolastici_del' THEN RETURN 'U004'|| p_id; END IF;
  IF p_function = 'databasechangelog_sel' THEN RETURN 'U005'|| p_id; END IF;
  IF p_function = 'databasechangelog_ins' THEN RETURN 'U006'|| p_id; END IF;
  IF p_function = 'databasechangelog_upd' THEN RETURN 'U007'|| p_id; END IF;
  IF p_function = 'databasechangelog_del' THEN RETURN 'U008'|| p_id; END IF;
  IF p_function = 'logging_event_exception_sel' THEN RETURN 'U009'|| p_id; END IF;
  IF p_function = 'logging_event_exception_ins' THEN RETURN 'U010'|| p_id; END IF;
  IF p_function = 'logging_event_exception_upd' THEN RETURN 'U011'|| p_id; END IF;
  IF p_function = 'logging_event_exception_del' THEN RETURN 'U012'|| p_id; END IF;
  IF p_function = 'gruppi_utenti_sel' THEN RETURN 'U013'|| p_id; END IF;
  IF p_function = 'gruppi_utenti_ins' THEN RETURN 'U014'|| p_id; END IF;
  IF p_function = 'gruppi_utenti_upd' THEN RETURN 'U015'|| p_id; END IF;
  IF p_function = 'gruppi_utenti_del' THEN RETURN 'U016'|| p_id; END IF;
  IF p_function = 'lezioni_sel' THEN RETURN 'U017'|| p_id; END IF;
  IF p_function = 'lezioni_ins' THEN RETURN 'U018'|| p_id; END IF;
  IF p_function = 'lezioni_upd' THEN RETURN 'U019'|| p_id; END IF;
  IF p_function = 'lezioni_del' THEN RETURN 'U020'|| p_id; END IF;
  IF p_function = 'materie_sel' THEN RETURN 'U021'|| p_id; END IF;
  IF p_function = 'materie_ins' THEN RETURN 'U022'|| p_id; END IF;
  IF p_function = 'materie_upd' THEN RETURN 'U023'|| p_id; END IF;
  IF p_function = 'materie_del' THEN RETURN 'U024'|| p_id; END IF;
  IF p_function = 'appuserroles_sel' THEN RETURN 'U025'|| p_id; END IF;
  IF p_function = 'appuserroles_ins' THEN RETURN 'U026'|| p_id; END IF;
  IF p_function = 'appuserroles_upd' THEN RETURN 'U027'|| p_id; END IF;
  IF p_function = 'appuserroles_del' THEN RETURN 'U028'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_dettaglio_sel' THEN RETURN 'U029'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_dettaglio_ins' THEN RETURN 'U030'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_dettaglio_upd' THEN RETURN 'U031'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_dettaglio_del' THEN RETURN 'U032'|| p_id; END IF;
  IF p_function = 'mancanze_sel' THEN RETURN 'U033'|| p_id; END IF;
  IF p_function = 'mancanze_ins' THEN RETURN 'U034'|| p_id; END IF;
  IF p_function = 'mancanze_upd' THEN RETURN 'U035'|| p_id; END IF;
  IF p_function = 'mancanze_del' THEN RETURN 'U036'|| p_id; END IF;
  IF p_function = 'messaggi_sel' THEN RETURN 'U037'|| p_id; END IF;
  IF p_function = 'messaggi_ins' THEN RETURN 'U038'|| p_id; END IF;
  IF p_function = 'messaggi_upd' THEN RETURN 'U039'|| p_id; END IF;
  IF p_function = 'messaggi_del' THEN RETURN 'U040'|| p_id; END IF;
  IF p_function = 'messaggi_sistema_sel' THEN RETURN 'U041'|| p_id; END IF;
  IF p_function = 'messaggi_sistema_ins' THEN RETURN 'U042'|| p_id; END IF;
  IF p_function = 'messaggi_sistema_upd' THEN RETURN 'U043'|| p_id; END IF;
  IF p_function = 'messaggi_sistema_del' THEN RETURN 'U044'|| p_id; END IF;
  IF p_function = 'utenti_istituti_sel' THEN RETURN 'U045'|| p_id; END IF;
  IF p_function = 'utenti_istituti_ins' THEN RETURN 'U046'|| p_id; END IF;
  IF p_function = 'utenti_istituti_upd' THEN RETURN 'U047'|| p_id; END IF;
  IF p_function = 'utenti_istituti_del' THEN RETURN 'U048'|| p_id; END IF;
  IF p_function = 'firme_sel' THEN RETURN 'U049'|| p_id; END IF;
  IF p_function = 'firme_ins' THEN RETURN 'U050'|| p_id; END IF;
  IF p_function = 'firme_upd' THEN RETURN 'U051'|| p_id; END IF;
  IF p_function = 'firme_del' THEN RETURN 'U052'|| p_id; END IF;
  IF p_function = 'role_sel' THEN RETURN 'U053'|| p_id; END IF;
  IF p_function = 'role_ins' THEN RETURN 'U054'|| p_id; END IF;
  IF p_function = 'role_upd' THEN RETURN 'U055'|| p_id; END IF;
  IF p_function = 'role_del' THEN RETURN 'U056'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_sel' THEN RETURN 'U057'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_ins' THEN RETURN 'U058'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_upd' THEN RETURN 'U059'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_del' THEN RETURN 'U060'|| p_id; END IF;
  IF p_function = 'argomenti_sel' THEN RETURN 'U061'|| p_id; END IF;
  IF p_function = 'argomenti_ins' THEN RETURN 'U062'|| p_id; END IF;
  IF p_function = 'argomenti_upd' THEN RETURN 'U063'|| p_id; END IF;
  IF p_function = 'argomenti_del' THEN RETURN 'U064'|| p_id; END IF;
  IF p_function = 'indirizzi_sel' THEN RETURN 'U065'|| p_id; END IF;
  IF p_function = 'indirizzi_ins' THEN RETURN 'U066'|| p_id; END IF;
  IF p_function = 'indirizzi_upd' THEN RETURN 'U067'|| p_id; END IF;
  IF p_function = 'indirizzi_del' THEN RETURN 'U068'|| p_id; END IF;
  IF p_function = 'voti_sel' THEN RETURN 'U069'|| p_id; END IF;
  IF p_function = 'voti_ins' THEN RETURN 'U070'|| p_id; END IF;
  IF p_function = 'voti_upd' THEN RETURN 'U071'|| p_id; END IF;
  IF p_function = 'voti_del' THEN RETURN 'U072'|| p_id; END IF;
  IF p_function = 'classi_alunni_sel' THEN RETURN 'U073'|| p_id; END IF;
  IF p_function = 'classi_alunni_ins' THEN RETURN 'U074'|| p_id; END IF;
  IF p_function = 'classi_alunni_upd' THEN RETURN 'U075'|| p_id; END IF;
  IF p_function = 'classi_alunni_del' THEN RETURN 'U076'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_qualifiche_sel' THEN RETURN 'U077'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_qualifiche_ins' THEN RETURN 'U078'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_qualifiche_upd' THEN RETURN 'U079'|| p_id; END IF;
  IF p_function = 'scrutini_valutazioni_qualifiche_del' THEN RETURN 'U080'|| p_id; END IF;
  IF p_function = 'logging_event_property_sel' THEN RETURN 'U081'|| p_id; END IF;
  IF p_function = 'logging_event_property_ins' THEN RETURN 'U082'|| p_id; END IF;
  IF p_function = 'logging_event_property_upd' THEN RETURN 'U083'|| p_id; END IF;
  IF p_function = 'logging_event_property_del' THEN RETURN 'U084'|| p_id; END IF;
  IF p_function = 'valutazioni_sel' THEN RETURN 'U085'|| p_id; END IF;
  IF p_function = 'valutazioni_ins' THEN RETURN 'U086'|| p_id; END IF;
  IF p_function = 'valutazioni_upd' THEN RETURN 'U087'|| p_id; END IF;
  IF p_function = 'valutazioni_del' THEN RETURN 'U088'|| p_id; END IF;
  IF p_function = 'databasechangeloglock_sel' THEN RETURN 'U089'|| p_id; END IF;
  IF p_function = 'databasechangeloglock_ins' THEN RETURN 'U090'|| p_id; END IF;
  IF p_function = 'databasechangeloglock_upd' THEN RETURN 'U091'|| p_id; END IF;
  IF p_function = 'databasechangeloglock_del' THEN RETURN 'U092'|| p_id; END IF;
  IF p_function = 'assenze_sel' THEN RETURN 'U093'|| p_id; END IF;
  IF p_function = 'assenze_ins' THEN RETURN 'U094'|| p_id; END IF;
  IF p_function = 'assenze_upd' THEN RETURN 'U095'|| p_id; END IF;
  IF p_function = 'assenze_del' THEN RETURN 'U096'|| p_id; END IF;
  IF p_function = 'plessi_sel' THEN RETURN 'U097'|| p_id; END IF;
  IF p_function = 'plessi_ins' THEN RETURN 'U098'|| p_id; END IF;
  IF p_function = 'plessi_upd' THEN RETURN 'U099'|| p_id; END IF;
  IF p_function = 'plessi_del' THEN RETURN 'U100'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_sel' THEN RETURN 'U101'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_ins' THEN RETURN 'U102'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_upd' THEN RETURN 'U103'|| p_id; END IF;
  IF p_function = 'gruppi_qualifiche_del' THEN RETURN 'U104'|| p_id; END IF;
  IF p_function = 'note_docenti_sel' THEN RETURN 'U105'|| p_id; END IF;
  IF p_function = 'note_docenti_ins' THEN RETURN 'U106'|| p_id; END IF;
  IF p_function = 'note_docenti_upd' THEN RETURN 'U107'|| p_id; END IF;
  IF p_function = 'note_docenti_del' THEN RETURN 'U108'|| p_id; END IF;
  IF p_function = 'istituti_sel' THEN RETURN 'U109'|| p_id; END IF;
  IF p_function = 'istituti_ins' THEN RETURN 'U110'|| p_id; END IF;
  IF p_function = 'istituti_upd' THEN RETURN 'U111'|| p_id; END IF;
  IF p_function = 'istituti_del' THEN RETURN 'U112'|| p_id; END IF;
  IF p_function = 'messaggi_letti_sel' THEN RETURN 'U113'|| p_id; END IF;
  IF p_function = 'messaggi_letti_ins' THEN RETURN 'U114'|| p_id; END IF;
  IF p_function = 'messaggi_letti_upd' THEN RETURN 'U115'|| p_id; END IF;
  IF p_function = 'messaggi_letti_del' THEN RETURN 'U116'|| p_id; END IF;
  IF p_function = 'persone_indirizzi_sel' THEN RETURN 'U117'|| p_id; END IF;
  IF p_function = 'persone_indirizzi_ins' THEN RETURN 'U118'|| p_id; END IF;
  IF p_function = 'persone_indirizzi_upd' THEN RETURN 'U119'|| p_id; END IF;
  IF p_function = 'persone_indirizzi_del' THEN RETURN 'U120'|| p_id; END IF;
  IF p_function = 'logging_event_sel' THEN RETURN 'U121'|| p_id; END IF;
  IF p_function = 'logging_event_ins' THEN RETURN 'U122'|| p_id; END IF;
  IF p_function = 'logging_event_upd' THEN RETURN 'U123'|| p_id; END IF;
  IF p_function = 'logging_event_del' THEN RETURN 'U124'|| p_id; END IF;
  IF p_function = 'festivi_sel' THEN RETURN 'U125'|| p_id; END IF;
  IF p_function = 'festivi_ins' THEN RETURN 'U126'|| p_id; END IF;
  IF p_function = 'festivi_upd' THEN RETURN 'U127'|| p_id; END IF;
  IF p_function = 'festivi_del' THEN RETURN 'U128'|| p_id; END IF;
  IF p_function = 'regioni_sel' THEN RETURN 'U129'|| p_id; END IF;
  IF p_function = 'regioni_ins' THEN RETURN 'U130'|| p_id; END IF;
  IF p_function = 'regioni_upd' THEN RETURN 'U131'|| p_id; END IF;
  IF p_function = 'regioni_del' THEN RETURN 'U132'|| p_id; END IF;
  IF p_function = 'tipi_comunicazione_sel' THEN RETURN 'U133'|| p_id; END IF;
  IF p_function = 'tipi_comunicazione_ins' THEN RETURN 'U134'|| p_id; END IF;
  IF p_function = 'tipi_comunicazione_upd' THEN RETURN 'U135'|| p_id; END IF;
  IF p_function = 'tipi_comunicazione_del' THEN RETURN 'U136'|| p_id; END IF;
  IF p_function = 'scrutini_sel' THEN RETURN 'U137'|| p_id; END IF;
  IF p_function = 'scrutini_ins' THEN RETURN 'U138'|| p_id; END IF;
  IF p_function = 'scrutini_upd' THEN RETURN 'U139'|| p_id; END IF;
  IF p_function = 'scrutini_del' THEN RETURN 'U140'|| p_id; END IF;
  IF p_function = 'colloqui_sel' THEN RETURN 'U141'|| p_id; END IF;
  IF p_function = 'colloqui_ins' THEN RETURN 'U142'|| p_id; END IF;
  IF p_function = 'colloqui_upd' THEN RETURN 'U143'|| p_id; END IF;
  IF p_function = 'colloqui_del' THEN RETURN 'U144'|| p_id; END IF;
  IF p_function = 'appuser_sel' THEN RETURN 'U145'|| p_id; END IF;
  IF p_function = 'appuser_ins' THEN RETURN 'U146'|| p_id; END IF;
  IF p_function = 'appuser_upd' THEN RETURN 'U147'|| p_id; END IF;
  IF p_function = 'appuser_del' THEN RETURN 'U148'|| p_id; END IF;
  IF p_function = 'libretti_sel' THEN RETURN 'U149'|| p_id; END IF;
  IF p_function = 'libretti_ins' THEN RETURN 'U150'|| p_id; END IF;
  IF p_function = 'libretti_upd' THEN RETURN 'U151'|| p_id; END IF;
  IF p_function = 'libretti_del' THEN RETURN 'U152'|| p_id; END IF;
  IF p_function = 'anni_scolastici_sel' THEN RETURN 'U153'|| p_id; END IF;
  IF p_function = 'anni_scolastici_ins' THEN RETURN 'U154'|| p_id; END IF;
  IF p_function = 'anni_scolastici_upd' THEN RETURN 'U155'|| p_id; END IF;
  IF p_function = 'anni_scolastici_del' THEN RETURN 'U156'|| p_id; END IF;
  IF p_function = 'conversazioni_sel' THEN RETURN 'U157'|| p_id; END IF;
  IF p_function = 'conversazioni_ins' THEN RETURN 'U158'|| p_id; END IF;
  IF p_function = 'conversazioni_upd' THEN RETURN 'U159'|| p_id; END IF;
  IF p_function = 'conversazioni_del' THEN RETURN 'U160'|| p_id; END IF;
  IF p_function = 'provincie_sel' THEN RETURN 'U161'|| p_id; END IF;
  IF p_function = 'provincie_ins' THEN RETURN 'U162'|| p_id; END IF;
  IF p_function = 'provincie_upd' THEN RETURN 'U163'|| p_id; END IF;
  IF p_function = 'provincie_del' THEN RETURN 'U164'|| p_id; END IF;
  IF p_function = 'uscite_sel' THEN RETURN 'U165'|| p_id; END IF;
  IF p_function = 'uscite_ins' THEN RETURN 'U166'|| p_id; END IF;
  IF p_function = 'uscite_upd' THEN RETURN 'U167'|| p_id; END IF;
  IF p_function = 'uscite_del' THEN RETURN 'U168'|| p_id; END IF;
  IF p_function = 'giustificazioni_sel' THEN RETURN 'U169'|| p_id; END IF;
  IF p_function = 'giustificazioni_ins' THEN RETURN 'U170'|| p_id; END IF;
  IF p_function = 'giustificazioni_upd' THEN RETURN 'U171'|| p_id; END IF;
  IF p_function = 'giustificazioni_del' THEN RETURN 'U172'|| p_id; END IF;
  IF p_function = 'mezzi_comunicazione_sel' THEN RETURN 'U173'|| p_id; END IF;
  IF p_function = 'mezzi_comunicazione_ins' THEN RETURN 'U174'|| p_id; END IF;
  IF p_function = 'mezzi_comunicazione_upd' THEN RETURN 'U175'|| p_id; END IF;
  IF p_function = 'mezzi_comunicazione_del' THEN RETURN 'U176'|| p_id; END IF;
  IF p_function = 'metriche_sel' THEN RETURN 'U177'|| p_id; END IF;
  IF p_function = 'metriche_ins' THEN RETURN 'U178'|| p_id; END IF;
  IF p_function = 'metriche_upd' THEN RETURN 'U179'|| p_id; END IF;
  IF p_function = 'metriche_del' THEN RETURN 'U180'|| p_id; END IF;
  IF p_function = 'qualifiche_sel' THEN RETURN 'U181'|| p_id; END IF;
  IF p_function = 'qualifiche_ins' THEN RETURN 'U182'|| p_id; END IF;
  IF p_function = 'qualifiche_upd' THEN RETURN 'U183'|| p_id; END IF;
  IF p_function = 'qualifiche_del' THEN RETURN 'U184'|| p_id; END IF;
  IF p_function = 'tipi_voto_sel' THEN RETURN 'U185'|| p_id; END IF;
  IF p_function = 'tipi_voto_ins' THEN RETURN 'U186'|| p_id; END IF;
  IF p_function = 'tipi_voto_upd' THEN RETURN 'U187'|| p_id; END IF;
  IF p_function = 'tipi_voto_del' THEN RETURN 'U188'|| p_id; END IF;
  IF p_function = 'comuni_sel' THEN RETURN 'U189'|| p_id; END IF;
  IF p_function = 'comuni_ins' THEN RETURN 'U190'|| p_id; END IF;
  IF p_function = 'comuni_upd' THEN RETURN 'U191'|| p_id; END IF;
  IF p_function = 'comuni_del' THEN RETURN 'U192'|| p_id; END IF;
  IF p_function = 'nazioni_sel' THEN RETURN 'U193'|| p_id; END IF;
  IF p_function = 'nazioni_ins' THEN RETURN 'U194'|| p_id; END IF;
  IF p_function = 'nazioni_upd' THEN RETURN 'U195'|| p_id; END IF;
  IF p_function = 'nazioni_del' THEN RETURN 'U196'|| p_id; END IF;
  IF p_function = 'note_sel' THEN RETURN 'U197'|| p_id; END IF;
  IF p_function = 'note_ins' THEN RETURN 'U198'|| p_id; END IF;
  IF p_function = 'note_upd' THEN RETURN 'U199'|| p_id; END IF;
  IF p_function = 'note_del' THEN RETURN 'U200'|| p_id; END IF;
  IF p_function = 'orari_settimanali_sel' THEN RETURN 'U201'|| p_id; END IF;
  IF p_function = 'orari_settimanali_ins' THEN RETURN 'U202'|| p_id; END IF;
  IF p_function = 'orari_settimanali_upd' THEN RETURN 'U203'|| p_id; END IF;
  IF p_function = 'orari_settimanali_del' THEN RETURN 'U204'|| p_id; END IF;
  IF p_function = 'fuori_classi_sel' THEN RETURN 'U205'|| p_id; END IF;
  IF p_function = 'fuori_classi_ins' THEN RETURN 'U206'|| p_id; END IF;
  IF p_function = 'fuori_classi_upd' THEN RETURN 'U207'|| p_id; END IF;
  IF p_function = 'fuori_classi_del' THEN RETURN 'U208'|| p_id; END IF;
  IF p_function = 'persone_sel' THEN RETURN 'U209'|| p_id; END IF;
  IF p_function = 'persone_ins' THEN RETURN 'U210'|| p_id; END IF;
  IF p_function = 'persone_upd' THEN RETURN 'U211'|| p_id; END IF;
  IF p_function = 'persone_del' THEN RETURN 'U212'|| p_id; END IF;
  IF p_function = 'persone_parenti_sel' THEN RETURN 'U213'|| p_id; END IF;
  IF p_function = 'persone_parenti_ins' THEN RETURN 'U214'|| p_id; END IF;
  IF p_function = 'persone_parenti_upd' THEN RETURN 'U215'|| p_id; END IF;
  IF p_function = 'persone_parenti_del' THEN RETURN 'U216'|| p_id; END IF;
  IF p_function = 'valutazioni_qualifiche_sel' THEN RETURN 'U217'|| p_id; END IF;
  IF p_function = 'valutazioni_qualifiche_ins' THEN RETURN 'U218'|| p_id; END IF;
  IF p_function = 'valutazioni_qualifiche_upd' THEN RETURN 'U219'|| p_id; END IF;
  IF p_function = 'valutazioni_qualifiche_del' THEN RETURN 'U220'|| p_id; END IF;
  IF p_function = 'gruppi_sel' THEN RETURN 'U221'|| p_id; END IF;
  IF p_function = 'gruppi_ins' THEN RETURN 'U222'|| p_id; END IF;
  IF p_function = 'gruppi_upd' THEN RETURN 'U223'|| p_id; END IF;
  IF p_function = 'gruppi_del' THEN RETURN 'U224'|| p_id; END IF;
  IF p_function = 'persistent_logins_sel' THEN RETURN 'U225'|| p_id; END IF;
  IF p_function = 'persistent_logins_ins' THEN RETURN 'U226'|| p_id; END IF;
  IF p_function = 'persistent_logins_upd' THEN RETURN 'U227'|| p_id; END IF;
  IF p_function = 'persistent_logins_del' THEN RETURN 'U228'|| p_id; END IF;
  IF p_function = 'utenti_sel' THEN RETURN 'U229'|| p_id; END IF;
  IF p_function = 'utenti_ins' THEN RETURN 'U230'|| p_id; END IF;
  IF p_function = 'utenti_upd' THEN RETURN 'U231'|| p_id; END IF;
  IF p_function = 'utenti_del' THEN RETURN 'U232'|| p_id; END IF;
  IF p_function = 'ritardi_sel' THEN RETURN 'U233'|| p_id; END IF;
  IF p_function = 'ritardi_ins' THEN RETURN 'U234'|| p_id; END IF;
  IF p_function = 'ritardi_upd' THEN RETURN 'U235'|| p_id; END IF;
  IF p_function = 'ritardi_del' THEN RETURN 'U236'|| p_id; END IF;
  IF p_function = 'classi_sel' THEN RETURN 'U237'|| p_id; END IF;
  IF p_function = 'classi_ins' THEN RETURN 'U238'|| p_id; END IF;
  IF p_function = 'classi_upd' THEN RETURN 'U239'|| p_id; END IF;
  IF p_function = 'classi_del' THEN RETURN 'U240'|| p_id; END IF;
  IF p_function = 'accesslog_sel' THEN RETURN 'U241'|| p_id; END IF;
  IF p_function = 'accesslog_ins' THEN RETURN 'U242'|| p_id; END IF;
  IF p_function = 'accesslog_upd' THEN RETURN 'U243'|| p_id; END IF;
  IF p_function = 'accesslog_del' THEN RETURN 'U244'|| p_id; END IF;
  IF p_function = 'configuration_sel' THEN RETURN 'U245'|| p_id; END IF;
  IF p_function = 'configuration_ins' THEN RETURN 'U246'|| p_id; END IF;
  IF p_function = 'configuration_upd' THEN RETURN 'U247'|| p_id; END IF;
  IF p_function = 'configuration_del' THEN RETURN 'U248'|| p_id; END IF;
  IF p_function = 'spazi_lavoro_sel' THEN RETURN 'U249'|| p_id; END IF;
  IF p_function = 'spazi_lavoro_ins' THEN RETURN 'U250'|| p_id; END IF;
  IF p_function = 'spazi_lavoro_upd' THEN RETURN 'U251'|| p_id; END IF;
  IF p_function = 'spazi_lavoro_del' THEN RETURN 'U252'|| p_id; END IF;
--
-- se il nome funzione non è stato gestito si imposta un codice generico:
--
  RETURN 'UZZZZ';
 END;
$$;


ALTER FUNCTION public.function_sqlcode(p_function character varying, p_id character) OWNER TO postgres;

--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 451
-- Name: FUNCTION function_sqlcode(p_function character varying, p_id character); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION function_sqlcode(p_function character varying, p_id character) IS 'Questa funzione serve per centralizzare la definizione del SQLCODE da usare ogni qualvolta
viene usata la funzione RAISE.
Lo scopo che si vuole raggiungere è quello di consentire, quando si riceve il SQLCODE
di un errore, di risalire alla funzione che lo ha generato.
Per questo il codice di errore, che al massimo può essere di 5 caratteri viene così composto:
Il primo carattere è sempre ''U'' (che sta per User) per differenziarlo da tutti gli altri 
codici di errore usati da postgres.
i successivi tre caratteri identificano la funzione che lo genera e, siccome non si riesce
a stabilire una regola di abbinamento, compilare una tabella di corrispondeza (scopo della
presente funzione).
L''ultimo carattere infine è un progressivo per identificare il punto, all''interno della
funzione, dove viene generato l''errore, in caso la funzione ne abbia più di uno.
Alla presente funzione viene passato il nome funzione (non c''è al momento la possibilità
di recuperare tale informazione in automatico) e il progressivo da appendere al codice
determinato.
Dato che si suppone che questa funzione verrà chiamata una sola volta e dopo si genererà
un errore, il metodo di lookup  usato per abbinare la funzione al codice non necessita
di particolare ottimizzazione.
Per comodità di programmazione viene passato l''identificativo del codice da concatenare
a quello determinato. 
****************************************
* Questa funzione è definita IMMUTABLE *
****************************************';


--
-- TOC entry 505 (class 1255 OID 3918227)
-- Name: griglia_valutazioni_colonne_by_classe_docente_materia(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT DISTINCT va.giorno AS giorno,
			       va.tipo_voto AS tipo_voto,
                               tv.descrizione AS tipo_voto_descrizione,
                               va.argomento AS argomento,
                               a.descrizione AS argomento_descrizione,
                               m.metrica as metrica,
                               m.descrizione AS metrica_descrizione
                          FROM valutazioni va
			  JOIN argomenti a ON a.argomento = va.argomento 
			  JOIN tipi_voto tv ON tv.tipo_voto = va.tipo_voto
			  JOIN voti vo ON vo.voto = va.voto
			  JOIN metriche m ON m.metrica = vo.metrica
			 WHERE va.classe = p_classe
			   AND va.docente = p_docente
			   AND va.materia = p_materia
		      ORDER BY giorno, tipo_voto_descrizione, argomento_descrizione, metrica_descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 3918228)
-- Name: griglia_valutazioni_righe_by_classe_docente_materia(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) RETURNS TABLE(alunno bigint, cognome character varying, nome character varying, assenze integer, ritardi integer, uscite integer, fuori_classe integer, note integer, mancanze integer, condotta character varying, rvs bigint[], valutazioni bigint[], voti bigint[])
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
	v_giorni character varying[];
	v_alunno record;
	v_valutazione record;
	v_scrutinio bigint;
	v_condotta bigint;
	v_anno_scolastico bigint;
	i integer;
BEGIN 

v_giorni :=  ARRAY( SELECT DISTINCT va.giorno || to_char(va.tipo_voto,'0000000000000000000') || to_char(va.argomento,'0000000000000000000')  || to_char(vo.metrica,'0000000000000000000')
			       FROM valutazioni va
			       JOIN voti vo ON vo.voto = va.voto 
			      WHERE va.classe = p_classe
			        AND va.docente = p_docente
			        AND va.materia = p_materia
		           ORDER BY 1);

SELECT i.condotta INTO v_condotta
  FROM istituti i
  JOIN materie m ON m.istituto = i.istituto
 WHERE materia = p_materia;

 SELECT anno_scolastico INTO v_anno_scolastico
   FROM classi
  WHERE classe = p_classe;

SELECT scrutinio into v_scrutinio
  FROM scrutini
 WHERE anno_scolastico = v_anno_scolastico
   AND data IN (SELECT MAX(data) 
		  FROM scrutini
		 WHERE anno_scolastico = v_anno_scolastico
		   AND chiuso = true);
   		           
FOR v_alunno IN SELECT p.persona AS alunno,
	               p.cognome AS cognome,
		       p.nome AS nome,
		       COALESCE(a.assenze,0) AS assenze,
		       COALESCE(r.ritardi,0) AS ritardi,
		       COALESCE(u.uscite,0) AS uscite,
		       COALESCE(fc.fuori_classi,0) AS fuori_classe,
		       COALESCE(n.note,0) AS note,
		       COALESCE(m.mancanze,0) AS mancanze,
		       COALESCE(v.mnemonico,'N/D') AS condotta
	          FROM classi_alunni ca 
	          JOIN persone p ON ca.alunno = p.persona
	          LEFT JOIN assenze_grp a ON a.classe = ca.classe AND a.alunno = ca.alunno
	          LEFT JOIN ritardi_grp r ON r.classe = ca.classe AND r.alunno = ca.alunno
	          LEFT JOIN uscite_grp u ON u.classe = ca.classe AND u.alunno = ca.alunno
	          LEFT JOIN fuori_classi_grp fc ON fc.classe = ca.classe AND fc.alunno = ca.alunno
	          LEFT JOIN note_grp n ON n.classe = ca.classe AND n.alunno = ca.alunno
	          LEFT JOIN mancanze_grp m ON m.classe = ca.classe AND m.alunno = ca.alunno
	          LEFT JOIN (SELECT svi.classe, svi.alunno, svi.voto 
	                       FROM scrutini_valutazioni svi
	                      WHERE svi.scrutinio = v_scrutinio
				AND svi.materia = v_condotta) AS sv ON sv.classe = ca.classe AND sv.alunno = ca.alunno
	          LEFT JOIN voti v ON v.voto = sv.voto
	         WHERE ca.classe = p_classe
	       ORDER BY p.cognome, p.nome, p.codice_fiscale
LOOP
	alunno := v_alunno.alunno;
	cognome := v_alunno.cognome;
	nome := v_alunno.nome;
	assenze := v_alunno.assenze;
	ritardi := v_alunno.ritardi;
	uscite := v_alunno.uscite;
	fuori_classe := v_alunno.fuori_classe;
	note := v_alunno.note;
	mancanze := v_alunno.mancanze;
	condotta := v_alunno.condotta;
	rvs := null;
        valutazioni := null;
	voti := null;

	--RAISE NOTICE 'alunno... : % %', v_alunno.cognome, v_alunno.nome;
	--RAISE NOTICE 'i-------------------... : %', i;
	i := 1;

	FOR v_valutazione IN SELECT va.giorno || to_char(va.tipo_voto,'0000000000000000000') || to_char(va.argomento,'0000000000000000000') || to_char(vo.metrica,'0000000000000000000')  AS giorno ,
				    va.xmin::text::bigint AS rv,
				    va.valutazione,
	                            va.voto
	                       FROM valutazioni va
	                       JOIN voti vo ON vo.voto = va.voto
	                      WHERE va.classe = p_classe
	                        AND va.materia = p_materia
	                        AND va.docente = p_docente
	                        AND va.alunno = v_alunno.alunno
	                   ORDER BY 1
	LOOP    
		--RAISE NOTICE 'v_valutazione.giorno... : %', v_valutazione.giorno;
		--RAISE NOTICE 'v_giorni[i]............ : %', v_giorni[i];
		WHILE v_giorni[i] < v_valutazione.giorno AND i <= array_length(v_giorni,1) LOOP
			rvs[i] = null;
			valutazioni[i] = null;
			voti[i] = null;
			i := i + 1;
			--RAISE NOTICE 'v_giorni[i]............ : %', v_giorni[i];
		END LOOP;
		IF i <= array_length(v_giorni,1) THEN
			rvs[i] = v_valutazione.rv;
			valutazioni[i] = v_valutazione.valutazione;
			voti[i] = v_valutazione.voto;
			--RAISE NOTICE 'v_giorni[i] == v_valutazione.giorno';
			i := i +1;
		END IF;
	END LOOP;
	WHILE i <= array_length(v_giorni,1) LOOP
		--RAISE NOTICE 'i: %s indice null';
		rvs[i] = null;
		valutazioni[i] = null;
		voti[i] = null;
		i := i +1;
	END LOOP;
	RETURN NEXT;
END LOOP;	        
END;
$$;


ALTER FUNCTION public.griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) OWNER TO postgres;

--
-- TOC entry 450 (class 1255 OID 3918229)
-- Name: in_uno_dei_ruoli(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_uno_dei_ruoli(p_ruoli character varying[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	
	PERFORM 1 FROM persone_ruoli pr
	          JOIN persone p ON p.persona = pr.persona 
	          JOIN utenti u ON u.utente = p.utente
	         WHERE u.usename = session_user
	           AND pr.ruolo = ANY(p_ruoli::ruolo[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_uno_dei_ruoli(p_ruoli character varying[]) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 3918230)
-- Name: in_uno_dei_ruoli(character varying[], bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM persone_ruoli
	         WHERE persona  = p_persona
	           AND ruolo = ANY(p_ruoli::ruolo[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 3918231)
-- Name: istituti_abilitati(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_abilitati() RETURNS bigint[]
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
BEGIN 

RETURN  ARRAY( SELECT p.istituto 
   	         FROM persone p
   	         JOIN utenti u on u.utente = p.utente
	        WHERE u.usename = "session_user"());
END;
$$;


ALTER FUNCTION public.istituti_abilitati() OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 3918232)
-- Name: istituti_by_descrizione(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_by_descrizione(p_descrizione character varying) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT i.xmin::text::bigint AS rv,
  		      i.istituto,
  		      i.descrizione,
  		      i.codice_meccanografico,
  		      i.mnemonico,
  		      i.esempio
	         FROM istituti i
	        WHERE i.descrizione LIKE p_descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.istituti_by_descrizione(p_descrizione character varying) OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 3918233)
-- Name: istituti_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_del(p_rv bigint, p_istituto bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messaggi di sistema utilizzati dalla funzione 
 
DELETE FROM messaggi_sistema WHERE function_name = 'istituti_del';


INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_del',1,'it','Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_del',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_del',3,'it','Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'istituti_del';

BEGIN
    DELETE FROM istituti t WHERE t.istituto = p_istituto AND xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_istituto),
	     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	     HINT = messaggi_sistema_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.istituti_del(p_rv bigint, p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 557 (class 1255 OID 4021222)
-- Name: istituti_del_cascade(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) RETURNS TABLE(table_name character varying, record_deleted bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
--
-- cancella l'istituto in input e tutti i dati da esso dipendenti
--
declare
     rowcount bigint;
begin 

delete from spazi_lavoro where istituto = istituto_da_cancellare; 
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'spazi_lavoro .......................... : % righe cancellate', rowcount;
table_name := 'spazi_lavoro';
record_deleted := rowcount;
return next;

delete from conversazioni
      using classi_alunni, persone
      where classi_alunni.classe_alunno = conversazioni.libretto
        and classi_alunni.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'conversazioni ......................... : % righe cancellate', rowcount;
table_name := 'conversazioni';
record_deleted := rowcount;
return next;

delete from firme
      using persone
      where firme.docente = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'firme ................................. : % righe cancellate', rowcount;
table_name := 'firme';
record_deleted := rowcount;
return next;

delete from mancanze
      using persone
      where mancanze.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'mancanze .............................. : % righe cancellate', rowcount;
table_name := 'mancanze';
record_deleted := rowcount;
return next;

delete from lezioni
      using persone
      where lezioni.docente = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'lezioni ............................... : % righe cancellate', rowcount;
table_name := 'lezioni';
record_deleted := rowcount;
return next;

delete from assenze
      using persone
      where assenze.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'assenze ............................... : % righe cancellate', rowcount;
table_name := 'assenze';
record_deleted := rowcount;
return next;

delete from ritardi
      using persone
      where ritardi.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'ritardi ............................... : % righe cancellate', rowcount;
table_name := 'ritardi';
record_deleted := rowcount;
return next;

delete from uscite
      using persone
      where uscite.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'uscite ................................ : % righe cancellate', rowcount;
table_name := 'uscite';
record_deleted := rowcount;
return next;

delete from note
      using classi, anni_scolastici
      where note.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'note .................................. : % righe cancellate', rowcount;
table_name := 'note';
record_deleted := rowcount;
return next;

delete from fuori_classi
      using persone
      where fuori_classi.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'fuori_classi .......................... : % righe cancellate', rowcount;
table_name := 'fuori_classi';
record_deleted := rowcount;
return next;

delete from note_docenti
      using classi, anni_scolastici
      where note_docenti.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'note_docenti .......................... : % righe cancellate', rowcount;
table_name := 'note_docenti';
record_deleted := rowcount;
return next;

delete from giustificazioni 
      using persone
      where giustificazioni.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'giustificazioni ....................... : % righe cancellate', rowcount;
table_name := 'giustificazioni';
record_deleted := rowcount;
return next;

delete from valutazioni_qualifiche
      using valutazioni, classi, anni_scolastici
      where valutazioni_qualifiche.valutazione = valutazioni.valutazione
        and valutazioni.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'valutazioni_qualifiche ................ : % righe cancellate', rowcount;
table_name := 'valutazioni_qualifiche';
record_deleted := rowcount;
return next;

delete from valutazioni
      using classi, anni_scolastici
      where valutazioni.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'valutazioni ........................... : % righe cancellate', rowcount;
table_name := 'valutazioni';
record_deleted := rowcount;
return next;

delete from argomenti
      using indirizzi_scolastici
      where argomenti.indirizzo_scolastico = indirizzi_scolastici.indirizzo_scolastico
        and indirizzi_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'argomenti ............................. : % righe cancellate', rowcount;
table_name := 'argomenti';
record_deleted := rowcount;
return next;

delete from tipi_voto
      using materie
      where tipi_voto.materia = materie.materia
        and materie.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'tipi_voto ............................. : % righe cancellate', rowcount;
table_name := 'tipi_voto';
record_deleted := rowcount;
return next;
--
-- riapro gli scrutini altrimenti non riesco a cancellare le righe da scrutini_valutazioni_qualifiche
--
update scrutini s set chiuso = false
  from anni_scolastici a
 where a.anno_scolastico = s.anno_scolastico
   and a.istituto = istituto_da_cancellare;

delete from scrutini_valutazioni_qualifiche
      using scrutini_valutazioni, scrutini, anni_scolastici 
      where scrutini_valutazioni_qualifiche.scrutinio_valutazione = scrutini_valutazioni.scrutinio_valutazione
        and scrutini_valutazioni.scrutinio = scrutini.scrutinio
        and scrutini.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'scrutini_valutazioni_qualifiche ....... : % righe cancellate', rowcount;
table_name := 'scrutini_valutazioni_qualifiche';
record_deleted := rowcount;
return next;

delete from scrutini_valutazioni
      using scrutini, anni_scolastici 
      where scrutini_valutazioni.scrutinio = scrutini.scrutinio
        and scrutini.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'scrutini_valutazioni .................. : % righe cancellate', rowcount;
table_name := 'scrutini_valutazioni';
record_deleted := rowcount;
return next;

delete from scrutini
      using anni_scolastici 
      where scrutini.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'scrutini .............................. : % righe cancellate', rowcount;
table_name := 'scrutini';
record_deleted := rowcount;
return next;

delete from orari_settimanali
      using classi, anni_scolastici
      where orari_settimanali.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'orari_settimanali ..................... : % righe cancellate', rowcount;
table_name := 'orari_settimanali';
record_deleted := rowcount;
return next;

delete from festivi 
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'festivi ............................... : % righe cancellate', rowcount;
table_name := 'festivi';
record_deleted := rowcount;
return next;

delete from classi_alunni
      using persone
      where classi_alunni.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'classi_alunni ......................... : % righe cancellate', rowcount;
table_name := 'classi_alunni';
record_deleted := rowcount;
return next;

delete from colloqui
      using persone
      where colloqui.docente = persone.persona
        and istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'colloqui .............................. : % righe cancellate', rowcount;
table_name := 'colloqui';
record_deleted := rowcount;
return next;

delete from persone
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'persone ............................... : % righe cancellate', rowcount;
table_name := 'persone';
record_deleted := rowcount;
return next;

delete from classi 
      using anni_scolastici
      where classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'classi ................................ : % righe cancellate', rowcount;
table_name := 'classi';
record_deleted := rowcount;
return next;

delete from qualifiche
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'qualifiche ............................ : % righe cancellate', rowcount;
table_name := 'qualifiche';
record_deleted := rowcount;
return next;
    
delete from anni_scolastici
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'anni_scolastici ....................... : % righe cancellate', rowcount;
table_name := 'anni_scolastici';
record_deleted := rowcount;
return next;

delete from indirizzi_scolastici
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'indirizzi_scolastici .................. : % righe cancellate', rowcount;
table_name := 'indirizzi_scolastici';
record_deleted := rowcount;
return next;

delete from plessi
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'plessi ................................ : % righe cancellate', rowcount;
table_name := 'plessi';
record_deleted := rowcount;
return next;
--
-- tolgo l'eventuale materia della condotta dall'istituto
--
update istituti set condotta = null 
 where istituto = istituto_da_cancellare;

delete from materie 
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'materie ............................... : % righe cancellate', rowcount;
table_name := 'materie';
record_deleted := rowcount;
return next;
      
delete from voti
      using metriche
      where voti.metrica = metriche.metrica
        and metriche.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'voti .................................. : % righe cancellate', rowcount;
table_name := 'voti';
record_deleted := rowcount;
return next;

delete from metriche
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'metriche .............................. : % righe cancellate', rowcount;
table_name := 'metriche';
record_deleted := rowcount;
return next;

delete from tipi_comunicazione
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'tipi_comunicazione .................... : % righe cancellate', rowcount;
table_name := 'tipi_comunicazione';
record_deleted := rowcount;
return next;

delete from istituti
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'istituti .............................. : % righe cancellate', rowcount;
table_name := 'istituti';
record_deleted := rowcount;
return next;

 return ;

 end;
$$;


ALTER FUNCTION public.istituti_del_cascade(istituto_da_cancellare bigint) OWNER TO postgres;

--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 557
-- Name: FUNCTION istituti_del_cascade(istituto_da_cancellare bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) IS 'Il comando prende in input il codice di un istituto e cancella tutti i record di tutte le tabelle collegate all''istituto';


--
-- TOC entry 514 (class 1255 OID 3918234)
-- Name: istituti_ins(character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'istituti_ins';

BEGIN 

    INSERT INTO istituti (descrizione, codice_meccanografico, mnemonico, esempio)
         VALUES (p_descrizione, p_codice_meccanografico, p_mnemonico, p_esempio);
         
    SELECT currval('pk_seq') INTO p_istituto;
    SELECT xmin::text::bigint INTO p_rv FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 3918235)
-- Name: istituti_ins(character varying, character varying, character varying, boolean, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'istituti_ins';

BEGIN 

    INSERT INTO istituti (descrizione, codice_meccanografico, mnemonico, esempio, logo)
         VALUES (p_descrizione, p_codice_meccanografico, p_mnemonico, p_esempio, p_logo);
         
    SELECT currval('pk_seq') INTO p_istituto;
    SELECT xmin::text::bigint INTO p_rv FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 3918236)
-- Name: istituti_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT i.xmin::text::bigint AS rv,
  		      i.istituto,
  		      i.descrizione,
  		      i.codice_meccanografico,
  		      i.mnemonico,
  		      i.esempio
                 FROM istituti i 
	   INNER JOIN persone p ON ( i.istituto = p.istituto  )  
	   INNER JOIN utenti u ON ( p.utente = u.utente  )  
	        WHERE u.usename = session_user
	     ORDER BY i.descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.istituti_list() OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 3918237)
-- Name: istituti_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione
 
DELETE FROM messaggi_sistema WHERE function_name = 'istituti_sel';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_sel',1,'it','Non è stata trovata nessuna riga nella tabella ''istituti'' con:  ''istituto'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_sel',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_sel',3,'it','Controllare il valore di: ''istituto'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'istituti_sel';

BEGIN

	SELECT xmin::text::bigint, istituto, descrizione, codice_meccanografico, mnemonico, esempio, logo
	INTO p_rv, p_istituto, p_descrizione, p_codice_meccanografico, p_mnemonico, p_esempio, p_logo
	FROM istituti
	WHERE istituto = p_istituto;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_istituto),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 3918238)
-- Name: istituti_sel_logo(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_sel_logo(p_istituto bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  m_logo bytea;
  function_name varchar = 'istituti_sel_logo';
BEGIN 
  SELECT logo INTO m_logo from istituti where istituto = p_istituto;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(messaggi_sistema_locale(function_name,1), p_istituto::varchar),
	        DETAIL = format(messaggi_sistema_locale(function_name,2) ,current_query()),
	        HINT = messaggi_sistema_locale(function_name,3);
	END IF;                   
  RETURN m_logo;
 END;
$$;


ALTER FUNCTION public.istituti_sel_logo(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 3918239)
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'istituti_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',3,'it','Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'istituti_upd';

BEGIN

	UPDATE istituti SET istituto = p_istituto,descrizione = p_descrizione,codice_meccanografico = p_codice_meccanografico,mnemonico = p_mnemonico,esempio = p_esempio
    	WHERE istituto = p_istituto AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_istituto),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) OWNER TO postgres;

--
-- TOC entry 525 (class 1255 OID 3918240)
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'istituti_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('istituti_upd',3,'it','Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'istituti_upd';

BEGIN

	UPDATE istituti SET istituto = p_istituto,descrizione = p_descrizione,codice_meccanografico = p_codice_meccanografico,mnemonico = p_mnemonico,esempio = p_esempio,logo = p_logo
    	WHERE istituto = p_istituto AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_istituto),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 526 (class 1255 OID 3918241)
-- Name: istituti_upd_logo(bigint, bigint, bytea); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'istituti_upd_logo';
BEGIN 
  UPDATE istituti SET logo=p_logo WHERE istituto = p_istituto  AND xmin = p_rv::text::xid;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(messaggi_sistema_locale(function_name,1), p_istituto::varchar),
	        DETAIL = format(messaggi_sistema_locale(function_name,1) ,current_query()),
	        HINT = messaggi_sistema_locale(function_name,3);
	END IF;                   
   RETURN xmin::text::bigint FROM istituti WHERE istituto = p_istituto;
 END;
$$;


ALTER FUNCTION public.istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 3918243)
-- Name: lezioni_by_docente_classe_materia(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT supplenza,
		       giorno,
		       dalle,
		       alle,
		       descrizione
		  FROM lezioni
		 WHERE docente = p_docente
		   AND classe = p_classe
		   AND materia = p_materia
	      ORDER BY giorno, dalle;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) IS 'Dato un docente, una classe ed una materia ritona l''elenco delle lezioni';


--
-- TOC entry 527 (class 1255 OID 3918244)
-- Name: materie_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_del(p_rv bigint, p_materia bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messaggi di sistema utilizzati dalla funzione 
 
DELETE FROM messaggi_sistema WHERE function_name = 'materie_del';


INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_del',1,'it','Non è stata trovata nessuna riga nella tabella ''materie'' con: ''revisione'' = ''%s'',  ''materia'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_del',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_del',3,'it','Controllare il valore di: ''revisione'', ''materia'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'materie_del';

BEGIN
    DELETE FROM materie t
	      WHERE t.materia = p_materia AND
	            xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_materia),
	     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	     HINT = messaggi_sistema_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.materie_del(p_rv bigint, p_materia bigint) OWNER TO postgres;

--
-- TOC entry 528 (class 1255 OID 3918245)
-- Name: materie_ins(bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'materie_ins';

BEGIN 

    INSERT INTO materie (istituto, descrizione)
         VALUES (p_istituto, p_descrizione);
         
    SELECT currval('pk_seq') INTO p_materia;
    SELECT xmin::text::bigint INTO p_rv FROM public.materie WHERE materia = p_materia;
END;
$$;


ALTER FUNCTION public.materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) OWNER TO postgres;

--
-- TOC entry 529 (class 1255 OID 3918246)
-- Name: materie_ins(bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
DECLARE

  function_name varchar = 'materie_ins';

BEGIN 

    INSERT INTO materie (istituto, descrizione, metrica)
         VALUES (p_istituto, p_descrizione, p_metrica);
         
    SELECT currval('pk_seq') INTO p_materia;
    SELECT xmin::text::bigint INTO p_rv FROM materie WHERE materia = p_materia;
END;
$$;


ALTER FUNCTION public.materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) OWNER TO postgres;

--
-- TOC entry 531 (class 1255 OID 3918247)
-- Name: materie_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_list(p_istituto bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
				 
DECLARE

	cur refcursor;
	function_name varchar = 'materie_list';

BEGIN

	OPEN cur FOR SELECT xmin::text::bigint AS rv, materia, istituto, descrizione
		       FROM materie 
	              WHERE istituto = p_istituto
		   ORDER BY descrizione;
	RETURN cur;
END;
$$;


ALTER FUNCTION public.materie_list(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 532 (class 1255 OID 3918248)
-- Name: materie_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione
 
DELETE FROM messaggi_sistema WHERE function_name = 'materie_sel';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_sel',1,'it','Non è stata trovata nessuna riga nella tabella ''materie'' con:  ''materia'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_sel',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_sel',3,'it','Controllare il valore di: ''materia'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'materie_sel';

BEGIN

	SELECT xmin::text::bigint, materia, istituto, descrizione
	INTO p_rv, p_materia, p_istituto, p_descrizione
	FROM materie
	WHERE materia = p_materia;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_materia),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) OWNER TO postgres;

--
-- TOC entry 533 (class 1255 OID 3918249)
-- Name: materie_upd(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:31:19 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'materie_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''materie'' con: ''revisione'' = ''%s'',  ''materia'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',3,'it','Controllare il valore di: ''revisione'', ''materia'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'materie_upd';

BEGIN

	UPDATE materie SET materia = p_materia,istituto = p_istituto,descrizione = p_descrizione
		WHERE materia = p_materia AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
           ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_materia),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 3918250)
-- Name: materie_upd(bigint, bigint, bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'materie_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''materie'' con: ''revisione'' = ''%s'',  ''materia'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('materie_upd',3,'it','Controllare il valore di: ''revisione'', ''materia'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'materie_upd';

BEGIN

	UPDATE materie SET materia = p_materia,istituto = p_istituto,descrizione = p_descrizione,metrica = p_metrica
		WHERE materia = p_materia AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_materia),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    RETURN xmin::text::bigint  FROM istituti WHERE istituto = p_istituto;
END;
$$;


ALTER FUNCTION public.materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) OWNER TO postgres;

--
-- TOC entry 537 (class 1255 OID 3918251)
-- Name: max_sequence(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION max_sequence(name text) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, max_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/*
   Elenca tutte le colonne del database che hanno collegato al default
   la sequenza indicata dal parametro name e visualizza il valore massimo assegnato
*/
declare
      results record;
      default_column character varying;
begin 
      default_column = 'nextval(''' || name || '''::regclass)';
      for  results in select
			columns.table_catalog, 
			columns.table_schema,
			columns.table_name, 
			columns.column_name
		      from
			information_schema.columns, 
			information_schema.tables
		      where
			columns.table_catalog = tables.table_catalog AND
			columns.table_schema = tables.table_schema AND
			columns.table_name = tables.table_name AND
			tables.table_catalog = 'scuola247' AND 
			tables.table_schema = 'public' AND 
			tables.table_type = 'BASE TABLE' AND 
			columns.column_default =  default_column
      loop
	table_catalog := results.table_catalog;
	table_schema := results.table_schema;
	table_name := results.table_name;
	column_name := results.column_name;
	execute 'SELECT MAX(' || column_name || ') FROM ' || table_name into strict max_value;
	return next;
      end loop;
 end;
$$;


ALTER FUNCTION public.max_sequence(name text) OWNER TO postgres;

--
-- TOC entry 3366 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION max_sequence(name text) IS 'Restituisce una tabella con le seguenti colonne: table_catalog, table_schema, table_name, column_name, max_value popolandola con una riga per ogni colonna del database che contiena una clausola default uguale a: "nextval(''<name>''::regclass)"  (dove il <name> si intende sostitutito dal parametro name passato alla funzione nel momento in cui viene richiamata) abbinandola al valore massimo contenuto dalla colonna.';


--
-- TOC entry 509 (class 1255 OID 3918252)
-- Name: messaggi_sistema_clona(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
  rowcount bigint;
BEGIN 
	INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
		SELECT p_function_name_to, id, lingua, descrizione FROM messaggi_sistema WHERE function_name = p_function_name_from;
	GET DIAGNOSTICS rowcount = ROW_COUNT;

RETURN 'Messaggi clonati: ' || rowcount ; 	        
END;
$$;


ALTER FUNCTION public.messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 3918253)
-- Name: messaggi_sistema_locale(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  msg varchar;
  lng lingua;
BEGIN 
  SELECT lingua INTO lng FROM public.utenti WHERE usename = session_user;
  IF NOT FOUND THEN
    msg := format('Non ho potuto descrivere il messaggio: ''%s'' della funzione: ''%s'' perché non ho trovato l''utente: ''%s'' nella tabella ''utenti''', p_id, p_function_name, session_user);
  ELSE
     SELECT descrizione INTO msg FROM public.messaggi_sistema WHERE function_name = p_function_name AND id = p_id AND lingua = lng;
     IF NOT FOUND THEN
        msg := format('Non ho potuto descrivere il messaggio: ''%s'' della funzione ''%s'' (per la lingua: ''%s'') perchè non l''ho trovato nella tabella: ''messaggi_sistema''',p_id, p_function_name, lng);
     END IF;
  END IF;
  RETURN msg;
  END;
$$;


ALTER FUNCTION public.messaggi_sistema_locale(p_function_name character varying, p_id integer) OWNER TO postgres;

--
-- TOC entry 3369 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) IS 'Restituisce il messaggio di sistema richiesto in base alla lingua dell''utente collegato';


--
-- TOC entry 460 (class 1255 OID 3918254)
-- Name: metriche_by_istituto(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION metriche_by_istituto(p_istituto bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       metrica,
		       descrizione
		  FROM metriche
		 WHERE istituto = p_istituto
	      ORDER BY descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.metriche_by_istituto(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 3918255)
-- Name: nel_ruolo(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nel_ruolo(p_ruolo character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	PERFORM 1 FROM persone_ruoli pr
	          JOIN persone p ON p.persona = pr.persona 
	          JOIN utenti u ON u.utente = p.utente
	         WHERE u.usename = session_user
	           AND pr.ruolo = p_ruolo::ruolo;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.nel_ruolo(p_ruolo character varying) OWNER TO postgres;

--
-- TOC entry 3372 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION nel_ruolo(p_ruolo character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION nel_ruolo(p_ruolo character varying) IS 'Il comando  restituisce TRUE o FALSE a seconda se l''utente collegato è abilitato al ruolo indicato in input';


--
-- TOC entry 461 (class 1255 OID 3918256)
-- Name: nel_ruolo(character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM persone_ruoli
	         WHERE persona  = p_persona
	           AND ruolo = p_ruolo::ruolo;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.nel_ruolo(p_ruolo character varying, p_persona bigint) OWNER TO postgres;

--
-- TOC entry 3374 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) IS 'Il comando  restituisce TRUE o FALSE a seconda se la persona indicata in input è abilitata al ruolo indicato in input';


--
-- TOC entry 459 (class 1255 OID 3918257)
-- Name: nel_ruolo(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM persone_ruoli pr
	          JOIN persone p ON p.persona = pr.persona 
	          JOIN utenti u ON u.utente = p.utente
	         WHERE u.usename = p_usename::name
	           AND pr.ruolo = p_ruolo::ruolo;
	RETURN FOUND;
	
END;
$$;


ALTER FUNCTION public.nel_ruolo(p_ruolo character varying, p_usename character varying) OWNER TO postgres;

--
-- TOC entry 3376 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) IS 'Il comando  restituisce TRUE o FALSE a seconda se l''utente indicato è abilitato al ruolo indicato in input';


--
-- TOC entry 462 (class 1255 OID 3918258)
-- Name: nome_giorno(giorno_settimana); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'nome_giorno';
BEGIN 
  RETURN messaggi_sistema_locale(function_name,p_giorno_settimana::int);
END;
$$;


ALTER FUNCTION public.nome_giorno(p_giorno_settimana giorno_settimana) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 3918259)
-- Name: orari_settimanali_xt_docente(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) RETURNS TABLE(periodo text, "lunedì" text, "martedì" text, "mercoledì" text, "giovedì" text, "venerdì" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
BEGIN 
  RETURN QUERY SELECT *
                 FROM crosstab('SELECT periodo, giorno_settimana, docente_nome_cognome 
                                  FROM orari_settimanali_giorni_ex 
                                 WHERE orario_settimanale='  || p_orario_settimanale || ' ORDER BY 1',
                                 $$VALUES (1),(2),(3),(4),(5),(6)$$
                               )
                   AS ct (periodo text, lunedì text, martedì text, mercoledì text, giovedì text, venerdì text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.orari_settimanali_xt_docente(p_orario_settimanale bigint) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 3918260)
-- Name: orari_settimanali_xt_materia(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) RETURNS TABLE(periodo text, "lunedì" text, "martedì" text, "mercoledì" text, "giovedì" text, "venerdì" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
BEGIN 
  RETURN QUERY SELECT *
                 FROM crosstab('SELECT periodo, giorno_settimana, materia::text 
                                  FROM orari_settimanali_giorni_ex 
                                 WHERE orario_settimanale='  || p_orario_settimanale || ' ORDER BY 1',
                                 $$VALUES (1),(2),(3),(4),(5),(6)$$
                               )
                   AS ct (periodo text, lunedì text, martedì text, mercoledì text, giovedì text, venerdì text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.orari_settimanali_xt_materia(p_orario_settimanale bigint) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 3918261)
-- Name: persone_cognome_nome(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persone_cognome_nome(p_persona bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  v_cognome_nome varchar;
  function_name varchar = 'persone_cognome_nome';
BEGIN 
  SELECT cognome || ' ' || nome INTO v_cognome_nome 
  FROM persone p
  JOIN istituti i ON i.istituto = p.istituto 
  JOIN utenti_istituti ui ON ui.istituto = i.istituto
  JOIN utenti u ON u.utente = ui .utente
  WHERE u.usename = session_user 
    AND p.persona = p_persona;
  IF NOT FOUND THEN 
	  RAISE USING
	        ERRCODE = function_sqlcode(function_name,'1'),
	        MESSAGE = format(messaggi_sistema_locale(function_name,1), p_persona::varchar),
	        DETAIL = format(messaggi_sistema_locale(function_name,2) ,current_query()),
	        HINT = messaggi_sistema_locale(function_name,3);
	END IF;                   
  RETURN v_cognome_nome;
 END;
$$;


ALTER FUNCTION public.persone_cognome_nome(p_persona bigint) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 3918262)
-- Name: persone_sel_foto_miniatura(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persone_sel_foto_miniatura(p_persona bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  m_miniatura bytea;
  function_name varchar = 'persone_sel_foto_miniatura';
BEGIN 
	SELECT COALESCE(foto_miniatura,foto_miniatura_default()) INTO m_miniatura from persone where persona = p_persona;
	IF NOT FOUND THEN 
		RAISE USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = format(messaggi_sistema_locale(function_name,1), p_persona::varchar),
		DETAIL = format(messaggi_sistema_locale(function_name,2) ,current_query()),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;  
RETURN m_miniatura;
END;
$$;


ALTER FUNCTION public.persone_sel_foto_miniatura(p_persona bigint) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 3918263)
-- Name: qualifiche_tree(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION qualifiche_tree() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
/*

Ancora non sono riuscito a mettere in una funzione la query che segue:

SELECT q.tipo, repeat('   ',level) || q.nome as tree,
       t.qualifica,
       q.nome,
       t.level,
       t.qualifica_padre,
       r.nome,
       t.branch
FROM connectby('public.qualifiche','qualifica','qualifica_padre','96203',100,'-')
AS t(qualifica bigint, qualifica_padre bigint, level int, branch text)
LEFT JOIN qualifiche q on (q.qualifica = t.qualifica)
LEFT JOIN qualifiche r on (r.qualifica = t.qualifica_padre)
ORDER BY t.branch;
*/
  v_min_qualifica text;
BEGIN 
  SELECT MIN(qualifica)::text INTO v_min_qualifica FROM qualifiche;
--  EXECUTE 'SELECT repeat(''   '',level) || q.nome as tree, t.qualifica, q.nome, t.level, t.riferimento, r.nome, t.branch FROM connectby(''public.qualifiche'',''qualifica'',''riferimento'',' || v_min_qualifica || ',100,''-'')'
 END;
$$;


ALTER FUNCTION public.qualifiche_tree() OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 3918264)
-- Name: rs_colonne_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rs_colonne_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT *
                 FROM rs_colonne;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.rs_colonne_list() OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 3918265)
-- Name: rs_righe_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rs_righe_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT *
                 FROM rs_righe;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.rs_righe_list() OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 3918266)
-- Name: ruoli_by_session_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION ruoli_by_session_user() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT pr.ruolo
 		 FROM persone_ruoli pr 
           INNER JOIN persone p ON ( pr.persona = p.persona  )  
	   INNER JOIN utenti u ON ( p.utente = u.utente  )  
	   INNER JOIN spazi_lavoro sl ON ( u.spazio_lavoro = sl.spazio_lavoro  )  
		WHERE u.usename = "session_user"()
		  AND p.istituto = sl.istituto;
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.ruoli_by_session_user() OWNER TO postgres;

--
-- TOC entry 469 (class 1255 OID 3918267)
-- Name: session_persona(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_persona(p_istituto bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
	v_persona bigint;
begin 

	SELECT p.persona INTO v_persona
	  FROM persone p
          JOIN utenti u ON u.utente = p.utente
         WHERE u.usename = session_user
           AND p.istituto = p_istituto;

	return v_persona;

 end;
$$;


ALTER FUNCTION public.session_persona(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 469
-- Name: FUNCTION session_persona(p_istituto bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_persona(p_istituto bigint) IS 'Il comando  restituisce la persona dell''utente collegato a seconda dell''istituto passato come parametro';


--
-- TOC entry 470 (class 1255 OID 3918268)
-- Name: session_utente(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_utente() RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
	v_utente bigint;
begin 

	SELECT utente
	INTO v_utente
	FROM utenti
	WHERE usename = session_user;

	return v_utente;

 end;
$$;


ALTER FUNCTION public.session_utente() OWNER TO postgres;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 470
-- Name: FUNCTION session_utente(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_utente() IS 'Il comando  restituisce l''utente collegato';


--
-- TOC entry 468 (class 1255 OID 3918269)
-- Name: set_max_sequence(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_max_sequence(name text) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
      max bigint;
begin 

 execute 'SELECT setval(''' || name || '''::regclass, max(max_value)) FROM max_sequence(''' || name || ''')' into strict  max;
 return max;

 end;
$$;


ALTER FUNCTION public.set_max_sequence(name text) OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION set_max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION set_max_sequence(name text) IS 'Il comando prende il valore massimo fra quelli restitutiti dalla funzione max_sequence, richiamata con il parametro ricevuti in input, e lo imposta nella sequenza il cui nome riceve come parametro di input nella chiamata';


--
-- TOC entry 520 (class 1255 OID 3918270)
-- Name: set_spazio_lavoro_default(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
La funzione imposta lo spazio di lavoro per l'utente corrente
non viene gestito il row versioning
*/
DECLARE
  function_name varchar = 'set_spazio_lavoro_default';
BEGIN
  UPDATE utenti SET spazio_lavoro = p_spazio_lavoro WHERE usename = session_user;
  IF NOT FOUND THEN 
     RAISE EXCEPTION USING
     ERRCODE = function_sqlcode(function_name,'1'),
     MESSAGE = format(messaggi_sistema_locale(function_name,1),p_spazio_lavoro),
     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
     HINT = messaggi_sistema_locale(function_name,3);
  END IF;
END;
$$;


ALTER FUNCTION public.set_spazio_lavoro_default(p_spazio_lavoro bigint) OWNER TO postgres;

--
-- TOC entry 471 (class 1255 OID 3918271)
-- Name: spazi_lavoro_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'spazi_lavoro_del';
BEGIN
  DELETE FROM spazi_lavoro WHERE spazio_lavoro = p_spazio_lavoro and xmin = p_rv::text::xid;
  IF NOT FOUND THEN 
     RAISE EXCEPTION USING
     ERRCODE = function_sqlcode(function_name,'1'),
     MESSAGE = format(messaggi_sistema_locale(function_name,1),p_spazio_lavoro, p_rv),
     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
     HINT = messaggi_sistema_locale(function_name,3);
  END IF;
END;
$$;


ALTER FUNCTION public.spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) OWNER TO postgres;

--
-- TOC entry 524 (class 1255 OID 3918272)
-- Name: spazi_lavoro_ins(character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  function_name varchar = 'spazi_lavoro_ins';
  v_utente bigint;
BEGIN 
  SELECT utente INTO v_utente FROM utenti WHERE usename = session_user;
  INSERT INTO spazi_lavoro(utente, descrizione, istituto, anno_scolastico, classe, materia, docente, famigliare, alunno) 
         VALUES (v_utente, p_descrizione, p_istituto, p_anno_scolastico, p_classe, p_materia, p_docente, p_famigliare, p_alunno);
  SELECT currval('pk_seq') INTO p_spazio_lavoro;
  SELECT xmin::text::bigint INTO p_rv FROM spazi_lavoro WHERE spazio_lavoro = p_spazio_lavoro;

END;
$$;


ALTER FUNCTION public.spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 3918273)
-- Name: spazi_lavoro_list(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION spazi_lavoro_list() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR  SELECT sl.xmin::text::bigint AS rv,
		        sl.spazio_lavoro,
		        sl.istituto,
		        sl.anno_scolastico,
		        sl.classe,
		        sl.materia,
		        sl.docente,
		        sl.famigliare,
		        sl.alunno,
		        sl.descrizione,
		        CASE WHEN sl.spazio_lavoro = u.spazio_lavoro THEN true ELSE false END AS default
		FROM spazi_lavoro sl 
		JOIN utenti u ON ( sl.utente = u.utente  )  
		WHERE u.usename = session_user
		ORDER BY sl.descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.spazi_lavoro_list() OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 3918274)
-- Name: test(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION test() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  v1 integer = 12;
  v2 integer;
BEGIN 

  --v1:= null;
  v2 = 12;

  if v1=v2 THEN 
	return 'ok'; 
  ELSE 
        return 'ko';
  END IF;
 END;
$$;


ALTER FUNCTION public.test() OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 3918275)
-- Name: test(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION test(p_istituto integer) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  function_sqlcode char(4);
BEGIN 

  SELECT function_sqlcode('z') INTO function_sqlcode;
  
  	  RAISE USING
	        ERRCODE = function_sqlcode || '1',
	        MESSAGE = 'mmmm',
	        DETAIL = 'dddd',
	        HINT = 'hhhhhhh';
RETURN 11;
 END;
$$;


ALTER FUNCTION public.test(p_istituto integer) OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 3918276)
-- Name: tipi_voto_by_materia(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tipi_voto_by_materia(p_materia bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       tipo_voto,
		       descrizione
		  FROM tipi_voto
		 WHERE materia = p_materia
	      ORDER BY descrizione;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.tipi_voto_by_materia(p_materia bigint) OWNER TO postgres;

--
-- TOC entry 530 (class 1255 OID 3918277)
-- Name: tr_argomenti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_argomenti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_argomenti_iu';
BEGIN
--
-- controllo che la materia e l'indirizzo scolastico siano dello stesso istituto
--
	PERFORM 1 FROM materie m
	          JOIN indirizzi_scolastici i ON i.istituto = m.istituto
	         WHERE m.materia = new.materia
	           AND i.indirizzo_scolastico = new.indirizzo_scolastico;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.argomento, new.materia,  new.anno_scolastico),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.materia,  new.anno_scolastico),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_argomenti_iu() OWNER TO postgres;

--
-- TOC entry 534 (class 1255 OID 3918278)
-- Name: tr_assenze_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_assenze_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_assenze_iu';
	v_istituto bigint;
BEGIN
--
-- leggo l'istituto della classe
--
        SELECT istituto INTO v_istituto FROM classi WHERE classe = new.classe;
--
-- controllo che nel giorno dell'assenza ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	         WHERE classe = new.classe
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.assenza,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la giustificazione, se indicata, sia relativa a quell'alunno, a quel giorno di assenza e creata dopo o al massimo il giorno stesso dell'assenza
--
	IF new.giustificazione IS NOT NULL THEN
		PERFORM 1 FROM giustificazioni WHERE giustificazione=new.giustificazione AND alunno = new.alunno AND creata_il >= new.giorno AND new.giorno BETWEEN dal AND al ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,6), new.assenza, new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,8), new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,10), new.assenza, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,14), new.assenza, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,16), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   END IF;	   
	END IF;	
--
-- controllo che l'alunno,  nello giorno, non sia già stato segnato come ritardo
--
	PERFORM 1 FROM ritardi 
	         WHERE classe = new.classe
	           AND giorno = new.giorno
	           AND alunno = new.alunno;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = messaggi_sistema_locale(function_name,17),
			   DETAIL = format(messaggi_sistema_locale(function_name,18), new.assenza, new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,19);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = messaggi_sistema_locale(function_name,17),
			   DETAIL = format(messaggi_sistema_locale(function_name,20), new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,19);
		END IF;	   
	END IF;
--
-- controllo che l'alunno,  nello giorno, non sia già stato segnato come uscito
--
	PERFORM 1 FROM uscite 
	         WHERE classe = new.classe
	           AND giorno = new.giorno
	           AND alunno = new.alunno;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'B'),
			   MESSAGE = messaggi_sistema_locale(function_name,21),
			   DETAIL = format(messaggi_sistema_locale(function_name,22),new.assenza, new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,23);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'C'),
			   MESSAGE = messaggi_sistema_locale(function_name,21),
			   DETAIL = format(messaggi_sistema_locale(function_name,24),new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,23);
		END IF;	   
	END IF;
--
-- controllo che l'alunno, nello giorno, non sia già stato segnato come fuori classe
--
	PERFORM 1 FROM fuori_classi 
	         WHERE classe = new.classe
	           AND giorno = new.giorno
	           AND alunno = new.alunno;
	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'D'),
			   MESSAGE = messaggi_sistema_locale(function_name,25),
			   DETAIL = format(messaggi_sistema_locale(function_name,26), new.assenza, new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,27);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'E'),
			   MESSAGE = messaggi_sistema_locale(function_name,25),
			   DETAIL = format(messaggi_sistema_locale(function_name,28), new.alunno, new.classe, new.giorno),
			   HINT = messaggi_sistema_locale(function_name,27);
		END IF;	   
	END IF;
--
-- controllo che l'alunno sia nel ruolo alunni
--
	IF NOT nel_ruolo('Alunno',new.alunno) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = messaggi_sistema_locale(function_name,29),
			   DETAIL = format(messaggi_sistema_locale(function_name,30), new.assenza, new.alunno),
			   HINT = messaggi_sistema_locale(function_name,31);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = messaggi_sistema_locale(function_name,29),
			   DETAIL = format(messaggi_sistema_locale(function_name,32), new.alunno),
			   HINT = messaggi_sistema_locale(function_name,31);
		END IF;	   
	END IF;
--
-- controllo che il docente sia nel ruolo docenti
--
	IF NOT nel_ruolo('Docente',new.docente) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'H'),
			   MESSAGE = messaggi_sistema_locale(function_name,33),
			   DETAIL = format(messaggi_sistema_locale(function_name,34), new.assenza, new.docente),
			   HINT = messaggi_sistema_locale(function_name,35);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'I'),
			   MESSAGE = messaggi_sistema_locale(function_name,33),
			   DETAIL = format(messaggi_sistema_locale(function_name,36), new.docente),
			   HINT = messaggi_sistema_locale(function_name,35);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_assenze_iu() OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 3918279)
-- Name: tr_classi_alunni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classi_alunni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_classi_alunni_iu';
BEGIN
--
-- controllo che classe e alunno siano dello stesso istituto
--
	PERFORM 1 FROM classe a
	          JOIN persone p ON a.istituto = p.istituto
	         WHERE c.classe = new.classe
	           AND p.persona = new.alunno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.classe_alunno, new.classe, new_alunno),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.classe, new_anno_alunno),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- l'aluuno può far parte di più classi:
-- esiste il caso che una classe abbia alcune materie in comune e poi aluni alunni abbiano
-- alcune materie e altri abbiano altre materie, in questo caso ogni alunno farà parte di due classi
-- una per le materie comuni ed un'altra per le restanti.
-- questo commento è stato messo per evitare di ripetere l'errore di aggiungere un controllo errato
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classi_alunni_iu() OWNER TO postgres;

--
-- TOC entry 539 (class 1255 OID 3918280)
-- Name: tr_classi_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classi_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_classi_iu';
BEGIN
--
-- controllo che anno_scolastico e indirizzo_scolastico siano dello stesso istituto
--
	PERFORM 1 FROM anni_scolastici a
	          JOIN indirizzi_scolastici i ON i.istituto = a.istituto
	         WHERE a.anno_scolastico = new.anno_scolastico
	           AND i.indirizzo_scolastico = new.indirizzo_scolastico;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.classe, new.anno_scolastico, new.indirizzo_scolastico),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.anno_scolastico, new.indirizzo_scolastico),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classi_iu() OWNER TO postgres;

--
-- TOC entry 538 (class 1255 OID 3918281)
-- Name: tr_colloqui_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_colloqui_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_colloqui_iu';
BEGIN
--
-- controllo che il docente e la persona che ha fissato il colloqui siano dello stesso istituto
--
	IF new.con IS NOT NULL THEN
		PERFORM 1 FROM persone doc
			  JOIN persone con ON doc.istituto = con.istituto
			 WHERE doc.persona = new.docente
			   AND con.persona = new.con;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'1'),
				   MESSAGE = messaggi_sistema_locale(function_name,1),
				   DETAIL = format(messaggi_sistema_locale(function_name,2), new.classe, new.anno_scolastico, new_indirizzo_scolastico),
				   HINT = messaggi_sistema_locale(function_name,3);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'2'),
				   MESSAGE = messaggi_sistema_locale(function_name,1),
				   DETAIL = format(messaggi_sistema_locale(function_name,4), new.anno_scolastico, new_indirizzo_scolastico),
				   HINT = messaggi_sistema_locale(function_name,3);
			END IF;	   
		END IF;
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_colloqui_iu() OWNER TO postgres;

--
-- TOC entry 540 (class 1255 OID 3918282)
-- Name: tr_conversazioni_invitati_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_conversazioni_invitati_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_conversazioni_invitati_iu';
BEGIN
--
-- controllo che la persona invitata sia dello stesso istituo dell'alunno a cui fa' capo la conversazione
--
	PERFORM 1 FROM conversazioni c
	          JOIN classi_alunni ca ON c.libretto = ca.classe_alunno
	          JOIN persone alu ON ca.alunno = p.persona
	          JOIN persone inv ON alu.istituto = inv.istituto
	         WHERE c.conversazione = new.conversazione
	           AND inv.persona = new.invitato;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.conversazioni_invitato, new.conversazione, new.invitato),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.conversazione, new.invitato),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_conversazioni_invitati_iu() OWNER TO postgres;

--
-- TOC entry 541 (class 1255 OID 3918283)
-- Name: tr_firme_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_firme_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_firme_iu';
BEGIN
--
-- controllo che il docente sia dello stesso istituo della classe
--
	PERFORM 1 FROM classi c
	          JOIN anni_scolastici a ON c.anno_scolastico = a.anno_scolastico
	          JOIN persone doc ON a.istituto = doc.istituto
	         WHERE doc.persona = new.docente
	           AND c.classe = new.classe;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.firma, new.docente, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.docente, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la persona indicata come docente abbia il ruolo di docente o dirigente
--
	IF NOT in_uno_dei_ruoli('{"Dirigente","Docente"}',new.docente) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,6), new.firma, new.docente),
			   HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = messaggi_sistema_locale(function_name,6),
			   DETAIL = format(messaggi_sistema_locale(function_name,8), new.docente),
			   HINT = messaggi_sistema_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_firme_iu() OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 3918284)
-- Name: tr_fuori_classi_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_fuori_classi_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_fuori_classi_iu';
	v_istituto	bigint;

BEGIN
--
-- controllo che nel giorno del fuori_classe ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	          JOIN classi_alunni ca ON ca.classe=l.classe
	         WHERE alunno = new.alunno
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.fuori_classe,  new.alunno),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.alunno),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- recupero l'istituto della classe
--
	SELECT a.istituto INTO v_istituto 
		FROM anni_scolastici a
		JOIN classi c ON a.anno_scolastico = c.anno_scolastico
		WHERE c.classe = new.classe;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = messaggi_sistema_locale(function_name,5),
		   DETAIL = format(messaggi_sistema_locale(function_name,6), new.fuori_classe, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,7);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = messaggi_sistema_locale(function_name,5),
		   DETAIL = format(messaggi_sistema_locale(function_name,8), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,7);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,10), new.fuori_classe, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,12), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,10);
	   END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_fuori_classi_iu() OWNER TO postgres;

--
-- TOC entry 546 (class 1255 OID 3918285)
-- Name: tr_giustificazioni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_giustificazioni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_giustificazioni_iu';
	v_istituto	bigint;
	v_nato		date;

BEGIN
--
-- controllo che l'alunno sia effettivamento un alunno
--
	IF NOT nel_ruolo('Alunno',alunno) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giustificazione, new.alunno),
		   HINT = messaggi_sistema_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,4), new.alunno),
		   HINT = messaggi_sistema_locale(function_name,3);
	   END IF;	   
	END IF;

--
-- recupero l'istituto e la data di nascita dell'alunno dell'alunno
--
	SELECT istituto, nato INTO v_istituto, v_nato
		FROM persone 
		WHERE persona = alunno;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della persona che ha creato la giustificazione
--
	PERFORM 1 FROM persone WHERE persona = new.creata_da AND istituto = v_istituto;

	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'3'),
			MESSAGE = messaggi_sistema_locale(function_name,5),
			DETAIL = format(messaggi_sistema_locale(function_name,6), new.giustificazione, new.alunno, v_istituto, new.creata_da),
			HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'4'),
			MESSAGE = messaggi_sistema_locale(function_name,5),
			DETAIL = format(messaggi_sistema_locale(function_name,8), new.alunno, v_istituto, new.creata_da),
			HINT = messaggi_sistema_locale(function_name,7);
		END IF;	   
	END IF;
--
-- controllo che se la giustificazione è stata fatta dall'alunno e questo sia maggiorenne
--
	IF new.creata_da = new.alunno THEN
		IF (SELECT extract('year' from age(new.registrato_il, v_nato)) < 18) THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'5'),
				MESSAGE = messaggi_sistema_locale(function_name,9),
				DETAIL = format(messaggi_sistema_locale(function_name,10), new.giustificazione, new.alunno),
				HINT = messaggi_sistema_locale(function_name,11);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'6'),
				MESSAGE = messaggi_sistema_locale(function_name,9),
				DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno),
				HINT = messaggi_sistema_locale(function_name,11);
			END IF;
		END IF;
	ELSE
	--
	-- altrimenti controllo che se la giustificazione sia stata fatta da un famigliare 
	-- esplicitamente autorizzato a giustificare e maggiorenne
	--
		PERFORM 1 FROM persone_relazioni pr
			  JOIN persone p ON pr.persona_relazionata = p.persona
		         WHERE pr.persona = new.alunno
		           AND pr.persona_relazionata = new.creata_da
		           AND pr.puo_giustificare = true
		           AND extract('year' from age(new.registrato_il, p.nato)) >= 18;
		IF NOT FOUND THEN
			--
			-- altrimenti controllo se la persona che ha creato la giustificazione è nel ruolo di
			-- gestori, dirigenti, impiegati o docenti 
			--
			IF NOT in_uno_dei_ruoli('{"Gestore","Dirigente","Impiegati","Docente"}',new.creata_da) THEN
				IF (TG_OP = 'UPDATE') THEN
					RAISE EXCEPTION USING
					ERRCODE = function_sqlcode(function_name,'7'),
					MESSAGE = messaggi_sistema_locale(function_name,13),
					DETAIL = format(messaggi_sistema_locale(function_name,14), new.giustificazione, new.creata_da),
					HINT = messaggi_sistema_locale(function_name,15);
				ELSE
					RAISE EXCEPTION USING
					ERRCODE = function_sqlcode(function_name,'8'),
					MESSAGE = messaggi_sistema_locale(function_name,13),
					DETAIL = format(messaggi_sistema_locale(function_name,16), new.creata_da),
					HINT = messaggi_sistema_locale(function_name,15);
				END IF;	
			END IF;			
		END IF;
	END IF;
--	
-- controllo che l'istituto dell'alunno sia uguale a quello della persona che ha registrato la giustificazione
--
	IF new.registrata_da IS NOT NULL THEN

		PERFORM 1 FROM persone WHERE persona = new.registrata_da AND istituto = v_istituto;

		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'9'),
				MESSAGE = messaggi_sistema_locale(function_name,17),
				DETAIL = format(messaggi_sistema_locale(function_name,18), new.giustificazione, new.registrato_da),
				HINT = messaggi_sistema_locale(function_name,19);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'10'),
				MESSAGE = messaggi_sistema_locale(function_name,17),
				DETAIL = format(messaggi_sistema_locale(function_name,20), new.registrato_da),
				HINT = messaggi_sistema_locale(function_name,19);
			END IF;	   
		END IF;
--
-- controllo che la persona che ha registrato la giustificazione sia un docente, un impiegato, un dirigente o un gestore
--
		IF NOT uno_dei_ruoli('{"Gestore","Dirigente","Impiegato","Docente"}')  THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'11'),
				MESSAGE = messaggi_sistema_locale(function_name,21),
				DETAIL = format(messaggi_sistema_locale(function_name,22), new.giustificazione, new.registrato_da),
				HINT = messaggi_sistema_locale(function_name,23);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'12'),
				MESSAGE = messaggi_sistema_locale(function_name,21),
				DETAIL = format(messaggi_sistema_locale(function_name,24), new.registrato_da),
				HINT = messaggi_sistema_locale(function_name,23);
			END IF;	   
		END IF;			
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_giustificazioni_iu() OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 3918286)
-- Name: tr_istituti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_istituti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_istituti_iu';
BEGIN
--
-- controllo la condotta
--
	IF new.condotta IS NOT NULL THEN
		IF (TG_OP = 'UPDATE') THEN
			--
			-- controllo che l'istituto della materia della condotta sia uguale a quello della riga in oggetto
			--
			PERFORM 1 FROM materie WHERE materia = new.materia AND istituto = new.istituto;
			IF NOT FOUND THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'1'),
				MESSAGE = messaggi_sistema_locale(function_name,1),
				DETAIL = format(messaggi_sistema_locale(function_name,2), new.valutazione, new.alunno, v_istituto, new.classe),
				HINT = messaggi_sistema_locale(function_name,3);
			END IF;
		ELSE
			--
			-- non posso impostare la condotta perchè necessita essa stessa dell'istituto ed essendo in inserimento
			-- dell'istituto ancora non ci sono materia associate a questo istituto
			--
			RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'2'),
				MESSAGE = messaggi_sistema_locale(function_name,4),
				DETAIL = format(messaggi_sistema_locale(function_name,5), new.alunno, v_istituto, new.classe),
				HINT = messaggi_sistema_locale(function_name,6);
		END IF;
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_istituti_iu() OWNER TO postgres;

--
-- TOC entry 547 (class 1255 OID 3918287)
-- Name: tr_lezioni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_lezioni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_lezioni_iu';
	v_istituto bigint;
BEGIN
--
-- leggo l'istituto della classe
--
        SELECT istituto INTO v_istituto FROM classi WHERE classe = new.classe;
--
-- controllo che l'istituto della materia sia uguale a quello della classe
--
	PERFORM 1 FROM materie WHERE materia = new.materia AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,2), new.lezione, new.materia, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,4), new.materia, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,3);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = messaggi_sistema_locale(function_name,5),
		   DETAIL = format(messaggi_sistema_locale(function_name,6), new.lezione, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,7);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = messaggi_sistema_locale(function_name,5),
		   DETAIL = format(messaggi_sistema_locale(function_name,8), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,7);
	   END IF;	   
	END IF;	
--
-- controllo che il docente sia nel ruolo docenti
--
	IF NOT nel_ruolo('Docente',new.docente) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'5'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,10), new.lezione, new.docente),
			   HINT = messaggi_sistema_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'6'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,12), new.docente),
			   HINT = messaggi_sistema_locale(function_name,11);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_lezioni_iu() OWNER TO postgres;

--
-- TOC entry 542 (class 1255 OID 3918288)
-- Name: tr_mancanze_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_mancanze_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_mancanze_iu';
	v_istituto bigint;
BEGIN
--
-- leggo l'istituto della classe
--
        SELECT istituto INTO v_istituto FROM classi WHERE classe = new.classe;
--
-- controllo che l'alunno faccia parte della classe della lezione
--
	PERFORM 1 FROM lezioni l
		  JOIN classi_alunni ca ON  ca.classe = l.classe
	         WHERE l.lezione = new.lezione
	           AND ca.alunno = new.alunno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.mancanza, new.alunno,  new.lezione),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4),  new.alunno,  new.lezione),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la nota, se indicata, sia relativa a quell'alunno, e a quella classe
--
	IF new.nota IS NOT NULL THEN
		PERFORM 1 FROM note n
		          JOIN lezioni l ON n.classe = l.classe
 		         WHERE n.nota = new.nota
		           AND n.alunno = new.alunno
		           AND l.lezione = new.lezione;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,6), new.mancanza, new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,8), new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'alunno sia nel ruolo alunni
--
	IF NOT nel_ruolo('Alunno',new.alunno) THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,10), new.mancanza, new.alunno),
			   HINT = messaggi_sistema_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno),
			   HINT = messaggi_sistema_locale(function_name,11);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_mancanze_iu() OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 3918289)
-- Name: tr_messaggi_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messaggi_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_messaggi_iu';
	v_istituto bigint;
BEGIN
--
-- leggo l'istituto della persona che ha scritto il messaggio
--
        SELECT istituto INTO v_istituto FROM persone WHERE persona = new.da;
--
-- controllo che la persona che ha scritto il messaggio (da) sia dello stesso istituto dell'alunno a cui fa' capo il libretto della conversazione
--
	PERFORM 1 FROM classi_alunni ca
		  JOIN conversazioni c ON  ca.classe_alunno = c.libretto
		  JOIN persone p ON p.persona = ca.alunno
	         WHERE c.conversazione = new.conversazione
	           AND p.istituto = v_istituto;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), v_istituto, new.da, new.messaggio, new.conversazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), v_istituto, new.da, new.conversazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messaggi_iu() OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 3918290)
-- Name: tr_messaggi_letti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messaggi_letti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_messaggi_letti_iu';
	v_istituto bigint;
BEGIN
--
-- leggo l'istituto della persona che ha scritto il messaggi_lettio
--
        SELECT istituto INTO v_istituto FROM persone WHERE persona = new.da;
--
-- controllo che la persona che ha scritto il messaggi_lettio (da) sia dello stesso istituto dell'alunno a cui fa' capo il libretto della conversazione
--
	PERFORM 1 FROM classi_alunni ca
		  JOIN conversazioni c ON  ca.classe_alunno = c.libretto
		  JOIN persone p ON p.persona = ca.alunno
	         WHERE c.conversazione = new.conversazione
	           AND p.istituto = v_istituto;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_letti_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_letti_sistema_locale(function_name,2), v_istituto, new.da, new.messaggi_lettio, new.conversazione),
			   HINT = messaggi_letti_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_letti_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_letti_sistema_locale(function_name,4), v_istituto, new.da, new.conversazione),
			   HINT = messaggi_letti_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messaggi_letti_iu() OWNER TO postgres;

--
-- TOC entry 472 (class 1255 OID 3918291)
-- Name: tr_mezzi_comunicazione_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_mezzi_comunicazione_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_mezzi_comunicazione_iu';
BEGIN
--
-- controllo che se richiesta la notifica il mezzo di comunicazione la gestisca
--
	IF new.notifica = TRUE THEN
		PERFORM 1 FROM tipi_comunicazione WHERE tipo_comunicazione = new.tipo_comunicazione AND gestione_notifica = TRUE;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'1'),
				   MESSAGE = messaggi_sistema_locale(function_name,1),
				   DETAIL = format(messaggi_sistema_locale(function_name,2), new.mezzo_comunicazione, new.tipo_comunicazione),
				   HINT = messaggi_sistema_locale(function_name,3);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'2'),
				   MESSAGE = messaggi_sistema_locale(function_name,1),
				   DETAIL = format(messaggi_sistema_locale(function_name,4), new.tipo_comunicazione),
				   HINT = messaggi_sistema_locale(function_name,3);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto del tipo_comunicazione sia uguale a quello della persona
--
	PERFORM 1 FROM tipi_comunicazione tc
	          JOIN persone p ON p.istituto = tc.istituto
	         WHERE tc.tipo_comunicazione = new.tipo_comunicazione
	           AND p.persona = new.persona;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,6), new.mezzo_comunicazione, new.tipo_comunicazione, new.persona),
			   HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,8), new.tipo_comunicazione, new.persona),
			   HINT = messaggi_sistema_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_mezzi_comunicazione_iu() OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 3918292)
-- Name: tr_note_docenti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_note_docenti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_note_docenti_iu';
	v_istituto bigint;
BEGIN
--
-- metto da una parte l'istituto della classe
--
	SELECT istituto INTO v_istituto FROM classi WHERE classe = new.classe;
----
-- controllo che nel giorno dell'nota_docente ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	         WHERE classe = new.classe
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.nota_docente,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	IF new.alunno IS NOT NULL THEN
		PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'3'),
				MESSAGE = messaggi_sistema_locale(function_name,9),
				DETAIL = format(messaggi_sistema_locale(function_name,10), new.nota_docente, new.alunno, v_istituto, new.classe),
				HINT = messaggi_sistema_locale(function_name,11);
			ELSE
				RAISE EXCEPTION USING
				ERRCODE = function_sqlcode(function_name,'4'),
				MESSAGE = messaggi_sistema_locale(function_name,9),
				DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno, v_istituto, new.classe),
				HINT = messaggi_sistema_locale(function_name,11);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,14), new.nota_docente, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,16), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   END IF;	   
	END IF;	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_note_docenti_iu() OWNER TO postgres;

--
-- TOC entry 544 (class 1255 OID 3918293)
-- Name: tr_note_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_note_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_note_iu';
	v_istituto bigint;
BEGIN
--
-- controllo che nel giorno dell'nota ci sia almeno una lezione
--
	SELECT istituto INTO v_istituto FROM classi WHERE classe = new.classe;
--
-- controllo che nel giorno dell'nota ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	         WHERE classe = new.classe
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.nota,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la giustificazione, se indicata, sia relativa a quell'alunno, a quel giorno di nota e creata dopo o al massimo il giorno stesso dell'nota
--
	IF new.giustificazione IS NOT NULL THEN
		PERFORM 1 FROM giustificazioni WHERE giustificazione=new.giustificazione AND alunno = new.alunno AND creata_il >= new.giorno AND new.giorno BETWEEN dal AND al ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,6), new.nota, new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,8), new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,10), new.nota, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,14), new.nota, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,16), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   END IF;	   
	END IF;	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_note_iu() OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 3918294)
-- Name: tr_note_visti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_note_visti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_note_visti_iu';
	v_istituto bigint;
BEGIN
--
-- metto da una parte l'istituto della classe
--
	SELECT c.istituto INTO v_istituto 
	  FROM note n
	  JOIN classi c ON c.classe = n.classe
	 WHERE n.nota = new.nota;
----
-- controllo che l'istituto della persona sia lo stesso di quello della classe della nota
--
	PERFORM 1 FROM persone
	         WHERE persona = new.persona
	           AND istituto = v_istituto;
	           
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.nota_visto, new.persona, v_istituto, new.nota),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.persona, v_istituto, new.nota),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_note_visti_iu() OWNER TO postgres;

--
-- TOC entry 550 (class 1255 OID 3918295)
-- Name: tr_orari_settimanali_giorni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_orari_settimanali_giorni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_orari_settimanali_giorni_iu';
	v_istituto bigint;
BEGIN
--
-- metto da una parte l'istituto della classe
--
	SELECT c.istituto INTO v_istituto 
	  FROM note n
	  JOIN classi c ON c.classe = n.classe
	 WHERE n.nota = new.nota;
----
-- controllo che l'istituto della persona sia lo stesso di quello della classe della nota
--
	PERFORM 1 FROM persone
	         WHERE persona = new.persona
	           AND istituto = v_istituto;
	           
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.orario_settimanali_giorno, new.persona, v_istituto, new.nota),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.persona, v_istituto, new.nota),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_orari_settimanali_giorni_iu() OWNER TO postgres;

--
-- TOC entry 551 (class 1255 OID 3918296)
-- Name: tr_ritardi_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_ritardi_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_ritardi_iu';
BEGIN
--
-- controllo che nel giorno dell'ritardo ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	         WHERE classe = new.classe
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.ritardo,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la giustificazione, se indicata, sia relativa a quell'alunno, a quel giorno di ritardo e creata dopo o al massimo il giorno stesso dell'ritardo
--
	IF new.giustificazione IS NOT NULL THEN
		PERFORM 1 FROM giustificazioni WHERE giustificazione=new.giustificazione AND alunno = new.alunno AND creata_il >= new.giorno AND new.giorno BETWEEN dal AND al ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,6), new.ritardo, new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,8), new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,10), new.fuori_classe, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,14), new.fuori_classe, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,16), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   END IF;	   
	END IF;	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_ritardi_iu() OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 3918297)
-- Name: tr_scrutini_i(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_scrutini_i() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_scrutini_i';
BEGIN
--
-- controllo che ci sia un solo scrutinio dopo la data di fine lezioni
--
	PERFORM 1 FROM scrutini s
	          JOIN anni_scolastici a ON a.anno_scolastico = s.anno_scolastico
		 WHERE s.anno_scolastico = new.anno_scolastico
		   AND new.data > a.fine_lezioni
		   AND s.data > a.fine_lezioni;
	IF FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = messaggi_sistema_locale(function_name,1),
		DETAIL = format(messaggi_sistema_locale(function_name,2), new.data, new.anno_scolastico, new.scrutinio),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_scrutini_i() OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 3918298)
-- Name: tr_scrutini_valutazioni_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_scrutini_valutazioni_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_scrutini_valutazioni_d';
BEGIN
--
-- controllo che lo scrutinio sia aperto
--
	PERFORM 1 FROM scrutini 
		 WHERE scrutinio = old.scrutinio
		   AND chiuso = false;
	IF NOT FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = messaggi_sistema_locale(function_name,1),
		DETAIL = format(messaggi_sistema_locale(function_name,2), new.scrutinio_valutazione, new.scrutinio),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_d() OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 3918299)
-- Name: tr_scrutini_valutazioni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_scrutini_valutazioni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_scrutini_valutazioni_iu';
BEGIN
--
-- controllo che la classe sia dello stesso anno_scolastico dello scrutinio
--
	PERFORM 1 FROM scrutini s
	          JOIN classi c ON s.anno_scolastico = c.anno_scolastico
	         WHERE s.scrutinio = new.scrutinio
	           AND c.classe = new.classe;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.scrutinio_valutazione, new.scrutinio,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.scrutinio,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'alunno appartenga alla classe 
--
	PERFORM 1 FROM classi_alunni ca
	         WHERE ca.classe = new.classe
	           AND ca.alunno = new.alunno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,6), new.scrutinio_valutazione, new.classe,  new.alunno),
			   HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,8), new.classe, new.alunno),
			   HINT = messaggi_sistema_locale(function_name,7);
		END IF;	   
	END IF;
--
-- controllo che la materia appartenga allo stesso istituto dell'anno_scolastico dello scrutinio
--
	PERFORM 1 FROM scrutini s
	          JOIN anni_scolastici a ON s.anno_scolastico = a.anno_scolastico
	          JOIN materie m ON a.istituto = m.istituto
	         WHERE s.scrutinio = new.scrutinio
	           AND m.materia = new.materia;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'5'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,10), new.scrutinio_valutazione, new.materia,  new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,11);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'6'),
			   MESSAGE = messaggi_sistema_locale(function_name,9),
			   DETAIL = format(messaggi_sistema_locale(function_name,12), new.materia, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,11);
		END IF;	   
	END IF;
--
-- controllo l'istituto della metrica del voto_proposto sia lo stesso di quello dell'anno_scolastico dello scrutinio
--
	PERFORM 1 FROM voti v
	          JOIN metriche m ON v.metrica = m.metrica
	          JOIN anni_scolastici a ON m.istituto = a.istituto
	          JOIN scrutini s ON a.anno_scolastico = s.anno_scolastico
	         WHERE v.voto =  new.voto_proposto
	           AND s.scrutinio = new.scrutinio;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,14), new.scrutinio_valutazione, new.voto_proposto, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,15);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,16), new.voto_proposto, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,15);
		END IF;	   
	END IF;
--
-- controllo l'istituto della metrica del voto sia lo stesso di quello dell'anno_scolastico dello scrutinio
--
	PERFORM 1 FROM voti v
	          JOIN metriche m ON v.metrica = m.metrica
	          JOIN anni_scolastici a ON m.istituto = a.istituto
	          JOIN scrutini s ON a.anno_scolastico = s.anno_scolastico
	         WHERE v.voto =  new.voto
	           AND s.scrutinio = new.scrutinio;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = messaggi_sistema_locale(function_name,17),
			   DETAIL = format(messaggi_sistema_locale(function_name,18), new.scrutinio_valutazione, new.voto, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,19);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = messaggi_sistema_locale(function_name,17),
			   DETAIL = format(messaggi_sistema_locale(function_name,20), new.voto, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,19);
		END IF;	   
	END IF;	
	--
-- controllo che lo scrutinio sia aperto
--
	PERFORM 1 FROM scrutini 
		 WHERE scrutinio = new.scrutinio
		   AND chiuso = false;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,21),
			   DETAIL = format(messaggi_sistema_locale(function_name,22), new.scrutinio_valutazione, new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,23);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,21),
			   DETAIL = format(messaggi_sistema_locale(function_name,24), new.scrutinio),
			   HINT = messaggi_sistema_locale(function_name,23);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_iu() OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 3918300)
-- Name: tr_scrutini_valutazioni_qualifiche_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_scrutini_valutazioni_qualifiche_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_scrutini_valutazioni_qualifiche_d';
BEGIN
--
-- controllo che lo scrutinio sia aperto
--
	PERFORM 1 FROM scrutini_valutazioni sv
		  JOIN scrutini s ON s.scrutinio = sv.scrutinio
		 WHERE sv.scrutinio_valutazione = old.scrutinio_valutazione
		   AND s.chiuso = false;
	IF NOT FOUND THEN
		RAISE EXCEPTION USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = messaggi_sistema_locale(function_name,1),
		DETAIL = format(messaggi_sistema_locale(function_name,2), old.scrutinio_valutazione_qualifica, old.scrutinio_valutazione),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_qualifiche_d() OWNER TO postgres;

--
-- TOC entry 552 (class 1255 OID 3918301)
-- Name: tr_scrutini_valutazioni_qualifiche_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_scrutini_valutazioni_qualifiche_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_scrutini_valutazioni_qualifiche_iu';
BEGIN
--
-- controllo che l'istituto della qualifica sia lo stesso di quello dell'alunno della scrutinio_valutazione
--
	PERFORM 1 FROM scrutini_valutazioni v
	          JOIN persone p ON v.alunno = p.persona
	          JOIN qualifiche q ON p.istituto = q.istituto
	         WHERE v.scrutinio_valutazione = new.scrutinio_valutazione
	           AND q.qualifica = new.qualifica;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.scrutinio_valutazione_qualifica, new.qualifica,  new.valutazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.qualifica,  new.valutazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'istituto della qualifica sia lo stesso di quello della metrica della materia del voto
--
	IF new.voto IS NOT NULL THEN
		PERFORM 1 FROM voti v
			  JOIN metriche m ON v.metrica = m.metrica
			  JOIN qualifiche q ON m.istituto = q.istituto
			 WHERE v.voto = new.voto
			   AND q.qualifica = new.qualifica;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'5'),
				   MESSAGE = messaggi_sistema_locale(function_name,9),
				   DETAIL = format(messaggi_sistema_locale(function_name,10), new.scrutinio_valutazione_qualifica, new.qualifica,  new.voto),
				   HINT = messaggi_sistema_locale(function_name,11);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'6'),
				   MESSAGE = messaggi_sistema_locale(function_name,9),
				   DETAIL = format(messaggi_sistema_locale(function_name,12), new.qualifica,  new.voto),
				   HINT = messaggi_sistema_locale(function_name,11);
			END IF;	   
		END IF;
	END IF;
--
-- controllo lo scrutinio sia aperto
--
	PERFORM 1 FROM scrutini_valutazioni sv
		  JOIN scrutini s ON s.scrutinio = sv.scrutinio
		 WHERE sv.scrutinio_valutazione = new.scrutinio_valutazione
		   AND s.chiuso = false;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,14), new.scrutinio_valutazione_qualifica, new.scrutinio_valutazione),
			   HINT = messaggi_sistema_locale(function_name,15);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,16), new.scrutinio_valutazione),
			   HINT = messaggi_sistema_locale(function_name,15);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_qualifiche_iu() OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 3918302)
-- Name: tr_uscite_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_uscite_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_uscite_iu';
BEGIN
--
-- controllo che nel giorno dell'uscita ci sia almeno una lezione
--
	PERFORM 1 FROM lezioni l
	         WHERE classe = new.classe
	           AND giorno = new.giorno;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.uscita,  new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.giorno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che la giustificazione, se indicata, sia relativa a quell'alunno, a quel giorno di uscita e creata dopo o al massimo il giorno stesso dell'uscita
--
	IF new.giustificazione IS NOT NULL THEN
		PERFORM 1 FROM giustificazioni WHERE giustificazione=new.giustificazione AND alunno = new.alunno AND creata_il >= new.giorno AND new.giorno BETWEEN dal AND al ;
		IF NOT FOUND THEN
			IF (TG_OP = 'UPDATE') THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,6), new.uscita, new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			ELSE
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'4'),
				   MESSAGE = messaggi_sistema_locale(function_name,5),
				   DETAIL = format(messaggi_sistema_locale(function_name,8), new.giustificazione, new.alunno, new.giorno),
				   HINT = messaggi_sistema_locale(function_name,7);
			END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,10), new.uscita, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,9),
		   DETAIL = format(messaggi_sistema_locale(function_name,12), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,11);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'7'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,14), new.uscita, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'8'),
		   MESSAGE = messaggi_sistema_locale(function_name,13),
		   DETAIL = format(messaggi_sistema_locale(function_name,16), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,15);
	   END IF;	   
	END IF;	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_uscite_iu() OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 3918303)
-- Name: tr_utenti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_utenti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_utenti_iu';
    BEGIN
        --
        -- check user name
        --
        PERFORM 1 FROM pg_shadow WHERE usename = new.usename;

        IF NOT FOUND THEN
           IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,2) ,new.utente, new.usename),
		   HINT = messaggi_sistema_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = messaggi_sistema_locale(function_name,4),
		   DETAIL = format(messaggi_sistema_locale(function_name,5) ,new.usename),
		   HINT = messaggi_sistema_locale(function_name,3);
	   END IF;
	END IF;
        --
        -- controllo che lo spazio di lavoro impostato non sia di un altro utente
        -- nel caso di inserimento è impossibile che ci sia uno spazio di lavoro dato 
        -- che per iserire nella tabella uno spazio di lavoro valido per l'utente
        -- ci deve essere l'utente, in sostanza prima si inserisce l'utente poi 
        -- si inseriscono i vari spazi di lavoro che l'utente può usare e poi si
        -- indica lo spazio di lavoro di default, quindi un inserimento specificando uno 
        -- spazio di lavoro è sicuramente un errore
        --
	IF new.spazio_lavoro IS NOT NULL THEN

		IF (TG_OP = 'UPDATE') THEN
			PERFORM 1 FROM spazi_lavoro WHERE utente = new.utente AND spazio_lavoro = new.spazio_lavoro;
			IF NOT FOUND THEN
				   RAISE EXCEPTION USING
				   ERRCODE = function_sqlcode(function_name,'3'),
				   MESSAGE = messaggi_sistema_locale(function_name,6),
				   DETAIL = format(messaggi_sistema_locale(function_name,7) ,new.utente,new.spazio_lavoro),
				   HINT = messaggi_sistema_locale(function_name,8);
			END IF;
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'4'),
			MESSAGE = messaggi_sistema_locale(function_name,9),
			DETAIL = format(messaggi_sistema_locale(function_name,10) ,new.spazio_lavoro),
			HINT = messaggi_sistema_locale(function_name,11);
		END IF;
	END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.tr_utenti_iu() OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 3918304)
-- Name: tr_valutazioni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutazioni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_istituto	bigint;
	v_metrica	bigint;
	function_name varchar = 'tr_valutazioni_iu';
BEGIN
--
-- recupero l'istituto della classe
--
	SELECT a.istituto INTO v_istituto 
		FROM anni_scolastici a
		JOIN classi c ON a.anno_scolastico = c.anno_scolastico
		WHERE c.classe = new.classe;
--
-- controllo che l'istituto dell'alunno sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.alunno AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'1'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,2), new.valutazione, new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,3);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'2'),
		   MESSAGE = messaggi_sistema_locale(function_name,1),
		   DETAIL = format(messaggi_sistema_locale(function_name,34), new.alunno, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,3);
	   END IF;	   
	END IF;
--
-- controllo che l'istituto della materia sia uguale a quello della classe
--
	PERFORM 1 FROM materie WHERE materia = new.materia AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'3'),
		   MESSAGE = messaggi_sistema_locale(function_name,4),
		   DETAIL = format(messaggi_sistema_locale(function_name,5), new.valutazione, new.materia, v_istituto,new.classe),
		   HINT = messaggi_sistema_locale(function_name,6);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'4'),
		   MESSAGE = messaggi_sistema_locale(function_name,4),
		   DETAIL = format(messaggi_sistema_locale(function_name,35), new.valutazione, new.materia, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,6);
	   END IF;	   
	END IF;
--
-- controllo che il tipo voto sia della stessa materia della valutazione
--
	PERFORM 1 FROM tipi_voto WHERE tipo_voto = new.tipo_voto AND materia = new.materia;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'5'),
		   MESSAGE = messaggi_sistema_locale(function_name,7),
		   DETAIL = format(messaggi_sistema_locale(function_name,8), new.valutazione, new.tipo_voto, new.materia),
		   HINT = messaggi_sistema_locale(function_name,9);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'6'),
		   MESSAGE = messaggi_sistema_locale(function_name,7),
		   DETAIL = format(messaggi_sistema_locale(function_name,36), new.tipo_voto, new.materia),
		   HINT = messaggi_sistema_locale(function_name,9);
	   END IF;	   
	END IF;
--
-- controllo che l'argomento sia della stessa materia della valutazione
--
        IF new.argomento IS NOT NULL THEN
		PERFORM 1 FROM argomenti WHERE argomento = new.argomento AND materia = new.materia;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'7'),
			   MESSAGE = messaggi_sistema_locale(function_name,10),
			   DETAIL = format(messaggi_sistema_locale(function_name,11), new.valutazione, new.argomento, new.materia),
			   HINT = messaggi_sistema_locale(function_name,12);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'8'),
			   MESSAGE = messaggi_sistema_locale(function_name,10),
			   DETAIL = format(messaggi_sistema_locale(function_name,37), new.argomento, new.materia),
			   HINT = messaggi_sistema_locale(function_name,12);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che anno_corso e indirizzo_scolastico dell'argomento siano gli stessi della classe
--
        IF new.argomento IS NOT NULL THEN
		PERFORM 1 FROM classi c
			  JOIN argomenti a ON (c.indirizzo_scolastico = a.indirizzo_scolastico AND
					       c.anno_corso = a.anno_corso)
			  WHERE c.classe = new.classe 
			  AND a.argomento = new.argomento;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'9'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,14), new.valutazione, new.argomento, new.classe),
			   HINT = messaggi_sistema_locale(function_name,15);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'A'),
			   MESSAGE = messaggi_sistema_locale(function_name,13),
			   DETAIL = format(messaggi_sistema_locale(function_name,38), new.argomento, new.classe),
			   HINT = messaggi_sistema_locale(function_name,15);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto della metrica del voto sia lo stesso della classe
--
	PERFORM 1 FROM metriche m
	          JOIN voti v ON (m.metrica = v.metrica)
	          WHERE v.voto = new.voto 
	          AND m.istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'B'),
		   MESSAGE = messaggi_sistema_locale(function_name,16),
		   DETAIL = format(messaggi_sistema_locale(function_name,17), new.valutazione, new.voto, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,18);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'C'),
		   MESSAGE = messaggi_sistema_locale(function_name,16),
		   DETAIL = format(messaggi_sistema_locale(function_name,39), new.voto, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,18);
	   END IF;	   
	END IF;
--
-- controllo che l'alunno sia una persona con il ruolo 'Alunno'
--
	IF NOT nel_ruolo('Alunno',new.alunno) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'D'),
		   MESSAGE = messaggi_sistema_locale(function_name,19),
		   DETAIL = format(messaggi_sistema_locale(function_name,20), new.valutazione, new.alunno),
		   HINT = messaggi_sistema_locale(function_name,21);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'E'),
		   MESSAGE = messaggi_sistema_locale(function_name,19),
		   DETAIL = format(messaggi_sistema_locale(function_name,40), new.alunno),
		   HINT = messaggi_sistema_locale(function_name,21);
	   END IF;	   
	END IF;
--
-- controllo che la nota faccia riferimento allo stesso alunno e allo stesso docente
--
        IF new.nota IS NOT NULL THEN
		PERFORM 1 FROM note
			 WHERE nota = new.nota
			   AND alunno = new.alunno
			   AND docente = new.docente;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = messaggi_sistema_locale(function_name,22),
			   DETAIL = format(messaggi_sistema_locale(function_name,23), new.valutazione, new.nota, new.alunno, new.docente),
			   HINT = messaggi_sistema_locale(function_name,24);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = messaggi_sistema_locale(function_name,22),
			   DETAIL = format(messaggi_sistema_locale(function_name,41), new.nota, new.alunno, new.docente),
			   HINT = messaggi_sistema_locale(function_name,24);
		   END IF;	   
		END IF;
	END IF;
--
-- controllo che l'istituto del docente sia uguale a quello della classe
--
	PERFORM 1 FROM persone WHERE persona = new.docente AND istituto = v_istituto;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'H'),
		   MESSAGE = messaggi_sistema_locale(function_name,25),
		   DETAIL = format(messaggi_sistema_locale(function_name,26), new.valutazione, new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,27);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'I'),
		   MESSAGE = messaggi_sistema_locale(function_name,25),
		   DETAIL = format(messaggi_sistema_locale(function_name,42), new.docente, v_istituto, new.classe),
		   HINT = messaggi_sistema_locale(function_name,27);
	   END IF;	   
	END IF;
--
-- controllo che il docente sia una persona con il ruolo 'Docente'
--
	IF NOT nel_ruolo('Docente',new.docente) THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'L'),
		   MESSAGE = messaggi_sistema_locale(function_name,28),
		   DETAIL = format(messaggi_sistema_locale(function_name,29), new.valutazione, new.docente),
		   HINT = messaggi_sistema_locale(function_name,30);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'M'),
		   MESSAGE = messaggi_sistema_locale(function_name,28),
		   DETAIL = format(messaggi_sistema_locale(function_name,43), new.docente),
		   HINT = messaggi_sistema_locale(function_name,30);
	   END IF;	   
	END IF;
--
-- controllo che la data della valutazione sia compresa fra l'inizio e la fine dell'anno scolastico
--
	PERFORM 1 FROM anni_scolastici a
		  JOIN classi c ON a.anno_scolastico = c.anno_scolastico
		  WHERE c.classe = new.classe AND
		        new.giorno BETWEEN a.inizio_lezioni AND a.fine_lezioni;

	IF NOT FOUND THEN
          IF (TG_OP = 'UPDATE') THEN
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'N'),
		   MESSAGE = messaggi_sistema_locale(function_name,31),
		   DETAIL = format(messaggi_sistema_locale(function_name,32), new.valutazione, new.il, new.classe),
		   HINT = messaggi_sistema_locale(function_name,33);
	   ELSE
		   RAISE EXCEPTION USING
		   ERRCODE = function_sqlcode(function_name,'O'),
		   MESSAGE = messaggi_sistema_locale(function_name,31),
		   DETAIL = format(messaggi_sistema_locale(function_name,44), new.il, new.classe),
		   HINT = messaggi_sistema_locale(function_name,33);
	   END IF;	   
	END IF;
--
-- controllo che per quella classe, materia, docente, giorno, tipo_voto, argomento vi sia una sola metrica
--
	SELECT metrica INTO v_metrica FROM voti WHERE voto = new.voto;
	
	PERFORM 1 FROM valutazioni va
		  JOIN voti vo ON va.voto = vo.voto
         	 WHERE va.classe = new.classe
		   AND va.materia = new.materia
		   AND va.docente = new.docente
		   AND va.alunno = new.alunno
		   AND va.giorno = new.giorno
		   AND va.tipo_voto = new.tipo_voto
		   AND va.argomento = new.argomento
		   AND vo.metrica = v_metrica
		   AND va.valutazione <> new.valutazione;

	IF FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'P'),
			MESSAGE = function_sqlcode(function_name,'P') || ' ' || messaggi_sistema_locale(function_name,45),
			DETAIL = format(messaggi_sistema_locale(function_name,46), new.voto, new.valutazione, v_metrica, new.classe, new.materia, new.docente, new.alunno, new.giorno, new.tipo_voto, new.argomento),
			HINT = messaggi_sistema_locale(function_name,47);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'Q'),
			MESSAGE = function_sqlcode(function_name,'Q') || ' ' || messaggi_sistema_locale(function_name,45),
			DETAIL = format(messaggi_sistema_locale(function_name,48), new.voto, v_metrica, new.classe, new.materia, new.docente, new.alunno, new.giorno, new.tipo_voto, new.argomento),
			HINT = messaggi_sistema_locale(function_name,47);
		END IF;	   
	END IF;	     
--
-- se la valutazione è privata non può essere assegnata una nota
--
	IF  new.privata = true AND new.nota IS NOT NULL THEN
		IF (TG_OP = 'UPDATE') THEN
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'R'),
			MESSAGE = messaggi_sistema_locale(function_name,49),
			DETAIL = format(messaggi_sistema_locale(function_name,50), new.valutazione, new.privata, new.nota),
			HINT = messaggi_sistema_locale(function_name,51);
		ELSE
			RAISE EXCEPTION USING
			ERRCODE = function_sqlcode(function_name,'S'),
			MESSAGE = messaggi_sistema_locale(function_name,49),
			DETAIL = format(messaggi_sistema_locale(function_name,52), new.privata, new.nota),
			HINT = messaggi_sistema_locale(function_name,51);
		END IF;	   
	END IF;
	
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutazioni_iu() OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 3918306)
-- Name: tr_valutazioni_qualifiche_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutazioni_qualifiche_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_valutazioni_qualifiche_iu';
BEGIN
--
-- controllo che l'istituto della qualifica sia lo stesso di quello dell'alunno della valutazione
--
	PERFORM 1 FROM valutazioni v
	          JOIN persone p ON v.alunno = p.persona
	          JOIN qualifiche q ON p.istituto = q.istituto
	         WHERE v.valutazione = new.valutazione
	           AND q.qualifica = new.qualifica;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.valutazione_qualifica, new.qualifica,  new.valutazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.qualifica,  new.valutazione),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
--
-- controllo che l'istituto della qualifica sia lo stesso di quello della metrica del voto 
--
	PERFORM 1 FROM voti v
	          JOIN metriche m ON v.metrica = v.metrica
	          JOIN qualifiche q ON m.istituto = q.istituto
	         WHERE v.voto = new.voto
	           AND q.qualifica = new.qualifica;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,6), new.valutazione_qualifica, new.qualifica,  new.voto),
			   HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,8), new.qualifica,  new.voto),
			   HINT = messaggi_sistema_locale(function_name,7);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutazioni_qualifiche_iu() OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 3918307)
-- Name: uno_nei_ruoli(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION uno_nei_ruoli(p_ruoli character varying[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	
	PERFORM 1 FROM persone_ruoli pr
	          JOIN persone p ON p.persona = pr.persona 
	          JOIN utenti u ON u.utente = p.utente
	         WHERE u.usename = session_user
	           AND pr.ruolo = ANY(p_ruoli::ruolo[]);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.uno_nei_ruoli(p_ruoli character varying[]) OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 3918308)
-- Name: valutazioni_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_del(p_rv bigint, p_valutazione bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*

-- messaggi di sistema utilizzati dalla funzione 
 
DELETE FROM messaggi_sistema WHERE function_name = 'valutazioni_del';


INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_del',1,'it','Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_del',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_del',3,'it','Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione'); 

*/
DECLARE

	function_name varchar = 'valutazioni_del';

BEGIN
    DELETE FROM valutazioni t WHERE t.valutazione = p_valutazione AND xmin = p_rv::text::xid;
    
    IF NOT FOUND THEN 
       RAISE EXCEPTION USING
	     ERRCODE = function_sqlcode(function_name,'1'),
	     MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_valutazione),
	     DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	     HINT = messaggi_sistema_locale(function_name,3);
    END IF;
END;
$$;


ALTER FUNCTION public.valutazioni_del(p_rv bigint, p_valutazione bigint) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 3918309)
-- Name: valutazioni_ex_by_classe_docente_materia(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT rv,
		       classe,
		       docente,
		       materia,
		       valutazione,
		       alunno,
		       cognome,
		       nome,
		       giorno,
		       tipo_voto,
		       tipo_voto_descrizione,
		       argomento,
		       argomento_descrizione,
		       metrica,
		       metrica_descrizione,
		       voto,
		       voto_descrizione,
		       giudizio,
		       privato
		  FROM valutazioni_ex
		 WHERE classe = p_classe
		   AND docente = p_docente
		   AND materia = p_materia   
	      ORDER BY giorno, cognome, nome, alunno, tipo_voto, argomento;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 3918310)
-- Name: valutazioni_ins(bigint, bigint, bigint, bigint, bigint, bigint, character varying, boolean, bigint, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE

  function_name varchar := 'valutazioni_ins';

BEGIN 
	INSERT INTO valutazioni (classe, alunno, materia, tipo_voto, argomento, voto, giudizio, privata, docente, giorno)
	VALUES (p_classe, p_alunno, p_materia, p_tipo_voto, p_argomento, p_voto, p_giudizio, p_privata, p_docente, p_giorno);

	SELECT currval('pk_seq') INTO p_valutazione;
	SELECT xmin::text::bigint INTO p_rv FROM public.valutazioni WHERE valutazione = p_valutazione;
END;
$$;


ALTER FUNCTION public.valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) OWNER TO postgres;

--
-- TOC entry 553 (class 1255 OID 3918311)
-- Name: valutazioni_ins_nota(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE

  function_name varchar := 'valutazioni_ins_nota';
  v_materia_descrizione varchar := null;
  v_tipo_voto_descrizione varchar := null;
  v_argomento_descrizione varchar := null;
  v_voto_descrizione varchar := null;
  v_docente_cognome_nome varchar := null;
  v_alunno_nome varchar := null;
  v_descrizione varchar :=null;

BEGIN 
	SELECT alu.nome , doc.cognome + ' ' + doc.nome , m.descrizione, tv.descrizione, a.descrizione, vo.descrizione
	INTO v_docente_cognome_nome, v_materia_descrizione, v_tipo_voto_descrizione, v_argomento_descrizione, v_voto_descrizione
	FROM valutazioni va
	JOIN persone alu ON va.alunno = alu.persona
	JOIN persone doc ON va.docente = doc.persona
	JOIN materie m ON va.materia = m.materia
	JOIN tipi_voti tv ON va.tipo_voto = tv.tipo_voto
	JOIN argomenti a ON va.argomento = a.argomento
	JOIN voti vo ON va.voto = vo.voto
	WHERE valutazione = p_valutazione;

	v_descrizione := format('In data: %s ad: %s il docente: %s (%s) ha dato sull''argomento: %s nel tipo di valutazione: %s il voto: %s e ha richiesto il vostro visto',
	                           to_char('2014-01-31'::date,'Dy DD Mon yyyy'), v_alunno_nome, v_docente_cognome_nome, v_materia_descrizione, v_argomento_descrizione, v_tipo_voto_descrizione, v_voto_descrizione);

	INSERT INTO note (alunno, descrizione, docente, disciplinare, giorno, ora, da_vistare, classe)
	VALUES (p_alunno, v_descrizione, 'false', p_giorno, now()::time, 'true', p_classe);

	SELECT currval('pk_seq') INTO p_nota;
	SELECT xmin::text::bigint INTO p_rv FROM note WHERE nota = p_nota;

END;
$$;


ALTER FUNCTION public.valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) OWNER TO postgres;

--
-- TOC entry 554 (class 1255 OID 3918312)
-- Name: valutazioni_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
-- messaggi di sistema utilizzati dalla funzione
 
DELETE FROM messaggi_sistema WHERE function_name = 'valutazioni_sel';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_sel',1,'it','Non è stata trovata nessuna riga nella tabella ''valutazioni'' con:  ''valutazione'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_sel',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_sel',3,'it','Controllare il valore di: ''valutazione'' e riprovare l''operazione'); 

*/

DECLARE

	function_name varchar = 'valutazioni_sel';

BEGIN

	SELECT xmin::text::bigint, valutazione, giudizio, privata, nota IS NOT NULL AS nota
	INTO p_rv, p_valutazione, p_giudizio, p_privata, p_nota 
	FROM valutazioni
	WHERE valutazione = p_valutazione;

	IF NOT FOUND THEN RAISE USING
	   ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_valutazione),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
	END IF;

END;
$$;


ALTER FUNCTION public.valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 3918313)
-- Name: valutazioni_upd(bigint, bigint, character varying, boolean, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero General Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'valutazioni_upd';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd',1,'it','Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd',3,'it','Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'valutazioni_upd';

BEGIN

	UPDATE valutazioni SET valutazione = p_valutazione, giudizio = p_giudizio, privata = p_privata
    	WHERE valutazione = p_valutazione;--AND xmin = p_rv::text::xid;

    IF NOT FOUND THEN RAISE USING
       ERRCODE = function_sqlcode(function_name,'1'),
	   MESSAGE = format(messaggi_sistema_locale(function_name,2),p_rv, p_valutazione),
	   DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
	   HINT = messaggi_sistema_locale(function_name,3);
    END IF;
    IF p_nota THEN
	--controllo se la nota manca ed eventualmente quindi la inserisco 
	PERFORM 1 FROM valutazioni WHERE valutazione = p_valutazione AND nota IS NOT NULL;
	IF NOT FOUND THEN
	-- inserire la nota 
	/*
		INSERT INTO note (classe,alunno,docente,disciplinare,giorno,ora,da_vistare,descrizione)
			    SELECT classe,alunno,docente,'true',giorno,now()::time,'true',
			         'Si comunica che il giorno: %s l''alunno ha ricevuto una valutazione di: %s '
			         'da parte di: %s docente di: %s durante la prova: %s con argomento: %s '
			         ' riportando il seguente giudizio: %s. Si richiede la visione' 
			    FROM valutazione 
			    WHERE valutazione = p_valutazione;
			    */
	END IF;	
    ELSE
	DELETE FROM note WHERE nota IN (SELECT nota FROM valutazioni WHERE valutazione = p_valutazione);
    END IF;

    RETURN xmin::text::bigint  FROM valutazioni WHERE valutazione = p_valutazione;
END;
$$;


ALTER FUNCTION public.valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) OWNER TO postgres;

--
-- TOC entry 555 (class 1255 OID 3918314)
-- Name: valutazioni_upd_voto(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$

/*
-- messaggi di sistema utilizzati dalla funzione 

DELETE FROM messaggi_sistema WHERE function_name = 'valutazioni_upd_voto';

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd_voto',1,'it','Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd_voto',2,'it','La funzione in errore è: ''%s'''); 

INSERT INTO messaggi_sistema (function_name, id, lingua, descrizione)
                     VALUES ('valutazioni_upd_voto',3,'it','Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione'); 
*/

DECLARE

	function_name varchar = 'valutazioni_upd_voto';

BEGIN

	UPDATE valutazioni
	   SET voto = p_voto
    	 WHERE valutazione = p_valutazione
    	   AND xmin = p_rv::text::xid;

	IF NOT FOUND THEN RAISE USING
		ERRCODE = function_sqlcode(function_name,'1'),
		MESSAGE = format(messaggi_sistema_locale(function_name,1),p_rv, p_valutazione),
		DETAIL = format(messaggi_sistema_locale(function_name,2),current_query()),
		HINT = messaggi_sistema_locale(function_name,3);
	END IF;
    RETURN xmin::text::bigint  FROM valutazioni WHERE valutazione = p_valutazione;
END;
$$;


ALTER FUNCTION public.valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 3918315)
-- Name: voti_by_metrica(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION voti_by_metrica(p_metrica bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       voto,
		       metrica,
		       descrizione,
		       mnemonico,
		       millesimi
		  FROM voti
		 WHERE metrica = p_metrica
	      ORDER BY millesimi;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.voti_by_metrica(p_metrica bigint) OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 3918316)
-- Name: pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pk_seq OWNER TO postgres;

--
-- TOC entry 3438 (class 0 OID 0)
-- Dependencies: 173
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'genera la primary key per tutte le tabelle del progetto';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 174 (class 1259 OID 3918318)
-- Name: assenze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assenze (
    assenza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    giorno date NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    classe bigint NOT NULL
);


ALTER TABLE public.assenze OWNER TO postgres;

--
-- TOC entry 3440 (class 0 OID 0)
-- Dependencies: 174
-- Name: TABLE assenze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE assenze IS 'Rileva le assenze di un alunno';


--
-- TOC entry 3441 (class 0 OID 0)
-- Dependencies: 174
-- Name: COLUMN assenze.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN assenze.docente IS 'Il docente che ha certificato l''assenza';


--
-- TOC entry 175 (class 1259 OID 3918322)
-- Name: assenze_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_grp AS
 SELECT assenze.classe, 
    assenze.alunno, 
    count(1) AS assenze
   FROM assenze
  GROUP BY assenze.classe, assenze.alunno;


ALTER TABLE public.assenze_grp OWNER TO postgres;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 175
-- Name: VIEW assenze_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e alunno';


--
-- TOC entry 176 (class 1259 OID 3918326)
-- Name: assenze_non_giustificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_non_giustificate_grp AS
 SELECT assenze.classe, 
    assenze.alunno, 
    count(1) AS assenze
   FROM assenze
  WHERE (assenze.giustificazione IS NULL)
  GROUP BY assenze.classe, assenze.alunno;


ALTER TABLE public.assenze_non_giustificate_grp OWNER TO postgres;

--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 176
-- Name: VIEW assenze_non_giustificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_non_giustificate_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e alunno limitando però la selezione a quelle non giustificate';


--
-- TOC entry 177 (class 1259 OID 3918330)
-- Name: classi_alunni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE classi_alunni (
    classe_alunno bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    ritirato_il date,
    classe_destinazione bigint
);


ALTER TABLE public.classi_alunni OWNER TO postgres;

--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN classi_alunni.ritirato_il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classi_alunni.ritirato_il IS 'Data in cui l''alunno si è ritirato dalla classe oppure è stato trasferito in un''altra classe dello stesso istituto o di un altro istituto';


--
-- TOC entry 3448 (class 0 OID 0)
-- Dependencies: 177
-- Name: COLUMN classi_alunni.classe_destinazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classi_alunni.classe_destinazione IS 'Viene tenuto traccia della classe cui l''alunno è stato trasferito se nello stesso istituto';


--
-- TOC entry 178 (class 1259 OID 3918334)
-- Name: comuni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comuni (
    comune character(4) NOT NULL,
    descrizione character varying(160) NOT NULL,
    provincia character(2) NOT NULL
);


ALTER TABLE public.comuni OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 3918337)
-- Name: fuori_classi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fuori_classi (
    fuori_classe bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    addetto_scolastico bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    giorno date NOT NULL,
    dalle time without time zone NOT NULL,
    alle time without time zone NOT NULL,
    classe bigint NOT NULL,
    CONSTRAINT fuori_classi_ck_alle CHECK ((alle > dalle))
);


ALTER TABLE public.fuori_classi OWNER TO postgres;

--
-- TOC entry 3451 (class 0 OID 0)
-- Dependencies: 179
-- Name: TABLE fuori_classi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE fuori_classi IS 'Indica quando un alunno non è presente in classe ma non deve essere considerato assente ad esempio per impegni sportivi';


--
-- TOC entry 180 (class 1259 OID 3918342)
-- Name: fuori_classi_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_grp AS
 SELECT fuori_classi.classe, 
    fuori_classi.alunno, 
    count(1) AS fuori_classi
   FROM fuori_classi
  GROUP BY fuori_classi.classe, fuori_classi.alunno;


ALTER TABLE public.fuori_classi_grp OWNER TO postgres;

--
-- TOC entry 3453 (class 0 OID 0)
-- Dependencies: 180
-- Name: VIEW fuori_classi_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW fuori_classi_grp IS 'Raggruppa le fuori classe per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 181 (class 1259 OID 3918346)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note (
    nota bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    disciplinare boolean NOT NULL,
    giorno date NOT NULL,
    ora time without time zone NOT NULL,
    da_vistare boolean DEFAULT false NOT NULL,
    classe bigint NOT NULL,
    CONSTRAINT note_ck_da_vistare CHECK (((((disciplinare = false) AND (da_vistare = false)) OR ((disciplinare = false) AND (da_vistare = true))) OR ((disciplinare = true) AND (da_vistare = true))))
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 3455 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN note.disciplinare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.disciplinare IS 'Indica che l''annotazione è di tipo disciplinare verrà quindi riportata sul libretto personale per la firma di visione del genitore.
L''annotazione è rivolta a tutta la classe a meno che non sia indicato il singolo alunno.
Se si vuole fare una nota disciplinare (ma anche normale) a due o più alunni è necesario inserire la nota per ciascuno.';


--
-- TOC entry 3456 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN note.da_vistare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.da_vistare IS 'indica che è richiesto il visto da parte dell''alunno (se maggiorenne) o da parte di chi esercita la patria potestà e ha richiesto di essere avvisato.
Se non è specificato l''alunno il visto deve essere richiesto per tutta la classe, se però è una nota disciplinare e manca l''alunno il visto deve essere richiesto per i soli alunni presenti';


--
-- TOC entry 3457 (class 0 OID 0)
-- Dependencies: 181
-- Name: COLUMN note.classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.classe IS 'indica se la nota è per tutta la classe';


--
-- TOC entry 3458 (class 0 OID 0)
-- Dependencies: 181
-- Name: CONSTRAINT note_ck_da_vistare ON note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT note_ck_da_vistare ON note IS 'Se è una nota disciplinare allora deve essere richiesto il visto';


--
-- TOC entry 182 (class 1259 OID 3918355)
-- Name: note_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_grp AS
 SELECT note.classe, 
    note.alunno, 
    count(1) AS note
   FROM note
  WHERE (note.disciplinare = true)
  GROUP BY note.classe, note.alunno;


ALTER TABLE public.note_grp OWNER TO postgres;

--
-- TOC entry 3460 (class 0 OID 0)
-- Dependencies: 182
-- Name: VIEW note_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW note_grp IS 'Raggruppa le note per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 183 (class 1259 OID 3918359)
-- Name: persone; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone (
    persona bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    nome character varying(60) NOT NULL,
    cognome character varying(60) NOT NULL,
    nato date,
    deceduto date,
    nazione_nascita smallint,
    codice_fiscale character(16),
    sesso sesso NOT NULL,
    foto bytea,
    istituto bigint,
    sidi bigint,
    comune_nascita character(4),
    foto_miniatura bytea,
    utente bigint
);


ALTER TABLE public.persone OWNER TO postgres;

--
-- TOC entry 3462 (class 0 OID 0)
-- Dependencies: 183
-- Name: COLUMN persone.utente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persone.utente IS 'utente del sistema';


--
-- TOC entry 184 (class 1259 OID 3918366)
-- Name: ritardi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ritardi (
    ritardo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    giorno date NOT NULL,
    ora time without time zone NOT NULL,
    classe bigint NOT NULL
);


ALTER TABLE public.ritardi OWNER TO postgres;

--
-- TOC entry 3464 (class 0 OID 0)
-- Dependencies: 184
-- Name: TABLE ritardi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE ritardi IS 'Rileva i ritardi di un alunno';


--
-- TOC entry 185 (class 1259 OID 3918370)
-- Name: ritardi_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_grp AS
 SELECT ritardi.classe, 
    ritardi.alunno, 
    count(1) AS ritardi
   FROM ritardi
  GROUP BY ritardi.classe, ritardi.alunno;


ALTER TABLE public.ritardi_grp OWNER TO postgres;

--
-- TOC entry 3466 (class 0 OID 0)
-- Dependencies: 185
-- Name: VIEW ritardi_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_grp IS 'Raggruppa i ritardi per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 186 (class 1259 OID 3918374)
-- Name: ritardi_non_giustificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_non_giustificati_grp AS
 SELECT ritardi.classe, 
    ritardi.alunno, 
    count(ritardi.alunno) AS ritardi
   FROM ritardi
  WHERE (ritardi.giustificazione IS NULL)
  GROUP BY ritardi.classe, ritardi.alunno;


ALTER TABLE public.ritardi_non_giustificati_grp OWNER TO postgres;

--
-- TOC entry 3468 (class 0 OID 0)
-- Dependencies: 186
-- Name: VIEW ritardi_non_giustificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_non_giustificati_grp IS 'Raggruppa i ritardi per classe (e quindi per anno acolastico) e alunno limitando però la selezione a quelli non giustificati';


--
-- TOC entry 187 (class 1259 OID 3918378)
-- Name: uscite; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE uscite (
    uscita bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint NOT NULL,
    giorno date NOT NULL,
    ora time without time zone NOT NULL,
    classe bigint NOT NULL
);


ALTER TABLE public.uscite OWNER TO postgres;

--
-- TOC entry 3470 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE uscite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE uscite IS 'Rileva i uscite di un alunno';


--
-- TOC entry 188 (class 1259 OID 3918382)
-- Name: uscite_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_grp AS
 SELECT uscite.classe, 
    uscite.alunno, 
    count(uscite.alunno) AS uscite
   FROM uscite
  GROUP BY uscite.classe, uscite.alunno;


ALTER TABLE public.uscite_grp OWNER TO postgres;

--
-- TOC entry 3472 (class 0 OID 0)
-- Dependencies: 188
-- Name: VIEW uscite_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_grp IS 'Raggruppa le uscite per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 189 (class 1259 OID 3918386)
-- Name: uscite_non_giustificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_non_giustificate_grp AS
 SELECT uscite.classe, 
    uscite.alunno, 
    count(uscite.alunno) AS uscite
   FROM uscite
  WHERE (uscite.giustificazione IS NULL)
  GROUP BY uscite.classe, uscite.alunno;


ALTER TABLE public.uscite_non_giustificate_grp OWNER TO postgres;

--
-- TOC entry 3474 (class 0 OID 0)
-- Dependencies: 189
-- Name: VIEW uscite_non_giustificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_non_giustificate_grp IS 'Raggruppa le uscite per classe (e quindi per anno acolastico) e alunno limitando però la selezione a quelle non giutificate';


--
-- TOC entry 190 (class 1259 OID 3918390)
-- Name: classi_alunni_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_alunni_ex AS
 SELECT ca.classe, 
    ca.alunno, 
    p.foto_miniatura, 
    p.codice_fiscale, 
    p.nome, 
    p.cognome, 
    p.sesso, 
    p.nato, 
    co.descrizione AS comune_nascita_descrizione, 
    COALESCE(agrp.assenze, (0)::bigint) AS assenze, 
    COALESCE(anggrp.assenze, (0)::bigint) AS assenze_non_giustificate, 
    COALESCE(rgrp.ritardi, (0)::bigint) AS ritardi, 
    COALESCE(rnggrp.ritardi, (0)::bigint) AS ritardi_non_giustificati, 
    COALESCE(ugrp.uscite, (0)::bigint) AS uscite, 
    COALESCE(unggrp.uscite, (0)::bigint) AS uscite_non_giustificate, 
    COALESCE(fcgrp.fuori_classi, (0)::bigint) AS fuori_classi, 
    COALESCE(ngrp.note, (0)::bigint) AS note
   FROM ((((((((((classi_alunni ca
   JOIN persone p ON ((p.persona = ca.alunno)))
   LEFT JOIN comuni co ON ((co.comune = p.comune_nascita)))
   LEFT JOIN assenze_grp agrp ON ((agrp.alunno = ca.alunno)))
   LEFT JOIN assenze_non_giustificate_grp anggrp ON ((anggrp.alunno = ca.alunno)))
   LEFT JOIN ritardi_grp rgrp ON ((rgrp.alunno = ca.alunno)))
   LEFT JOIN ritardi_non_giustificati_grp rnggrp ON ((rnggrp.alunno = ca.alunno)))
   LEFT JOIN uscite_grp ugrp ON ((ugrp.alunno = ca.alunno)))
   LEFT JOIN uscite_non_giustificate_grp unggrp ON ((unggrp.alunno = ca.alunno)))
   LEFT JOIN fuori_classi_grp fcgrp ON ((fcgrp.alunno = ca.alunno)))
   LEFT JOIN note_grp ngrp ON ((ngrp.alunno = ca.alunno)))
  WHERE (p.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.classi_alunni_ex OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 3918395)
-- Name: w_classi_alunni_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classi_alunni_ex() RETURNS SETOF classi_alunni_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve da wrapper per la query con il corrispondente nome senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM classi_alunni_ex;
 END;
$$;


ALTER FUNCTION public.w_classi_alunni_ex() OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 3918396)
-- Name: anni_scolastici; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anni_scolastici (
    anno_scolastico bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    inizio date NOT NULL,
    fine_lezioni date NOT NULL,
    inizio_lezioni date NOT NULL,
    fine date NOT NULL,
    CONSTRAINT anni_scolastici_ck_fine CHECK ((fine > inizio)),
    CONSTRAINT anni_scolastici_ck_fine_lezioni CHECK (((fine_lezioni > inizio_lezioni) AND (fine_lezioni <= fine))),
    CONSTRAINT anni_scolastici_ck_inizio_lezioni CHECK ((inizio_lezioni >= inizio))
);


ALTER TABLE public.anni_scolastici OWNER TO postgres;

--
-- TOC entry 3478 (class 0 OID 0)
-- Dependencies: 191
-- Name: TABLE anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anni_scolastici IS 'Rappresenta l''anno scolastico ed è suddiviso per istituto';


--
-- TOC entry 3479 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN anni_scolastici.inizio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.inizio IS 'Indica la data di inizio dell''anno scolastico, non necessariamente deve corrispondere con l''inizio delle lezioni.
';


--
-- TOC entry 3480 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN anni_scolastici.fine_lezioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.fine_lezioni IS 'I dati dei registri relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio dell''anno scolastico e la data di fine delle lezioni.';


--
-- TOC entry 3481 (class 0 OID 0)
-- Dependencies: 191
-- Name: COLUMN anni_scolastici.inizio_lezioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.inizio_lezioni IS 'I dati dei registro relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio e fine delle lezioni.';


--
-- TOC entry 192 (class 1259 OID 3918403)
-- Name: classi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE classi (
    classe bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    anno_scolastico bigint NOT NULL,
    indirizzo_scolastico bigint NOT NULL,
    sezione character varying(5),
    anno_corso anno_corso NOT NULL,
    descrizione character varying(160) NOT NULL,
    plesso bigint NOT NULL
);


ALTER TABLE public.classi OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 3918407)
-- Name: istituti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE istituti (
    istituto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL,
    codice_meccanografico character varying(160) NOT NULL,
    mnemonico character varying(30) NOT NULL,
    esempio boolean DEFAULT false NOT NULL,
    logo bytea,
    condotta bigint
);


ALTER TABLE public.istituti OWNER TO postgres;

--
-- TOC entry 3484 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN istituti.esempio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istituti.esempio IS 'Indica se l''istituto e tutti i dati collegati sono stati inseriti per essere di esempio.
Se il dato è impostato a vero l''istituto verrà usato come sorgente dati per la compilazione dei dati di esempio.';


--
-- TOC entry 3485 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN istituti.condotta; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istituti.condotta IS 'indica la materia da usare per il voto di condotta';


SET default_with_oids = false;

--
-- TOC entry 194 (class 1259 OID 3918415)
-- Name: plessi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plessi (
    plesso bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.plessi OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 3918419)
-- Name: classi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_ex AS
 SELECT i.istituto, 
    i.descrizione AS istituto_descrizione, 
    i.logo, 
    a.anno_scolastico, 
    a.descrizione AS anno_scolastico_descrizione, 
    p.descrizione AS plesso_descrizione, 
    c.classe, 
    c.descrizione AS classe_descrizione
   FROM (((istituti i
   JOIN anni_scolastici a ON ((i.istituto = a.istituto)))
   JOIN classi c ON ((a.anno_scolastico = c.anno_scolastico)))
   JOIN plessi p ON ((c.plesso = p.plesso)))
  WHERE (i.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.classi_ex OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 3918424)
-- Name: w_classi_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classi_ex() RETURNS SETOF classi_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve da wrapper per la query con il corrispondente nome senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM classi_ex;
 END;
$$;


ALTER FUNCTION public.w_classi_ex() OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 196 (class 1259 OID 3918425)
-- Name: orari_settimanali; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE orari_settimanali (
    orario_settimanale bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    descrizione character varying(160)
);


ALTER TABLE public.orari_settimanali OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 3918429)
-- Name: orari_settimanali_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW orari_settimanali_ex AS
 SELECT c.classe, 
    os.orario_settimanale, 
    os.descrizione AS orario_settimanale_descrizione
   FROM ((orari_settimanali os
   JOIN classi c ON ((os.classe = c.classe)))
   JOIN anni_scolastici a ON ((c.anno_scolastico = a.anno_scolastico)))
  WHERE (a.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.orari_settimanali_ex OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 3918433)
-- Name: w_orari_settimanali_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_orari_settimanali_ex() RETURNS SETOF orari_settimanali_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve da wrapper per la query con il corrispondente nome senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM orari_settimanali_ex;
 END;
$$;


ALTER FUNCTION public.w_orari_settimanali_ex() OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 3918434)
-- Name: materie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE materie (
    materia bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.materie OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 3918438)
-- Name: orari_settimanali_giorni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE orari_settimanali_giorni (
    orario_settimanale_giorno bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    orario_settimanale bigint NOT NULL,
    giorno_settimana giorno_settimana NOT NULL,
    docente bigint,
    materia bigint,
    compresenza smallint DEFAULT 1 NOT NULL,
    dalle time(0) without time zone NOT NULL,
    alle time(0) without time zone NOT NULL,
    CONSTRAINT orari_settimanali_giorni_ck_docente_materia CHECK (((docente IS NOT NULL) OR (materia IS NOT NULL)))
);


ALTER TABLE public.orari_settimanali_giorni OWNER TO postgres;

--
-- TOC entry 3494 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN orari_settimanali_giorni.compresenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN orari_settimanali_giorni.compresenza IS 'Indica il numero di compresenza (1 il primo insegnante, 2 il secondo insgnante e così via) se c''è un insegnante solo mettere 1 ';


--
-- TOC entry 3495 (class 0 OID 0)
-- Dependencies: 199
-- Name: CONSTRAINT orari_settimanali_giorni_ck_docente_materia ON orari_settimanali_giorni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT orari_settimanali_giorni_ck_docente_materia ON orari_settimanali_giorni IS 'Almeno uno dei campi tra docente e materia deve essere compilato.';


--
-- TOC entry 200 (class 1259 OID 3918444)
-- Name: orari_settimanali_giorni_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW orari_settimanali_giorni_ex AS
 SELECT c.classe, 
    os.orario_settimanale, 
    os.descrizione AS orario_settimanale_descrizione, 
    osg.orario_settimanale_giorno, 
    osg.giorno_settimana, 
    nome_giorno(osg.giorno_settimana) AS nome_giorno_settimana, 
    ((to_char((('now'::text)::date + osg.dalle), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.alle), ((('HH24:MI'::text || ' ('::text) || (osg.compresenza)::text) || ')'::text))) AS periodo, 
    (((p.nome)::text || ' '::text) || (p.cognome)::text) AS docente_nome_cognome, 
    p.foto_miniatura AS docente_foto_miniatura, 
    m.descrizione AS materia_descrizione
   FROM (((((anni_scolastici a
   JOIN classi c ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN orari_settimanali os ON ((os.classe = c.classe)))
   JOIN orari_settimanali_giorni osg ON ((osg.orario_settimanale = os.orario_settimanale)))
   JOIN persone p ON ((p.persona = osg.docente)))
   LEFT JOIN materie m ON ((m.materia = osg.materia)))
  WHERE (a.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.orari_settimanali_giorni_ex OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 3918449)
-- Name: w_orari_settimanali_giorni_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_orari_settimanali_giorni_ex() RETURNS SETOF orari_settimanali_giorni_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve da wrapper per la query con il corrispondente nome senza il prefisso w_
*/
BEGIN 
  RETURN QUERY SELECT * FROM orari_settimanali_giorni_ex;
 END;
$$;


ALTER FUNCTION public.w_orari_settimanali_giorni_ex() OWNER TO postgres;

--
-- TOC entry 556 (class 1255 OID 3918450)
-- Name: where_sequence(text, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION where_sequence(name text, search_value bigint) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, num_time_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Cerca in tutte le colonne del database che hanno per default 
   la sequenza indicata nel parametro name il valore indicato nel
   parametro value
*/
declare
      results record;
      default_column character varying;
begin 
      default_column = 'nextval(''' || name || '''::regclass)';
      for  results in select
			columns.table_catalog, 
			columns.table_schema,
			columns.table_name, 
			columns.column_name
		      from
			information_schema.columns, 
			information_schema.tables
		      where
			columns.table_catalog = tables.table_catalog AND
			columns.table_schema = tables.table_schema AND
			columns.table_name = tables.table_name AND
			tables.table_catalog = 'scuola247' AND 
			tables.table_schema = 'public' AND 
			tables.table_type = 'BASE TABLE' AND 
			columns.column_default =  default_column
      loop
	table_catalog := results.table_catalog;
	table_schema := results.table_schema;
	table_name := results.table_name;
	column_name := results.column_name;
	execute 'SELECT COUNT(''x'') FROM ' || table_name || ' WHERE ' || column_name || ' = ' || search_value into strict num_time_found;
        return next;
      end loop;
 end;
$$;


ALTER FUNCTION public.where_sequence(name text, search_value bigint) OWNER TO postgres;

--
-- TOC entry 3499 (class 0 OID 0)
-- Dependencies: 556
-- Name: FUNCTION where_sequence(name text, search_value bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(name text, search_value bigint) IS 'Restituisce l''elenco delle tabelle che hanno la colonna collegata alla sequenza indicata e contengono il valore indicato.';


--
-- TOC entry 201 (class 1259 OID 3918451)
-- Name: argomenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE argomenti (
    argomento bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    materia bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    anno_corso anno_corso,
    indirizzo_scolastico bigint NOT NULL
);


ALTER TABLE public.argomenti OWNER TO postgres;

--
-- TOC entry 3501 (class 0 OID 0)
-- Dependencies: 201
-- Name: TABLE argomenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE argomenti IS 'Contiene gli argomenti oggetto di una valutazione';


--
-- TOC entry 202 (class 1259 OID 3918455)
-- Name: assenze_certificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_certificate_grp AS
 SELECT assenze.classe, 
    assenze.docente, 
    count(1) AS assenze_certificate
   FROM assenze
  GROUP BY assenze.classe, assenze.docente;


ALTER TABLE public.assenze_certificate_grp OWNER TO postgres;

--
-- TOC entry 3503 (class 0 OID 0)
-- Dependencies: 202
-- Name: VIEW assenze_certificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_certificate_grp IS 'raggruppa le assenze certificate da ogni docente per ogni classe';


--
-- TOC entry 203 (class 1259 OID 3918459)
-- Name: giustificazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE giustificazioni (
    giustificazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    creata_il timestamp without time zone NOT NULL,
    creata_da bigint NOT NULL,
    registrata_il timestamp without time zone,
    registrata_da bigint,
    dal date,
    al date,
    entra time without time zone,
    esce time without time zone,
    tipo tipo_giustificazione,
    CONSTRAINT giustificazioni_ck_al CHECK ((al >= dal)),
    CONSTRAINT giustificazioni_ck_esce CHECK ((esce > entra)),
    CONSTRAINT giustificazioni_ck_registrata_il CHECK ((registrata_il >= creata_il))
);


ALTER TABLE public.giustificazioni OWNER TO postgres;

--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE giustificazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE giustificazioni IS 'contiene le giustificazioni per assenze, ritardi e uscite.
Può essere fatta da un addetto scolastico che compilerà la descrizione o da un esercenta la patria potestà';


--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.creata_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.creata_da IS 'La persona, addetto scolastico, famigliare o l''alunno stesso, se maggiorenne, che ha inserito la giustificazione';


--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.registrata_il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.registrata_il IS 'Data ed ora in cui la giustificazione è stata usata (è stata cioè associata ad un''assenza)';


--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.registrata_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.registrata_da IS 'L''addetto scolastico che ha usato la giustificazione (l''ha associata ad un''assenza)';


--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.dal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.dal IS 'giorno di inizio della giustificazione (per i ritardo e le uscite coincide con al)';


--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.al; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.al IS 'giorno di fine giustificazione (per i ritardo e le uscite coincide con dal)';


--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.entra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.entra IS 'ora di entrata (ritardo)';


--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN giustificazioni.esce; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.esce IS 'Ora di uscita';


--
-- TOC entry 204 (class 1259 OID 3918469)
-- Name: assenze_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_ex AS
 SELECT a.classe, 
    a.giorno, 
    doc.foto_miniatura AS docente_foto_miniatura, 
    doc.cognome AS docente_cognome, 
    doc.nome AS docente_nome, 
    doc.codice_fiscale AS docente_codice_fiscale, 
    alu.foto_miniatura AS alunno_foto_miniatura, 
    alu.cognome AS alunno_cognome, 
    alu.nome AS alunno_nome, 
    alu.codice_fiscale AS alunno_codice_fiscale, 
    g.descrizione AS giustificazione_descrizione, 
    g.creata_il AS giustificazione_creata_il, 
    pcre.cognome AS creata_da_cognome, 
    pcre.nome AS creata_da_nome, 
    pcre.foto_miniatura AS creata_da_foto_miniatura, 
    g.registrata_il AS giustificazione_registrata_il, 
    preg.cognome AS registrata_il_cognome, 
    preg.nome AS registrata_il_nome, 
    preg.foto_miniatura AS registrata_il_foto_miniatura
   FROM ((((((assenze a
   JOIN classi c ON ((c.classe = a.classe)))
   JOIN persone alu ON ((a.alunno = alu.persona)))
   JOIN persone doc ON ((a.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = a.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)));


ALTER TABLE public.assenze_ex OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 3918474)
-- Name: assenze_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_mese_grp AS
 WITH cmg AS (
         SELECT assenze.classe, 
            date_part('month'::text, assenze.giorno) AS mese, 
            count(1) AS assenze
           FROM assenze
          GROUP BY assenze.classe, date_part('month'::text, assenze.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.assenze, (0)::bigint) AS assenze
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.assenze_mese_grp OWNER TO postgres;

--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 205
-- Name: VIEW assenze_mese_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_mese_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e mese
viene usata una crossjoin per creare la lista di tutte le classi con tutti i mesi a zero per unirli con le assenze della tabella lo scopo e di avere le assenze di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle delle assenze, non ci sarebbero';


--
-- TOC entry 206 (class 1259 OID 3918479)
-- Name: persone_indirizzi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_indirizzi (
    persona_indirizzo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    tipo_indirizzo tipo_indirizzo NOT NULL,
    via character varying(160) NOT NULL,
    cap character varying(15) NOT NULL,
    comune character(4) NOT NULL
);


ALTER TABLE public.persone_indirizzi OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 3918483)
-- Name: classi_alunni_indirizzi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_alunni_indirizzi_ex AS
 SELECT ca.classe, 
    ca.alunno, 
    p.nome, 
    p.cognome, 
    p.codice_fiscale, 
    p.sesso, 
    p.nato, 
    cn.descrizione AS comune_nascita, 
    pi.via, 
    pi.cap, 
    ci.descrizione AS comune, 
    ci.provincia, 
    COALESCE(agrp.assenze, (0)::bigint) AS assenze
   FROM (((((classi_alunni ca
   JOIN persone p ON ((p.persona = ca.alunno)))
   JOIN persone_indirizzi pi ON ((pi.persona = p.persona)))
   LEFT JOIN comuni cn ON ((cn.comune = p.comune_nascita)))
   LEFT JOIN comuni ci ON ((ci.comune = pi.comune)))
   LEFT JOIN assenze_grp agrp ON ((agrp.alunno = ca.alunno)))
  WHERE (p.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.classi_alunni_indirizzi_ex OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 3918488)
-- Name: lezioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE lezioni (
    lezione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    giorno date NOT NULL,
    materia bigint NOT NULL,
    docente bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    supplenza boolean DEFAULT false NOT NULL,
    dalle time without time zone NOT NULL,
    alle time without time zone NOT NULL,
    compiti character varying(2048),
    periodo tsrange,
    CONSTRAINT lezioni_ck_alle CHECK ((alle > dalle))
);


ALTER TABLE public.lezioni OWNER TO postgres;

--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN lezioni.supplenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.supplenza IS 'Indica se la lezione è di supplenza cioè tenuta da un insegnante non titolare della cattedra';


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN lezioni.compiti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.compiti IS 'compiti assegnati durante la lezione';


--
-- TOC entry 209 (class 1259 OID 3918497)
-- Name: classi_docenti; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_docenti AS
 SELECT DISTINCT lezioni.classe, 
    lezioni.docente
   FROM lezioni;


ALTER TABLE public.classi_docenti OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 3918501)
-- Name: firme; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE firme (
    firma bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    docente bigint NOT NULL,
    giorno date NOT NULL,
    ora time without time zone
);


ALTER TABLE public.firme OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 3918505)
-- Name: firme_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW firme_grp AS
 SELECT f.classe, 
    f.docente, 
    count(1) AS firme
   FROM firme f
  GROUP BY f.classe, f.docente;


ALTER TABLE public.firme_grp OWNER TO postgres;

--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 211
-- Name: VIEW firme_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW firme_grp IS 'raggruppa le firme fatte da ogni docenti per ogni classe';


--
-- TOC entry 212 (class 1259 OID 3918509)
-- Name: fuori_classi_certificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_certificati_grp AS
 SELECT fuori_classi.classe, 
    fuori_classi.addetto_scolastico, 
    count(1) AS fuori_classi_certificati
   FROM fuori_classi
  GROUP BY fuori_classi.classe, fuori_classi.addetto_scolastico;


ALTER TABLE public.fuori_classi_certificati_grp OWNER TO postgres;

--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 212
-- Name: VIEW fuori_classi_certificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW fuori_classi_certificati_grp IS 'raggruppa i fuori classi certificati da ogni addetto scolastico per ogni classe';


--
-- TOC entry 213 (class 1259 OID 3918513)
-- Name: lezioni_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lezioni_grp AS
 SELECT l.classe, 
    l.docente, 
    count(1) AS lezioni
   FROM lezioni l
  GROUP BY l.classe, l.docente;


ALTER TABLE public.lezioni_grp OWNER TO postgres;

--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 213
-- Name: VIEW lezioni_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lezioni_grp IS 'raggruppa le lezioi fatti da ogni docente per ogni classe';


--
-- TOC entry 214 (class 1259 OID 3918517)
-- Name: note_emesse_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_emesse_grp AS
 SELECT note.classe, 
    note.docente, 
    count(1) AS note_emesse
   FROM note
  GROUP BY note.classe, note.docente;


ALTER TABLE public.note_emesse_grp OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 3918521)
-- Name: ritardi_certificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_certificati_grp AS
 SELECT ritardi.classe, 
    ritardi.docente, 
    count(1) AS ritardi_certificati
   FROM ritardi
  GROUP BY ritardi.classe, ritardi.docente;


ALTER TABLE public.ritardi_certificati_grp OWNER TO postgres;

--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 215
-- Name: VIEW ritardi_certificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_certificati_grp IS 'raggruppa i ritardi certificate da ogni docente per ogni classe';


--
-- TOC entry 216 (class 1259 OID 3918525)
-- Name: uscite_certificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_certificate_grp AS
 SELECT uscite.classe, 
    uscite.docente, 
    count(1) AS uscite_certificate
   FROM uscite
  GROUP BY uscite.classe, uscite.docente;


ALTER TABLE public.uscite_certificate_grp OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 216
-- Name: VIEW uscite_certificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_certificate_grp IS 'raggruppa le uscite certificate da ogni docente per ogni classe';


--
-- TOC entry 217 (class 1259 OID 3918529)
-- Name: classi_docenti_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_docenti_ex AS
 SELECT cd.classe, 
    cd.docente, 
    p.foto_miniatura, 
    p.codice_fiscale, 
    p.cognome, 
    p.nome, 
    p.sesso, 
    p.nato, 
    co.descrizione AS comune_nascita_descrizione, 
    lgrp.lezioni, 
    COALESCE(fgrp.firme, (0)::bigint) AS firme, 
    COALESCE(acgrp.assenze_certificate, (0)::bigint) AS assenze_certificate, 
    COALESCE(rcgrp.ritardi_certificati, (0)::bigint) AS ritardi_certificati, 
    COALESCE(ucgrp.uscite_certificate, (0)::bigint) AS uscite_certificate, 
    COALESCE(fccgrp.fuori_classi_certificati, (0)::bigint) AS fuori_classe_certificati, 
    COALESCE(negrp.note_emesse, (0)::bigint) AS note_emesse
   FROM (((((((((classi_docenti cd
   JOIN persone p ON ((p.persona = cd.docente)))
   JOIN lezioni_grp lgrp ON (((lgrp.classe = cd.classe) AND (lgrp.docente = cd.docente))))
   LEFT JOIN comuni co ON ((co.comune = p.comune_nascita)))
   LEFT JOIN firme_grp fgrp ON (((fgrp.classe = cd.classe) AND (fgrp.docente = cd.docente))))
   LEFT JOIN assenze_certificate_grp acgrp ON (((acgrp.classe = cd.classe) AND (acgrp.docente = cd.docente))))
   LEFT JOIN ritardi_certificati_grp rcgrp ON (((rcgrp.classe = cd.classe) AND (rcgrp.docente = cd.docente))))
   LEFT JOIN uscite_certificate_grp ucgrp ON (((ucgrp.classe = cd.classe) AND (ucgrp.docente = cd.docente))))
   LEFT JOIN fuori_classi_certificati_grp fccgrp ON (((fccgrp.classe = cd.classe) AND (fccgrp.addetto_scolastico = cd.docente))))
   LEFT JOIN note_emesse_grp negrp ON (((negrp.classe = cd.classe) AND (negrp.docente = cd.docente))))
  WHERE (p.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.classi_docenti_ex OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 3918534)
-- Name: classi_docenti_materia; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_docenti_materia AS
 SELECT DISTINCT lezioni.classe, 
    lezioni.docente, 
    lezioni.materia
   FROM lezioni;


ALTER TABLE public.classi_docenti_materia OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 219 (class 1259 OID 3918538)
-- Name: colloqui; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE colloqui (
    colloquio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    docente bigint NOT NULL,
    con bigint,
    il timestamp without time zone
);


ALTER TABLE public.colloqui OWNER TO postgres;

--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE colloqui; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE colloqui IS 'in questa tabella sono memorizzati tutti i periodi di disponibilità per i colloqui con gli esercenti la patria ';


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN colloqui.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.docente IS 'docente che è disponibile nella data indicata dalla colonna il';


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN colloqui.con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.con IS 'persona con la quale è stato prenotato il colloquio';


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN colloqui.il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.il IS 'data e ora in cui il docente è disponibile per un colloquio';


SET default_with_oids = true;

--
-- TOC entry 220 (class 1259 OID 3918542)
-- Name: conversazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conversazioni (
    conversazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    libretto bigint NOT NULL,
    oggetto character varying(160) NOT NULL,
    riservata boolean DEFAULT false NOT NULL,
    inizio timestamp without time zone DEFAULT now(),
    fine timestamp without time zone,
    CONSTRAINT conversazioni_ck_fine CHECK ((fine >= inizio))
);


ALTER TABLE public.conversazioni OWNER TO postgres;

--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN conversazioni.libretto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.libretto IS 'Riferimento alla tabella classi_alunni';


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN conversazioni.riservata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.riservata IS 'Indica che la conversazione può essere visualizzata solo dai partecipante e non, come è norma, anche dagli addetti scolastici.
Inoltre non viene inclusa nella stampa del libretto personale.';


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN conversazioni.fine; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.fine IS 'quando una conversazione è terminta non + più possibile aggiungere o modificare messaggi';


SET default_with_oids = false;

--
-- TOC entry 221 (class 1259 OID 3918549)
-- Name: conversazioni_invitati; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conversazioni_invitati (
    conversazione_invitato bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversazione bigint NOT NULL,
    invitato bigint NOT NULL
);


ALTER TABLE public.conversazioni_invitati OWNER TO postgres;

--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 221
-- Name: TABLE conversazioni_invitati; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE conversazioni_invitati IS 'definisce gli invitati ad una conversazione cioè le persone abilitate a vedere e/o partecipare ad una determinata conversazione';


--
-- TOC entry 222 (class 1259 OID 3918553)
-- Name: docenti_lezioni_firme_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW docenti_lezioni_firme_ex AS
         SELECT 'lezione'::text AS tipo_riga, 
            l.classe, 
            p.persona AS docente, 
            (((p.cognome)::text || ' '::text) || (p.nome)::text) AS docente_cognome_nome, 
            p.foto_miniatura AS docente_foto_miniatura, 
            l.giorno, 
            l.dalle, 
            l.alle, 
            COALESCE(m.descrizione, '* nessuna materia specificata *'::character varying(160)) AS materia_descrizione, 
            l.descrizione, 
            l.supplenza
           FROM ((lezioni l
      JOIN persone p ON ((l.docente = p.persona)))
   LEFT JOIN materie m ON ((l.materia = m.materia)))
UNION ALL 
         SELECT 'firma'::text AS tipo_riga, 
            f.classe, 
            p.persona AS docente, 
            (((p.cognome)::text || ' '::text) || (p.nome)::text) AS docente_cognome_nome, 
            p.foto_miniatura AS docente_foto_miniatura, 
            f.giorno, 
            f.ora AS dalle, 
            NULL::time without time zone AS alle, 
            NULL::character varying AS materia_descrizione, 
            NULL::character varying AS descrizione, 
            NULL::boolean AS supplenza
           FROM (firme f
      JOIN persone p ON ((f.docente = p.persona)));


ALTER TABLE public.docenti_lezioni_firme_ex OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 223 (class 1259 OID 3918558)
-- Name: festivi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE festivi (
    festivo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    giorno date NOT NULL,
    descrizione character varying(160)
);


ALTER TABLE public.festivi OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 3918562)
-- Name: firme_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW firme_ex AS
 SELECT f.classe, 
    f.giorno, 
    f.ora, 
    p.foto_miniatura, 
    p.persona AS docente, 
    p.cognome, 
    p.nome, 
    p.codice_fiscale
   FROM (firme f
   JOIN persone p ON ((f.docente = p.persona)));


ALTER TABLE public.firme_ex OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 3918566)
-- Name: fuori_classi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_ex AS
 SELECT f.classe, 
    f.giorno, 
    f.dalle, 
    f.alle, 
    f.descrizione, 
    adsco.foto_miniatura AS addetto_scolastico_foto_miniatura, 
    adsco.cognome AS addetto_scolastico_cognome, 
    adsco.nome AS addetto_scolastico_nome, 
    adsco.codice_fiscale AS addetto_scolastico_codice_fiscale, 
    alu.foto_miniatura AS alunno_foto_miniatura, 
    alu.cognome AS alunno_cognome, 
    alu.nome AS alunno_nome, 
    alu.codice_fiscale AS alunno_codice_fiscale
   FROM ((fuori_classi f
   JOIN persone alu ON ((f.alunno = alu.persona)))
   JOIN persone adsco ON ((f.addetto_scolastico = adsco.persona)));


ALTER TABLE public.fuori_classi_ex OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 3918571)
-- Name: fuori_classi_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_mese_grp AS
 WITH cmg AS (
         SELECT fuori_classi.classe, 
            date_part('month'::text, fuori_classi.giorno) AS mese, 
            count(1) AS fuori_classi
           FROM fuori_classi
          GROUP BY fuori_classi.classe, date_part('month'::text, fuori_classi.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.fuori_classi, (0)::bigint) AS fuori_classi
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.fuori_classi_mese_grp OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 3918576)
-- Name: immagine_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE immagine_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.immagine_seq OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 3918578)
-- Name: indirizzi_scolastici; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE indirizzi_scolastici (
    indirizzo_scolastico bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    anni_corso anno_corso NOT NULL
);


ALTER TABLE public.indirizzi_scolastici OWNER TO postgres;

--
-- TOC entry 3554 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN indirizzi_scolastici.anni_corso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN indirizzi_scolastici.anni_corso IS 'anni del corso ad esempio:
5 per le primarie
3 per le secondarie di primo grado
5 per le secondarie di secondo grado';


--
-- TOC entry 229 (class 1259 OID 3918582)
-- Name: istituti_anni_scolastici_classi_orari_settimanali; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW istituti_anni_scolastici_classi_orari_settimanali AS
 SELECT i.istituto, 
    i.descrizione AS istituto_descrizione, 
    i.logo, 
    a.anno_scolastico, 
    a.descrizione AS anno_scolastico_descrizione, 
    c.classe, 
    c.descrizione AS classe_descrizione, 
    o.orario_settimanale, 
    o.descrizione AS orario_settimanale_descrizione
   FROM (((istituti i
   JOIN anni_scolastici a ON ((i.istituto = a.istituto)))
   JOIN classi c ON ((a.anno_scolastico = c.anno_scolastico)))
   JOIN orari_settimanali o ON ((c.classe = o.classe)))
  WHERE (i.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.istituti_anni_scolastici_classi_orari_settimanali OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 3918587)
-- Name: lezioni_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lezioni_ex AS
 SELECT l.classe, 
    l.giorno, 
    l.dalle, 
    l.alle, 
    p.cognome, 
    p.nome, 
    p.codice_fiscale, 
    p.foto_miniatura, 
    l.descrizione AS lezione_descrizione, 
    m.descrizione AS materia_descrizione
   FROM ((lezioni l
   JOIN persone p ON ((l.docente = p.persona)))
   LEFT JOIN materie m ON ((l.materia = m.materia)));


ALTER TABLE public.lezioni_ex OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 3918592)
-- Name: lezioni_giorni; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lezioni_giorni AS
 SELECT DISTINCT l.classe, 
    l.giorno
   FROM lezioni l;


ALTER TABLE public.lezioni_giorni OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 3918596)
-- Name: mancanze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mancanze (
    mancanza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    lezione bigint NOT NULL,
    nota bigint
);


ALTER TABLE public.mancanze OWNER TO postgres;

--
-- TOC entry 3559 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE mancanze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE mancanze IS 'Rileva le mancanze di un alunno';


--
-- TOC entry 233 (class 1259 OID 3918603)
-- Name: mancanze_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW mancanze_grp AS
 SELECT l.classe, 
    m.alunno, 
    count(1) AS mancanze
   FROM (mancanze m
   JOIN lezioni l ON ((l.lezione = m.lezione)))
  GROUP BY l.classe, m.alunno;


ALTER TABLE public.mancanze_grp OWNER TO postgres;

--
-- TOC entry 3561 (class 0 OID 0)
-- Dependencies: 233
-- Name: VIEW mancanze_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW mancanze_grp IS 'Raggruppa le mancanze per classe (e quindi per anno scolastico) e alunno';


--
-- TOC entry 234 (class 1259 OID 3918607)
-- Name: messaggi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi (
    messaggio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversazione bigint NOT NULL,
    scritto_il timestamp without time zone DEFAULT now() NOT NULL,
    testo character varying(2048) NOT NULL,
    da bigint NOT NULL
);


ALTER TABLE public.messaggi OWNER TO postgres;

--
-- TOC entry 3563 (class 0 OID 0)
-- Dependencies: 234
-- Name: COLUMN messaggi.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi.da IS 'La persona fisica che ha scritto il messaggio';


--
-- TOC entry 235 (class 1259 OID 3918615)
-- Name: messaggi_letti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi_letti (
    messaggio_letto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    messaggio bigint NOT NULL,
    da bigint NOT NULL,
    letto_il timestamp without time zone
);


ALTER TABLE public.messaggi_letti OWNER TO postgres;

--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN messaggi_letti.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi_letti.da IS 'Persona fisica che ha letto il messaggio';


--
-- TOC entry 236 (class 1259 OID 3918619)
-- Name: messaggi_sistema; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi_sistema (
    messaggio_sistema bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(1024) NOT NULL,
    function_name character varying(1024) NOT NULL,
    id integer NOT NULL,
    lingua lingua DEFAULT 'it'::lingua NOT NULL
);


ALTER TABLE public.messaggi_sistema OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 3918627)
-- Name: metriche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metriche (
    metrica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL,
    sufficenza smallint DEFAULT 600 NOT NULL
);


ALTER TABLE public.metriche OWNER TO postgres;

--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN metriche.sufficenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metriche.sufficenza IS 'indica i millesimi da raggiungere per ottenere la sufficenza';


--
-- TOC entry 238 (class 1259 OID 3918632)
-- Name: mezzi_comunicazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mezzi_comunicazione (
    mezzo_comunicazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    tipo_comunicazione bigint NOT NULL,
    descrizione character varying(160),
    percorso character varying(255) NOT NULL,
    notifica boolean DEFAULT false NOT NULL
);


ALTER TABLE public.mezzi_comunicazione OWNER TO postgres;

--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN mezzi_comunicazione.notifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN mezzi_comunicazione.notifica IS 'Indica se usare questo mezzo di comunicazione nelle notifiche, ovviamente solo se il tipo di comunicazione lo permette';


--
-- TOC entry 239 (class 1259 OID 3918637)
-- Name: nazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nazioni (
    nazione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    esistente boolean DEFAULT true NOT NULL
);


ALTER TABLE public.nazioni OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 3918641)
-- Name: note_docenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note_docenti (
    nota_docente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    giorno date NOT NULL,
    ora time without time zone,
    classe bigint NOT NULL
);


ALTER TABLE public.note_docenti OWNER TO postgres;

--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE note_docenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE note_docenti IS 'Svolge le stesse funzioni della tabella note ma per il registro del professore.
L''unica differenza è che non è stato necessario replicare anche la colonna ''disciplinare'' perchè le note disciplinari si fanno solo sul registro di classe mentre queste note sono principalmente ad uso privato dell''insegnante.';


--
-- TOC entry 241 (class 1259 OID 3918648)
-- Name: note_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_ex AS
 SELECT n.classe, 
    n.giorno, 
    n.ora, 
    n.nota, 
    n.descrizione, 
    n.disciplinare, 
    n.da_vistare, 
    doc.foto_miniatura AS docente_foto_miniatura, 
    doc.cognome AS docente_cognome, 
    doc.nome AS docente_nome, 
    doc.codice_fiscale AS docente_codice_fiscale, 
    alu.foto_miniatura AS alunno_foto_miniatura, 
    alu.cognome AS alunno_cognome, 
    alu.nome AS alunno_nome, 
    alu.codice_fiscale AS alunno_codice_fiscale
   FROM ((note n
   JOIN persone doc ON ((n.docente = doc.persona)))
   LEFT JOIN persone alu ON ((n.alunno = alu.persona)));


ALTER TABLE public.note_ex OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 3918653)
-- Name: note_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_mese_grp AS
 WITH cmg AS (
         SELECT note.classe, 
            date_part('month'::text, note.giorno) AS mese, 
            count(1) AS note
           FROM note
          GROUP BY note.classe, date_part('month'::text, note.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.note, (0)::bigint) AS note
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.note_mese_grp OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 243 (class 1259 OID 3918658)
-- Name: note_visti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note_visti (
    nota_visto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    il timestamp without time zone,
    nota bigint NOT NULL
);


ALTER TABLE public.note_visti OWNER TO postgres;

--
-- TOC entry 3577 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN note_visti.persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note_visti.persona IS 'persona che deve vistare la nota: i parenti dell''alunno che nella colonna visto della tabella persone_parenti hanno il valore true';


--
-- TOC entry 3578 (class 0 OID 0)
-- Dependencies: 243
-- Name: COLUMN note_visti.il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note_visti.il IS 'date e ora in cui la nota è stata vista dalla persona';


--
-- TOC entry 244 (class 1259 OID 3918662)
-- Name: note_visti_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_visti_ex AS
 SELECT n.nota, 
    v.il AS visto_il, 
    per.cognome AS visto_cognome, 
    per.nome AS visto_nome, 
    per.foto_miniatura AS visto_foto_miniatura, 
    per.codice_fiscale AS visto_codice_fiscale
   FROM ((note n
   LEFT JOIN note_visti v ON ((v.nota = n.nota)))
   LEFT JOIN persone per ON ((v.persona = per.persona)));


ALTER TABLE public.note_visti_ex OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 3918667)
-- Name: orari_settimanali_docenti_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW orari_settimanali_docenti_ex AS
 SELECT c.classe, 
    p.persona AS docente, 
    (((p.cognome)::text || ' '::text) || (p.nome)::text) AS docente_cognome_nome, 
    os.descrizione AS orario_settimanale_descrizione, 
    COALESCE(m.descrizione, 'Materia non specificata'::character varying) AS materia_descrizione, 
    osg.giorno_settimana, 
    ((to_char((('now'::text)::date + osg.dalle), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.alle), ((('HH24:MI'::text || ' ('::text) || (osg.compresenza)::text) || ')'::text))) AS periodo
   FROM (((((anni_scolastici a
   JOIN classi c ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN orari_settimanali os ON ((os.classe = c.classe)))
   JOIN orari_settimanali_giorni osg ON ((osg.orario_settimanale = os.orario_settimanale)))
   JOIN persone p ON ((p.persona = osg.docente)))
   LEFT JOIN materie m ON ((m.materia = osg.materia)))
  WHERE (a.istituto = ANY (istituti_abilitati()));


ALTER TABLE public.orari_settimanali_docenti_ex OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 246 (class 1259 OID 3918672)
-- Name: persone_relazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_relazioni (
    persona_relazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    persona_relazionata bigint NOT NULL,
    visto_richiesto boolean DEFAULT true NOT NULL,
    relazione relazione_personale NOT NULL,
    puo_giustificare boolean DEFAULT false
);


ALTER TABLE public.persone_relazioni OWNER TO postgres;

--
-- TOC entry 3582 (class 0 OID 0)
-- Dependencies: 246
-- Name: TABLE persone_relazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persone_relazioni IS 'Indica le relazioni fra le persone: tipicamente l''alunno (colonna persona) avrà come relazione ''Padre/Madre''  il padre (persona_relazionata) per indicare la madre si inserirà una riga con i valori uguali a quelli appena detti avendo cura, questa volta, di mettere nella colona persona_relazionata il codice della persona che identifica la madre';


--
-- TOC entry 3583 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN persone_relazioni.visto_richiesto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persone_relazioni.visto_richiesto IS 'Indica se, nel caso di note di classe (ad esempio l''avviso per la gita scolastica) o nel caso di note discplinari, il docente deve avere cura di verificare se il parente in oggetto ha visto la nota';


--
-- TOC entry 3584 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN persone_relazioni.puo_giustificare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persone_relazioni.puo_giustificare IS 'può firmare giustificazioni per la persona in relazione';


SET default_with_oids = false;

--
-- TOC entry 247 (class 1259 OID 3918678)
-- Name: persone_ruoli; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_ruoli (
    persona_ruolo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    ruolo ruolo NOT NULL
);


ALTER TABLE public.persone_ruoli OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 248 (class 1259 OID 3918682)
-- Name: provincie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincie (
    provincia character(2) NOT NULL,
    descrizione character varying(160) NOT NULL,
    regione smallint
);


ALTER TABLE public.provincie OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 3918685)
-- Name: qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE qualifiche (
    qualifica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    nome character varying(160) NOT NULL,
    descrizione character varying(4000) NOT NULL,
    metrica bigint NOT NULL,
    tipo tipo_qualifica NOT NULL,
    qualifica_padre bigint
);


ALTER TABLE public.qualifiche OWNER TO postgres;

--
-- TOC entry 3588 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifiche IS 'Descrive per il singolo istituto le competenze conoscenze e abilita.
Mettendo tutto in una singola tabella si è coniato il termine qualifica per essere generico rispetto alla declinazione che può avere: Competenza, conosenza, abilità';


--
-- TOC entry 3589 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN qualifiche.qualifica_padre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifiche.qualifica_padre IS 'Serve a creare la gerarchia delle qualifiche in questa colonna si indica la qualifica da cui si dipende: la qualifica padre';


SET default_with_oids = false;

--
-- TOC entry 250 (class 1259 OID 3918692)
-- Name: qualifiche_pof; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE qualifiche_pof (
    qualifica_pof bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    qualifica bigint NOT NULL,
    indirizzo_scolastico bigint,
    anno_corso anno_corso,
    materia bigint
);


ALTER TABLE public.qualifiche_pof OWNER TO postgres;

--
-- TOC entry 3591 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE qualifiche_pof; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifiche_pof IS 'Contiene i collegamenti fra il piano formativo (indirizzo_scolastico, anno_corso e materia) e le qualifiche.
Serve in fase di valutazione per presentare le qualifiche coerenti con la valutazione espressa';


SET default_with_oids = true;

--
-- TOC entry 251 (class 1259 OID 3918696)
-- Name: regioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regioni (
    regione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    ripartizione_geografica ripartizione_geografica
);


ALTER TABLE public.regioni OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 3918699)
-- Name: ritardi_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_mese_grp AS
 WITH cmg AS (
         SELECT ritardi.classe, 
            date_part('month'::text, ritardi.giorno) AS mese, 
            count(1) AS ritardi
           FROM ritardi
          GROUP BY ritardi.classe, date_part('month'::text, ritardi.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.ritardi, (0)::bigint) AS ritardi
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.ritardi_mese_grp OWNER TO postgres;

--
-- TOC entry 3594 (class 0 OID 0)
-- Dependencies: 252
-- Name: VIEW ritardi_mese_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_mese_grp IS 'Raggruppa i ritardi per classe (e quindi per anno scolastico) e mese
viene usata una crossjoin per creare la lista di tutte le classi con tutti i mesi a zero per unirli con i ritardi della tabell, lo scopo e di avere i ritardi di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle dei ritardi, non ci sarebbero';


--
-- TOC entry 253 (class 1259 OID 3918704)
-- Name: uscite_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_mese_grp AS
 WITH cmg AS (
         SELECT uscite.classe, 
            date_part('month'::text, uscite.giorno) AS mese, 
            count(1) AS uscite
           FROM uscite
          GROUP BY uscite.classe, date_part('month'::text, uscite.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.uscite, (0)::bigint) AS uscite
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.uscite_mese_grp OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 3918709)
-- Name: registro_di_classe_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW registro_di_classe_mese_grp AS
        (        (        (         SELECT 'assenze'::text AS evento, 
                                    assenze_mese_grp.classe, 
                                    assenze_mese_grp.mese, 
                                    assenze_mese_grp.assenze AS numero
                                   FROM assenze_mese_grp
                        UNION ALL 
                                 SELECT 'ritardi'::text AS evento, 
                                    ritardi_mese_grp.classe, 
                                    ritardi_mese_grp.mese, 
                                    ritardi_mese_grp.ritardi AS numero
                                   FROM ritardi_mese_grp)
                UNION ALL 
                         SELECT 'uscite'::text AS evento, 
                            uscite_mese_grp.classe, 
                            uscite_mese_grp.mese, 
                            uscite_mese_grp.uscite AS numero
                           FROM uscite_mese_grp)
        UNION ALL 
                 SELECT 'fuori classi'::text AS evento, 
                    fuori_classi_mese_grp.classe, 
                    fuori_classi_mese_grp.mese, 
                    fuori_classi_mese_grp.fuori_classi AS numero
                   FROM fuori_classi_mese_grp)
UNION ALL 
         SELECT 'note'::text AS evento, 
            note_mese_grp.classe, 
            note_mese_grp.mese, 
            note_mese_grp.note AS numero
           FROM note_mese_grp;


ALTER TABLE public.registro_di_classe_mese_grp OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 255 (class 1259 OID 3918713)
-- Name: residenza_grp_comune; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE residenza_grp_comune (
    istituto bigint,
    descrizione character varying(160),
    count bigint
);


ALTER TABLE public.residenza_grp_comune OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 3918716)
-- Name: ritardi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_ex AS
 SELECT r.classe, 
    r.giorno, 
    r.ora, 
    doc.foto_miniatura AS docente_foto_miniatura, 
    doc.cognome AS docente_cognome, 
    doc.nome AS docente_nome, 
    doc.codice_fiscale AS docente_codice_fiscale, 
    alu.foto_miniatura AS alunno_foto_miniatura, 
    alu.cognome AS alunno_cognome, 
    alu.nome AS alunno_nome, 
    alu.codice_fiscale AS alunno_codice_fiscale, 
    g.descrizione AS giustificazione_descrizione, 
    g.creata_il AS giustificazione_creata_il, 
    pcre.cognome AS creata_da_cognome, 
    pcre.nome AS creata_da_nome, 
    pcre.foto_miniatura AS creata_da_foto_miniatura, 
    g.registrata_il AS giustificazione_registrata_il, 
    preg.cognome AS registrata_il_cognome, 
    preg.nome AS registrata_il_nome, 
    preg.foto_miniatura AS registrata_il_foto_miniatura
   FROM (((((ritardi r
   JOIN persone alu ON ((r.alunno = alu.persona)))
   JOIN persone doc ON ((r.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = r.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)));


ALTER TABLE public.ritardi_ex OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 3918721)
-- Name: scrutini; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini (
    scrutinio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    anno_scolastico bigint,
    data date,
    descrizione character varying(60) NOT NULL,
    chiuso boolean DEFAULT false NOT NULL
);


ALTER TABLE public.scrutini OWNER TO postgres;

--
-- TOC entry 3600 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN scrutini.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini.data IS 'Data dello scrutinio';


--
-- TOC entry 3601 (class 0 OID 0)
-- Dependencies: 257
-- Name: COLUMN scrutini.chiuso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini.chiuso IS 'Indica che lo scrutinio è chiuso e non si possono più fare modifiche';


--
-- TOC entry 258 (class 1259 OID 3918726)
-- Name: scrutini_valutazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini_valutazioni (
    scrutinio_valutazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    scrutinio bigint NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    materia bigint NOT NULL,
    voto bigint NOT NULL,
    note character varying(2048),
    carenze_formative boolean DEFAULT false NOT NULL,
    voto_di_consiglio boolean DEFAULT false,
    docente bigint,
    CONSTRAINT scrutini_valutazioni_ck_voto_consiglio CHECK ((((docente IS NOT NULL) AND (voto_di_consiglio IS NULL)) OR ((docente IS NULL) AND (voto_di_consiglio IS NOT NULL))))
);


ALTER TABLE public.scrutini_valutazioni OWNER TO postgres;

--
-- TOC entry 3603 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN scrutini_valutazioni.voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.voto IS 'Se il docente è nullo indica il voto di scrutinio altrimenti il voto proposto dal docente';


--
-- TOC entry 3604 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN scrutini_valutazioni.carenze_formative; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.carenze_formative IS 'indica se l''alunno ha dimostrato di avere carenze formative';


--
-- TOC entry 3605 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN scrutini_valutazioni.voto_di_consiglio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.voto_di_consiglio IS 'Indica che il voto è stato deciso dal consiglio di classe in difformità a quanto proposto dal docente se il docente è indicato _(quindi la riga del db indica una proposta di voto deve essere nullo)';


--
-- TOC entry 3606 (class 0 OID 0)
-- Dependencies: 258
-- Name: COLUMN scrutini_valutazioni.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.docente IS 'se nullo indica il voto dello scrutinio altrimenti indica il docente proponente il voto';


--
-- TOC entry 3607 (class 0 OID 0)
-- Dependencies: 258
-- Name: CONSTRAINT scrutini_valutazioni_ck_voto_consiglio ON scrutini_valutazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT scrutini_valutazioni_ck_voto_consiglio ON scrutini_valutazioni IS 'Se è indicato il docente (proposta di voto) allora il flag ''voto_di_consiglio'' non deve essere indicato perchè è valido solo per il voto di scrutinio e viceversa';


SET default_with_oids = true;

--
-- TOC entry 259 (class 1259 OID 3918736)
-- Name: scrutini_valutazioni_qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini_valutazioni_qualifiche (
    scrutinio_valutazione_qualifica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    scrutinio_valutazione bigint NOT NULL,
    qualifica bigint NOT NULL,
    voto bigint NOT NULL,
    note character varying(2048)
);


ALTER TABLE public.scrutini_valutazioni_qualifiche OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 260 (class 1259 OID 3918743)
-- Name: spazi_lavoro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE spazi_lavoro (
    spazio_lavoro bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    utente bigint NOT NULL,
    istituto bigint NOT NULL,
    anno_scolastico bigint NOT NULL,
    classe bigint,
    materia bigint,
    docente bigint,
    famigliare bigint,
    alunno bigint,
    descrizione character varying(1024) NOT NULL
);


ALTER TABLE public.spazi_lavoro OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 3918750)
-- Name: temp_val; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE temp_val (
    x_docente character varying,
    x_classe character varying,
    x_materia character varying,
    x_alunno character varying,
    x_data character varying,
    x_metrica character varying,
    x_voto character varying,
    x_tipo_voto character varying,
    x_argomento character varying,
    id integer NOT NULL,
    giudizio character varying,
    docente bigint,
    classe bigint,
    materia bigint,
    alunno bigint,
    data date,
    metrica bigint,
    voto bigint,
    tipo_voto bigint,
    argomento bigint
);


ALTER TABLE public.temp_val OWNER TO postgres;

--
-- TOC entry 3611 (class 0 OID 0)
-- Dependencies: 261
-- Name: COLUMN temp_val.metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN temp_val.metrica IS '
';


--
-- TOC entry 262 (class 1259 OID 3918756)
-- Name: temp_val_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE temp_val_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.temp_val_id_seq OWNER TO postgres;

--
-- TOC entry 3612 (class 0 OID 0)
-- Dependencies: 262
-- Name: temp_val_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE temp_val_id_seq OWNED BY temp_val.id;


SET default_with_oids = true;

--
-- TOC entry 263 (class 1259 OID 3918758)
-- Name: tipi_comunicazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_comunicazione (
    tipo_comunicazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL,
    gestione_notifica boolean DEFAULT false NOT NULL,
    istituto bigint
);


ALTER TABLE public.tipi_comunicazione OWNER TO postgres;

--
-- TOC entry 3613 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE tipi_comunicazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE tipi_comunicazione IS 'Indica i tipi di comunicazioni gestiti dal singolo istituto e l''eventuale gestione della notifica che viene tenuta distinta da istituto a istituto perchè potrebbe avere costi aggiuntivi che non tutti gli istituti vogliono';


--
-- TOC entry 3614 (class 0 OID 0)
-- Dependencies: 263
-- Name: COLUMN tipi_comunicazione.gestione_notifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipi_comunicazione.gestione_notifica IS 'indica se quel tipo di comunicazione gestisce le notifiche';


--
-- TOC entry 264 (class 1259 OID 3918763)
-- Name: tipi_voto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_voto (
    tipo_voto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(60) NOT NULL,
    materia bigint NOT NULL
);


ALTER TABLE public.tipi_voto OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 3918767)
-- Name: uscite_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_ex AS
 SELECT u.classe, 
    u.giorno, 
    u.ora, 
    doc.foto_miniatura AS docente_foto_miniatura, 
    doc.cognome AS docente_cognome, 
    doc.nome AS docente_nome, 
    doc.codice_fiscale AS docente_codice_fiscale, 
    alu.foto_miniatura AS alunno_foto_miniatura, 
    alu.cognome AS alunno_cognome, 
    alu.nome AS alunno_nome, 
    alu.codice_fiscale AS alunno_codice_fiscale, 
    g.descrizione AS giustificazione_descrizione, 
    g.creata_il AS giustificazione_creata_il, 
    pcre.cognome AS creata_da_cognome, 
    pcre.nome AS creata_da_nome, 
    pcre.foto_miniatura AS creata_da_foto_miniatura, 
    g.registrata_il AS giustificazione_registrata_il, 
    preg.cognome AS registrata_il_cognome, 
    preg.nome AS registrata_il_nome, 
    preg.foto_miniatura AS registrata_il_foto_miniatura
   FROM (((((uscite u
   JOIN persone alu ON ((u.alunno = alu.persona)))
   JOIN persone doc ON ((u.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = u.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)));


ALTER TABLE public.uscite_ex OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 3918772)
-- Name: usenames_rolnames; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usenames_rolnames AS
 SELECT (members.rolname)::character varying AS usename, 
    (roles.rolname)::character varying AS rolname
   FROM ((pg_authid roles
   JOIN pg_auth_members links ON ((links.roleid = roles.oid)))
   JOIN pg_authid members ON ((links.member = members.oid)));


ALTER TABLE public.usenames_rolnames OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 267 (class 1259 OID 3918776)
-- Name: utenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti (
    utente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    usename name NOT NULL,
    token character varying(1024),
    spazio_lavoro bigint,
    lingua lingua DEFAULT 'it'::lingua NOT NULL
);


ALTER TABLE public.utenti OWNER TO postgres;

--
-- TOC entry 3619 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE utenti IS 'Tutti gli utenti del sistema';


--
-- TOC entry 3620 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN utenti.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti.token IS 'serve per il ripristino della password via email';


--
-- TOC entry 3621 (class 0 OID 0)
-- Dependencies: 267
-- Name: COLUMN utenti.spazio_lavoro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti.spazio_lavoro IS 'spazio di lavoro di default, quello selezionato nel desktop quando l`utente si collega';


SET default_with_oids = true;

--
-- TOC entry 268 (class 1259 OID 3918784)
-- Name: valutazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE valutazioni (
    valutazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    materia bigint NOT NULL,
    tipo_voto bigint NOT NULL,
    argomento bigint,
    voto bigint NOT NULL,
    giudizio character varying(160),
    privata boolean DEFAULT false NOT NULL,
    docente bigint NOT NULL,
    giorno date NOT NULL,
    nota bigint
);


ALTER TABLE public.valutazioni OWNER TO postgres;

--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE valutazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni IS 'Contiene le valutazioni di tutti gli alunni fatti da tutti gli insegnati ';


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN valutazioni.privata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.privata IS 'Indica che il voto è visibile al solo docente che lo ha inserito';


--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 268
-- Name: COLUMN valutazioni.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.docente IS 'La colonna docente è stata inserita poichè il docente durante l`anno potrebbe cambiare in questo modo viene tenuto traccia di chi ha inserito il dato';


--
-- TOC entry 269 (class 1259 OID 3918789)
-- Name: voti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE voti (
    voto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    metrica bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    millesimi smallint NOT NULL,
    mnemonico character varying(3) NOT NULL
);


ALTER TABLE public.voti OWNER TO postgres;

--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE voti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE voti IS 'Contiene i voti delle varie metriche';


--
-- TOC entry 270 (class 1259 OID 3918793)
-- Name: valutazioni_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutazioni_ex AS
 SELECT ((v.xmin)::text)::bigint AS rv, 
    v.classe, 
    v.docente, 
    v.materia, 
    v.valutazione, 
    v.alunno, 
    alu.cognome, 
    alu.nome, 
    v.giorno, 
    v.tipo_voto, 
    tv.descrizione AS tipo_voto_descrizione, 
    v.argomento, 
    a.descrizione AS argomento_descrizione, 
    m.metrica, 
    m.descrizione AS metrica_descrizione, 
    v.voto, 
    vo.descrizione AS voto_descrizione, 
    v.giudizio, 
    v.privata AS privato
   FROM (((((valutazioni v
   JOIN persone alu ON ((alu.persona = v.alunno)))
   JOIN tipi_voto tv ON ((tv.tipo_voto = v.tipo_voto)))
   JOIN argomenti a ON ((a.argomento = v.argomento)))
   JOIN voti vo ON ((vo.voto = v.voto)))
   JOIN metriche m ON ((m.metrica = vo.metrica)));


ALTER TABLE public.valutazioni_ex OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 3918798)
-- Name: valutazioni_qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE valutazioni_qualifiche (
    valutazione_qualifica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    valutazione bigint NOT NULL,
    qualifica bigint NOT NULL,
    voto bigint NOT NULL,
    note character varying(2048)
);


ALTER TABLE public.valutazioni_qualifiche OWNER TO postgres;

--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE valutazioni_qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni_qualifiche IS 'Per ogni valutazione inserita nella tabella valutazioni è possibile collegare anche la valutazione delle qualifiche collegate che vengono memorizzate qui';


--
-- TOC entry 2690 (class 2604 OID 3918805)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY temp_val ALTER COLUMN id SET DEFAULT nextval('temp_val_id_seq'::regclass);


--
-- TOC entry 2756 (class 2606 OID 4020333)
-- Name: anni_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_pk PRIMARY KEY (anno_scolastico);


--
-- TOC entry 2758 (class 2606 OID 4020335)
-- Name: anni_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 2758
-- Name: CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici IS 'La descrizione deve essere univoca all''interno di un istituto';


--
-- TOC entry 2802 (class 2606 OID 4020337)
-- Name: argomenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_pk PRIMARY KEY (argomento);


--
-- TOC entry 2804 (class 2606 OID 4020339)
-- Name: argomenti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_uq_descrizione UNIQUE (indirizzo_scolastico, anno_corso, materia, descrizione);


--
-- TOC entry 2704 (class 2606 OID 4020341)
-- Name: assenze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_pk PRIMARY KEY (assenza);


--
-- TOC entry 2706 (class 2606 OID 4020343)
-- Name: assenze_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_uq_classe UNIQUE (classe, alunno, giorno);


--
-- TOC entry 2709 (class 2606 OID 4020345)
-- Name: classi_alunni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_pk PRIMARY KEY (classe_alunno);


--
-- TOC entry 2711 (class 2606 OID 4020347)
-- Name: classi_alunni_uq_classe_alunno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_uq_classe_alunno UNIQUE (classe, alunno);


--
-- TOC entry 2763 (class 2606 OID 4020349)
-- Name: classi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_pk PRIMARY KEY (classe);


--
-- TOC entry 2765 (class 2606 OID 4020351)
-- Name: classi_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_classe UNIQUE (anno_scolastico, plesso, indirizzo_scolastico, sezione, anno_corso);


--
-- TOC entry 2767 (class 2606 OID 4020353)
-- Name: classi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_descrizione UNIQUE (anno_scolastico, descrizione);


--
-- TOC entry 2830 (class 2606 OID 4020355)
-- Name: colloqui_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_pk PRIMARY KEY (colloquio);


--
-- TOC entry 2832 (class 2606 OID 4020357)
-- Name: colloqui_uq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_uq UNIQUE (docente, il);


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 2832
-- Name: CONSTRAINT colloqui_uq ON colloqui; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT colloqui_uq ON colloqui IS 'Un docente non può avere più di un colloquio in un determinato momento';


--
-- TOC entry 2714 (class 2606 OID 4020359)
-- Name: comuni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_pk PRIMARY KEY (comune);


--
-- TOC entry 2716 (class 2606 OID 4020361)
-- Name: comuni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_uq_descrizione UNIQUE (descrizione, provincia);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 2716
-- Name: CONSTRAINT comuni_uq_descrizione ON comuni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT comuni_uq_descrizione ON comuni IS 'Non ci possono essere due comuni con la stessa descrizione nella stessa provincia';


--
-- TOC entry 2837 (class 2606 OID 4020363)
-- Name: conversazioni_invitati_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_pk PRIMARY KEY (conversazione_invitato);


--
-- TOC entry 2839 (class 2606 OID 4020365)
-- Name: conversazioni_invitati_uq_invitato; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_uq_invitato UNIQUE (conversazione, invitato);


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 2839
-- Name: CONSTRAINT conversazioni_invitati_uq_invitato ON conversazioni_invitati; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT conversazioni_invitati_uq_invitato ON conversazioni_invitati IS 'Non è possibile, per una determinata conversazione, invitare la stessa persona più volte';


--
-- TOC entry 2835 (class 2606 OID 4020367)
-- Name: conversazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_pk PRIMARY KEY (conversazione);


--
-- TOC entry 2844 (class 2606 OID 4020369)
-- Name: festivi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_pk PRIMARY KEY (festivo);


--
-- TOC entry 2846 (class 2606 OID 4020371)
-- Name: festivi_uq_giorno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_uq_giorno UNIQUE (istituto, giorno);


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 2846
-- Name: CONSTRAINT festivi_uq_giorno ON festivi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT festivi_uq_giorno ON festivi IS 'Nello stesso istituto ogni giorno deve essere indicato al massimo una volta';


--
-- TOC entry 2824 (class 2606 OID 4020373)
-- Name: firme_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_pk PRIMARY KEY (firma);


--
-- TOC entry 2826 (class 2606 OID 4020375)
-- Name: firme_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_uq_classe UNIQUE (classe, docente, giorno, ora);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 2826
-- Name: CONSTRAINT firme_uq_classe ON firme; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT firme_uq_classe ON firme IS 'Un docente non può firmare più di una volta nello stesso giorno e  nella stessa ora (indipendentemente dalla classe)';


--
-- TOC entry 2720 (class 2606 OID 4020377)
-- Name: fuori_classi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classi_pk PRIMARY KEY (fuori_classe);


--
-- TOC entry 2722 (class 2606 OID 4020379)
-- Name: fuori_classi_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classi_uq_classe UNIQUE (classe, alunno, giorno);


--
-- TOC entry 2809 (class 2606 OID 4020381)
-- Name: giustificazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_pk PRIMARY KEY (giustificazione);


--
-- TOC entry 2849 (class 2606 OID 4020383)
-- Name: indirizzi_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_pk PRIMARY KEY (indirizzo_scolastico);


--
-- TOC entry 2851 (class 2606 OID 4020385)
-- Name: indirizzi_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2770 (class 2606 OID 4020387)
-- Name: istituti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_pk PRIMARY KEY (istituto);


--
-- TOC entry 2772 (class 2606 OID 4020389)
-- Name: istituti_uq_codice_meccanografico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_codice_meccanografico UNIQUE (codice_meccanografico, esempio);


--
-- TOC entry 2774 (class 2606 OID 4020391)
-- Name: istituti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2776 (class 2606 OID 4020393)
-- Name: istituti_uq_mnemonico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_mnemonico UNIQUE (mnemonico);


--
-- TOC entry 2820 (class 2606 OID 4020395)
-- Name: lezioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_pk PRIMARY KEY (lezione);


--
-- TOC entry 2855 (class 2606 OID 4020397)
-- Name: mancanze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_pk PRIMARY KEY (mancanza);


--
-- TOC entry 2789 (class 2606 OID 4020399)
-- Name: materie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_pk PRIMARY KEY (materia);


--
-- TOC entry 2791 (class 2606 OID 4020401)
-- Name: materie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2865 (class 2606 OID 4020403)
-- Name: messaggi_letti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_pk PRIMARY KEY (messaggio_letto);


--
-- TOC entry 2867 (class 2606 OID 4020405)
-- Name: messaggi_letti_uq_letto_il; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_uq_letto_il UNIQUE (messaggio, da);


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 2867
-- Name: CONSTRAINT messaggi_letti_uq_letto_il ON messaggi_letti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT messaggi_letti_uq_letto_il ON messaggi_letti IS 'L''indicazione di quando è stato letto un messaggio è univoco per ogni messagio e persona (da) che lo ha letto';


--
-- TOC entry 2859 (class 2606 OID 4020407)
-- Name: messaggi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_pk PRIMARY KEY (messaggio);


--
-- TOC entry 2869 (class 2606 OID 4020409)
-- Name: messaggi_sistema_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_sistema
    ADD CONSTRAINT messaggi_sistema_pk PRIMARY KEY (messaggio_sistema);


--
-- TOC entry 2871 (class 2606 OID 4020411)
-- Name: messaggi_sistema_uq_function_name; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_sistema
    ADD CONSTRAINT messaggi_sistema_uq_function_name UNIQUE (function_name, id, lingua);


--
-- TOC entry 2861 (class 2606 OID 4020413)
-- Name: messaggi_uq_da; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_uq_da UNIQUE (conversazione, da, scritto_il);


--
-- TOC entry 2874 (class 2606 OID 4020415)
-- Name: metriche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_pk PRIMARY KEY (metrica);


--
-- TOC entry 2876 (class 2606 OID 4020417)
-- Name: metriche_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2880 (class 2606 OID 4020419)
-- Name: mezzi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_pk PRIMARY KEY (mezzo_comunicazione);


--
-- TOC entry 2882 (class 2606 OID 4020421)
-- Name: mezzi_di_comunicazione_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_di_comunicazione_uq_descrizione UNIQUE (persona, tipo_comunicazione, descrizione);


--
-- TOC entry 2884 (class 2606 OID 4020423)
-- Name: mezzi_di_comunicazione_uq_percorso; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_di_comunicazione_uq_percorso UNIQUE (persona, tipo_comunicazione, percorso);


--
-- TOC entry 2886 (class 2606 OID 4020425)
-- Name: nazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_pk PRIMARY KEY (nazione);


--
-- TOC entry 2888 (class 2606 OID 4020427)
-- Name: nazioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2893 (class 2606 OID 4020429)
-- Name: note_docenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_pk PRIMARY KEY (nota_docente);


--
-- TOC entry 2895 (class 2606 OID 4020431)
-- Name: note_docenti_uq_giorno_ora; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_uq_giorno_ora UNIQUE (classe, alunno, giorno, ora);


--
-- TOC entry 2727 (class 2606 OID 4020433)
-- Name: note_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_pk PRIMARY KEY (nota);


--
-- TOC entry 2729 (class 2606 OID 4020435)
-- Name: note_uq_giorno_ora; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_uq_giorno_ora UNIQUE (classe, alunno, giorno, ora);


--
-- TOC entry 2899 (class 2606 OID 4020437)
-- Name: note_visti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_pk PRIMARY KEY (nota_visto);


--
-- TOC entry 2901 (class 2606 OID 4020439)
-- Name: note_visti_uq_persona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_uq_persona UNIQUE (nota, persona);


--
-- TOC entry 2796 (class 2606 OID 4020441)
-- Name: orari_settimanali_giorni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_pk PRIMARY KEY (orario_settimanale_giorno);


--
-- TOC entry 2798 (class 2606 OID 4020443)
-- Name: orari_settimanali_giorni_uq_orario_settimanale; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_uq_orario_settimanale UNIQUE (orario_settimanale, giorno_settimana, docente, materia, dalle);


--
-- TOC entry 2784 (class 2606 OID 4020445)
-- Name: orari_settimanali_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_pk PRIMARY KEY (orario_settimanale);


--
-- TOC entry 2786 (class 2606 OID 4020447)
-- Name: orari_settimanali_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_uq_descrizione UNIQUE (classe, descrizione);


--
-- TOC entry 2813 (class 2606 OID 4020449)
-- Name: persone_indirizzi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_pk PRIMARY KEY (persona_indirizzo);


--
-- TOC entry 2815 (class 2606 OID 4020451)
-- Name: persone_indirizzi_uq_indirizzo; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_uq_indirizzo UNIQUE (persona, via, cap, comune);


--
-- TOC entry 2735 (class 2606 OID 4020453)
-- Name: persone_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_pk PRIMARY KEY (persona);


--
-- TOC entry 2905 (class 2606 OID 4020455)
-- Name: persone_relazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_pk PRIMARY KEY (persona_relazione);


--
-- TOC entry 2907 (class 2606 OID 4020457)
-- Name: persone_relazioni_uq_persona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_uq_persona UNIQUE (persona, relazione, persona_relazionata);


--
-- TOC entry 2910 (class 2606 OID 4020459)
-- Name: persone_ruoli_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_ruoli
    ADD CONSTRAINT persone_ruoli_pk PRIMARY KEY (persona_ruolo);


--
-- TOC entry 2912 (class 2606 OID 4020461)
-- Name: persone_ruoli_uq_persona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_ruoli
    ADD CONSTRAINT persone_ruoli_uq_persona UNIQUE (persona, ruolo);


--
-- TOC entry 2737 (class 2606 OID 4020463)
-- Name: persone_uq_codice_fiscale; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_uq_codice_fiscale UNIQUE (istituto, codice_fiscale);


--
-- TOC entry 2739 (class 2606 OID 4020465)
-- Name: persone_uq_utente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_uq_utente UNIQUE (istituto, utente);


--
-- TOC entry 2779 (class 2606 OID 4020467)
-- Name: plessi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_pk PRIMARY KEY (plesso);


--
-- TOC entry 2781 (class 2606 OID 4020469)
-- Name: plessi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2914 (class 2606 OID 4020471)
-- Name: provincie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_pk PRIMARY KEY (provincia);


--
-- TOC entry 2916 (class 2606 OID 4020473)
-- Name: provincie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2921 (class 2606 OID 4020475)
-- Name: qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_pk PRIMARY KEY (qualifica);


--
-- TOC entry 2928 (class 2606 OID 4020477)
-- Name: qualifiche_pof_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_pk PRIMARY KEY (qualifica_pof);


--
-- TOC entry 2930 (class 2606 OID 4020479)
-- Name: qualifiche_pof_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_uq_qualifica UNIQUE (indirizzo_scolastico, anno_corso, materia, qualifica);


--
-- TOC entry 2923 (class 2606 OID 4020481)
-- Name: qualifiche_uq_nome; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_uq_nome UNIQUE (istituto, nome);


--
-- TOC entry 2932 (class 2606 OID 4020483)
-- Name: regioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_pk PRIMARY KEY (regione);


--
-- TOC entry 2934 (class 2606 OID 4020485)
-- Name: regioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2744 (class 2606 OID 4020487)
-- Name: ritardi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_pk PRIMARY KEY (ritardo);


--
-- TOC entry 2746 (class 2606 OID 4020489)
-- Name: ritardi_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_uq_classe UNIQUE (classe, alunno, giorno);


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 2746
-- Name: CONSTRAINT ritardi_uq_classe ON ritardi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT ritardi_uq_classe ON ritardi IS 'Per un alunno di una classe in un giorno è possibile un solo ritardo';


--
-- TOC entry 2937 (class 2606 OID 4020491)
-- Name: scrutini_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_pk PRIMARY KEY (scrutinio);


--
-- TOC entry 2939 (class 2606 OID 4020493)
-- Name: scrutini_uq_data; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_data UNIQUE (anno_scolastico, data);


--
-- TOC entry 2941 (class 2606 OID 4020495)
-- Name: scrutini_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_descrizione UNIQUE (anno_scolastico, descrizione);


--
-- TOC entry 2949 (class 2606 OID 4020497)
-- Name: scrutini_valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_pk PRIMARY KEY (scrutinio_valutazione);


--
-- TOC entry 2956 (class 2606 OID 4020499)
-- Name: scrutini_valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_pk PRIMARY KEY (scrutinio_valutazione_qualifica);


--
-- TOC entry 2958 (class 2606 OID 4020501)
-- Name: scrutini_valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_uq_qualifica UNIQUE (scrutinio_valutazione, qualifica);


--
-- TOC entry 2951 (class 2606 OID 4020503)
-- Name: scrutini_valutazioni_uq_alunno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_uq_alunno UNIQUE (scrutinio, classe, alunno, materia, docente);


--
-- TOC entry 2967 (class 2606 OID 4020505)
-- Name: spazi_lavoro_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_pk PRIMARY KEY (spazio_lavoro);


--
-- TOC entry 2969 (class 2606 OID 4020507)
-- Name: spazi_lavoro_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_uq_descrizione UNIQUE (utente, descrizione);


--
-- TOC entry 2971 (class 2606 OID 4020509)
-- Name: spazi_lavoro_uq_utente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_uq_utente UNIQUE (utente, istituto, anno_scolastico, classe, materia, docente, famigliare, alunno);


--
-- TOC entry 2973 (class 2606 OID 4020511)
-- Name: temp_val_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY temp_val
    ADD CONSTRAINT temp_val_pk PRIMARY KEY (id);


--
-- TOC entry 2976 (class 2606 OID 4020513)
-- Name: tipi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_pk PRIMARY KEY (tipo_comunicazione);


--
-- TOC entry 2978 (class 2606 OID 4020515)
-- Name: tipi_comunicazione_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2980 (class 2606 OID 4020517)
-- Name: tipi_voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voti_uq_descrizione UNIQUE (materia, descrizione);


--
-- TOC entry 2983 (class 2606 OID 4020519)
-- Name: tipi_voto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_pk PRIMARY KEY (tipo_voto);


--
-- TOC entry 2751 (class 2606 OID 4020521)
-- Name: uscite_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_pk PRIMARY KEY (uscita);


--
-- TOC entry 2753 (class 2606 OID 4020523)
-- Name: uscite_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_uq_classe UNIQUE (classe, alunno, giorno);


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 2753
-- Name: CONSTRAINT uscite_uq_classe ON uscite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT uscite_uq_classe ON uscite IS 'Per ub alunno di una classe in un giorno è possibile una sola uscita';


--
-- TOC entry 2986 (class 2606 OID 4020525)
-- Name: utenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_pk PRIMARY KEY (utente);


--
-- TOC entry 2988 (class 2606 OID 4020527)
-- Name: utenti_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_uq_usename UNIQUE (usename);


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 2988
-- Name: CONSTRAINT utenti_uq_usename ON utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT utenti_uq_usename ON utenti IS 'ad ogni utente di sistema deve corrispondere un solo utente ';


--
-- TOC entry 2994 (class 2606 OID 4020529)
-- Name: valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_pk PRIMARY KEY (valutazione);


--
-- TOC entry 3004 (class 2606 OID 4020531)
-- Name: valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_pk PRIMARY KEY (valutazione_qualifica);


--
-- TOC entry 3006 (class 2606 OID 4020533)
-- Name: valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_uq_qualifica UNIQUE (valutazione, qualifica);


--
-- TOC entry 2997 (class 2606 OID 4020535)
-- Name: voti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_pk PRIMARY KEY (voto);


--
-- TOC entry 2999 (class 2606 OID 4020537)
-- Name: voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_uq_descrizione UNIQUE (metrica, descrizione);


--
-- TOC entry 2754 (class 1259 OID 4020538)
-- Name: anni_scolastici_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX anni_scolastici_fx_istituto ON anni_scolastici USING btree (istituto);


--
-- TOC entry 2799 (class 1259 OID 4020539)
-- Name: argomenti_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_fx_indirizzo_scolastico ON argomenti USING btree (indirizzo_scolastico);


--
-- TOC entry 2800 (class 1259 OID 4020540)
-- Name: argomenti_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_fx_materia ON argomenti USING btree (materia);


--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 2800
-- Name: INDEX argomenti_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX argomenti_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2700 (class 1259 OID 4020541)
-- Name: assenze_fx_classe_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_classe_alunno ON assenze USING btree (classe, alunno);


--
-- TOC entry 2701 (class 1259 OID 4020542)
-- Name: assenze_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_docente ON assenze USING btree (docente);


--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 2701
-- Name: INDEX assenze_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2702 (class 1259 OID 4020543)
-- Name: assenze_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_giustificazione ON assenze USING btree (giustificazione);


--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 2702
-- Name: INDEX assenze_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2707 (class 1259 OID 4020544)
-- Name: classi_alunni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_alunni_fx_classe ON classi_alunni USING btree (classe);


--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 2707
-- Name: INDEX classi_alunni_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_alunni_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2759 (class 1259 OID 4020545)
-- Name: classi_fx_anno_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_anno_scolastico ON classi USING btree (anno_scolastico);


--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 2759
-- Name: INDEX classi_fx_anno_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_fx_anno_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2760 (class 1259 OID 4020546)
-- Name: classi_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_indirizzo_scolastico ON classi USING btree (indirizzo_scolastico);


--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 2760
-- Name: INDEX classi_fx_indirizzo_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_fx_indirizzo_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2761 (class 1259 OID 4020547)
-- Name: classi_fx_plesso; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_plesso ON classi USING btree (plesso);


--
-- TOC entry 2827 (class 1259 OID 4020548)
-- Name: colloqui_fx_con; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_fx_con ON colloqui USING btree (con);


--
-- TOC entry 2828 (class 1259 OID 4020549)
-- Name: colloqui_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_fx_docente ON colloqui USING btree (docente);


--
-- TOC entry 2712 (class 1259 OID 4020550)
-- Name: comuni_fx_provincia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comuni_fx_provincia ON comuni USING btree (provincia);


--
-- TOC entry 2833 (class 1259 OID 4020551)
-- Name: conversazioni_fx_libretto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_fx_libretto ON conversazioni USING btree (libretto);


--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 2833
-- Name: INDEX conversazioni_fx_libretto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX conversazioni_fx_libretto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2840 (class 1259 OID 4020552)
-- Name: conversazioni_partecipanti_fx_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_partecipanti_fx_conversazione ON conversazioni_invitati USING btree (conversazione);


--
-- TOC entry 2841 (class 1259 OID 4020553)
-- Name: conversazioni_partecipanti_fx_partecipante; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_partecipanti_fx_partecipante ON conversazioni_invitati USING btree (invitato);


--
-- TOC entry 2842 (class 1259 OID 4020554)
-- Name: festivi_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX festivi_fx_istituto ON festivi USING btree (istituto);


--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 2842
-- Name: INDEX festivi_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX festivi_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2821 (class 1259 OID 4020555)
-- Name: firme_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_fx_classe ON firme USING btree (classe);


--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 2821
-- Name: INDEX firme_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2822 (class 1259 OID 4020556)
-- Name: firme_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_fx_docente ON firme USING btree (docente);


--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 2822
-- Name: INDEX firme_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2717 (class 1259 OID 4020557)
-- Name: fuori_classi_fx_addetto_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_fx_addetto_scolastico ON fuori_classi USING btree (addetto_scolastico);


--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 2717
-- Name: INDEX fuori_classi_fx_addetto_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_fx_addetto_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2718 (class 1259 OID 4020558)
-- Name: fuori_classi_fx_classe_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_fx_classe_alunno ON fuori_classi USING btree (classe, alunno);


--
-- TOC entry 2805 (class 1259 OID 4020559)
-- Name: giustificazioni_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_alunno ON giustificazioni USING btree (alunno);


--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 2805
-- Name: INDEX giustificazioni_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2806 (class 1259 OID 4020560)
-- Name: giustificazioni_fx_creata_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_creata_da ON giustificazioni USING btree (creata_da);


--
-- TOC entry 2807 (class 1259 OID 4020561)
-- Name: giustificazioni_fx_usata_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_usata_da ON giustificazioni USING btree (registrata_da);


--
-- TOC entry 2768 (class 1259 OID 4020562)
-- Name: idx_istituti; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_istituti ON istituti USING btree (condotta);


--
-- TOC entry 2908 (class 1259 OID 4020563)
-- Name: idx_persone_ruoli; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_persone_ruoli ON persone_ruoli USING btree (persona);


--
-- TOC entry 2942 (class 1259 OID 4020564)
-- Name: idx_scrutini_valutazioni; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_scrutini_valutazioni ON scrutini_valutazioni USING btree (docente);


--
-- TOC entry 2959 (class 1259 OID 4020565)
-- Name: idx_spazi_lavoro; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro ON spazi_lavoro USING btree (docente);


--
-- TOC entry 2960 (class 1259 OID 4020566)
-- Name: idx_spazi_lavoro_0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro_0 ON spazi_lavoro USING btree (famigliare);


--
-- TOC entry 2961 (class 1259 OID 4020567)
-- Name: idx_spazi_lavoro_1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro_1 ON spazi_lavoro USING btree (alunno);


--
-- TOC entry 2847 (class 1259 OID 4020568)
-- Name: indirizzi_scolastici_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indirizzi_scolastici_fx_istituto ON indirizzi_scolastici USING btree (istituto);


--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 2847
-- Name: INDEX indirizzi_scolastici_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX indirizzi_scolastici_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2816 (class 1259 OID 4020569)
-- Name: lezioni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_classe ON lezioni USING btree (classe);


--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 2816
-- Name: INDEX lezioni_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2817 (class 1259 OID 4020570)
-- Name: lezioni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_docente ON lezioni USING btree (docente);


--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 2817
-- Name: INDEX lezioni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2818 (class 1259 OID 4020571)
-- Name: lezioni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_materia ON lezioni USING btree (materia);


--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 2818
-- Name: INDEX lezioni_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2862 (class 1259 OID 4020572)
-- Name: libretti_messaggi_letti_fx_libretto_mess; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_fx_libretto_mess ON messaggi_letti USING btree (messaggio);


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 2862
-- Name: INDEX libretti_messaggi_letti_fx_libretto_mess; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_fx_libretto_mess IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2863 (class 1259 OID 4020573)
-- Name: libretti_messaggi_letti_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_fx_persona ON messaggi_letti USING btree (da);


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 2863
-- Name: INDEX libretti_messaggi_letti_fx_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_fx_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2852 (class 1259 OID 4020574)
-- Name: mancanze_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_fx_alunno ON mancanze USING btree (alunno);


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 2852
-- Name: INDEX mancanze_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2853 (class 1259 OID 4020575)
-- Name: mancanze_fx_lezione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_fx_lezione ON mancanze USING btree (lezione);


--
-- TOC entry 2787 (class 1259 OID 4020576)
-- Name: materie_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX materie_fx_istituto ON materie USING btree (istituto);


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 2787
-- Name: INDEX materie_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX materie_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2856 (class 1259 OID 4020577)
-- Name: messaggi_fx_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_fx_conversazione ON messaggi USING btree (conversazione);


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 2856
-- Name: INDEX messaggi_fx_conversazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_fx_conversazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2857 (class 1259 OID 4020578)
-- Name: messaggi_fx_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_fx_da ON messaggi USING btree (da);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 2857
-- Name: INDEX messaggi_fx_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_fx_da IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2872 (class 1259 OID 4020579)
-- Name: metriche_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX metriche_fx_istituto ON metriche USING btree (istituto);


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 2872
-- Name: INDEX metriche_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX metriche_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2877 (class 1259 OID 4020580)
-- Name: mezzi_comunicazione_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_persona ON mezzi_comunicazione USING btree (persona);


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 2877
-- Name: INDEX mezzi_comunicazione_ix_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2878 (class 1259 OID 4020581)
-- Name: mezzi_comunicazione_ix_tipo_comunicazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_tipo_comunicazione ON mezzi_comunicazione USING btree (tipo_comunicazione);


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 2878
-- Name: INDEX mezzi_comunicazione_ix_tipo_comunicazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_tipo_comunicazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2889 (class 1259 OID 4020582)
-- Name: note_docenti_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_alunno ON note_docenti USING btree (alunno);


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 2889
-- Name: INDEX note_docenti_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2890 (class 1259 OID 4020583)
-- Name: note_docenti_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_classe ON note_docenti USING btree (classe);


--
-- TOC entry 2891 (class 1259 OID 4020584)
-- Name: note_docenti_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_docente ON note_docenti USING btree (docente);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 2891
-- Name: INDEX note_docenti_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2723 (class 1259 OID 4020585)
-- Name: note_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_fx_classe ON note USING btree (classe);


--
-- TOC entry 2724 (class 1259 OID 4020586)
-- Name: note_fx_classe_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_fx_classe_alunno ON note USING btree (classe, alunno);


--
-- TOC entry 2725 (class 1259 OID 4020587)
-- Name: note_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_fx_docente ON note USING btree (docente);


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 2725
-- Name: INDEX note_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2896 (class 1259 OID 4020588)
-- Name: note_visti_fx_nota; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_visti_fx_nota ON note_visti USING btree (nota);


--
-- TOC entry 2897 (class 1259 OID 4020589)
-- Name: note_visti_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_visti_fx_persona ON note_visti USING btree (persona);


--
-- TOC entry 2782 (class 1259 OID 4020590)
-- Name: orari_settimanali_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_fx_classe ON orari_settimanali USING btree (classe);


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 2782
-- Name: INDEX orari_settimanali_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2792 (class 1259 OID 4020591)
-- Name: orari_settimanali_giorni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_docente ON orari_settimanali_giorni USING btree (docente);


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 2792
-- Name: INDEX orari_settimanali_giorni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2793 (class 1259 OID 4020592)
-- Name: orari_settimanali_giorni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_materia ON orari_settimanali_giorni USING btree (materia);


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 2793
-- Name: INDEX orari_settimanali_giorni_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2794 (class 1259 OID 4020593)
-- Name: orari_settimanali_giorni_fx_orario_settimanale; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_orario_settimanale ON orari_settimanali_giorni USING btree (orario_settimanale);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 2794
-- Name: INDEX orari_settimanali_giorni_fx_orario_settimanale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_orario_settimanale IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2730 (class 1259 OID 4020594)
-- Name: persone_fx_comune_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_comune_nascita ON persone USING btree (comune_nascita);


--
-- TOC entry 2731 (class 1259 OID 4020595)
-- Name: persone_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_istituto ON persone USING btree (istituto);


--
-- TOC entry 2732 (class 1259 OID 4020596)
-- Name: persone_fx_nazione_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_nazione_nascita ON persone USING btree (nazione_nascita);


--
-- TOC entry 2733 (class 1259 OID 4020597)
-- Name: persone_fx_utente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_utente ON persone USING btree (utente);


--
-- TOC entry 2810 (class 1259 OID 4020598)
-- Name: persone_indirizzi_fx_comune; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_fx_comune ON persone_indirizzi USING btree (comune);


--
-- TOC entry 2811 (class 1259 OID 4020599)
-- Name: persone_indirizzi_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_fx_persona ON persone_indirizzi USING btree (persona);


--
-- TOC entry 2902 (class 1259 OID 4020600)
-- Name: persone_relazioni_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_relazioni_fx_persona ON persone_relazioni USING btree (persona);


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 2902
-- Name: INDEX persone_relazioni_fx_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_relazioni_fx_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2903 (class 1259 OID 4020601)
-- Name: persone_relazioni_fx_persona_relazionata; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_relazioni_fx_persona_relazionata ON persone_relazioni USING btree (persona_relazionata);


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 2903
-- Name: INDEX persone_relazioni_fx_persona_relazionata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_relazioni_fx_persona_relazionata IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2777 (class 1259 OID 4020602)
-- Name: plessi_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX plessi_fx_istituto ON plessi USING btree (istituto);


--
-- TOC entry 2917 (class 1259 OID 4020603)
-- Name: qualifiche_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_istituto ON qualifiche USING btree (istituto);


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 2917
-- Name: INDEX qualifiche_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2918 (class 1259 OID 4020604)
-- Name: qualifiche_fx_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_metrica ON qualifiche USING btree (metrica);


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 2918
-- Name: INDEX qualifiche_fx_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_fx_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2919 (class 1259 OID 4020605)
-- Name: qualifiche_fx_riferimento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_riferimento ON qualifiche USING btree (qualifica_padre);


--
-- TOC entry 2924 (class 1259 OID 4020606)
-- Name: qualifiche_pof_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_indirizzo_scolastico ON qualifiche_pof USING btree (indirizzo_scolastico);


--
-- TOC entry 2925 (class 1259 OID 4020607)
-- Name: qualifiche_pof_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_materia ON qualifiche_pof USING btree (materia);


--
-- TOC entry 2926 (class 1259 OID 4020608)
-- Name: qualifiche_pof_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_qualifica ON qualifiche_pof USING btree (qualifica);


--
-- TOC entry 2740 (class 1259 OID 4020609)
-- Name: ritardi_fx_classe_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_classe_alunno ON ritardi USING btree (classe, alunno);


--
-- TOC entry 2741 (class 1259 OID 4020610)
-- Name: ritardi_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_docente ON ritardi USING btree (docente);


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 2741
-- Name: INDEX ritardi_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2742 (class 1259 OID 4020611)
-- Name: ritardi_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_giustificazione ON ritardi USING btree (giustificazione);


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 2742
-- Name: INDEX ritardi_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2935 (class 1259 OID 4020612)
-- Name: scrutini_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_fx_istituto ON scrutini USING btree (anno_scolastico);


--
-- TOC entry 2943 (class 1259 OID 4020613)
-- Name: scrutini_valutazioni_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_alunno ON scrutini_valutazioni USING btree (alunno);


--
-- TOC entry 2944 (class 1259 OID 4020614)
-- Name: scrutini_valutazioni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_classe ON scrutini_valutazioni USING btree (classe);


--
-- TOC entry 2945 (class 1259 OID 4020615)
-- Name: scrutini_valutazioni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_materia ON scrutini_valutazioni USING btree (materia);


--
-- TOC entry 2946 (class 1259 OID 4020616)
-- Name: scrutini_valutazioni_fx_scrutinio; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_scrutinio ON scrutini_valutazioni USING btree (scrutinio);


--
-- TOC entry 2947 (class 1259 OID 4020617)
-- Name: scrutini_valutazioni_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_voto ON scrutini_valutazioni USING btree (voto);


--
-- TOC entry 2952 (class 1259 OID 4020618)
-- Name: scrutini_valutazioni_qualifiche_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_qualifica ON scrutini_valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 3680 (class 0 OID 0)
-- Dependencies: 2952
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2953 (class 1259 OID 4020619)
-- Name: scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione ON scrutini_valutazioni_qualifiche USING btree (scrutinio_valutazione);


--
-- TOC entry 3681 (class 0 OID 0)
-- Dependencies: 2953
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2954 (class 1259 OID 4020620)
-- Name: scrutini_valutazioni_qualifiche_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_voto ON scrutini_valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 3682 (class 0 OID 0)
-- Dependencies: 2954
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2962 (class 1259 OID 4020621)
-- Name: spazi_lavoro_fx_anno_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_anno_scolastico ON spazi_lavoro USING btree (anno_scolastico);


--
-- TOC entry 2963 (class 1259 OID 4020622)
-- Name: spazi_lavoro_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_classe ON spazi_lavoro USING btree (classe);


--
-- TOC entry 2964 (class 1259 OID 4020623)
-- Name: spazi_lavoro_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_istituto ON spazi_lavoro USING btree (istituto);


--
-- TOC entry 2965 (class 1259 OID 4020624)
-- Name: spazi_lavoro_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_materia ON spazi_lavoro USING btree (materia);


--
-- TOC entry 2974 (class 1259 OID 4020625)
-- Name: tipi_comunicazione_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX tipi_comunicazione_fx_istituto ON tipi_comunicazione USING btree (istituto);


--
-- TOC entry 2981 (class 1259 OID 4020626)
-- Name: tipi_voto_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX tipi_voto_fx_materia ON tipi_voto USING btree (materia);


--
-- TOC entry 2747 (class 1259 OID 4020627)
-- Name: uscite_fx_classe_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_classe_alunno ON uscite USING btree (classe, alunno);


--
-- TOC entry 2748 (class 1259 OID 4020628)
-- Name: uscite_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_docente ON uscite USING btree (docente);


--
-- TOC entry 3683 (class 0 OID 0)
-- Dependencies: 2748
-- Name: INDEX uscite_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2749 (class 1259 OID 4020629)
-- Name: uscite_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_giustificazione ON uscite USING btree (giustificazione);


--
-- TOC entry 3684 (class 0 OID 0)
-- Dependencies: 2749
-- Name: INDEX uscite_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2984 (class 1259 OID 4020630)
-- Name: utenti_fx_spazio_lavoro; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX utenti_fx_spazio_lavoro ON utenti USING btree (spazio_lavoro);


--
-- TOC entry 2989 (class 1259 OID 4020631)
-- Name: valutazioni_fx_argomento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_argomento ON valutazioni USING btree (argomento);


--
-- TOC entry 3685 (class 0 OID 0)
-- Dependencies: 2989
-- Name: INDEX valutazioni_fx_argomento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_argomento IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2990 (class 1259 OID 4020632)
-- Name: valutazioni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_docente ON valutazioni USING btree (docente);


--
-- TOC entry 3686 (class 0 OID 0)
-- Dependencies: 2990
-- Name: INDEX valutazioni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2991 (class 1259 OID 4020633)
-- Name: valutazioni_fx_nota; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_nota ON valutazioni USING btree (nota);


--
-- TOC entry 2992 (class 1259 OID 4020634)
-- Name: valutazioni_fx_tipo_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_tipo_voto ON valutazioni USING btree (tipo_voto);


--
-- TOC entry 3687 (class 0 OID 0)
-- Dependencies: 2992
-- Name: INDEX valutazioni_fx_tipo_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_tipo_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 3000 (class 1259 OID 4020635)
-- Name: valutazioni_qualifiche_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_qualifica ON valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 3688 (class 0 OID 0)
-- Dependencies: 3000
-- Name: INDEX valutazioni_qualifiche_fx_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 3001 (class 1259 OID 4020636)
-- Name: valutazioni_qualifiche_fx_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_valutazione ON valutazioni_qualifiche USING btree (valutazione);


--
-- TOC entry 3689 (class 0 OID 0)
-- Dependencies: 3001
-- Name: INDEX valutazioni_qualifiche_fx_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 3002 (class 1259 OID 4020637)
-- Name: valutazioni_qualifiche_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_voto ON valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 3690 (class 0 OID 0)
-- Dependencies: 3002
-- Name: INDEX valutazioni_qualifiche_fx_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2995 (class 1259 OID 4020638)
-- Name: voti_fx_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX voti_fx_metrica ON voti USING btree (metrica);


--
-- TOC entry 3691 (class 0 OID 0)
-- Dependencies: 2995
-- Name: INDEX voti_fx_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX voti_fx_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 3290 (class 2618 OID 4020639)
-- Name: _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO residenza_grp_comune DO INSTEAD  SELECT p.istituto, 
    c.descrizione, 
    count(p.persona) AS count
   FROM ((persone p
   JOIN persone_indirizzi pi ON ((pi.persona = p.persona)))
   JOIN comuni c ON ((pi.comune = c.comune)))
  WHERE (pi.tipo_indirizzo = 'Residenza'::tipo_indirizzo)
  GROUP BY p.istituto, c.comune;


--
-- TOC entry 3119 (class 2620 OID 4020641)
-- Name: argomenti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER argomenti_iu AFTER INSERT OR UPDATE ON argomenti FOR EACH ROW EXECUTE PROCEDURE tr_argomenti_iu();


--
-- TOC entry 3111 (class 2620 OID 4020642)
-- Name: assenze_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER assenze_iu AFTER INSERT OR UPDATE ON assenze FOR EACH ROW EXECUTE PROCEDURE tr_assenze_iu();


--
-- TOC entry 3112 (class 2620 OID 4020643)
-- Name: classi_alunni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classi_alunni_iu AFTER INSERT OR UPDATE ON classi_alunni FOR EACH ROW EXECUTE PROCEDURE tr_classi_alunni_iu();


--
-- TOC entry 3117 (class 2620 OID 4020644)
-- Name: classi_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classi_iu AFTER INSERT OR UPDATE ON classi FOR EACH ROW EXECUTE PROCEDURE tr_classi_iu();


--
-- TOC entry 3123 (class 2620 OID 4020645)
-- Name: colloqui_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER colloqui_iu AFTER INSERT OR UPDATE ON colloqui FOR EACH ROW EXECUTE PROCEDURE tr_colloqui_iu();


--
-- TOC entry 3124 (class 2620 OID 4020646)
-- Name: conversazioni_invitati_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER conversazioni_invitati_iu AFTER INSERT OR UPDATE ON conversazioni_invitati FOR EACH ROW EXECUTE PROCEDURE tr_conversazioni_invitati_iu();


--
-- TOC entry 3122 (class 2620 OID 4020647)
-- Name: firme_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER firme_iu AFTER INSERT OR UPDATE ON firme FOR EACH ROW EXECUTE PROCEDURE tr_firme_iu();


--
-- TOC entry 3113 (class 2620 OID 4020648)
-- Name: fuori_classi_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER fuori_classi_iu AFTER INSERT OR UPDATE ON fuori_classi FOR EACH ROW EXECUTE PROCEDURE tr_fuori_classi_iu();


--
-- TOC entry 3120 (class 2620 OID 4020649)
-- Name: giustificazioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER giustificazioni_iu AFTER INSERT OR UPDATE ON giustificazioni FOR EACH ROW EXECUTE PROCEDURE tr_giustificazioni_iu();


--
-- TOC entry 3118 (class 2620 OID 4020650)
-- Name: istituti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER istituti_iu AFTER INSERT OR UPDATE ON istituti FOR EACH ROW EXECUTE PROCEDURE tr_istituti_iu();


--
-- TOC entry 3121 (class 2620 OID 4020651)
-- Name: lezioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lezioni_iu AFTER INSERT OR UPDATE ON lezioni FOR EACH ROW EXECUTE PROCEDURE tr_lezioni_iu();


--
-- TOC entry 3125 (class 2620 OID 4020652)
-- Name: mancanze_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mancanze_iu AFTER INSERT OR UPDATE ON mancanze FOR EACH ROW EXECUTE PROCEDURE tr_mancanze_iu();


--
-- TOC entry 3126 (class 2620 OID 4020653)
-- Name: messaggi_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messaggi_iu AFTER INSERT OR UPDATE ON messaggi FOR EACH ROW EXECUTE PROCEDURE tr_messaggi_iu();


--
-- TOC entry 3127 (class 2620 OID 4020654)
-- Name: messaggi_letti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messaggi_letti_iu AFTER INSERT OR UPDATE ON messaggi_letti FOR EACH ROW EXECUTE PROCEDURE tr_messaggi_letti_iu();


--
-- TOC entry 3128 (class 2620 OID 4020655)
-- Name: mezzi_comunicazione_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mezzi_comunicazione_iu AFTER INSERT OR UPDATE ON mezzi_comunicazione FOR EACH ROW EXECUTE PROCEDURE tr_mezzi_comunicazione_iu();


--
-- TOC entry 3129 (class 2620 OID 4020656)
-- Name: note_docenti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_docenti_iu AFTER INSERT OR UPDATE ON note_docenti FOR EACH ROW EXECUTE PROCEDURE tr_note_docenti_iu();


--
-- TOC entry 3114 (class 2620 OID 4020657)
-- Name: note_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_iu AFTER INSERT OR UPDATE ON note FOR EACH ROW EXECUTE PROCEDURE tr_note_iu();


--
-- TOC entry 3130 (class 2620 OID 4020658)
-- Name: note_visti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_visti_iu AFTER INSERT OR UPDATE ON note_visti FOR EACH ROW EXECUTE PROCEDURE tr_note_visti_iu();


--
-- TOC entry 3115 (class 2620 OID 4020659)
-- Name: ritardi_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ritardi_iu AFTER INSERT OR UPDATE ON ritardi FOR EACH ROW EXECUTE PROCEDURE tr_ritardi_iu();


--
-- TOC entry 3131 (class 2620 OID 4020660)
-- Name: scrutini_i; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_i AFTER INSERT ON scrutini FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_i();


--
-- TOC entry 3132 (class 2620 OID 4020661)
-- Name: scrutini_valutazioni_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_d AFTER DELETE ON scrutini_valutazioni FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_d();


--
-- TOC entry 3133 (class 2620 OID 4020662)
-- Name: scrutini_valutazioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_iu AFTER INSERT OR UPDATE ON scrutini_valutazioni FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_iu();


--
-- TOC entry 3134 (class 2620 OID 4020663)
-- Name: scrutini_valutazioni_qualifiche_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_qualifiche_d AFTER DELETE ON scrutini_valutazioni_qualifiche FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_qualifiche_d();


--
-- TOC entry 3135 (class 2620 OID 4020664)
-- Name: scrutini_valutazioni_qualifiche_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_qualifiche_iu AFTER INSERT OR UPDATE ON scrutini_valutazioni_qualifiche FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_qualifiche_iu();


--
-- TOC entry 3116 (class 2620 OID 4020665)
-- Name: uscite_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER uscite_iu AFTER INSERT OR UPDATE ON uscite FOR EACH ROW EXECUTE PROCEDURE tr_uscite_iu();


--
-- TOC entry 3136 (class 2620 OID 4020666)
-- Name: utenti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER utenti_iu AFTER INSERT OR UPDATE ON utenti FOR EACH ROW EXECUTE PROCEDURE tr_utenti_iu();


--
-- TOC entry 3137 (class 2620 OID 4020667)
-- Name: valutazioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutazioni_iu AFTER INSERT OR UPDATE ON valutazioni FOR EACH ROW EXECUTE PROCEDURE tr_valutazioni_iu();


--
-- TOC entry 3138 (class 2620 OID 4020668)
-- Name: valutazioni_qualifiche_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutazioni_qualifiche_iu AFTER INSERT OR UPDATE ON valutazioni_qualifiche FOR EACH ROW EXECUTE PROCEDURE tr_valutazioni_qualifiche_iu();


--
-- TOC entry 3028 (class 2606 OID 4020669)
-- Name: anni_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3039 (class 2606 OID 4020674)
-- Name: argomenti_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3040 (class 2606 OID 4020679)
-- Name: argomenti_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3007 (class 2606 OID 4020684)
-- Name: assenze_fk_classe_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_classe_alunno FOREIGN KEY (classe, alunno) REFERENCES classi_alunni(classe, alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3008 (class 2606 OID 4020689)
-- Name: assenze_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3009 (class 2606 OID 4020694)
-- Name: assenze_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3010 (class 2606 OID 4020699)
-- Name: classi_alunni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3011 (class 2606 OID 4020704)
-- Name: classi_alunni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3029 (class 2606 OID 4020709)
-- Name: classi_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3030 (class 2606 OID 4020714)
-- Name: classi_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3031 (class 2606 OID 4020719)
-- Name: classi_fk_plesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_plesso FOREIGN KEY (plesso) REFERENCES plessi(plesso) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3051 (class 2606 OID 4020724)
-- Name: colloqui_fk_con; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_con FOREIGN KEY (con) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3052 (class 2606 OID 4020729)
-- Name: colloqui_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3012 (class 2606 OID 4020734)
-- Name: comuni_fk_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_fk_provincia FOREIGN KEY (provincia) REFERENCES provincie(provincia);


--
-- TOC entry 3053 (class 2606 OID 4020739)
-- Name: conversazioni_fk_libretto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_fk_libretto FOREIGN KEY (libretto) REFERENCES classi_alunni(classe_alunno);


--
-- TOC entry 3054 (class 2606 OID 4020744)
-- Name: conversazioni_invitati_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3055 (class 2606 OID 4020749)
-- Name: conversazioni_invitati_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_fk_persona FOREIGN KEY (invitato) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3056 (class 2606 OID 4020754)
-- Name: festivi_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3049 (class 2606 OID 4020759)
-- Name: firme_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3050 (class 2606 OID 4020764)
-- Name: firme_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3013 (class 2606 OID 4020769)
-- Name: fuori_classi_fk_addetto_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classi_fk_addetto_scolastico FOREIGN KEY (addetto_scolastico) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3014 (class 2606 OID 4020774)
-- Name: fuori_classi_fk_classe_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classi_fk_classe_alunno FOREIGN KEY (classe, alunno) REFERENCES classi_alunni(classe, alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3041 (class 2606 OID 4020779)
-- Name: giustificazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3042 (class 2606 OID 4020784)
-- Name: giustificazioni_fk_creata_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_creata_da FOREIGN KEY (creata_da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3043 (class 2606 OID 4020789)
-- Name: giustificazioni_fk_registrata_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_registrata_da FOREIGN KEY (registrata_da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3057 (class 2606 OID 4020794)
-- Name: indirizzi_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3032 (class 2606 OID 4020799)
-- Name: istituti_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_fk_materia FOREIGN KEY (condotta) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3046 (class 2606 OID 4020804)
-- Name: lezioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3047 (class 2606 OID 4020809)
-- Name: lezioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3048 (class 2606 OID 4020814)
-- Name: lezioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3058 (class 2606 OID 4020819)
-- Name: mancanze_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3059 (class 2606 OID 4020824)
-- Name: mancanze_fk_lezione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_lezione FOREIGN KEY (lezione) REFERENCES lezioni(lezione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3035 (class 2606 OID 4020829)
-- Name: materie_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3060 (class 2606 OID 4020834)
-- Name: messaggi_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3061 (class 2606 OID 4020839)
-- Name: messaggi_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3062 (class 2606 OID 4020844)
-- Name: messaggi_letti_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3063 (class 2606 OID 4020849)
-- Name: messaggi_letti_fk_messaggio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_messaggio FOREIGN KEY (messaggio) REFERENCES messaggi(messaggio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3064 (class 2606 OID 4020854)
-- Name: metriche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3065 (class 2606 OID 4020859)
-- Name: mezzi_comunicazione_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3066 (class 2606 OID 4020864)
-- Name: mezzi_comunicazione_fk_tipo_comunicazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_tipo_comunicazione FOREIGN KEY (tipo_comunicazione) REFERENCES tipi_comunicazione(tipo_comunicazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3067 (class 2606 OID 4020869)
-- Name: note_docenti_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3068 (class 2606 OID 4020874)
-- Name: note_docenti_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3069 (class 2606 OID 4020879)
-- Name: note_docenti_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3015 (class 2606 OID 4020884)
-- Name: note_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3016 (class 2606 OID 4020889)
-- Name: note_fk_classe_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_classe_alunno FOREIGN KEY (classe, alunno) REFERENCES classi_alunni(classe, alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3017 (class 2606 OID 4020894)
-- Name: note_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3070 (class 2606 OID 4020899)
-- Name: note_visti_fk_nota; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_fk_nota FOREIGN KEY (nota) REFERENCES note(nota) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3071 (class 2606 OID 4020904)
-- Name: note_visti_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3034 (class 2606 OID 4020909)
-- Name: orari_settimanali_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3036 (class 2606 OID 4020914)
-- Name: orari_settimanali_giorni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3037 (class 2606 OID 4020919)
-- Name: orari_settimanali_giorni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3038 (class 2606 OID 4020924)
-- Name: orari_settimanali_giorni_fk_orario_settimanale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_orario_settimanale FOREIGN KEY (orario_settimanale) REFERENCES orari_settimanali(orario_settimanale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3018 (class 2606 OID 4020929)
-- Name: persone_fk_comune_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_comune_nascita FOREIGN KEY (comune_nascita) REFERENCES comuni(comune);


--
-- TOC entry 3019 (class 2606 OID 4020934)
-- Name: persone_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3020 (class 2606 OID 4020939)
-- Name: persone_fk_nazione_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_nazione_nascita FOREIGN KEY (nazione_nascita) REFERENCES nazioni(nazione);


--
-- TOC entry 3021 (class 2606 OID 4021217)
-- Name: persone_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3044 (class 2606 OID 4020949)
-- Name: persone_indirizzi_fk_comune; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_comune FOREIGN KEY (comune) REFERENCES comuni(comune) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3045 (class 2606 OID 4020954)
-- Name: persone_indirizzi_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3072 (class 2606 OID 4020959)
-- Name: persone_relazioni_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3073 (class 2606 OID 4020964)
-- Name: persone_relazioni_fk_persona_relazionata; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_fk_persona_relazionata FOREIGN KEY (persona_relazionata) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3074 (class 2606 OID 4020969)
-- Name: persone_ruoli_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_ruoli
    ADD CONSTRAINT persone_ruoli_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3033 (class 2606 OID 4020974)
-- Name: plessi_fk_istituti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_fk_istituti FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3075 (class 2606 OID 4020979)
-- Name: provincie_fk_regione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_fk_regione FOREIGN KEY (regione) REFERENCES regioni(regione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3076 (class 2606 OID 4020984)
-- Name: qualifiche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3077 (class 2606 OID 4020989)
-- Name: qualifiche_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3078 (class 2606 OID 4020994)
-- Name: qualifiche_fk_qualifica_padre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_qualifica_padre FOREIGN KEY (qualifica_padre) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3079 (class 2606 OID 4020999)
-- Name: qualifiche_pof_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3080 (class 2606 OID 4021004)
-- Name: qualifiche_pof_fk_materie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_materie FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3081 (class 2606 OID 4021009)
-- Name: qualifiche_pof_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3022 (class 2606 OID 4021014)
-- Name: ritardi_fk_classe_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_classe_alunno FOREIGN KEY (classe, alunno) REFERENCES classi_alunni(classe, alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3023 (class 2606 OID 4021019)
-- Name: ritardi_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3024 (class 2606 OID 4021024)
-- Name: ritardi_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3082 (class 2606 OID 4021029)
-- Name: scrutini_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3083 (class 2606 OID 4021034)
-- Name: scrutini_valutazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3084 (class 2606 OID 4021039)
-- Name: scrutini_valutazioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3085 (class 2606 OID 4021044)
-- Name: scrutini_valutazioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3086 (class 2606 OID 4021049)
-- Name: scrutini_valutazioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3087 (class 2606 OID 4021054)
-- Name: scrutini_valutazioni_fk_scrutinio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_scrutinio FOREIGN KEY (scrutinio) REFERENCES scrutini(scrutinio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3088 (class 2606 OID 4021059)
-- Name: scrutini_valutazioni_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3089 (class 2606 OID 4021064)
-- Name: scrutini_valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3090 (class 2606 OID 4021069)
-- Name: scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione FOREIGN KEY (scrutinio_valutazione) REFERENCES scrutini_valutazioni(scrutinio_valutazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3091 (class 2606 OID 4021074)
-- Name: scrutini_valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3092 (class 2606 OID 4021079)
-- Name: spazi_lavoro_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3093 (class 2606 OID 4021084)
-- Name: spazi_lavoro_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3094 (class 2606 OID 4021089)
-- Name: spazi_lavoro_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3095 (class 2606 OID 4021094)
-- Name: spazi_lavoro_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3096 (class 2606 OID 4021099)
-- Name: spazi_lavoro_fk_famigliare; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_famigliare FOREIGN KEY (famigliare) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3097 (class 2606 OID 4021104)
-- Name: spazi_lavoro_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3098 (class 2606 OID 4021109)
-- Name: spazi_lavoro_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3099 (class 2606 OID 4021114)
-- Name: spazi_lavoro_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3100 (class 2606 OID 4021119)
-- Name: tipi_comunicazione_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3101 (class 2606 OID 4021124)
-- Name: tipi_voto_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3025 (class 2606 OID 4021129)
-- Name: uscite_fk_classe_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_classe_alunno FOREIGN KEY (classe, alunno) REFERENCES classi_alunni(classe, alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3026 (class 2606 OID 4021134)
-- Name: uscite_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3027 (class 2606 OID 4021139)
-- Name: uscite_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3102 (class 2606 OID 4021144)
-- Name: utenti_fk_spazio_lavoro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_fk_spazio_lavoro FOREIGN KEY (spazio_lavoro) REFERENCES spazi_lavoro(spazio_lavoro) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 3103 (class 2606 OID 4021149)
-- Name: valutazioni_fk_argomento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_argomento FOREIGN KEY (argomento) REFERENCES argomenti(argomento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3104 (class 2606 OID 4021154)
-- Name: valutazioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona);


--
-- TOC entry 3105 (class 2606 OID 4021159)
-- Name: valutazioni_fk_nota; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_nota FOREIGN KEY (nota) REFERENCES note(nota) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3106 (class 2606 OID 4021164)
-- Name: valutazioni_fk_tipo_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_tipo_voto FOREIGN KEY (tipo_voto) REFERENCES tipi_voto(tipo_voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3108 (class 2606 OID 4021169)
-- Name: valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3109 (class 2606 OID 4021174)
-- Name: valutazioni_qualifiche_fk_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_valutazione FOREIGN KEY (valutazione) REFERENCES valutazioni(valutazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3110 (class 2606 OID 4021179)
-- Name: valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3107 (class 2606 OID 4021184)
-- Name: voti_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3297 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO scuola247_manager;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO scuola247;


--
-- TOC entry 3301 (class 0 OID 0)
-- Dependencies: 1247
-- Name: anno_corso; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE anno_corso FROM PUBLIC;
REVOKE ALL ON TYPE anno_corso FROM postgres;
GRANT ALL ON TYPE anno_corso TO postgres;
GRANT ALL ON TYPE anno_corso TO scuola247_manager;


--
-- TOC entry 3302 (class 0 OID 0)
-- Dependencies: 1251
-- Name: giorno_settimana; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE giorno_settimana FROM PUBLIC;
REVOKE ALL ON TYPE giorno_settimana FROM postgres;
GRANT ALL ON TYPE giorno_settimana TO postgres;
GRANT ALL ON TYPE giorno_settimana TO scuola247_manager;


--
-- TOC entry 3303 (class 0 OID 0)
-- Dependencies: 1253
-- Name: lingua; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE lingua FROM PUBLIC;
REVOKE ALL ON TYPE lingua FROM postgres;
GRANT ALL ON TYPE lingua TO postgres;
GRANT ALL ON TYPE lingua TO scuola247_manager;


--
-- TOC entry 3304 (class 0 OID 0)
-- Dependencies: 1255
-- Name: periodo_lezione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE periodo_lezione FROM PUBLIC;
REVOKE ALL ON TYPE periodo_lezione FROM postgres;
GRANT ALL ON TYPE periodo_lezione TO postgres;
GRANT ALL ON TYPE periodo_lezione TO scuola247_manager;


--
-- TOC entry 3305 (class 0 OID 0)
-- Dependencies: 1257
-- Name: relazione_personale; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE relazione_personale FROM PUBLIC;
REVOKE ALL ON TYPE relazione_personale FROM postgres;
GRANT ALL ON TYPE relazione_personale TO postgres;
GRANT ALL ON TYPE relazione_personale TO scuola247_manager;


--
-- TOC entry 3306 (class 0 OID 0)
-- Dependencies: 1259
-- Name: ripartizione_geografica; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE ripartizione_geografica FROM PUBLIC;
REVOKE ALL ON TYPE ripartizione_geografica FROM postgres;
GRANT ALL ON TYPE ripartizione_geografica TO postgres;
GRANT ALL ON TYPE ripartizione_geografica TO scuola247_manager;


--
-- TOC entry 3307 (class 0 OID 0)
-- Dependencies: 1260
-- Name: ruolo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE ruolo FROM PUBLIC;
REVOKE ALL ON TYPE ruolo FROM postgres;
GRANT ALL ON TYPE ruolo TO postgres;
GRANT ALL ON TYPE ruolo TO scuola247_manager;


--
-- TOC entry 3308 (class 0 OID 0)
-- Dependencies: 1262
-- Name: sesso; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE sesso FROM PUBLIC;
REVOKE ALL ON TYPE sesso FROM postgres;
GRANT ALL ON TYPE sesso TO postgres;
GRANT ALL ON TYPE sesso TO scuola247_manager;


--
-- TOC entry 3309 (class 0 OID 0)
-- Dependencies: 1249
-- Name: settimana; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE settimana FROM PUBLIC;
REVOKE ALL ON TYPE settimana FROM postgres;
GRANT ALL ON TYPE settimana TO postgres;
GRANT ALL ON TYPE settimana TO scuola247_manager;


--
-- TOC entry 3310 (class 0 OID 0)
-- Dependencies: 1254
-- Name: stato_civile; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE stato_civile FROM PUBLIC;
REVOKE ALL ON TYPE stato_civile FROM postgres;
GRANT ALL ON TYPE stato_civile TO postgres;
GRANT ALL ON TYPE stato_civile TO scuola247_manager;


--
-- TOC entry 3311 (class 0 OID 0)
-- Dependencies: 1258
-- Name: tipo_giustificazione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE tipo_giustificazione FROM PUBLIC;
REVOKE ALL ON TYPE tipo_giustificazione FROM postgres;
GRANT ALL ON TYPE tipo_giustificazione TO postgres;
GRANT ALL ON TYPE tipo_giustificazione TO scuola247_manager;


--
-- TOC entry 3312 (class 0 OID 0)
-- Dependencies: 1261
-- Name: tipo_indirizzo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE tipo_indirizzo FROM PUBLIC;
REVOKE ALL ON TYPE tipo_indirizzo FROM postgres;
GRANT ALL ON TYPE tipo_indirizzo TO postgres;
GRANT ALL ON TYPE tipo_indirizzo TO scuola247_manager;


--
-- TOC entry 3313 (class 0 OID 0)
-- Dependencies: 1263
-- Name: tipo_qualifica; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE tipo_qualifica FROM PUBLIC;
REVOKE ALL ON TYPE tipo_qualifica FROM postgres;
GRANT ALL ON TYPE tipo_qualifica TO postgres;
GRANT ALL ON TYPE tipo_qualifica TO scuola247_manager;


--
-- TOC entry 3314 (class 0 OID 0)
-- Dependencies: 1264
-- Name: tipo_soggetto; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE tipo_soggetto FROM PUBLIC;
REVOKE ALL ON TYPE tipo_soggetto FROM postgres;
GRANT ALL ON TYPE tipo_soggetto TO postgres;
GRANT ALL ON TYPE tipo_soggetto TO scuola247_manager;


--
-- TOC entry 3315 (class 0 OID 0)
-- Dependencies: 490
-- Name: alunni_by_classe(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION alunni_by_classe(p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION alunni_by_classe(p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION alunni_by_classe(p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION alunni_by_classe(p_classe bigint) TO scuola247;


--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 491
-- Name: anni_scolastici_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) TO scuola247;


--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 493
-- Name: anni_scolastici_ins(bigint, character varying, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO scuola247;


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 492
-- Name: anni_scolastici_ins(bigint, character varying, date, date, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO scuola247;


--
-- TOC entry 3319 (class 0 OID 0)
-- Dependencies: 494
-- Name: anni_scolastici_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) TO scuola247;


--
-- TOC entry 3320 (class 0 OID 0)
-- Dependencies: 495
-- Name: anni_scolastici_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) TO scuola247;


--
-- TOC entry 3321 (class 0 OID 0)
-- Dependencies: 499
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO scuola247;


--
-- TOC entry 3322 (class 0 OID 0)
-- Dependencies: 500
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO scuola247;


--
-- TOC entry 3323 (class 0 OID 0)
-- Dependencies: 445
-- Name: argomenti_by_materia_classe(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION argomenti_by_materia_classe(p_materia bigint, p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION argomenti_by_materia_classe(p_materia bigint, p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION argomenti_by_materia_classe(p_materia bigint, p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION argomenti_by_materia_classe(p_materia bigint, p_classe bigint) TO scuola247;


--
-- TOC entry 3324 (class 0 OID 0)
-- Dependencies: 444
-- Name: classe_alunni_ex(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classe_alunni_ex(p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classe_alunni_ex(p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION classe_alunni_ex(p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION classe_alunni_ex(p_classe bigint) TO scuola247;


--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 446
-- Name: classi_alunni_indirizzi_ex_by_classe(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_alunni_indirizzi_ex_by_classe(p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_alunni_indirizzi_ex_by_classe(p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_alunni_indirizzi_ex_by_classe(p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION classi_alunni_indirizzi_ex_by_classe(p_classe bigint) TO scuola247;


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 501
-- Name: classi_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) TO scuola247;


--
-- TOC entry 3327 (class 0 OID 0)
-- Dependencies: 502
-- Name: classi_ins(bigint, bigint, character varying, smallint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO postgres;
GRANT ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO scuola247;


--
-- TOC entry 3328 (class 0 OID 0)
-- Dependencies: 504
-- Name: classi_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_list(p_anno_scolastico bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_list(p_anno_scolastico bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_list(p_anno_scolastico bigint) TO postgres;
GRANT ALL ON FUNCTION classi_list(p_anno_scolastico bigint) TO scuola247;


--
-- TOC entry 3329 (class 0 OID 0)
-- Dependencies: 503
-- Name: classi_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) TO postgres;
GRANT ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) TO scuola247;


--
-- TOC entry 3330 (class 0 OID 0)
-- Dependencies: 507
-- Name: classi_upd(bigint, bigint, bigint, bigint, character varying, smallint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO postgres;
GRANT ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO scuola247;


--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 448
-- Name: docenti_by_istituto(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION docenti_by_istituto(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION docenti_by_istituto(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION docenti_by_istituto(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION docenti_by_istituto(p_istituto bigint) TO scuola247;


--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 508
-- Name: famigliari_by_classe(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION famigliari_by_classe(p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION famigliari_by_classe(p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION famigliari_by_classe(p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION famigliari_by_classe(p_classe bigint) TO scuola247;


--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 443
-- Name: firme_by_docente_classe(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION firme_by_docente_classe(p_docente bigint, p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION firme_by_docente_classe(p_docente bigint, p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION firme_by_docente_classe(p_docente bigint, p_classe bigint) TO postgres;
GRANT ALL ON FUNCTION firme_by_docente_classe(p_docente bigint, p_classe bigint) TO scuola247;


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 447
-- Name: foto_default(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION foto_default() FROM PUBLIC;
REVOKE ALL ON FUNCTION foto_default() FROM postgres;
GRANT ALL ON FUNCTION foto_default() TO postgres;
GRANT ALL ON FUNCTION foto_default() TO scuola247;
GRANT ALL ON FUNCTION foto_default() TO scuola247_manager;


--
-- TOC entry 3337 (class 0 OID 0)
-- Dependencies: 512
-- Name: foto_miniatura_default(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION foto_miniatura_default() FROM PUBLIC;
REVOKE ALL ON FUNCTION foto_miniatura_default() FROM postgres;
GRANT ALL ON FUNCTION foto_miniatura_default() TO postgres;
GRANT ALL ON FUNCTION foto_miniatura_default() TO scuola247;
GRANT ALL ON FUNCTION foto_miniatura_default() TO scuola247_manager;


--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 451
-- Name: function_sqlcode(character varying, character); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) FROM PUBLIC;
REVOKE ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) FROM postgres;
GRANT ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) TO postgres;
GRANT ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) TO scuola247;
GRANT ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) TO scuola247_manager;


--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 505
-- Name: griglia_valutazioni_colonne_by_classe_docente_materia(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION griglia_valutazioni_colonne_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO scuola247;


--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 513
-- Name: griglia_valutazioni_righe_by_classe_docente_materia(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION griglia_valutazioni_righe_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO scuola247;


--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 450
-- Name: in_uno_dei_ruoli(character varying[]); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[]) FROM PUBLIC;
REVOKE ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[]) FROM postgres;
GRANT ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[]) TO postgres;
GRANT ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[]) TO scuola247;


--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 453
-- Name: in_uno_dei_ruoli(character varying[], bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION in_uno_dei_ruoli(p_ruoli character varying[], p_persona bigint) TO scuola247;


--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 452
-- Name: istituti_abilitati(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_abilitati() FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_abilitati() FROM postgres;
GRANT ALL ON FUNCTION istituti_abilitati() TO postgres;
GRANT ALL ON FUNCTION istituti_abilitati() TO PUBLIC;
GRANT ALL ON FUNCTION istituti_abilitati() TO scuola247;


--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 449
-- Name: istituti_by_descrizione(character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_by_descrizione(p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_by_descrizione(p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION istituti_by_descrizione(p_descrizione character varying) TO postgres;
GRANT ALL ON FUNCTION istituti_by_descrizione(p_descrizione character varying) TO scuola247;


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 506
-- Name: istituti_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) TO scuola247;


--
-- TOC entry 3348 (class 0 OID 0)
-- Dependencies: 557
-- Name: istituti_del_cascade(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) FROM postgres;
GRANT ALL ON FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) TO postgres;
GRANT ALL ON FUNCTION istituti_del_cascade(istituto_da_cancellare bigint) TO scuola247;


--
-- TOC entry 3349 (class 0 OID 0)
-- Dependencies: 514
-- Name: istituti_ins(character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO scuola247;


--
-- TOC entry 3350 (class 0 OID 0)
-- Dependencies: 515
-- Name: istituti_ins(character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO scuola247;


--
-- TOC entry 3351 (class 0 OID 0)
-- Dependencies: 454
-- Name: istituti_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_list() FROM postgres;
GRANT ALL ON FUNCTION istituti_list() TO postgres;
GRANT ALL ON FUNCTION istituti_list() TO scuola247;


--
-- TOC entry 3352 (class 0 OID 0)
-- Dependencies: 516
-- Name: istituti_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) TO postgres;
GRANT ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) TO scuola247;


--
-- TOC entry 3353 (class 0 OID 0)
-- Dependencies: 455
-- Name: istituti_sel_logo(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_sel_logo(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_sel_logo(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION istituti_sel_logo(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION istituti_sel_logo(p_istituto bigint) TO scuola247;


--
-- TOC entry 3354 (class 0 OID 0)
-- Dependencies: 521
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO scuola247;


--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 525
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO scuola247;


--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 526
-- Name: istituti_upd_logo(bigint, bigint, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) TO postgres;
GRANT ALL ON FUNCTION istituti_upd_logo(p_rv bigint, p_istituto bigint, p_logo bytea) TO scuola247;


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 456
-- Name: lezioni_by_docente_classe_materia(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) TO scuola247;


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 527
-- Name: materie_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) TO scuola247;


--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 528
-- Name: materie_ins(bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) TO postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) TO scuola247;


--
-- TOC entry 3361 (class 0 OID 0)
-- Dependencies: 529
-- Name: materie_ins(bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO scuola247;


--
-- TOC entry 3362 (class 0 OID 0)
-- Dependencies: 531
-- Name: materie_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_list(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_list(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_list(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION materie_list(p_istituto bigint) TO scuola247;


--
-- TOC entry 3363 (class 0 OID 0)
-- Dependencies: 532
-- Name: materie_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) TO postgres;
GRANT ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) TO scuola247;


--
-- TOC entry 3364 (class 0 OID 0)
-- Dependencies: 533
-- Name: materie_upd(bigint, bigint, bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) TO postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) TO scuola247;


--
-- TOC entry 3365 (class 0 OID 0)
-- Dependencies: 536
-- Name: materie_upd(bigint, bigint, bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO scuola247;


--
-- TOC entry 3367 (class 0 OID 0)
-- Dependencies: 537
-- Name: max_sequence(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION max_sequence(name text) FROM PUBLIC;
REVOKE ALL ON FUNCTION max_sequence(name text) FROM postgres;
GRANT ALL ON FUNCTION max_sequence(name text) TO postgres;
GRANT ALL ON FUNCTION max_sequence(name text) TO scuola247;


--
-- TOC entry 3368 (class 0 OID 0)
-- Dependencies: 509
-- Name: messaggi_sistema_clona(character varying, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) FROM postgres;
GRANT ALL ON FUNCTION messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) TO postgres;
GRANT ALL ON FUNCTION messaggi_sistema_clona(p_function_name_from character varying, p_function_name_to character varying) TO scuola247;


--
-- TOC entry 3370 (class 0 OID 0)
-- Dependencies: 510
-- Name: messaggi_sistema_locale(character varying, integer); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) FROM postgres;
GRANT ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) TO postgres;
GRANT ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) TO scuola247;
GRANT ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) TO scuola247_manager;


--
-- TOC entry 3371 (class 0 OID 0)
-- Dependencies: 460
-- Name: metriche_by_istituto(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION metriche_by_istituto(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION metriche_by_istituto(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION metriche_by_istituto(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION metriche_by_istituto(p_istituto bigint) TO scuola247;


--
-- TOC entry 3373 (class 0 OID 0)
-- Dependencies: 458
-- Name: nel_ruolo(character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying) FROM postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying) TO postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying) TO scuola247;


--
-- TOC entry 3375 (class 0 OID 0)
-- Dependencies: 461
-- Name: nel_ruolo(character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_persona bigint) TO scuola247;


--
-- TOC entry 3377 (class 0 OID 0)
-- Dependencies: 459
-- Name: nel_ruolo(character varying, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) FROM postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) TO postgres;
GRANT ALL ON FUNCTION nel_ruolo(p_ruolo character varying, p_usename character varying) TO scuola247;


--
-- TOC entry 3378 (class 0 OID 0)
-- Dependencies: 462
-- Name: nome_giorno(giorno_settimana); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) FROM PUBLIC;
REVOKE ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) FROM postgres;
GRANT ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) TO postgres;
GRANT ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) TO scuola247;


--
-- TOC entry 3379 (class 0 OID 0)
-- Dependencies: 511
-- Name: orari_settimanali_xt_docente(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) FROM postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) TO postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) TO scuola247;


--
-- TOC entry 3380 (class 0 OID 0)
-- Dependencies: 463
-- Name: orari_settimanali_xt_materia(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) FROM postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) TO postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) TO scuola247;


--
-- TOC entry 3381 (class 0 OID 0)
-- Dependencies: 518
-- Name: persone_cognome_nome(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persone_cognome_nome(p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION persone_cognome_nome(p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION persone_cognome_nome(p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION persone_cognome_nome(p_persona bigint) TO scuola247;


--
-- TOC entry 3382 (class 0 OID 0)
-- Dependencies: 519
-- Name: persone_sel_foto_miniatura(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) TO scuola247;


--
-- TOC entry 3383 (class 0 OID 0)
-- Dependencies: 517
-- Name: qualifiche_tree(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION qualifiche_tree() FROM PUBLIC;
REVOKE ALL ON FUNCTION qualifiche_tree() FROM postgres;
GRANT ALL ON FUNCTION qualifiche_tree() TO postgres;
GRANT ALL ON FUNCTION qualifiche_tree() TO scuola247;


--
-- TOC entry 3384 (class 0 OID 0)
-- Dependencies: 466
-- Name: rs_colonne_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION rs_colonne_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION rs_colonne_list() FROM postgres;
GRANT ALL ON FUNCTION rs_colonne_list() TO postgres;
GRANT ALL ON FUNCTION rs_colonne_list() TO scuola247;


--
-- TOC entry 3385 (class 0 OID 0)
-- Dependencies: 465
-- Name: rs_righe_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION rs_righe_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION rs_righe_list() FROM postgres;
GRANT ALL ON FUNCTION rs_righe_list() TO postgres;
GRANT ALL ON FUNCTION rs_righe_list() TO scuola247;


--
-- TOC entry 3386 (class 0 OID 0)
-- Dependencies: 467
-- Name: ruoli_by_session_user(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION ruoli_by_session_user() FROM PUBLIC;
REVOKE ALL ON FUNCTION ruoli_by_session_user() FROM postgres;
GRANT ALL ON FUNCTION ruoli_by_session_user() TO postgres;
GRANT ALL ON FUNCTION ruoli_by_session_user() TO scuola247;


--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 469
-- Name: session_persona(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION session_persona(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION session_persona(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION session_persona(p_istituto bigint) TO postgres;
GRANT ALL ON FUNCTION session_persona(p_istituto bigint) TO scuola247;


--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 470
-- Name: session_utente(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION session_utente() FROM PUBLIC;
REVOKE ALL ON FUNCTION session_utente() FROM postgres;
GRANT ALL ON FUNCTION session_utente() TO postgres;
GRANT ALL ON FUNCTION session_utente() TO scuola247;


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 468
-- Name: set_max_sequence(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION set_max_sequence(name text) FROM PUBLIC;
REVOKE ALL ON FUNCTION set_max_sequence(name text) FROM postgres;
GRANT ALL ON FUNCTION set_max_sequence(name text) TO postgres;
GRANT ALL ON FUNCTION set_max_sequence(name text) TO scuola247;


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 520
-- Name: set_spazio_lavoro_default(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) FROM postgres;
GRANT ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) TO postgres;
GRANT ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) TO scuola247;


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 471
-- Name: spazi_lavoro_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) TO postgres;
GRANT ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) TO scuola247;


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 524
-- Name: spazi_lavoro_ins(character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) TO postgres;
GRANT ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) TO scuola247;


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 522
-- Name: spazi_lavoro_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_list() FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_list() TO postgres;
GRANT ALL ON FUNCTION spazi_lavoro_list() TO scuola247;


--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 473
-- Name: test(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION test() FROM PUBLIC;
REVOKE ALL ON FUNCTION test() FROM postgres;
GRANT ALL ON FUNCTION test() TO postgres;
GRANT ALL ON FUNCTION test() TO scuola247;


--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 474
-- Name: test(integer); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION test(p_istituto integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION test(p_istituto integer) FROM postgres;
GRANT ALL ON FUNCTION test(p_istituto integer) TO postgres;
GRANT ALL ON FUNCTION test(p_istituto integer) TO scuola247;


--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 523
-- Name: tipi_voto_by_materia(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tipi_voto_by_materia(p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION tipi_voto_by_materia(p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION tipi_voto_by_materia(p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION tipi_voto_by_materia(p_materia bigint) TO scuola247;


--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 530
-- Name: tr_argomenti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_argomenti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_argomenti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_argomenti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_argomenti_iu() TO scuola247;


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 534
-- Name: tr_assenze_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_assenze_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_assenze_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_assenze_iu() TO postgres;
GRANT ALL ON FUNCTION tr_assenze_iu() TO scuola247;
GRANT ALL ON FUNCTION tr_assenze_iu() TO scuola247_manager;


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 535
-- Name: tr_classi_alunni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classi_alunni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_classi_alunni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_classi_alunni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_classi_alunni_iu() TO scuola247;


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 539
-- Name: tr_classi_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classi_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_classi_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_classi_iu() TO postgres;
GRANT ALL ON FUNCTION tr_classi_iu() TO scuola247;


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 538
-- Name: tr_colloqui_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_colloqui_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_colloqui_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_colloqui_iu() TO postgres;
GRANT ALL ON FUNCTION tr_colloqui_iu() TO scuola247;


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 540
-- Name: tr_conversazioni_invitati_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_conversazioni_invitati_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_conversazioni_invitati_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_conversazioni_invitati_iu() TO postgres;
GRANT ALL ON FUNCTION tr_conversazioni_invitati_iu() TO scuola247;


--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 541
-- Name: tr_firme_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_firme_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_firme_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_firme_iu() TO postgres;
GRANT ALL ON FUNCTION tr_firme_iu() TO scuola247;
GRANT ALL ON FUNCTION tr_firme_iu() TO scuola247_manager;


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 477
-- Name: tr_fuori_classi_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_fuori_classi_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_fuori_classi_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_fuori_classi_iu() TO postgres;
GRANT ALL ON FUNCTION tr_fuori_classi_iu() TO scuola247;


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 546
-- Name: tr_giustificazioni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_giustificazioni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_giustificazioni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_giustificazioni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_giustificazioni_iu() TO scuola247;
GRANT ALL ON FUNCTION tr_giustificazioni_iu() TO scuola247_manager;


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 545
-- Name: tr_istituti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_istituti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_istituti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_istituti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_istituti_iu() TO scuola247;


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 547
-- Name: tr_lezioni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_lezioni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_lezioni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_lezioni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_lezioni_iu() TO scuola247;
GRANT ALL ON FUNCTION tr_lezioni_iu() TO scuola247_manager;


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 542
-- Name: tr_mancanze_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_mancanze_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_mancanze_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_mancanze_iu() TO postgres;
GRANT ALL ON FUNCTION tr_mancanze_iu() TO scuola247;
GRANT ALL ON FUNCTION tr_mancanze_iu() TO scuola247_manager;


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 543
-- Name: tr_messaggi_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messaggi_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_messaggi_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_messaggi_iu() TO postgres;
GRANT ALL ON FUNCTION tr_messaggi_iu() TO scuola247;


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 478
-- Name: tr_messaggi_letti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messaggi_letti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_messaggi_letti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_messaggi_letti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_messaggi_letti_iu() TO scuola247;


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 472
-- Name: tr_mezzi_comunicazione_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_mezzi_comunicazione_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_mezzi_comunicazione_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_mezzi_comunicazione_iu() TO postgres;
GRANT ALL ON FUNCTION tr_mezzi_comunicazione_iu() TO scuola247;


--
-- TOC entry 3415 (class 0 OID 0)
-- Dependencies: 476
-- Name: tr_note_docenti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_note_docenti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_note_docenti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_note_docenti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_note_docenti_iu() TO scuola247;


--
-- TOC entry 3416 (class 0 OID 0)
-- Dependencies: 544
-- Name: tr_note_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_note_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_note_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_note_iu() TO postgres;
GRANT ALL ON FUNCTION tr_note_iu() TO scuola247;


--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 548
-- Name: tr_note_visti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_note_visti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_note_visti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_note_visti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_note_visti_iu() TO scuola247;


--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 550
-- Name: tr_orari_settimanali_giorni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_orari_settimanali_giorni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_orari_settimanali_giorni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_orari_settimanali_giorni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_orari_settimanali_giorni_iu() TO scuola247;


--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 551
-- Name: tr_ritardi_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_ritardi_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_ritardi_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_ritardi_iu() TO postgres;
GRANT ALL ON FUNCTION tr_ritardi_iu() TO scuola247;


--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 480
-- Name: tr_scrutini_i(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_scrutini_i() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_scrutini_i() FROM postgres;
GRANT ALL ON FUNCTION tr_scrutini_i() TO postgres;
GRANT ALL ON FUNCTION tr_scrutini_i() TO scuola247;


--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 479
-- Name: tr_scrutini_valutazioni_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_d() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_d() FROM postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_d() TO postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_d() TO scuola247;


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 481
-- Name: tr_scrutini_valutazioni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_iu() TO scuola247;


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 457
-- Name: tr_scrutini_valutazioni_qualifiche_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_d() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_d() FROM postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_d() TO postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_d() TO scuola247;


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 552
-- Name: tr_scrutini_valutazioni_qualifiche_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_iu() TO postgres;
GRANT ALL ON FUNCTION tr_scrutini_valutazioni_qualifiche_iu() TO scuola247;


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 549
-- Name: tr_uscite_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_uscite_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_uscite_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_uscite_iu() TO postgres;
GRANT ALL ON FUNCTION tr_uscite_iu() TO scuola247;


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 496
-- Name: tr_utenti_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_utenti_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_utenti_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_utenti_iu() TO postgres;
GRANT ALL ON FUNCTION tr_utenti_iu() TO scuola247;


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 484
-- Name: tr_valutazioni_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutazioni_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_valutazioni_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_valutazioni_iu() TO postgres;
GRANT ALL ON FUNCTION tr_valutazioni_iu() TO scuola247;


--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 497
-- Name: tr_valutazioni_qualifiche_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutazioni_qualifiche_iu() FROM PUBLIC;
REVOKE ALL ON FUNCTION tr_valutazioni_qualifiche_iu() FROM postgres;
GRANT ALL ON FUNCTION tr_valutazioni_qualifiche_iu() TO postgres;
GRANT ALL ON FUNCTION tr_valutazioni_qualifiche_iu() TO scuola247;


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 485
-- Name: uno_nei_ruoli(character varying[]); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) FROM PUBLIC;
REVOKE ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) FROM postgres;
GRANT ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) TO postgres;
GRANT ALL ON FUNCTION uno_nei_ruoli(p_ruoli character varying[]) TO scuola247;


--
-- TOC entry 3430 (class 0 OID 0)
-- Dependencies: 498
-- Name: valutazioni_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_del(p_rv bigint, p_valutazione bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_del(p_rv bigint, p_valutazione bigint) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_del(p_rv bigint, p_valutazione bigint) TO postgres;
GRANT ALL ON FUNCTION valutazioni_del(p_rv bigint, p_valutazione bigint) TO scuola247;


--
-- TOC entry 3431 (class 0 OID 0)
-- Dependencies: 486
-- Name: valutazioni_ex_by_classe_docente_materia(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO postgres;
GRANT ALL ON FUNCTION valutazioni_ex_by_classe_docente_materia(p_classe bigint, p_docente bigint, p_materia bigint) TO scuola247;


--
-- TOC entry 3432 (class 0 OID 0)
-- Dependencies: 483
-- Name: valutazioni_ins(bigint, bigint, bigint, bigint, bigint, bigint, character varying, boolean, bigint, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) TO postgres;
GRANT ALL ON FUNCTION valutazioni_ins(OUT p_rv bigint, OUT p_valutazione bigint, p_classe bigint, p_alunno bigint, p_materia bigint, p_tipo_voto bigint, p_argomento bigint, p_voto bigint, p_giudizio character varying, p_privata boolean, p_docente bigint, p_giorno date) TO scuola247;


--
-- TOC entry 3433 (class 0 OID 0)
-- Dependencies: 553
-- Name: valutazioni_ins_nota(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) TO postgres;
GRANT ALL ON FUNCTION valutazioni_ins_nota(OUT p_rv bigint, OUT p_nota bigint, p_valutazione bigint) TO scuola247;


--
-- TOC entry 3434 (class 0 OID 0)
-- Dependencies: 554
-- Name: valutazioni_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) TO postgres;
GRANT ALL ON FUNCTION valutazioni_sel(OUT p_rv bigint, p_valutazione bigint, OUT p_giudizio character varying, OUT p_privata boolean, OUT p_nota boolean) TO scuola247;


--
-- TOC entry 3435 (class 0 OID 0)
-- Dependencies: 487
-- Name: valutazioni_upd(bigint, bigint, character varying, boolean, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) TO postgres;
GRANT ALL ON FUNCTION valutazioni_upd(p_rv bigint, p_valutazione bigint, p_giudizio character varying, p_privata boolean, p_nota boolean) TO scuola247;


--
-- TOC entry 3436 (class 0 OID 0)
-- Dependencies: 555
-- Name: valutazioni_upd_voto(bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) FROM postgres;
GRANT ALL ON FUNCTION valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) TO postgres;
GRANT ALL ON FUNCTION valutazioni_upd_voto(p_rv bigint, p_valutazione bigint, p_voto bigint) TO scuola247;


--
-- TOC entry 3437 (class 0 OID 0)
-- Dependencies: 488
-- Name: voti_by_metrica(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION voti_by_metrica(p_metrica bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION voti_by_metrica(p_metrica bigint) FROM postgres;
GRANT ALL ON FUNCTION voti_by_metrica(p_metrica bigint) TO postgres;
GRANT ALL ON FUNCTION voti_by_metrica(p_metrica bigint) TO scuola247;


--
-- TOC entry 3439 (class 0 OID 0)
-- Dependencies: 173
-- Name: pk_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE pk_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE pk_seq FROM postgres;
GRANT ALL ON SEQUENCE pk_seq TO postgres;
GRANT ALL ON SEQUENCE pk_seq TO scuola247_manager;


--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 174
-- Name: assenze; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze FROM PUBLIC;
REVOKE ALL ON TABLE assenze FROM postgres;
GRANT ALL ON TABLE assenze TO postgres;
GRANT ALL ON TABLE assenze TO scuola247_manager;


--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 175
-- Name: assenze_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze_grp FROM PUBLIC;
REVOKE ALL ON TABLE assenze_grp FROM postgres;
GRANT ALL ON TABLE assenze_grp TO postgres;
GRANT ALL ON TABLE assenze_grp TO scuola247_manager;


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 176
-- Name: assenze_non_giustificate_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze_non_giustificate_grp FROM PUBLIC;
REVOKE ALL ON TABLE assenze_non_giustificate_grp FROM postgres;
GRANT ALL ON TABLE assenze_non_giustificate_grp TO postgres;
GRANT ALL ON TABLE assenze_non_giustificate_grp TO scuola247_manager;


--
-- TOC entry 3449 (class 0 OID 0)
-- Dependencies: 177
-- Name: classi_alunni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_alunni FROM PUBLIC;
REVOKE ALL ON TABLE classi_alunni FROM postgres;
GRANT ALL ON TABLE classi_alunni TO postgres;
GRANT ALL ON TABLE classi_alunni TO scuola247_manager;


--
-- TOC entry 3450 (class 0 OID 0)
-- Dependencies: 178
-- Name: comuni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE comuni FROM PUBLIC;
REVOKE ALL ON TABLE comuni FROM postgres;
GRANT ALL ON TABLE comuni TO postgres;
GRANT ALL ON TABLE comuni TO scuola247_manager;


--
-- TOC entry 3452 (class 0 OID 0)
-- Dependencies: 179
-- Name: fuori_classi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi FROM postgres;
GRANT ALL ON TABLE fuori_classi TO postgres;
GRANT ALL ON TABLE fuori_classi TO scuola247_manager;


--
-- TOC entry 3454 (class 0 OID 0)
-- Dependencies: 180
-- Name: fuori_classi_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi_grp FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi_grp FROM postgres;
GRANT ALL ON TABLE fuori_classi_grp TO postgres;
GRANT ALL ON TABLE fuori_classi_grp TO scuola247_manager;


--
-- TOC entry 3459 (class 0 OID 0)
-- Dependencies: 181
-- Name: note; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note FROM PUBLIC;
REVOKE ALL ON TABLE note FROM postgres;
GRANT ALL ON TABLE note TO postgres;
GRANT ALL ON TABLE note TO scuola247_manager;


--
-- TOC entry 3461 (class 0 OID 0)
-- Dependencies: 182
-- Name: note_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_grp FROM PUBLIC;
REVOKE ALL ON TABLE note_grp FROM postgres;
GRANT ALL ON TABLE note_grp TO postgres;
GRANT ALL ON TABLE note_grp TO scuola247_manager;


--
-- TOC entry 3463 (class 0 OID 0)
-- Dependencies: 183
-- Name: persone; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone FROM PUBLIC;
REVOKE ALL ON TABLE persone FROM postgres;
GRANT ALL ON TABLE persone TO postgres;
GRANT ALL ON TABLE persone TO scuola247_manager;


--
-- TOC entry 3465 (class 0 OID 0)
-- Dependencies: 184
-- Name: ritardi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi FROM PUBLIC;
REVOKE ALL ON TABLE ritardi FROM postgres;
GRANT ALL ON TABLE ritardi TO postgres;
GRANT ALL ON TABLE ritardi TO scuola247_manager;


--
-- TOC entry 3467 (class 0 OID 0)
-- Dependencies: 185
-- Name: ritardi_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi_grp FROM PUBLIC;
REVOKE ALL ON TABLE ritardi_grp FROM postgres;
GRANT ALL ON TABLE ritardi_grp TO postgres;
GRANT ALL ON TABLE ritardi_grp TO scuola247_manager;


--
-- TOC entry 3469 (class 0 OID 0)
-- Dependencies: 186
-- Name: ritardi_non_giustificati_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi_non_giustificati_grp FROM PUBLIC;
REVOKE ALL ON TABLE ritardi_non_giustificati_grp FROM postgres;
GRANT ALL ON TABLE ritardi_non_giustificati_grp TO postgres;
GRANT ALL ON TABLE ritardi_non_giustificati_grp TO scuola247_manager;


--
-- TOC entry 3471 (class 0 OID 0)
-- Dependencies: 187
-- Name: uscite; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite FROM PUBLIC;
REVOKE ALL ON TABLE uscite FROM postgres;
GRANT ALL ON TABLE uscite TO postgres;
GRANT ALL ON TABLE uscite TO scuola247_manager;


--
-- TOC entry 3473 (class 0 OID 0)
-- Dependencies: 188
-- Name: uscite_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite_grp FROM PUBLIC;
REVOKE ALL ON TABLE uscite_grp FROM postgres;
GRANT ALL ON TABLE uscite_grp TO postgres;
GRANT ALL ON TABLE uscite_grp TO scuola247_manager;


--
-- TOC entry 3475 (class 0 OID 0)
-- Dependencies: 189
-- Name: uscite_non_giustificate_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite_non_giustificate_grp FROM PUBLIC;
REVOKE ALL ON TABLE uscite_non_giustificate_grp FROM postgres;
GRANT ALL ON TABLE uscite_non_giustificate_grp TO postgres;
GRANT ALL ON TABLE uscite_non_giustificate_grp TO scuola247_manager;


--
-- TOC entry 3476 (class 0 OID 0)
-- Dependencies: 190
-- Name: classi_alunni_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_alunni_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_alunni_ex FROM postgres;
GRANT ALL ON TABLE classi_alunni_ex TO postgres;
GRANT ALL ON TABLE classi_alunni_ex TO scuola247_manager;


--
-- TOC entry 3477 (class 0 OID 0)
-- Dependencies: 489
-- Name: w_classi_alunni_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classi_alunni_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_classi_alunni_ex() FROM postgres;
GRANT ALL ON FUNCTION w_classi_alunni_ex() TO postgres;
GRANT ALL ON FUNCTION w_classi_alunni_ex() TO scuola247;


--
-- TOC entry 3482 (class 0 OID 0)
-- Dependencies: 191
-- Name: anni_scolastici; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE anni_scolastici FROM PUBLIC;
REVOKE ALL ON TABLE anni_scolastici FROM postgres;
GRANT ALL ON TABLE anni_scolastici TO postgres;
GRANT ALL ON TABLE anni_scolastici TO scuola247_manager;


--
-- TOC entry 3483 (class 0 OID 0)
-- Dependencies: 192
-- Name: classi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi FROM PUBLIC;
REVOKE ALL ON TABLE classi FROM postgres;
GRANT ALL ON TABLE classi TO postgres;
GRANT ALL ON TABLE classi TO scuola247_manager;


--
-- TOC entry 3486 (class 0 OID 0)
-- Dependencies: 193
-- Name: istituti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE istituti FROM PUBLIC;
REVOKE ALL ON TABLE istituti FROM postgres;
GRANT ALL ON TABLE istituti TO scuola247_manager;


--
-- TOC entry 3487 (class 0 OID 0)
-- Dependencies: 194
-- Name: plessi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE plessi FROM PUBLIC;
REVOKE ALL ON TABLE plessi FROM postgres;
GRANT ALL ON TABLE plessi TO postgres;
GRANT ALL ON TABLE plessi TO scuola247_manager;


--
-- TOC entry 3488 (class 0 OID 0)
-- Dependencies: 195
-- Name: classi_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_ex FROM postgres;
GRANT ALL ON TABLE classi_ex TO postgres;
GRANT ALL ON TABLE classi_ex TO scuola247_manager;


--
-- TOC entry 3489 (class 0 OID 0)
-- Dependencies: 464
-- Name: w_classi_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classi_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_classi_ex() FROM postgres;
GRANT ALL ON FUNCTION w_classi_ex() TO postgres;
GRANT ALL ON FUNCTION w_classi_ex() TO scuola247;


--
-- TOC entry 3490 (class 0 OID 0)
-- Dependencies: 196
-- Name: orari_settimanali; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali FROM postgres;
GRANT ALL ON TABLE orari_settimanali TO postgres;
GRANT ALL ON TABLE orari_settimanali TO scuola247_manager;


--
-- TOC entry 3491 (class 0 OID 0)
-- Dependencies: 197
-- Name: orari_settimanali_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_ex FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_ex FROM postgres;
GRANT ALL ON TABLE orari_settimanali_ex TO postgres;
GRANT ALL ON TABLE orari_settimanali_ex TO scuola247_manager;


--
-- TOC entry 3492 (class 0 OID 0)
-- Dependencies: 475
-- Name: w_orari_settimanali_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_orari_settimanali_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_orari_settimanali_ex() FROM postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_ex() TO postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_ex() TO scuola247;


--
-- TOC entry 3493 (class 0 OID 0)
-- Dependencies: 198
-- Name: materie; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE materie FROM PUBLIC;
REVOKE ALL ON TABLE materie FROM postgres;
GRANT ALL ON TABLE materie TO postgres;
GRANT ALL ON TABLE materie TO scuola247_manager;


--
-- TOC entry 3496 (class 0 OID 0)
-- Dependencies: 199
-- Name: orari_settimanali_giorni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_giorni FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_giorni FROM postgres;
GRANT ALL ON TABLE orari_settimanali_giorni TO postgres;
GRANT ALL ON TABLE orari_settimanali_giorni TO scuola247_manager;


--
-- TOC entry 3497 (class 0 OID 0)
-- Dependencies: 200
-- Name: orari_settimanali_giorni_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_giorni_ex FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_giorni_ex FROM postgres;
GRANT ALL ON TABLE orari_settimanali_giorni_ex TO postgres;
GRANT ALL ON TABLE orari_settimanali_giorni_ex TO scuola247_manager;


--
-- TOC entry 3498 (class 0 OID 0)
-- Dependencies: 482
-- Name: w_orari_settimanali_giorni_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_orari_settimanali_giorni_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_orari_settimanali_giorni_ex() FROM postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_giorni_ex() TO postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_giorni_ex() TO scuola247;


--
-- TOC entry 3500 (class 0 OID 0)
-- Dependencies: 556
-- Name: where_sequence(text, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION where_sequence(name text, search_value bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION where_sequence(name text, search_value bigint) FROM postgres;
GRANT ALL ON FUNCTION where_sequence(name text, search_value bigint) TO postgres;
GRANT ALL ON FUNCTION where_sequence(name text, search_value bigint) TO scuola247;


--
-- TOC entry 3502 (class 0 OID 0)
-- Dependencies: 201
-- Name: argomenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE argomenti FROM PUBLIC;
REVOKE ALL ON TABLE argomenti FROM postgres;
GRANT ALL ON TABLE argomenti TO postgres;
GRANT ALL ON TABLE argomenti TO scuola247_manager;


--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 202
-- Name: assenze_certificate_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze_certificate_grp FROM PUBLIC;
REVOKE ALL ON TABLE assenze_certificate_grp FROM postgres;
GRANT ALL ON TABLE assenze_certificate_grp TO postgres;
GRANT ALL ON TABLE assenze_certificate_grp TO scuola247_manager;


--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 203
-- Name: giustificazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE giustificazioni FROM PUBLIC;
REVOKE ALL ON TABLE giustificazioni FROM postgres;
GRANT ALL ON TABLE giustificazioni TO postgres;
GRANT ALL ON TABLE giustificazioni TO scuola247_manager;


--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 204
-- Name: assenze_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze_ex FROM PUBLIC;
REVOKE ALL ON TABLE assenze_ex FROM postgres;
GRANT ALL ON TABLE assenze_ex TO postgres;
GRANT ALL ON TABLE assenze_ex TO scuola247_manager;


--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 205
-- Name: assenze_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE assenze_mese_grp FROM postgres;
GRANT ALL ON TABLE assenze_mese_grp TO postgres;
GRANT ALL ON TABLE assenze_mese_grp TO scuola247_manager;


--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 206
-- Name: persone_indirizzi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone_indirizzi FROM PUBLIC;
REVOKE ALL ON TABLE persone_indirizzi FROM postgres;
GRANT ALL ON TABLE persone_indirizzi TO postgres;
GRANT ALL ON TABLE persone_indirizzi TO scuola247_manager;


--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 207
-- Name: classi_alunni_indirizzi_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_alunni_indirizzi_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_alunni_indirizzi_ex FROM postgres;
GRANT ALL ON TABLE classi_alunni_indirizzi_ex TO postgres;
GRANT ALL ON TABLE classi_alunni_indirizzi_ex TO scuola247_manager;


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 208
-- Name: lezioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lezioni FROM PUBLIC;
REVOKE ALL ON TABLE lezioni FROM postgres;
GRANT ALL ON TABLE lezioni TO postgres;
GRANT ALL ON TABLE lezioni TO scuola247_manager;


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 209
-- Name: classi_docenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_docenti FROM PUBLIC;
REVOKE ALL ON TABLE classi_docenti FROM postgres;
GRANT ALL ON TABLE classi_docenti TO postgres;
GRANT ALL ON TABLE classi_docenti TO scuola247_manager;


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 210
-- Name: firme; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE firme FROM PUBLIC;
REVOKE ALL ON TABLE firme FROM postgres;
GRANT ALL ON TABLE firme TO postgres;
GRANT ALL ON TABLE firme TO scuola247_manager;


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 211
-- Name: firme_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE firme_grp FROM PUBLIC;
REVOKE ALL ON TABLE firme_grp FROM postgres;
GRANT ALL ON TABLE firme_grp TO postgres;
GRANT ALL ON TABLE firme_grp TO scuola247_manager;


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 212
-- Name: fuori_classi_certificati_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi_certificati_grp FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi_certificati_grp FROM postgres;
GRANT ALL ON TABLE fuori_classi_certificati_grp TO postgres;
GRANT ALL ON TABLE fuori_classi_certificati_grp TO scuola247_manager;


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 213
-- Name: lezioni_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lezioni_grp FROM PUBLIC;
REVOKE ALL ON TABLE lezioni_grp FROM postgres;
GRANT ALL ON TABLE lezioni_grp TO postgres;
GRANT ALL ON TABLE lezioni_grp TO scuola247_manager;


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 214
-- Name: note_emesse_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_emesse_grp FROM PUBLIC;
REVOKE ALL ON TABLE note_emesse_grp FROM postgres;
GRANT ALL ON TABLE note_emesse_grp TO postgres;
GRANT ALL ON TABLE note_emesse_grp TO scuola247_manager;


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 215
-- Name: ritardi_certificati_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi_certificati_grp FROM PUBLIC;
REVOKE ALL ON TABLE ritardi_certificati_grp FROM postgres;
GRANT ALL ON TABLE ritardi_certificati_grp TO postgres;
GRANT ALL ON TABLE ritardi_certificati_grp TO scuola247_manager;


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 216
-- Name: uscite_certificate_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite_certificate_grp FROM PUBLIC;
REVOKE ALL ON TABLE uscite_certificate_grp FROM postgres;
GRANT ALL ON TABLE uscite_certificate_grp TO postgres;
GRANT ALL ON TABLE uscite_certificate_grp TO scuola247_manager;


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 217
-- Name: classi_docenti_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_docenti_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_docenti_ex FROM postgres;
GRANT ALL ON TABLE classi_docenti_ex TO postgres;
GRANT ALL ON TABLE classi_docenti_ex TO scuola247_manager;


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 218
-- Name: classi_docenti_materia; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_docenti_materia FROM PUBLIC;
REVOKE ALL ON TABLE classi_docenti_materia FROM postgres;
GRANT ALL ON TABLE classi_docenti_materia TO postgres;
GRANT ALL ON TABLE classi_docenti_materia TO scuola247_manager;


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 219
-- Name: colloqui; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE colloqui FROM PUBLIC;
REVOKE ALL ON TABLE colloqui FROM postgres;
GRANT ALL ON TABLE colloqui TO postgres;
GRANT ALL ON TABLE colloqui TO scuola247_manager;


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 220
-- Name: conversazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE conversazioni FROM PUBLIC;
REVOKE ALL ON TABLE conversazioni FROM postgres;
GRANT ALL ON TABLE conversazioni TO postgres;
GRANT ALL ON TABLE conversazioni TO scuola247_manager;


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 221
-- Name: conversazioni_invitati; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE conversazioni_invitati FROM PUBLIC;
REVOKE ALL ON TABLE conversazioni_invitati FROM postgres;
GRANT ALL ON TABLE conversazioni_invitati TO postgres;
GRANT ALL ON TABLE conversazioni_invitati TO scuola247_manager;


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 222
-- Name: docenti_lezioni_firme_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE docenti_lezioni_firme_ex FROM PUBLIC;
REVOKE ALL ON TABLE docenti_lezioni_firme_ex FROM postgres;
GRANT ALL ON TABLE docenti_lezioni_firme_ex TO postgres;
GRANT ALL ON TABLE docenti_lezioni_firme_ex TO scuola247_manager;


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 223
-- Name: festivi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE festivi FROM PUBLIC;
REVOKE ALL ON TABLE festivi FROM postgres;
GRANT ALL ON TABLE festivi TO postgres;
GRANT ALL ON TABLE festivi TO scuola247_manager;


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 224
-- Name: firme_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE firme_ex FROM PUBLIC;
REVOKE ALL ON TABLE firme_ex FROM postgres;
GRANT ALL ON TABLE firme_ex TO postgres;
GRANT ALL ON TABLE firme_ex TO scuola247_manager;


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 225
-- Name: fuori_classi_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi_ex FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi_ex FROM postgres;
GRANT ALL ON TABLE fuori_classi_ex TO postgres;
GRANT ALL ON TABLE fuori_classi_ex TO scuola247_manager;


--
-- TOC entry 3552 (class 0 OID 0)
-- Dependencies: 226
-- Name: fuori_classi_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi_mese_grp FROM postgres;
GRANT ALL ON TABLE fuori_classi_mese_grp TO postgres;
GRANT ALL ON TABLE fuori_classi_mese_grp TO scuola247_manager;


--
-- TOC entry 3553 (class 0 OID 0)
-- Dependencies: 227
-- Name: immagine_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE immagine_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE immagine_seq FROM postgres;
GRANT ALL ON SEQUENCE immagine_seq TO postgres;
GRANT ALL ON SEQUENCE immagine_seq TO scuola247_manager;


--
-- TOC entry 3555 (class 0 OID 0)
-- Dependencies: 228
-- Name: indirizzi_scolastici; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE indirizzi_scolastici FROM PUBLIC;
REVOKE ALL ON TABLE indirizzi_scolastici FROM postgres;
GRANT ALL ON TABLE indirizzi_scolastici TO postgres;
GRANT ALL ON TABLE indirizzi_scolastici TO scuola247_manager;


--
-- TOC entry 3556 (class 0 OID 0)
-- Dependencies: 229
-- Name: istituti_anni_scolastici_classi_orari_settimanali; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali FROM PUBLIC;
REVOKE ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali FROM postgres;
GRANT ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali TO postgres;
GRANT ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali TO scuola247_manager;


--
-- TOC entry 3557 (class 0 OID 0)
-- Dependencies: 230
-- Name: lezioni_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lezioni_ex FROM PUBLIC;
REVOKE ALL ON TABLE lezioni_ex FROM postgres;
GRANT ALL ON TABLE lezioni_ex TO postgres;
GRANT ALL ON TABLE lezioni_ex TO scuola247_manager;


--
-- TOC entry 3558 (class 0 OID 0)
-- Dependencies: 231
-- Name: lezioni_giorni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lezioni_giorni FROM PUBLIC;
REVOKE ALL ON TABLE lezioni_giorni FROM postgres;
GRANT ALL ON TABLE lezioni_giorni TO postgres;
GRANT ALL ON TABLE lezioni_giorni TO scuola247_manager;


--
-- TOC entry 3560 (class 0 OID 0)
-- Dependencies: 232
-- Name: mancanze; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE mancanze FROM PUBLIC;
REVOKE ALL ON TABLE mancanze FROM postgres;
GRANT ALL ON TABLE mancanze TO postgres;
GRANT ALL ON TABLE mancanze TO scuola247_manager;


--
-- TOC entry 3562 (class 0 OID 0)
-- Dependencies: 233
-- Name: mancanze_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE mancanze_grp FROM PUBLIC;
REVOKE ALL ON TABLE mancanze_grp FROM postgres;
GRANT ALL ON TABLE mancanze_grp TO postgres;
GRANT ALL ON TABLE mancanze_grp TO scuola247_manager;


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 234
-- Name: messaggi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi FROM PUBLIC;
REVOKE ALL ON TABLE messaggi FROM postgres;
GRANT ALL ON TABLE messaggi TO postgres;
GRANT ALL ON TABLE messaggi TO scuola247_manager;


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 235
-- Name: messaggi_letti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi_letti FROM PUBLIC;
REVOKE ALL ON TABLE messaggi_letti FROM postgres;
GRANT ALL ON TABLE messaggi_letti TO postgres;
GRANT ALL ON TABLE messaggi_letti TO scuola247_manager;


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 236
-- Name: messaggi_sistema; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi_sistema FROM PUBLIC;
REVOKE ALL ON TABLE messaggi_sistema FROM postgres;
GRANT ALL ON TABLE messaggi_sistema TO postgres;
GRANT ALL ON TABLE messaggi_sistema TO scuola247_manager;


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 237
-- Name: metriche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE metriche FROM PUBLIC;
REVOKE ALL ON TABLE metriche FROM postgres;
GRANT ALL ON TABLE metriche TO postgres;
GRANT ALL ON TABLE metriche TO scuola247_manager;


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 238
-- Name: mezzi_comunicazione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE mezzi_comunicazione FROM PUBLIC;
REVOKE ALL ON TABLE mezzi_comunicazione FROM postgres;
GRANT ALL ON TABLE mezzi_comunicazione TO postgres;
GRANT ALL ON TABLE mezzi_comunicazione TO scuola247_manager;


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 239
-- Name: nazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE nazioni FROM PUBLIC;
REVOKE ALL ON TABLE nazioni FROM postgres;
GRANT ALL ON TABLE nazioni TO postgres;
GRANT ALL ON TABLE nazioni TO scuola247_manager;


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 240
-- Name: note_docenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_docenti FROM PUBLIC;
REVOKE ALL ON TABLE note_docenti FROM postgres;
GRANT ALL ON TABLE note_docenti TO postgres;
GRANT ALL ON TABLE note_docenti TO scuola247_manager;


--
-- TOC entry 3575 (class 0 OID 0)
-- Dependencies: 241
-- Name: note_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_ex FROM PUBLIC;
REVOKE ALL ON TABLE note_ex FROM postgres;
GRANT ALL ON TABLE note_ex TO postgres;
GRANT ALL ON TABLE note_ex TO scuola247_manager;


--
-- TOC entry 3576 (class 0 OID 0)
-- Dependencies: 242
-- Name: note_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE note_mese_grp FROM postgres;
GRANT ALL ON TABLE note_mese_grp TO postgres;
GRANT ALL ON TABLE note_mese_grp TO scuola247_manager;


--
-- TOC entry 3579 (class 0 OID 0)
-- Dependencies: 243
-- Name: note_visti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_visti FROM PUBLIC;
REVOKE ALL ON TABLE note_visti FROM postgres;
GRANT ALL ON TABLE note_visti TO postgres;
GRANT ALL ON TABLE note_visti TO scuola247_manager;


--
-- TOC entry 3580 (class 0 OID 0)
-- Dependencies: 244
-- Name: note_visti_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_visti_ex FROM PUBLIC;
REVOKE ALL ON TABLE note_visti_ex FROM postgres;
GRANT ALL ON TABLE note_visti_ex TO postgres;
GRANT ALL ON TABLE note_visti_ex TO scuola247_manager;


--
-- TOC entry 3581 (class 0 OID 0)
-- Dependencies: 245
-- Name: orari_settimanali_docenti_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_docenti_ex FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_docenti_ex FROM postgres;
GRANT ALL ON TABLE orari_settimanali_docenti_ex TO postgres;
GRANT ALL ON TABLE orari_settimanali_docenti_ex TO scuola247_manager;


--
-- TOC entry 3585 (class 0 OID 0)
-- Dependencies: 246
-- Name: persone_relazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone_relazioni FROM PUBLIC;
REVOKE ALL ON TABLE persone_relazioni FROM postgres;
GRANT ALL ON TABLE persone_relazioni TO postgres;
GRANT ALL ON TABLE persone_relazioni TO scuola247_manager;


--
-- TOC entry 3586 (class 0 OID 0)
-- Dependencies: 247
-- Name: persone_ruoli; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone_ruoli FROM PUBLIC;
REVOKE ALL ON TABLE persone_ruoli FROM postgres;
GRANT ALL ON TABLE persone_ruoli TO postgres;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 248
-- Name: provincie; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE provincie FROM PUBLIC;
REVOKE ALL ON TABLE provincie FROM postgres;
GRANT ALL ON TABLE provincie TO postgres;
GRANT ALL ON TABLE provincie TO scuola247_manager;


--
-- TOC entry 3590 (class 0 OID 0)
-- Dependencies: 249
-- Name: qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE qualifiche FROM postgres;
GRANT ALL ON TABLE qualifiche TO postgres;
GRANT ALL ON TABLE qualifiche TO scuola247_manager;


--
-- TOC entry 3592 (class 0 OID 0)
-- Dependencies: 250
-- Name: qualifiche_pof; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE qualifiche_pof FROM PUBLIC;
REVOKE ALL ON TABLE qualifiche_pof FROM postgres;
GRANT ALL ON TABLE qualifiche_pof TO postgres;
GRANT ALL ON TABLE qualifiche_pof TO scuola247_manager;


--
-- TOC entry 3593 (class 0 OID 0)
-- Dependencies: 251
-- Name: regioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE regioni FROM PUBLIC;
REVOKE ALL ON TABLE regioni FROM postgres;
GRANT ALL ON TABLE regioni TO postgres;
GRANT ALL ON TABLE regioni TO scuola247_manager;


--
-- TOC entry 3595 (class 0 OID 0)
-- Dependencies: 252
-- Name: ritardi_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE ritardi_mese_grp FROM postgres;
GRANT ALL ON TABLE ritardi_mese_grp TO postgres;
GRANT ALL ON TABLE ritardi_mese_grp TO scuola247_manager;


--
-- TOC entry 3596 (class 0 OID 0)
-- Dependencies: 253
-- Name: uscite_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE uscite_mese_grp FROM postgres;
GRANT ALL ON TABLE uscite_mese_grp TO postgres;
GRANT ALL ON TABLE uscite_mese_grp TO scuola247_manager;


--
-- TOC entry 3597 (class 0 OID 0)
-- Dependencies: 254
-- Name: registro_di_classe_mese_grp; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE registro_di_classe_mese_grp FROM PUBLIC;
REVOKE ALL ON TABLE registro_di_classe_mese_grp FROM postgres;
GRANT ALL ON TABLE registro_di_classe_mese_grp TO postgres;
GRANT ALL ON TABLE registro_di_classe_mese_grp TO scuola247_manager;


--
-- TOC entry 3598 (class 0 OID 0)
-- Dependencies: 255
-- Name: residenza_grp_comune; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE residenza_grp_comune FROM PUBLIC;
REVOKE ALL ON TABLE residenza_grp_comune FROM postgres;
GRANT ALL ON TABLE residenza_grp_comune TO postgres;
GRANT ALL ON TABLE residenza_grp_comune TO scuola247_manager;


--
-- TOC entry 3599 (class 0 OID 0)
-- Dependencies: 256
-- Name: ritardi_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi_ex FROM PUBLIC;
REVOKE ALL ON TABLE ritardi_ex FROM postgres;
GRANT ALL ON TABLE ritardi_ex TO postgres;
GRANT ALL ON TABLE ritardi_ex TO scuola247_manager;


--
-- TOC entry 3602 (class 0 OID 0)
-- Dependencies: 257
-- Name: scrutini; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini FROM PUBLIC;
REVOKE ALL ON TABLE scrutini FROM postgres;
GRANT ALL ON TABLE scrutini TO postgres;
GRANT ALL ON TABLE scrutini TO scuola247_manager;


--
-- TOC entry 3608 (class 0 OID 0)
-- Dependencies: 258
-- Name: scrutini_valutazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini_valutazioni FROM PUBLIC;
REVOKE ALL ON TABLE scrutini_valutazioni FROM postgres;
GRANT ALL ON TABLE scrutini_valutazioni TO postgres;
GRANT ALL ON TABLE scrutini_valutazioni TO scuola247_manager;


--
-- TOC entry 3609 (class 0 OID 0)
-- Dependencies: 259
-- Name: scrutini_valutazioni_qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini_valutazioni_qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE scrutini_valutazioni_qualifiche FROM postgres;
GRANT ALL ON TABLE scrutini_valutazioni_qualifiche TO postgres;
GRANT ALL ON TABLE scrutini_valutazioni_qualifiche TO scuola247_manager;


--
-- TOC entry 3610 (class 0 OID 0)
-- Dependencies: 260
-- Name: spazi_lavoro; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE spazi_lavoro FROM PUBLIC;
REVOKE ALL ON TABLE spazi_lavoro FROM postgres;
GRANT ALL ON TABLE spazi_lavoro TO postgres;
GRANT ALL ON TABLE spazi_lavoro TO scuola247_manager;


--
-- TOC entry 3615 (class 0 OID 0)
-- Dependencies: 263
-- Name: tipi_comunicazione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipi_comunicazione FROM PUBLIC;
REVOKE ALL ON TABLE tipi_comunicazione FROM postgres;
GRANT ALL ON TABLE tipi_comunicazione TO postgres;
GRANT ALL ON TABLE tipi_comunicazione TO scuola247_manager;


--
-- TOC entry 3616 (class 0 OID 0)
-- Dependencies: 264
-- Name: tipi_voto; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipi_voto FROM PUBLIC;
REVOKE ALL ON TABLE tipi_voto FROM postgres;
GRANT ALL ON TABLE tipi_voto TO postgres;
GRANT ALL ON TABLE tipi_voto TO scuola247_manager;


--
-- TOC entry 3617 (class 0 OID 0)
-- Dependencies: 265
-- Name: uscite_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite_ex FROM PUBLIC;
REVOKE ALL ON TABLE uscite_ex FROM postgres;
GRANT ALL ON TABLE uscite_ex TO postgres;
GRANT ALL ON TABLE uscite_ex TO scuola247_manager;


--
-- TOC entry 3618 (class 0 OID 0)
-- Dependencies: 266
-- Name: usenames_rolnames; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE usenames_rolnames FROM PUBLIC;
REVOKE ALL ON TABLE usenames_rolnames FROM postgres;
GRANT ALL ON TABLE usenames_rolnames TO postgres;
GRANT ALL ON TABLE usenames_rolnames TO scuola247_manager;


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 267
-- Name: utenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE utenti FROM PUBLIC;
REVOKE ALL ON TABLE utenti FROM postgres;
GRANT ALL ON TABLE utenti TO postgres;
GRANT ALL ON TABLE utenti TO scuola247_manager;


--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 268
-- Name: valutazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE valutazioni FROM PUBLIC;
REVOKE ALL ON TABLE valutazioni FROM postgres;
GRANT ALL ON TABLE valutazioni TO postgres;
GRANT ALL ON TABLE valutazioni TO scuola247_manager;


--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 269
-- Name: voti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE voti FROM PUBLIC;
REVOKE ALL ON TABLE voti FROM postgres;
GRANT ALL ON TABLE voti TO postgres;
GRANT ALL ON TABLE voti TO scuola247_manager;


--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 270
-- Name: valutazioni_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE valutazioni_ex FROM PUBLIC;
REVOKE ALL ON TABLE valutazioni_ex FROM postgres;
GRANT ALL ON TABLE valutazioni_ex TO postgres;
GRANT ALL ON TABLE valutazioni_ex TO scuola247_manager;


--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 271
-- Name: valutazioni_qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE valutazioni_qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE valutazioni_qualifiche FROM postgres;
GRANT ALL ON TABLE valutazioni_qualifiche TO postgres;
GRANT ALL ON TABLE valutazioni_qualifiche TO scuola247_manager;


-- Completed on 2014-05-30 19:19:21

--
-- PostgreSQL database dump complete
--

