--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.0
-- Dumped by pg_dump version 9.3.2
-- Started on 2014-04-19 09:37:02

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 268 (class 3079 OID 11750)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2977 (class 0 OID 0)
-- Dependencies: 268
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 269 (class 3079 OID 2390005)
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS tablefunc WITH SCHEMA public;


--
-- TOC entry 2978 (class 0 OID 0)
-- Dependencies: 269
-- Name: EXTENSION tablefunc; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION tablefunc IS 'functions that manipulate whole tables, including crosstab';


SET search_path = public, pg_catalog;

--
-- TOC entry 706 (class 1247 OID 2228221)
-- Name: anno_corso; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN anno_corso AS smallint
	CONSTRAINT anno_corso_range CHECK (((VALUE >= 1) AND (VALUE <= 6)));


ALTER DOMAIN public.anno_corso OWNER TO postgres;

--
-- TOC entry 708 (class 1247 OID 2228223)
-- Name: giorno_settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN giorno_settimana AS smallint
	CONSTRAINT giorno_settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN public.giorno_settimana OWNER TO postgres;

--
-- TOC entry 923 (class 1247 OID 2459553)
-- Name: id_version; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE id_version AS (
	id bigint,
	version bigint
);


ALTER TYPE public.id_version OWNER TO postgres;

--
-- TOC entry 710 (class 1247 OID 2228226)
-- Name: lingue; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE lingue AS ENUM (
    'it',
    'en',
    'de'
);


ALTER TYPE public.lingue OWNER TO postgres;

--
-- TOC entry 713 (class 1247 OID 2228245)
-- Name: periodo_lezione; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN periodo_lezione AS smallint
	CONSTRAINT periodo_lezione_range CHECK (((VALUE >= 1) AND (VALUE <= 24)));


ALTER DOMAIN public.periodo_lezione OWNER TO postgres;

--
-- TOC entry 1028 (class 1247 OID 2798034)
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
-- TOC entry 715 (class 1247 OID 2228248)
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
-- TOC entry 718 (class 1247 OID 2228260)
-- Name: ruolo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ruolo AS ENUM (
    'Alunno',
    'Impiegato',
    'Dirigente',
    'Docente',
    'Famigliare',
    'Gestore sistema'
);


ALTER TYPE public.ruolo OWNER TO postgres;

--
-- TOC entry 721 (class 1247 OID 2228272)
-- Name: sesso; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sesso AS ENUM (
    'M',
    'F'
);


ALTER TYPE public.sesso OWNER TO postgres;

--
-- TOC entry 724 (class 1247 OID 2228277)
-- Name: settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN settimana AS smallint
	CONSTRAINT settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 4)));


ALTER DOMAIN public.settimana OWNER TO postgres;

--
-- TOC entry 726 (class 1247 OID 2228280)
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
-- TOC entry 907 (class 1247 OID 2797990)
-- Name: tipo_giustificazione; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_giustificazione AS ENUM (
    'assenza',
    'ritardo',
    'uscita'
);


ALTER TYPE public.tipo_giustificazione OWNER TO postgres;

--
-- TOC entry 729 (class 1247 OID 2228290)
-- Name: tipo_indirizzo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_indirizzo AS ENUM (
    'Domicilio',
    'Lavoro',
    'Residenza'
);


ALTER TYPE public.tipo_indirizzo OWNER TO postgres;

--
-- TOC entry 732 (class 1247 OID 2228298)
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
-- TOC entry 735 (class 1247 OID 2228306)
-- Name: tipo_soggetto; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_soggetto AS ENUM (
    'Persona fisica',
    'Persona giuridica'
);


ALTER TYPE public.tipo_soggetto OWNER TO postgres;

--
-- TOC entry 362 (class 1255 OID 3237250)
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
	IF has_rolname('gestori') OR has_rolname('dirigenti') OR has_rolname('docenti')   THEN
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

	ELSEIF has_rolname('famigliari') THEN
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

	ELSEIF has_rolname('alunni') THEN
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
-- TOC entry 338 (class 1255 OID 2561951)
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
-- TOC entry 322 (class 1255 OID 2561952)
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
-- TOC entry 339 (class 1255 OID 2563472)
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
-- TOC entry 340 (class 1255 OID 2563499)
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

	OPEN cur FOR SELECT a.xmin::text::bigint AS rv, a.anno_scolastico, a.istituto, a.descrizione, a.inizio, a.fine, a.inizio_lezioni, a.fine_lezioni 
		       FROM istituti i 
		 INNER JOIN public.utenti_istituti ui ON ( i.istituto = ui.istituto  )  
	         INNER JOIN public.utenti u ON ( ui.utente = u.utente  )  
		 INNER JOIN public.anni_scolastici a ON ( i.istituto = a.istituto  )  
		      WHERE i.istituto = p_istituto
		        AND u.usename = session_user;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.anni_scolastici_list(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 341 (class 1255 OID 2563464)
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
-- TOC entry 342 (class 1255 OID 2561947)
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
-- TOC entry 343 (class 1255 OID 2563468)
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
-- TOC entry 361 (class 1255 OID 2797591)
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
--		       encode(foto_miniatura,'base64') as foto_miniatura,
		       foto_miniatura,
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
-- TOC entry 344 (class 1255 OID 2561977)
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
-- TOC entry 345 (class 1255 OID 2561978)
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
-- TOC entry 346 (class 1255 OID 2562627)
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

	OPEN cur FOR SELECT c.xmin::text::bigint AS rv, c.classe, c.anno_scolastico, c.indirizzo_scolastico, c.sezione, c.anno_corso, c.descrizione, c.plesso
		       FROM istituti i 
		 INNER JOIN public.utenti_istituti ui ON ( i.istituto = ui.istituto  )  
	         INNER JOIN public.utenti u ON ( ui.utente = u.utente  )  
	         INNER JOIN public.anni_scolastici a ON ( i.istituto = a.istituto  )  
	         INNER JOIN public.classi c ON ( a.anno_scolastico = c.anno_scolastico  )  
	              WHERE a.anno_scolastico = p_anno_scolastico
			AND u.usename = session_user;

	RETURN cur;
END;
$$;


ALTER FUNCTION public.classi_list(p_anno_scolastico bigint) OWNER TO postgres;

--
-- TOC entry 348 (class 1255 OID 2561969)
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
-- TOC entry 349 (class 1255 OID 2561973)
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
-- TOC entry 359 (class 1255 OID 2228311)
-- Name: delete_istituto(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete_istituto(istituto_da_cancellare bigint) RETURNS TABLE(table_name character varying, record_deleted bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
declare
     rowcount bigint;
begin 

delete from utenti_istituti where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'utenti_istituti ....................... : % righe cancellate', rowcount;
table_name := 'utenti_istituti';
record_deleted := rowcount;
return next;

delete from spazi_lavoro where istituto = istituto_da_cancellare; 
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'spazi_lavoro .......................... : % righe cancellate', rowcount;
table_name := 'spazi_lavoro';
record_deleted := rowcount;
return next;

delete from conversazioni
      using classi_alunni, classi, anni_scolastici
      where classi_alunni.classe_alunno = conversazioni.libretto
        and classi_alunni.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'conversazioni ......................... : % righe cancellate', rowcount;
table_name := 'conversazioni';
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

delete from firme
      using persone
      where firme.docente = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'firme ................................. : % righe cancellate', rowcount;
table_name := 'firme';
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

delete from mancanze
      using persone
      where mancanze.alunno = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'mancanze .............................. : % righe cancellate', rowcount;
table_name := 'mancanze';
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

delete from indirizzi
      where indirizzo not in (select indirizzo from persone_indirizzi);
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'indirizzi ............................. : % righe cancellate', rowcount;
table_name := 'indirizzi';
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

delete from qualifiche
      where istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'qualifiche ............................ : % righe cancellate', rowcount;
table_name := 'qualifiche';
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


ALTER FUNCTION public.delete_istituto(istituto_da_cancellare bigint) OWNER TO postgres;

--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 359
-- Name: FUNCTION delete_istituto(istituto_da_cancellare bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION delete_istituto(istituto_da_cancellare bigint) IS 'Il comando prende in input il codice di un istituto e cancella tutti i record di tutte le tabelle collegate all''istituto';


--
-- TOC entry 358 (class 1255 OID 3237249)
-- Name: docenti_by_istituto(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION docenti_by_istituto(p_istituto bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
   OPEN cur FOR SELECT persona AS docente,
		       cognome,
		       nome,
		       codice_fiscale,
		       foto_miniatura
--		       encode(foto_miniatura,'base64') as foto_miniatura
		  FROM persone
		 WHERE istituto = p_istituto
		   AND ruolo = 'Docente'
	      ORDER BY cognome, nome, codice_fiscale;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.docenti_by_istituto(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 363 (class 1255 OID 3245447)
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
	IF has_rolnames('{"gestori","dirigenti","docenti"}')  THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       p.foto_miniatura
	--		       encode(foto_miniatura,'base64') as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
		          JOIN persone p ON rel.persona_relazionata = p.persona
			 WHERE ca.classe = p_classe
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF has_rolname('famigliari') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       p.foto_miniatura
	--		       encode(foto_miniatura,'base64') as foto_miniatura
			  FROM classi_alunni ca 
		          JOIN persone_relazioni rel ON ca.alunno = rel.persona
		          JOIN persone p ON rel.persona_relazionata = p.persona
			 WHERE ca.classe = p_classe
			   AND rel.persona_relazionata = session_utente()
		      ORDER BY cognome, nome, codice_fiscale;

	ELSEIF has_rolname('alunni') THEN
		OPEN cur FOR SELECT p.persona AS alunno,
			       p.cognome,
			       p.nome,
			       p.codice_fiscale,
			       p.foto_miniatura
	--		       encode(foto_miniatura,'base64') as foto_miniatura
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
-- TOC entry 354 (class 1255 OID 2798401)
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
-- TOC entry 298 (class 1255 OID 2407193)
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
  IF p_function = 'tr_utenti_istituti_iu' THEN RETURN 'UM17'|| p_id; END IF;
  IF p_function = 'tr_scrutini_valutazioni_qualifiche_iu' THEN RETURN 'UM18'|| p_id; END IF;
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
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 298
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
funzione, dove viene generati l''errore, in caso la funzione ne abbia più di uno.
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
-- TOC entry 357 (class 1255 OID 3245417)
-- Name: has_rolname(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION has_rolname(p_rolname character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	PERFORM 1 FROM usenames_rolnames WHERE usename = session_user AND rolname = p_rolname;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.has_rolname(p_rolname character varying) OWNER TO postgres;

--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION has_rolname(p_rolname character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION has_rolname(p_rolname character varying) IS 'Il comando  restituisce TRUE o FALSE a seconda se l''utente collegato è abilitato al ruolo indicato in input';


--
-- TOC entry 371 (class 1255 OID 3245698)
-- Name: has_rolname(character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION has_rolname(p_rolname character varying, p_persona bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM usenames_rolnames usenames
		  JOIN utenti u ON usenames.usename = u.usename
		  JOIN utenti_istituti ui  ON u.utente = ui.utente 
	         WHERE usenames.rolname = p_rolname
	           AND ui.persona = p_persona;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.has_rolname(p_rolname character varying, p_persona bigint) OWNER TO postgres;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION has_rolname(p_rolname character varying, p_persona bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION has_rolname(p_rolname character varying, p_persona bigint) IS 'Il comando  restituisce TRUE o FALSE a seconda se la persona indicata in input è abilitata al ruolo indicato in input';


--
-- TOC entry 365 (class 1255 OID 3245659)
-- Name: has_rolname(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION has_rolname(p_rolname character varying, p_usename character varying) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM usenames_rolnames WHERE usename = p_usename AND rolname = p_rolname;
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.has_rolname(p_rolname character varying, p_usename character varying) OWNER TO postgres;

--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 365
-- Name: FUNCTION has_rolname(p_rolname character varying, p_usename character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION has_rolname(p_rolname character varying, p_usename character varying) IS 'Il comando  restituisce TRUE o FALSE a seconda se l''utente indicato è abilitato al ruolo indicato in input';


--
-- TOC entry 316 (class 1255 OID 3245838)
-- Name: has_rolnames(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION has_rolnames(p_rolname character varying[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
BEGIN 

	PERFORM 1 FROM usenames_rolnames 
	         WHERE usename = session_user 
	           AND rolname = ANY(p_rolname);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.has_rolnames(p_rolname character varying[]) OWNER TO postgres;

--
-- TOC entry 370 (class 1255 OID 3245697)
-- Name: has_rolnames(character varying[], bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION has_rolnames(p_rolnames character varying[], p_persona bigint) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN 

	PERFORM 1 FROM usenames_rolnames usenames
		  JOIN utenti u ON usenames.usename = u.usename
		  JOIN utenti_istituti ui  ON u.utente = ui.utente 
	         WHERE ui.persona = p_persona
	           AND usenames.rolname = ANY(p_rolnames);
	RETURN FOUND;
END;
$$;


ALTER FUNCTION public.has_rolnames(p_rolnames character varying[], p_persona bigint) OWNER TO postgres;

--
-- TOC entry 297 (class 1255 OID 2406526)
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
-- TOC entry 319 (class 1255 OID 2228313)
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
-- TOC entry 333 (class 1255 OID 2553190)
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
-- TOC entry 321 (class 1255 OID 2553111)
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
-- TOC entry 324 (class 1255 OID 2562223)
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
                 FROM public.istituti i 
	   INNER JOIN public.utenti_istituti ui ON ( i.istituto = ui.istituto  )  
	   INNER JOIN public.utenti u ON ( ui.utente = u.utente  )  
	        WHERE u.usename = session_user;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.istituti_list() OWNER TO postgres;

--
-- TOC entry 334 (class 1255 OID 2553139)
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
-- TOC entry 305 (class 1255 OID 2501997)
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
-- TOC entry 335 (class 1255 OID 2553194)
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
-- TOC entry 336 (class 1255 OID 2553152)
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
-- TOC entry 337 (class 1255 OID 2502064)
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
-- TOC entry 355 (class 1255 OID 2798402)
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
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION lezioni_by_docente_classe_materia(p_docente bigint, p_classe bigint, p_materia bigint) IS 'Dato un docente, una classe ed una materia ritona l''elenco delle lezioni';


--
-- TOC entry 347 (class 1255 OID 2561964)
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
-- TOC entry 302 (class 1255 OID 2563484)
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
-- TOC entry 308 (class 1255 OID 2561965)
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
-- TOC entry 350 (class 1255 OID 2563536)
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

	OPEN cur FOR SELECT m.xmin::text::bigint AS rv, m.materia, m.istituto, m.descrizione
		       FROM istituti i 
	         INNER JOIN public.utenti_istituti ui ON ( i.istituto = ui.istituto  )  
		 INNER JOIN public.utenti u ON ( ui.utente = u.utente  )  
	         INNER JOIN public.materie m ON ( i.istituto = m.istituto  )
	              WHERE i.istituto = p_istituto
		        AND u.usename = session_user;
	RETURN cur;
END;
$$;


ALTER FUNCTION public.materie_list(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 326 (class 1255 OID 2563476)
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
-- TOC entry 327 (class 1255 OID 2563480)
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
-- TOC entry 351 (class 1255 OID 2561960)
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
-- TOC entry 304 (class 1255 OID 2228317)
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
-- TOC entry 3013 (class 0 OID 0)
-- Dependencies: 304
-- Name: FUNCTION max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION max_sequence(name text) IS 'Restituisce una tabella con le seguenti colonne: table_catalog, table_schema, table_name, column_name, max_value popolandola con una riga per ogni colonna del database che contiena una clausola default uguale a: "nextval(''<name>''::regclass)"  (dove il <name> si intende sostitutito dal parametro name passato alla funzione nel momento in cui viene richiamata) abbinandola al valore massimo contenuto dalla colonna.';


--
-- TOC entry 352 (class 1255 OID 2407208)
-- Name: messaggi_sistema_locale(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  msg varchar;
  lng public.lingue;
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
-- TOC entry 300 (class 1255 OID 2484337)
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
-- TOC entry 283 (class 1255 OID 2390029)
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
-- TOC entry 284 (class 1255 OID 2390032)
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
-- TOC entry 328 (class 1255 OID 2569452)
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
-- TOC entry 306 (class 1255 OID 2536927)
-- Name: persone_sel_foto_miniatura(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persone_sel_foto_miniatura(p_persona bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  m_foto_miniatura bytea;
  function_name varchar = 'persone_sel_foto_miniatura';
BEGIN 
  SELECT foto_miniatura INTO m_foto_miniatura 
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
  RETURN m_foto_miniatura;
 END;
$$;


ALTER FUNCTION public.persone_sel_foto_miniatura(p_persona bigint) OWNER TO postgres;

--
-- TOC entry 303 (class 1255 OID 2544890)
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
-- TOC entry 360 (class 1255 OID 3245416)
-- Name: rolnames_by_session_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION rolnames_by_session_user() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
DECLARE
  cur refcursor;
BEGIN 
  OPEN cur FOR SELECT rolname
                 FROM usenames_rolnames
                WHERE usename = session_user;
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.rolnames_by_session_user() OWNER TO postgres;

--
-- TOC entry 325 (class 1255 OID 3237263)
-- Name: session_persona(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_persona(p_istituto bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
declare
	v_persona bigint;
begin 

	SELECT ui.persona INTO v_persona
	  FROM utenti_istituti ui
          JOIN utenti u ON u.utente = ui.utente
         WHERE u.usename = session_user
           AND ui.istituto = p_istituto;

	return v_persona;

 end;
$$;


ALTER FUNCTION public.session_persona(p_istituto bigint) OWNER TO postgres;

--
-- TOC entry 3023 (class 0 OID 0)
-- Dependencies: 325
-- Name: FUNCTION session_persona(p_istituto bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_persona(p_istituto bigint) IS 'Il comando  restituisce la persona dell''utente collegato a seconda dell''istituto passato come parametro';


--
-- TOC entry 329 (class 1255 OID 2563539)
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
-- TOC entry 3024 (class 0 OID 0)
-- Dependencies: 329
-- Name: FUNCTION session_utente(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION session_utente() IS 'Il comando  restituisce l''utente collegato';


--
-- TOC entry 289 (class 1255 OID 2228319)
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
-- TOC entry 3026 (class 0 OID 0)
-- Dependencies: 289
-- Name: FUNCTION set_max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION set_max_sequence(name text) IS 'Il comando prende il valore massimo fra quelli restitutiti dalla funzione max_sequence, richiamata con il parametro ricevuti in input, e lo imposta nella sequenza il cui nome riceve come parametro di input nella chiamata';


--
-- TOC entry 317 (class 1255 OID 2798414)
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
-- TOC entry 299 (class 1255 OID 2526609)
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
-- TOC entry 364 (class 1255 OID 3245596)
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
-- TOC entry 366 (class 1255 OID 2553083)
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
		WHERE u.usename = session_user;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.spazi_lavoro_list() OWNER TO postgres;

--
-- TOC entry 356 (class 1255 OID 2798052)
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
-- TOC entry 282 (class 1255 OID 2407191)
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
-- TOC entry 323 (class 1255 OID 3237243)
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
-- TOC entry 320 (class 1255 OID 3237241)
-- Name: tr_assenze_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_assenze_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_assenze_iu';
BEGIN
--
-- controllo che nel giorno dell'assenza ci sia almeno una lezione
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
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.giorno, new.assenza,  new.alunno),
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
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_assenze_iu() OWNER TO postgres;

--
-- TOC entry 367 (class 1255 OID 3245610)
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
-- TOC entry 369 (class 1255 OID 3245597)
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
	PERFORM 1 FROM anno_scolastico a
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
-- TOC entry 368 (class 1255 OID 3245621)
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
-- TOC entry 310 (class 1255 OID 3245644)
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
-- TOC entry 372 (class 1255 OID 3245653)
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
	IF NOT has_rolenames('{"dirigenti","docenti"}',new.docente) THEN
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
-- TOC entry 309 (class 1255 OID 2796493)
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
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_mezzi_comunicazione_iu() OWNER TO postgres;

--
-- TOC entry 312 (class 1255 OID 2798057)
-- Name: tr_note_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_note_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_delete_visti boolean := FALSE;
	v_insert_visti boolean := FALSE;
BEGIN
	IF TG_OP = 'INSERT' THEN
		IF new.da_vistare = TRUE THEN
			v_insert_visti := TRUE;
		END IF;
	END IF;
	IF TG_OP = 'UPDATE' THEN
		--
		-- se sono richiesti i visti controllo che lo fossero anche prima
		--
		IF new.da_vistare = TRUE THEN
			--
			-- se sono stati richiesti i visti controllo se è cambiata la classe, l'alunno o la descrizione
			-- nel qual caso si devono cancellare i vecchi visti ed inserire i nuovi
			-- ponendo attenzione che l'alunno può essere null
			--
			IF old.da_vistare = TRUE THEN
				IF new.descrizione != old.descrizione THEN
					v_delete_visti := TRUE;
					v_insert_visti := TRUE;
				END IF;
				IF new.classe != old.classe THEN
					v_delete_visti := TRUE;
					v_insert_visti := TRUE;
				END IF;
				IF new.alunno IS NULL THEN
					IF old.alunno IS NULL THEN
					ELSE
						v_delete_visti := TRUE;
					END IF;
				ELSE
					IF old.alunno IS NULL THEN
						v_insert_visti := TRUE;
					ELSE
						IF new.alunno != old.alunno THEN
							v_delete_visti := TRUE;
							v_insert_visti := TRUE;
						END IF;
					END IF;
				END IF ;
			END IF;
			--
			-- se non erano stati richiesti i visti allora devo inserirli
			--
			IF old.da_vistare = FALSE THEN
				v_insert_visti := TRUE;
			END IF;
		END IF;
		--
		-- se non sono richiesti i visti controllo se lo erano stati
		--
		IF new.da_vistare = FALSE THEN
			--
			-- se erano stati richiesti i visti allora devo cancellare queeli vecchi
			--
			IF old.da_vistare = TRUE THEN
				v_delete_visti := TRUE;
			END IF;
		END IF;
	END IF;

	--
	-- cancello fisicament i vecchi visti se è stato determinato dei cancellarli
	--
	IF v_delete_visti THEN 
		DELETE FROM note_visti WHERE nota = old.nota;
	END IF;
	--
	-- inserirso i nuovi visti se è stato determinato di inserirli
	--
	IF v_insert_visti THEN
		IF new.alunno IS NULL THEN
			INSERT INTO note_visti (nota, persona) SELECT new.nota, persona_relazionata
			                                         FROM  persone_relazioni WHERE visto_richiesto = TRUE 
			                                                                AND persona IN (SELECT alunno
			                                                                                  FROM classi_alunni
			                                                                                 WHERE classe = new.classe 
			                                                                                   AND alunno NOT IN (SELECT alunno
			                                                                                                        FROM assenze where giorno = new.giorno));
		ELSE
			INSERT INTO note_visti (nota, persona) SELECT new.nota, persona_relazionata
			                                         FROM  persone_relazioni WHERE visto_richiesto = TRUE 
			                                                                  AND persona = new.alunno;
		END IF;
	END IF;

	RETURN NEW;
 END;
$$;


ALTER FUNCTION public.tr_note_iu() OWNER TO postgres;

--
-- TOC entry 313 (class 1255 OID 3245704)
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
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_iu() OWNER TO postgres;

--
-- TOC entry 318 (class 1255 OID 3245804)
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
-- controllo che l'istituto della qualifica sia lo stesso di quello della metrica della materia del voto_proposto
--
	PERFORM 1 FROM voti v
	          JOIN metriche m ON v.metrica = m.metrica
	          JOIN qualifiche q ON m.istituto = q.istituto
	         WHERE v.voto = new.voto_proposto
	           AND q.qualifica = new.qualifica;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'3'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,6), new.scrutinio_valutazione_qualifica, new.qualifica,  new.voto_proposto),
			   HINT = messaggi_sistema_locale(function_name,7);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'4'),
			   MESSAGE = messaggi_sistema_locale(function_name,5),
			   DETAIL = format(messaggi_sistema_locale(function_name,8), new.qualifica,  new.voto_proposto),
			   HINT = messaggi_sistema_locale(function_name,7);
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
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_scrutini_valutazioni_qualifiche_iu() OWNER TO postgres;

--
-- TOC entry 314 (class 1255 OID 3245798)
-- Name: tr_utenti_istituti_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_utenti_istituti_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	function_name varchar = 'tr_utenti_istituti_iu';
BEGIN
--
-- controllo che la persona sia dello stesso istituto
--
	PERFORM 1 FROM persone p
	         WHERE p.persona = new.persona
	           AND p.istituto = new.istituto;
	IF NOT FOUND THEN
		IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'1'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,2), new.utente_istituto, new.persona,  new.istituto),
			   HINT = messaggi_sistema_locale(function_name,3);
		ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'2'),
			   MESSAGE = messaggi_sistema_locale(function_name,1),
			   DETAIL = format(messaggi_sistema_locale(function_name,4), new.persona,  new.istituto),
			   HINT = messaggi_sistema_locale(function_name,3);
		END IF;	   
	END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_utenti_istituti_iu() OWNER TO postgres;

--
-- TOC entry 331 (class 1255 OID 2407194)
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
-- TOC entry 332 (class 1255 OID 2484700)
-- Name: tr_valutazioni_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutazioni_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_istituto	bigint;
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
	PERFORM 1 FROM persone WHERE persona = new.alunno AND ruolo = 'Alunno';

	IF NOT FOUND THEN
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
-- controllo che la conversazione faccia riferimento ad un libretto intestato all'alunno ed alla classe
--
        IF new.conversazione IS NOT NULL THEN
		PERFORM 1 FROM conversazioni c
			  JOIN classi_alunni ca ON (ca.classe_alunno = c.libretto)
			 WHERE c.conversazione = new.conversazione
			   AND ca.classe = new.classe
			   AND ca.alunno = new.alunno;

		IF NOT FOUND THEN
		  IF (TG_OP = 'UPDATE') THEN
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'F'),
			   MESSAGE = messaggi_sistema_locale(function_name,22),
			   DETAIL = format(messaggi_sistema_locale(function_name,23), new.valutazione, new.conversazione, new.alunno, new.classe),
			   HINT = messaggi_sistema_locale(function_name,24);
		   ELSE
			   RAISE EXCEPTION USING
			   ERRCODE = function_sqlcode(function_name,'G'),
			   MESSAGE = messaggi_sistema_locale(function_name,22),
			   DETAIL = format(messaggi_sistema_locale(function_name,41), new.conversazione, new.alunno, new.classe),
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
	PERFORM 1 FROM persone WHERE persona = new.docente AND ruolo = 'Docente';

	IF NOT FOUND THEN
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
		   DETAIL = format(messaggi_sistema_locale(function_name,32), new.il, new.classe),
		   HINT = messaggi_sistema_locale(function_name,33);
	   END IF;	   
	END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutazioni_iu() OWNER TO postgres;

--
-- TOC entry 315 (class 1255 OID 3245785)
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
-- TOC entry 170 (class 1259 OID 2228320)
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
-- TOC entry 3033 (class 0 OID 0)
-- Dependencies: 170
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'genera la primary key per tutte le tabelle del progetto';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 171 (class 1259 OID 2228322)
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
-- TOC entry 3034 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anni_scolastici IS 'Rappresenta l''anno scolastico ed è suddiviso per istituto';


--
-- TOC entry 3035 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN anni_scolastici.inizio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.inizio IS 'Indica la data di inizio dell''anno scolastico, non necessariamente deve corrispondere con l''inizio delle lezioni.
';


--
-- TOC entry 3036 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN anni_scolastici.fine_lezioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.fine_lezioni IS 'I dati dei registri relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio dell''anno scolastico e la data di fine delle lezioni.';


--
-- TOC entry 3037 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN anni_scolastici.inizio_lezioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.inizio_lezioni IS 'I dati dei registro relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio e fine delle lezioni.';


--
-- TOC entry 173 (class 1259 OID 2228331)
-- Name: assenze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assenze (
    assenza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    giorno date NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint
);


ALTER TABLE public.assenze OWNER TO postgres;

--
-- TOC entry 3039 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE assenze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE assenze IS 'Rileva le assenze di un alunno';


--
-- TOC entry 3040 (class 0 OID 0)
-- Dependencies: 173
-- Name: COLUMN assenze.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN assenze.docente IS 'Il docente che ha certificato l''assenza';


--
-- TOC entry 174 (class 1259 OID 2228335)
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
-- TOC entry 175 (class 1259 OID 2228339)
-- Name: classi_alunni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE classi_alunni (
    classe_alunno bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL
);


ALTER TABLE public.classi_alunni OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 2569475)
-- Name: assenze_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(1) AS assenze
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN assenze a ON ((ca.alunno = a.alunno)))
  WHERE ((a.giorno >= asco.inizio_lezioni) AND (a.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.assenze_grp OWNER TO postgres;

--
-- TOC entry 3044 (class 0 OID 0)
-- Dependencies: 229
-- Name: VIEW assenze_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e alunno';


--
-- TOC entry 237 (class 1259 OID 2569595)
-- Name: assenze_non_giustificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_non_giustificate_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(1) AS assenze
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN assenze a ON ((ca.alunno = a.alunno)))
  WHERE (((a.giorno >= asco.inizio_lezioni) AND (a.giorno <= asco.fine_lezioni)) AND (a.giustificazione IS NULL))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.assenze_non_giustificate_grp OWNER TO postgres;

--
-- TOC entry 3045 (class 0 OID 0)
-- Dependencies: 237
-- Name: VIEW assenze_non_giustificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_non_giustificate_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e alunno limitando però la selezione a quelle non giustificate';


--
-- TOC entry 177 (class 1259 OID 2228347)
-- Name: comuni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comuni (
    comune character(4) NOT NULL,
    descrizione character varying(160) NOT NULL,
    provincia character(2) NOT NULL
);


ALTER TABLE public.comuni OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 2228362)
-- Name: fuori_classi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fuori_classi (
    fuori_classe bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    addetto_scolastico bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    giorno date NOT NULL,
    dalle time without time zone NOT NULL,
    alle time without time zone NOT NULL
);


ALTER TABLE public.fuori_classi OWNER TO postgres;

--
-- TOC entry 3047 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE fuori_classi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE fuori_classi IS 'Indica quando un alunno non è presente in classe ma non deve essere considerato assente ad esempio per impegni sportivi';


--
-- TOC entry 231 (class 1259 OID 2569516)
-- Name: fuori_classi_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(1) AS fuori_classi
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN fuori_classi fc ON ((ca.alunno = fc.alunno)))
  WHERE ((fc.giorno >= asco.inizio_lezioni) AND (fc.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.fuori_classi_grp OWNER TO postgres;

--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 231
-- Name: VIEW fuori_classi_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW fuori_classi_grp IS 'Raggruppa le fuori classe per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 185 (class 1259 OID 2228400)
-- Name: istituti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE istituti (
    istituto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL,
    codice_meccanografico character varying(160) NOT NULL,
    mnemonico character varying(30) NOT NULL,
    esempio boolean DEFAULT false NOT NULL,
    logo bytea
);


ALTER TABLE public.istituti OWNER TO postgres;

--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 185
-- Name: COLUMN istituti.esempio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istituti.esempio IS 'Indica se l''istituto e tutti i dati collegati sono stati inseriti per essere di esempio.
Se il dato è impostato a vero l''istituto verrà usato come sorgente dati per la compilazione dei dati di esempio.';


--
-- TOC entry 195 (class 1259 OID 2228455)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note (
    nota bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    disciplinare boolean NOT NULL,
    giorno date,
    ora time without time zone,
    da_vistare boolean DEFAULT false NOT NULL,
    classe bigint NOT NULL,
    CONSTRAINT note_ck_classe CHECK ((1 = 1)),
    CONSTRAINT note_ck_da_vistare CHECK (((((disciplinare = false) AND (da_vistare = false)) OR ((disciplinare = false) AND (da_vistare = true))) OR ((disciplinare = true) AND (da_vistare = true))))
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 3052 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN note.disciplinare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.disciplinare IS 'Indica che l''annotazione è di tipo disciplinare verrà quindi riportata sul libretto personale per la firma di visione del genitore.
L''annotazione è rivolta a tutta la classe a meno che non sia indicato il singolo alunno.
Se si vuole fare una nota disciplinare (ma anche normale) a due o più alunni è necesario inserire la nota per ciascuno.';


--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN note.da_vistare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.da_vistare IS 'indica che è richiesto il visto da parte dell''alunno (se maggiorenne) o da parte di chi esercita la patria potestà e ha richiesto di essere avvisato.
Se non è specificato l''alunno il visto deve essere richiesto per tutta la classe, se però è una nota disciplinare e manca l''alunno il visto deve essere richiesto per i soli alunni presenti';


--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN note.classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.classe IS 'indica se la nota è per tutta la classe';


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 195
-- Name: CONSTRAINT note_ck_classe ON note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT note_ck_classe ON note IS 'La note può essere per tutta la classe (in questo caso sarà valorizzato il campo classe) o per un solo alunno (in questo caso sarà valorizzato il campo classe e il campo alunno) non esiste che nessuno dei due si a valorizzato o che sia valorizzato solo il campo alunno';


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 195
-- Name: CONSTRAINT note_ck_da_vistare ON note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT note_ck_da_vistare ON note IS 'Se è una nota disciplinare allora deve essere richiesto il visto';


--
-- TOC entry 233 (class 1259 OID 2569544)
-- Name: note_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(1) AS note
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN note n ON ((ca.alunno = n.alunno)))
  WHERE (((n.giorno >= asco.inizio_lezioni) AND (n.giorno <= asco.fine_lezioni)) AND (n.disciplinare = true))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.note_grp OWNER TO postgres;

--
-- TOC entry 3058 (class 0 OID 0)
-- Dependencies: 233
-- Name: VIEW note_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW note_grp IS 'Raggruppa le note per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 198 (class 1259 OID 2228473)
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
    ruolo ruolo NOT NULL,
    istituto bigint,
    sidi bigint,
    comune_nascita character(4),
    foto_miniatura bytea
);


ALTER TABLE public.persone OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 2228508)
-- Name: ritardi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ritardi (
    ritardo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    giorno date NOT NULL,
    ora time without time zone NOT NULL
);


ALTER TABLE public.ritardi OWNER TO postgres;

--
-- TOC entry 3060 (class 0 OID 0)
-- Dependencies: 206
-- Name: TABLE ritardi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE ritardi IS 'Rileva i ritardi di un alunno';


--
-- TOC entry 230 (class 1259 OID 2569490)
-- Name: ritardi_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(1) AS ritardi
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN ritardi r ON ((ca.alunno = r.alunno)))
  WHERE ((r.giorno >= asco.inizio_lezioni) AND (r.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.ritardi_grp OWNER TO postgres;

--
-- TOC entry 3062 (class 0 OID 0)
-- Dependencies: 230
-- Name: VIEW ritardi_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_grp IS 'Raggruppa i ritardi per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 235 (class 1259 OID 2569584)
-- Name: ritardi_non_giustificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_non_giustificati_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(ca.alunno) AS ritardi
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN ritardi r ON ((ca.alunno = r.alunno)))
  WHERE (((r.giorno >= asco.inizio_lezioni) AND (r.giorno <= asco.fine_lezioni)) AND (r.giustificazione IS NULL))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.ritardi_non_giustificati_grp OWNER TO postgres;

--
-- TOC entry 3063 (class 0 OID 0)
-- Dependencies: 235
-- Name: VIEW ritardi_non_giustificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_non_giustificati_grp IS 'Raggruppa i ritardi per classe (e quindi per anno acolastico) e alunno limitando però la selezione a quelli non giustificati';


--
-- TOC entry 212 (class 1259 OID 2228540)
-- Name: uscite; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE uscite (
    uscita bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint NOT NULL,
    giorno date NOT NULL,
    ora time without time zone NOT NULL
);


ALTER TABLE public.uscite OWNER TO postgres;

--
-- TOC entry 3064 (class 0 OID 0)
-- Dependencies: 212
-- Name: TABLE uscite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE uscite IS 'Rileva i uscite di un alunno';


--
-- TOC entry 232 (class 1259 OID 2569539)
-- Name: uscite_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(ca.alunno) AS uscite
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN uscite u ON ((ca.alunno = u.alunno)))
  WHERE ((u.giorno >= asco.inizio_lezioni) AND (u.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.uscite_grp OWNER TO postgres;

--
-- TOC entry 3066 (class 0 OID 0)
-- Dependencies: 232
-- Name: VIEW uscite_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_grp IS 'Raggruppa le uscite per classe (e quindi per anno acolastico) e alunno';


--
-- TOC entry 236 (class 1259 OID 2569590)
-- Name: uscite_non_giustificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_non_giustificate_grp AS
 SELECT ca.classe, 
    ca.alunno, 
    count(ca.alunno) AS uscite
   FROM (((classi c
   JOIN anni_scolastici asco ON ((c.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c.classe = ca.classe)))
   JOIN uscite u ON ((ca.alunno = u.alunno)))
  WHERE (((u.giorno >= asco.inizio_lezioni) AND (u.giorno <= asco.fine_lezioni)) AND (u.giustificazione IS NULL))
  GROUP BY ca.classe, ca.alunno;


ALTER TABLE public.uscite_non_giustificate_grp OWNER TO postgres;

--
-- TOC entry 3067 (class 0 OID 0)
-- Dependencies: 236
-- Name: VIEW uscite_non_giustificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_non_giustificate_grp IS 'Raggruppa le uscite per classe (e quindi per anno acolastico) e alunno limitando però la selezione a quelle non giutificate';


SET default_with_oids = false;

--
-- TOC entry 213 (class 1259 OID 2228544)
-- Name: utenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti (
    utente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    usename name NOT NULL,
    token character varying(1024),
    lingua lingue DEFAULT 'it'::lingue NOT NULL,
    spazio_lavoro bigint
);


ALTER TABLE public.utenti OWNER TO postgres;

--
-- TOC entry 3068 (class 0 OID 0)
-- Dependencies: 213
-- Name: TABLE utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE utenti IS 'Tutti gli utenti del sistema';


--
-- TOC entry 3069 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN utenti.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti.token IS 'serve per il ripristino della password via email';


--
-- TOC entry 3070 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN utenti.spazio_lavoro; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti.spazio_lavoro IS 'spazio di lavoro di default, quello selezionato nel desktop quando l`utente si collega';


--
-- TOC entry 214 (class 1259 OID 2228551)
-- Name: utenti_istituti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti_istituti (
    utente_istituto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    utente bigint NOT NULL,
    istituto bigint NOT NULL,
    persona bigint NOT NULL
);


ALTER TABLE public.utenti_istituti OWNER TO postgres;

--
-- TOC entry 3072 (class 0 OID 0)
-- Dependencies: 214
-- Name: TABLE utenti_istituti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE utenti_istituti IS 'Indica gli istituti autorizzati per il singolo utente';


--
-- TOC entry 3073 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN utenti_istituti.persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti_istituti.persona IS 'La persona rappresentata dall''utente per un determinato istituto';


--
-- TOC entry 238 (class 1259 OID 2569600)
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
   FROM (((((((((((((((utenti u
   JOIN utenti_istituti ui ON ((ui.utente = u.utente)))
   JOIN istituti i ON ((i.istituto = ui.istituto)))
   JOIN anni_scolastici a ON ((a.istituto = i.istituto)))
   JOIN classi c ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN classi_alunni ca ON ((ca.classe = c.classe)))
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
  WHERE (u.usename = "session_user"());


ALTER TABLE public.classi_alunni_ex OWNER TO postgres;

--
-- TOC entry 330 (class 1255 OID 2569605)
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
-- TOC entry 201 (class 1259 OID 2228488)
-- Name: plessi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plessi (
    plesso bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.plessi OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 2484352)
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
   FROM (((((istituti i
   JOIN utenti_istituti ui ON ((i.istituto = ui.istituto)))
   JOIN utenti u ON ((ui.utente = u.utente)))
   JOIN anni_scolastici a ON ((i.istituto = a.istituto)))
   JOIN classi c ON ((a.anno_scolastico = c.anno_scolastico)))
   JOIN plessi p ON ((c.plesso = p.plesso)))
  WHERE (u.usename = "session_user"());


ALTER TABLE public.classi_ex OWNER TO postgres;

--
-- TOC entry 301 (class 1255 OID 2484357)
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
-- TOC entry 197 (class 1259 OID 2228469)
-- Name: orari_settimanali; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE orari_settimanali (
    orario_settimanale bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    descrizione character varying(160)
);


ALTER TABLE public.orari_settimanali OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 2464558)
-- Name: orari_settimanali_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW orari_settimanali_ex AS
 SELECT c.classe, 
    os.orario_settimanale, 
    os.descrizione AS orario_settimanale_descrizione
   FROM (((((orari_settimanali os
   JOIN classi c ON ((os.classe = c.classe)))
   JOIN anni_scolastici a ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN istituti i ON ((a.istituto = i.istituto)))
   JOIN utenti_istituti ui ON ((i.istituto = ui.istituto)))
   JOIN utenti u ON ((ui.utente = u.utente)))
  WHERE (u.usename = "session_user"());


ALTER TABLE public.orari_settimanali_ex OWNER TO postgres;

--
-- TOC entry 307 (class 1255 OID 2535367)
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
-- TOC entry 188 (class 1259 OID 2228420)
-- Name: materie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE materie (
    materia bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.materie OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 2389072)
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
-- TOC entry 3084 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN orari_settimanali_giorni.compresenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN orari_settimanali_giorni.compresenza IS 'Indica il numero di compresenza (1 il primo insegnante, 2 il secondo insgnante e così via) se c''è un insegnante solo mettere 1 ';


--
-- TOC entry 3085 (class 0 OID 0)
-- Dependencies: 218
-- Name: CONSTRAINT orari_settimanali_giorni_ck_docente_materia ON orari_settimanali_giorni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT orari_settimanali_giorni_ck_docente_materia ON orari_settimanali_giorni IS 'Almeno uno dei campi tra docente e materia deve essere compilato.';


--
-- TOC entry 246 (class 1259 OID 2781382)
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
   FROM ((((((((istituti i
   JOIN utenti_istituti ui ON ((i.istituto = ui.istituto)))
   JOIN utenti u ON ((ui.utente = u.utente)))
   JOIN anni_scolastici a ON ((a.istituto = i.istituto)))
   JOIN classi c ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN orari_settimanali os ON ((os.classe = c.classe)))
   JOIN orari_settimanali_giorni osg ON ((osg.orario_settimanale = os.orario_settimanale)))
   JOIN persone p ON ((p.persona = osg.docente)))
   LEFT JOIN materie m ON ((m.materia = osg.materia)))
  WHERE (u.usename = "session_user"());


ALTER TABLE public.orari_settimanali_giorni_ex OWNER TO postgres;

--
-- TOC entry 311 (class 1255 OID 2781387)
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
-- TOC entry 353 (class 1255 OID 2384009)
-- Name: where_sequence(text, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION where_sequence(name text, search_value bigint) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, num_time_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Cerca in tute le colonne del database che hanno per default 
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
-- TOC entry 3088 (class 0 OID 0)
-- Dependencies: 353
-- Name: FUNCTION where_sequence(name text, search_value bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(name text, search_value bigint) IS 'Restituisce l''elenco delle tabelle che hanno la colonna collegata alla sequenza indicata e contengono il valore indicato.';


--
-- TOC entry 172 (class 1259 OID 2228327)
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
-- TOC entry 3090 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE argomenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE argomenti IS 'Contiene gli argomenti oggetto di una valutazione';


--
-- TOC entry 250 (class 1259 OID 2781469)
-- Name: assenze_certificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_certificate_grp AS
 SELECT ca.classe, 
    a.docente, 
    count(1) AS assenze_certificate
   FROM (((assenze a
   JOIN classi_alunni ca ON ((ca.alunno = a.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
  WHERE ((a.giorno >= asco.inizio_lezioni) AND (a.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, a.docente;


ALTER TABLE public.assenze_certificate_grp OWNER TO postgres;

--
-- TOC entry 3092 (class 0 OID 0)
-- Dependencies: 250
-- Name: VIEW assenze_certificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_certificate_grp IS 'raggruppa le assenze certificate da ogni docente per ogni classe';


--
-- TOC entry 182 (class 1259 OID 2228366)
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
    CONSTRAINT giustificazioni_ck_esce CHECK ((esce >= entra)),
    CONSTRAINT giustificazioni_ck_registrata_il CHECK ((registrata_il >= creata_il))
);


ALTER TABLE public.giustificazioni OWNER TO postgres;

--
-- TOC entry 3093 (class 0 OID 0)
-- Dependencies: 182
-- Name: TABLE giustificazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE giustificazioni IS 'contiene le giustificazioni per assenze, ritardi e uscite.
Può essere fatta da un addetto scolastico che compilerà la descrizione o da un esercenta la patria potestà';


--
-- TOC entry 3094 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.creata_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.creata_da IS 'La persona, addetto scolastico, famigliare o l''alunno stesso, se maggiorenne, che ha inserito la giustificazione';


--
-- TOC entry 3095 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.registrata_il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.registrata_il IS 'Data ed ora in cui la giustificazione è stata usata (è stata cioè associata ad un''assenza)';


--
-- TOC entry 3096 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.registrata_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.registrata_da IS 'L''addetto scolastico che ha usato la giustificazione (l''ha associata ad un''assenza)';


--
-- TOC entry 3097 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.dal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.dal IS 'giorno di inizio della giustificazione (per i ritardo e le uscite coincide con al)';


--
-- TOC entry 3098 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.al; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.al IS 'giorno di fine giustificazione (per i ritardo e le uscite coincide con dal)';


--
-- TOC entry 3099 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.entra; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.entra IS 'ora di entrata (ritardo)';


--
-- TOC entry 3100 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.esce; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.esce IS 'Ora di uscita';


--
-- TOC entry 264 (class 1259 OID 2798393)
-- Name: assenze_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_ex AS
 SELECT ca.classe, 
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
   FROM ((((((((assenze a
   JOIN classi_alunni ca ON ((ca.alunno = a.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
   JOIN persone alu ON ((ca.alunno = alu.persona)))
   JOIN persone doc ON ((a.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = a.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)))
  WHERE ((a.giorno >= asco.inizio_lezioni) AND (a.giorno <= asco.fine_lezioni));


ALTER TABLE public.assenze_ex OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 2781553)
-- Name: assenze_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW assenze_mese_grp AS
 WITH cmg AS (
         SELECT ca.classe, 
            date_part('month'::text, a.giorno) AS mese, 
            count(1) AS assenze
           FROM (((classi c_1
      JOIN anni_scolastici asco ON ((c_1.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c_1.classe = ca.classe)))
   JOIN assenze a ON ((ca.alunno = a.alunno)))
  WHERE ((a.giorno >= asco.inizio_lezioni) AND (a.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, date_part('month'::text, a.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.assenze, (0)::bigint) AS assenze
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.assenze_mese_grp OWNER TO postgres;

--
-- TOC entry 3102 (class 0 OID 0)
-- Dependencies: 257
-- Name: VIEW assenze_mese_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW assenze_mese_grp IS 'Raggruppa le assenze per classe (e quindi per anno scolastico) e mese
viene usata una crossjoin per creare la lista di tutte le classi con tutti i mesi a zero per unirli con le assenze della tabella lo scopo e di avere le assenze di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle delle assenze, non ci sarebbero';


--
-- TOC entry 186 (class 1259 OID 2228405)
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
    alle time without time zone NOT NULL
);


ALTER TABLE public.lezioni OWNER TO postgres;

--
-- TOC entry 3103 (class 0 OID 0)
-- Dependencies: 186
-- Name: COLUMN lezioni.supplenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.supplenza IS 'Indica se la lezione è di supplenza cioè tenuta da un insegnante non titolare della cattedra';


--
-- TOC entry 254 (class 1259 OID 2781499)
-- Name: classi_docenti; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classi_docenti AS
 SELECT DISTINCT lezioni.classe, 
    lezioni.docente
   FROM lezioni;


ALTER TABLE public.classi_docenti OWNER TO postgres;

--
-- TOC entry 180 (class 1259 OID 2228358)
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
-- TOC entry 249 (class 1259 OID 2781465)
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
-- TOC entry 3106 (class 0 OID 0)
-- Dependencies: 249
-- Name: VIEW firme_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW firme_grp IS 'raggruppa le firme fatte da ogni docenti per ogni classe';


--
-- TOC entry 251 (class 1259 OID 2781484)
-- Name: fuori_classi_certificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_certificati_grp AS
 SELECT ca.classe, 
    fc.addetto_scolastico, 
    count(1) AS fuori_classi_certificati
   FROM (((fuori_classi fc
   JOIN classi_alunni ca ON ((ca.alunno = fc.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
  WHERE ((fc.giorno >= asco.inizio_lezioni) AND (fc.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, fc.addetto_scolastico;


ALTER TABLE public.fuori_classi_certificati_grp OWNER TO postgres;

--
-- TOC entry 3107 (class 0 OID 0)
-- Dependencies: 251
-- Name: VIEW fuori_classi_certificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW fuori_classi_certificati_grp IS 'raggruppa i fuori classi certificati da ogni addetto scolastico per ogni classe';


--
-- TOC entry 248 (class 1259 OID 2781461)
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
-- TOC entry 3108 (class 0 OID 0)
-- Dependencies: 248
-- Name: VIEW lezioni_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lezioni_grp IS 'raggruppa le lezioi fatti da ogni docente per ogni classe';


--
-- TOC entry 255 (class 1259 OID 2781503)
-- Name: note_emesse_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_emesse_grp AS
 SELECT ca.classe, 
    n.docente, 
    count(1) AS note_emesse
   FROM (((note n
   JOIN classi_alunni ca ON ((ca.alunno = n.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
  WHERE ((n.giorno >= asco.inizio_lezioni) AND (n.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, n.docente;


ALTER TABLE public.note_emesse_grp OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 2781489)
-- Name: ritardi_certificati_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_certificati_grp AS
 SELECT ca.classe, 
    r.docente, 
    count(1) AS ritardi_certificati
   FROM (((ritardi r
   JOIN classi_alunni ca ON ((ca.alunno = r.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
  WHERE ((r.giorno >= asco.inizio_lezioni) AND (r.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, r.docente;


ALTER TABLE public.ritardi_certificati_grp OWNER TO postgres;

--
-- TOC entry 3109 (class 0 OID 0)
-- Dependencies: 252
-- Name: VIEW ritardi_certificati_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_certificati_grp IS 'raggruppa i ritardi certificate da ogni docente per ogni classe';


--
-- TOC entry 253 (class 1259 OID 2781494)
-- Name: uscite_certificate_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_certificate_grp AS
 SELECT ca.classe, 
    u.docente, 
    count(1) AS uscite_certificate
   FROM (((uscite u
   JOIN classi_alunni ca ON ((ca.alunno = u.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
  WHERE ((u.giorno >= asco.inizio_lezioni) AND (u.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, u.docente;


ALTER TABLE public.uscite_certificate_grp OWNER TO postgres;

--
-- TOC entry 3110 (class 0 OID 0)
-- Dependencies: 253
-- Name: VIEW uscite_certificate_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW uscite_certificate_grp IS 'raggruppa le uscite certificate da ogni docente per ogni classe';


--
-- TOC entry 256 (class 1259 OID 2781514)
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
   FROM ((((((((((((((classi_docenti cd
   JOIN classi c ON ((c.classe = cd.classe)))
   JOIN anni_scolastici a ON ((a.anno_scolastico = c.anno_scolastico)))
   JOIN istituti i ON ((i.istituto = a.istituto)))
   JOIN utenti_istituti ui ON ((ui.istituto = i.istituto)))
   JOIN utenti u ON ((u.utente = ui.utente)))
   JOIN persone p ON ((p.persona = cd.docente)))
   JOIN lezioni_grp lgrp ON (((lgrp.classe = cd.classe) AND (lgrp.docente = cd.docente))))
   LEFT JOIN comuni co ON ((co.comune = p.comune_nascita)))
   LEFT JOIN firme_grp fgrp ON (((fgrp.classe = cd.classe) AND (fgrp.docente = cd.docente))))
   LEFT JOIN assenze_certificate_grp acgrp ON (((acgrp.classe = cd.classe) AND (acgrp.docente = cd.docente))))
   LEFT JOIN ritardi_certificati_grp rcgrp ON (((rcgrp.classe = cd.classe) AND (rcgrp.docente = cd.docente))))
   LEFT JOIN uscite_certificate_grp ucgrp ON (((ucgrp.classe = cd.classe) AND (ucgrp.docente = cd.docente))))
   LEFT JOIN fuori_classi_certificati_grp fccgrp ON (((fccgrp.classe = cd.classe) AND (fccgrp.addetto_scolastico = cd.docente))))
   LEFT JOIN note_emesse_grp negrp ON (((negrp.classe = cd.classe) AND (negrp.docente = cd.docente))))
  WHERE (u.usename = "session_user"());


ALTER TABLE public.classi_docenti_ex OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 176 (class 1259 OID 2228343)
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
-- TOC entry 3111 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE colloqui; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE colloqui IS 'in questa tabella sono memorizzati tutti i periodi di disponibilità per i colloqui con gli esercenti la patria ';


--
-- TOC entry 3112 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN colloqui.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.docente IS 'docente che è disponibile nella data indicata dalla colonna il';


--
-- TOC entry 3113 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN colloqui.con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.con IS 'persona con la quale è stato prenotato il colloquio';


--
-- TOC entry 3114 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN colloqui.il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.il IS 'data e ora in cui il docente è disponibile per un colloquio';


SET default_with_oids = true;

--
-- TOC entry 178 (class 1259 OID 2228350)
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
-- TOC entry 3116 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN conversazioni.libretto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.libretto IS 'Riferimento alla tabella classi_alunni';


--
-- TOC entry 3117 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN conversazioni.riservata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.riservata IS 'Indica che la conversazione può essere visualizzata solo dai partecipante e non, come è norma, anche dagli addetti scolastici.
Inoltre non viene inclusa nella stampa del libretto personale.';


--
-- TOC entry 3118 (class 0 OID 0)
-- Dependencies: 178
-- Name: COLUMN conversazioni.fine; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversazioni.fine IS 'quando una conversazione è terminta non + più possibile aggiungere o modificare messaggi';


SET default_with_oids = false;

--
-- TOC entry 247 (class 1259 OID 2781423)
-- Name: conversazioni_invitati; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conversazioni_invitati (
    conversazione_invitato bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversazione bigint NOT NULL,
    invitato bigint NOT NULL
);


ALTER TABLE public.conversazioni_invitati OWNER TO postgres;

--
-- TOC entry 3120 (class 0 OID 0)
-- Dependencies: 247
-- Name: TABLE conversazioni_invitati; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE conversazioni_invitati IS 'definisce gli invitati ad una conversazione cioè le persone abilitate a vedere e/o partecipare ad una determinata conversazione';


--
-- TOC entry 239 (class 1259 OID 2764958)
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
-- TOC entry 179 (class 1259 OID 2228354)
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
-- TOC entry 241 (class 1259 OID 2773194)
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
-- TOC entry 244 (class 1259 OID 2781371)
-- Name: fuori_classi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_ex AS
 SELECT ca.classe, 
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
   FROM (((((fuori_classi f
   JOIN classi_alunni ca ON ((f.alunno = ca.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
   JOIN persone alu ON ((ca.alunno = alu.persona)))
   JOIN persone adsco ON ((f.addetto_scolastico = adsco.persona)))
  WHERE ((f.giorno >= asco.inizio_lezioni) AND (f.giorno <= asco.fine_lezioni));


ALTER TABLE public.fuori_classi_ex OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 2781570)
-- Name: fuori_classi_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW fuori_classi_mese_grp AS
 WITH cmg AS (
         SELECT ca.classe, 
            date_part('month'::text, f.giorno) AS mese, 
            count(1) AS fuori_classi
           FROM (((classi c_1
      JOIN anni_scolastici asco ON ((c_1.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c_1.classe = ca.classe)))
   JOIN fuori_classi f ON ((ca.alunno = f.alunno)))
  WHERE ((f.giorno >= asco.inizio_lezioni) AND (f.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, date_part('month'::text, f.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.fuori_classi, (0)::bigint) AS fuori_classi
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.fuori_classi_mese_grp OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 2415373)
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
-- TOC entry 183 (class 1259 OID 2228392)
-- Name: indirizzi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE indirizzi (
    indirizzo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    via character varying(160),
    cap character varying(15),
    provincia character varying(160),
    nazione bigint,
    comune character(4)
);


ALTER TABLE public.indirizzi OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 2228396)
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
-- TOC entry 3123 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN indirizzi_scolastici.anni_corso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN indirizzi_scolastici.anni_corso IS 'anni del corso ad esempio:
5 per le primarie
3 per le secondarie di primo grado
5 per le secondarie di secondo grado';


--
-- TOC entry 222 (class 1259 OID 2407234)
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
   FROM (((((istituti i
   JOIN utenti_istituti ui ON ((i.istituto = ui.istituto)))
   JOIN utenti u ON ((ui.utente = u.utente)))
   JOIN anni_scolastici a ON ((i.istituto = a.istituto)))
   JOIN classi c ON ((a.anno_scolastico = c.anno_scolastico)))
   JOIN orari_settimanali o ON ((c.classe = o.classe)));


ALTER TABLE public.istituti_anni_scolastici_classi_orari_settimanali OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 2773189)
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
-- TOC entry 234 (class 1259 OID 2569573)
-- Name: lezioni_giorni; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lezioni_giorni AS
 SELECT DISTINCT l.classe, 
    l.giorno
   FROM lezioni l;


ALTER TABLE public.lezioni_giorni OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 2228413)
-- Name: mancanze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mancanze (
    mancanza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    descrizione character varying(2048) NOT NULL,
    giorno date NOT NULL
);


ALTER TABLE public.mancanze OWNER TO postgres;

--
-- TOC entry 3126 (class 0 OID 0)
-- Dependencies: 187
-- Name: TABLE mancanze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE mancanze IS 'Rileva le mancanze di un alunno';


--
-- TOC entry 189 (class 1259 OID 2228424)
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
-- TOC entry 3128 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN messaggi.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi.da IS 'La persona fisica che ha scritto il messaggio';


--
-- TOC entry 190 (class 1259 OID 2228432)
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
-- TOC entry 3130 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN messaggi_letti.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi_letti.da IS 'Persona fisica che ha letto il messaggio';


--
-- TOC entry 191 (class 1259 OID 2228436)
-- Name: messaggi_sistema; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi_sistema (
    messaggio_sistema bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    lingua lingue DEFAULT 'it'::lingue NOT NULL,
    descrizione character varying(1024) NOT NULL,
    function_name character varying(1024) NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.messaggi_sistema OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 2228443)
-- Name: metriche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metriche (
    metrica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.metriche OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 2228447)
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
-- TOC entry 3134 (class 0 OID 0)
-- Dependencies: 193
-- Name: COLUMN mezzi_comunicazione.notifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN mezzi_comunicazione.notifica IS 'Indica se usare questo mezzo di comunicazione nelle notifiche, ovviamente solo se il tipo di comunicazione lo permette';


--
-- TOC entry 194 (class 1259 OID 2228451)
-- Name: nazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nazioni (
    nazione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    esistente boolean DEFAULT true NOT NULL
);


ALTER TABLE public.nazioni OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 2228462)
-- Name: note_docenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note_docenti (
    nota_docente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    giorno date NOT NULL,
    ora time without time zone,
    classe bigint
);


ALTER TABLE public.note_docenti OWNER TO postgres;

--
-- TOC entry 3137 (class 0 OID 0)
-- Dependencies: 196
-- Name: TABLE note_docenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE note_docenti IS 'Svolge le stesse funzioni della tabella note ma per il registro del professore.
L''unica differenza è che non è stato necessario replicare anche la colonna ''disciplinare'' perchè le note disciplinari si fanno solo sul registro di classe mentre queste note sono principalmente ad uso privato dell''insegnante.';


--
-- TOC entry 266 (class 1259 OID 2830165)
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
-- TOC entry 261 (class 1259 OID 2781580)
-- Name: note_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW note_mese_grp AS
 WITH cmg AS (
         SELECT ca.classe, 
            date_part('month'::text, f.giorno) AS mese, 
            count(1) AS note
           FROM (((classi c_1
      JOIN anni_scolastici asco ON ((c_1.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c_1.classe = ca.classe)))
   JOIN note f ON ((ca.alunno = f.alunno)))
  WHERE ((f.giorno >= asco.inizio_lezioni) AND (f.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, date_part('month'::text, f.giorno)
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
-- TOC entry 263 (class 1259 OID 2781618)
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
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 263
-- Name: COLUMN note_visti.persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note_visti.persona IS 'persona che deve vistare la nota: i parenti dell''alunno che nella colonna visto della tabella persone_parenti hanno il valore true';


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 263
-- Name: COLUMN note_visti.il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note_visti.il IS 'date e ora in cui la nota è stata vista dalla persona';


--
-- TOC entry 265 (class 1259 OID 2830159)
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
-- TOC entry 245 (class 1259 OID 2781376)
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
   FROM ((((((((istituti i
   JOIN utenti_istituti ui ON ((i.istituto = ui.istituto)))
   JOIN utenti u ON ((ui.utente = u.utente)))
   JOIN anni_scolastici a ON ((a.istituto = i.istituto)))
   JOIN classi c ON ((c.anno_scolastico = a.anno_scolastico)))
   JOIN orari_settimanali os ON ((os.classe = c.classe)))
   JOIN orari_settimanali_giorni osg ON ((osg.orario_settimanale = os.orario_settimanale)))
   JOIN persone p ON ((p.persona = osg.docente)))
   LEFT JOIN materie m ON ((m.materia = osg.materia)))
  WHERE (u.usename = "session_user"());


ALTER TABLE public.orari_settimanali_docenti_ex OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 199 (class 1259 OID 2228480)
-- Name: persone_indirizzi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_indirizzi (
    persona_indirizzo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    indirizzo bigint NOT NULL,
    tipo_indirizzo tipo_indirizzo NOT NULL
);


ALTER TABLE public.persone_indirizzi OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 2228484)
-- Name: persone_relazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_relazioni (
    persona_relazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    persona_relazionata bigint NOT NULL,
    visto_richiesto boolean DEFAULT true NOT NULL,
    relazione relazione_personale NOT NULL
);


ALTER TABLE public.persone_relazioni OWNER TO postgres;

--
-- TOC entry 3142 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE persone_relazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persone_relazioni IS 'Indica le relazioni fra le persone: tipicamente l''alunno (colonna persona) avrà come relazione ''Padre/Madre''  il padre (persona_relazionata) per indicare la madre si inserirà una riga con i valori uguali a quelli appena detti avendo cura, questa volta, di mettere nella colona persona_relazionata il codice della persona che identifica la madre';


--
-- TOC entry 3143 (class 0 OID 0)
-- Dependencies: 200
-- Name: COLUMN persone_relazioni.visto_richiesto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persone_relazioni.visto_richiesto IS 'Indica se, nel caso di note di classe (ad esempio l''avviso per la gita scolastica) o nel caso di note discplinari, il docente deve avere cura di verificare se il parente in oggetto ha visto la nota';


--
-- TOC entry 202 (class 1259 OID 2228492)
-- Name: provincie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincie (
    provincia character(2) NOT NULL,
    descrizione character varying(160) NOT NULL,
    regione smallint
);


ALTER TABLE public.provincie OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 2228495)
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
-- TOC entry 3146 (class 0 OID 0)
-- Dependencies: 203
-- Name: TABLE qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifiche IS 'Descrive per il singolo istituto le competenze conoscenze e abilita.
Mettendo tutto in una singola tabella si è coniato il termine qualifica per essere generico rispetto alla declinazione che può avere: Competenza, conosenza, abilità';


--
-- TOC entry 3147 (class 0 OID 0)
-- Dependencies: 203
-- Name: COLUMN qualifiche.qualifica_padre; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifiche.qualifica_padre IS 'Serve a creare la gerarchia delle qualifiche in questa colonna si indica la qualifica da cui si dipende: la qualifica padre';


SET default_with_oids = false;

--
-- TOC entry 228 (class 1259 OID 2536654)
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
-- TOC entry 3149 (class 0 OID 0)
-- Dependencies: 228
-- Name: TABLE qualifiche_pof; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifiche_pof IS 'Contiene i collegamenti fra il piano formativo (indirizzo_scolastico, anno_corso e materia) e le qualifiche.
Serve in fase di valutazione per presentare le qualifiche coerenti con la valutazione espressa';


SET default_with_oids = true;

--
-- TOC entry 204 (class 1259 OID 2228502)
-- Name: regioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regioni (
    regione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    ripartizione_geografica ripartizione_geografica
);


ALTER TABLE public.regioni OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 2781560)
-- Name: ritardi_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_mese_grp AS
 WITH cmg AS (
         SELECT ca.classe, 
            date_part('month'::text, r.giorno) AS mese, 
            count(1) AS ritardi
           FROM (((classi c_1
      JOIN anni_scolastici asco ON ((c_1.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c_1.classe = ca.classe)))
   JOIN ritardi r ON ((ca.alunno = r.alunno)))
  WHERE ((r.giorno >= asco.inizio_lezioni) AND (r.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, date_part('month'::text, r.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.ritardi, (0)::bigint) AS ritardi
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.ritardi_mese_grp OWNER TO postgres;

--
-- TOC entry 3151 (class 0 OID 0)
-- Dependencies: 258
-- Name: VIEW ritardi_mese_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW ritardi_mese_grp IS 'Raggruppa i ritardi per classe (e quindi per anno scolastico) e mese
viene usata una crossjoin per creare la lista di tutte le classi con tutti i mesi a zero per unirli con i ritardi della tabell, lo scopo e di avere i ritardi di ttti i mesi dell''anno. anche quelli a zero. che altrimenti, interrogando la sola tabelle dei ritardi, non ci sarebbero';


--
-- TOC entry 259 (class 1259 OID 2781565)
-- Name: uscite_mese_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_mese_grp AS
 WITH cmg AS (
         SELECT ca.classe, 
            date_part('month'::text, u.giorno) AS mese, 
            count(1) AS uscite
           FROM (((classi c_1
      JOIN anni_scolastici asco ON ((c_1.anno_scolastico = asco.anno_scolastico)))
   JOIN classi_alunni ca ON ((c_1.classe = ca.classe)))
   JOIN uscite u ON ((ca.alunno = u.alunno)))
  WHERE ((u.giorno >= asco.inizio_lezioni) AND (u.giorno <= asco.fine_lezioni))
  GROUP BY ca.classe, date_part('month'::text, u.giorno)
        )
 SELECT c.classe, 
    mese.mese, 
    COALESCE(cmg.uscite, (0)::bigint) AS uscite
   FROM ((classi c
  CROSS JOIN generate_series(1, 12) mese(mese))
   LEFT JOIN cmg ON (((cmg.classe = c.classe) AND ((mese.mese)::double precision = cmg.mese))));


ALTER TABLE public.uscite_mese_grp OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 2781589)
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
-- TOC entry 205 (class 1259 OID 2228505)
-- Name: residenza_grp_comune; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE residenza_grp_comune (
    istituto bigint,
    descrizione character varying(160),
    count bigint
);


ALTER TABLE public.residenza_grp_comune OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 2773206)
-- Name: ritardi_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW ritardi_ex AS
 SELECT ca.classe, 
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
   FROM ((((((((ritardi r
   JOIN classi_alunni ca ON ((r.alunno = ca.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
   JOIN persone alu ON ((ca.alunno = alu.persona)))
   JOIN persone doc ON ((r.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = r.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)))
  WHERE ((r.giorno >= asco.inizio_lezioni) AND (r.giorno <= asco.fine_lezioni));


ALTER TABLE public.ritardi_ex OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 2228512)
-- Name: scrutini; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini (
    scrutinio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    anno_scolastico bigint,
    data date,
    descrizione character varying(60) NOT NULL
);


ALTER TABLE public.scrutini OWNER TO postgres;

--
-- TOC entry 3153 (class 0 OID 0)
-- Dependencies: 207
-- Name: COLUMN scrutini.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini.data IS 'Data dello scrutinio';


--
-- TOC entry 208 (class 1259 OID 2228516)
-- Name: scrutini_valutazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini_valutazioni (
    scrutinio_valutazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    scrutinio bigint NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    materia bigint NOT NULL,
    voto_proposto bigint NOT NULL,
    voto bigint,
    note character varying(2048),
    carenze_formative boolean DEFAULT false NOT NULL,
    voto_di_consiglio boolean DEFAULT false NOT NULL
);


ALTER TABLE public.scrutini_valutazioni OWNER TO postgres;

--
-- TOC entry 3155 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN scrutini_valutazioni.carenze_formative; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.carenze_formative IS 'indica se l''alunno ha dimostrato di avere carenze formative';


--
-- TOC entry 3156 (class 0 OID 0)
-- Dependencies: 208
-- Name: COLUMN scrutini_valutazioni.voto_di_consiglio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.voto_di_consiglio IS 'Indica che il voto è stato deciso dal consiglio di classe in difformità a quanto proposto dal docente';


SET default_with_oids = true;

--
-- TOC entry 209 (class 1259 OID 2228525)
-- Name: scrutini_valutazioni_qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini_valutazioni_qualifiche (
    scrutinio_valutazione_qualifica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    scrutinio_valutazione bigint NOT NULL,
    qualifica bigint NOT NULL,
    voto_proposto bigint NOT NULL,
    voto bigint NOT NULL,
    note character varying(2048)
);


ALTER TABLE public.scrutini_valutazioni_qualifiche OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 227 (class 1259 OID 2526588)
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

SET default_with_oids = true;

--
-- TOC entry 210 (class 1259 OID 2228532)
-- Name: tipi_comunicazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_comunicazione (
    tipo_comunicazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL,
    gestione_notifica boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tipi_comunicazione OWNER TO postgres;

--
-- TOC entry 3159 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN tipi_comunicazione.gestione_notifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN tipi_comunicazione.gestione_notifica IS 'indica se quel tipo di comunicazione gestisce le notifiche';


--
-- TOC entry 211 (class 1259 OID 2228536)
-- Name: tipi_voto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_voto (
    tipo_voto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(60) NOT NULL,
    materia bigint NOT NULL
);


ALTER TABLE public.tipi_voto OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 2781366)
-- Name: uscite_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW uscite_ex AS
 SELECT ca.classe, 
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
   FROM ((((((((uscite u
   JOIN classi_alunni ca ON ((u.alunno = ca.alunno)))
   JOIN classi c ON ((c.classe = ca.classe)))
   JOIN anni_scolastici asco ON ((asco.anno_scolastico = c.anno_scolastico)))
   JOIN persone alu ON ((ca.alunno = alu.persona)))
   JOIN persone doc ON ((u.docente = doc.persona)))
   LEFT JOIN giustificazioni g ON ((g.giustificazione = u.giustificazione)))
   LEFT JOIN persone pcre ON ((pcre.persona = g.creata_da)))
   LEFT JOIN persone preg ON ((preg.persona = g.registrata_da)))
  WHERE ((u.giorno >= asco.inizio_lezioni) AND (u.giorno <= asco.fine_lezioni));


ALTER TABLE public.uscite_ex OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 3245412)
-- Name: usenames_rolnames; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usenames_rolnames AS
 SELECT (members.rolname)::character varying AS usename, 
    (roles.rolname)::character varying AS rolname
   FROM ((pg_authid roles
   JOIN pg_auth_members links ON ((links.roleid = roles.oid)))
   JOIN pg_authid members ON ((links.member = members.oid)));


ALTER TABLE public.usenames_rolnames OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 2228555)
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
    note character varying(160),
    conversazione bigint,
    privato boolean DEFAULT false NOT NULL,
    docente bigint NOT NULL,
    giorno date NOT NULL
);


ALTER TABLE public.valutazioni OWNER TO postgres;

--
-- TOC entry 3162 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE valutazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni IS 'Contiene le valutazioni di tutti gli alunni fatti da tutti gli insegnati ';


--
-- TOC entry 3163 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN valutazioni.privato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.privato IS 'Indica che il voto è visibile al solo docente che lo ha inserito';


--
-- TOC entry 3164 (class 0 OID 0)
-- Dependencies: 215
-- Name: COLUMN valutazioni.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.docente IS 'La colonna docente è stata inserita poichè il docente durante l`anno potrebbe cambiare in questo modo viene tenuto traccia di chi ha inserito il dato';


--
-- TOC entry 216 (class 1259 OID 2228560)
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
-- TOC entry 3166 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE valutazioni_qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni_qualifiche IS 'Per ogni valutazione inserita nella tabella valutazioni è possibile collegare anche la valutazione delle qualifiche collegate che vengono memorizzate qui';


--
-- TOC entry 217 (class 1259 OID 2228567)
-- Name: voti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE voti (
    voto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    metrica bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    millesimi smallint NOT NULL
);


ALTER TABLE public.voti OWNER TO postgres;

--
-- TOC entry 3168 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE voti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE voti IS 'Contiene i voti delle varie metriche';


--
-- TOC entry 2425 (class 2606 OID 2228572)
-- Name: anni_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_pk PRIMARY KEY (anno_scolastico);


--
-- TOC entry 2427 (class 2606 OID 2228574)
-- Name: anni_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 3170 (class 0 OID 0)
-- Dependencies: 2427
-- Name: CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici IS 'La descrizione deve essere univoca all''interno di un istituto';


--
-- TOC entry 2431 (class 2606 OID 2228576)
-- Name: argomenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_pk PRIMARY KEY (argomento);


--
-- TOC entry 2433 (class 2606 OID 3237227)
-- Name: argomenti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_uq_descrizione UNIQUE (indirizzo_scolastico, anno_corso, materia, descrizione);


--
-- TOC entry 2438 (class 2606 OID 2228580)
-- Name: assenze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_pk PRIMARY KEY (assenza);


--
-- TOC entry 2449 (class 2606 OID 2764978)
-- Name: classi_alunni_fx_alunno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fx_alunno UNIQUE (alunno);


--
-- TOC entry 2452 (class 2606 OID 2228582)
-- Name: classi_alunni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_pk PRIMARY KEY (classe_alunno);


--
-- TOC entry 2443 (class 2606 OID 2228586)
-- Name: classi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_pk PRIMARY KEY (classe);


--
-- TOC entry 2445 (class 2606 OID 2228588)
-- Name: classi_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_classe UNIQUE (anno_scolastico, plesso, indirizzo_scolastico, sezione, anno_corso);


--
-- TOC entry 2447 (class 2606 OID 2228590)
-- Name: classi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_descrizione UNIQUE (anno_scolastico, plesso, descrizione);


--
-- TOC entry 2456 (class 2606 OID 2228592)
-- Name: colloqui_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_pk PRIMARY KEY (colloquio);


--
-- TOC entry 2458 (class 2606 OID 3245620)
-- Name: colloqui_uq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_uq UNIQUE (docente, il);


--
-- TOC entry 3171 (class 0 OID 0)
-- Dependencies: 2458
-- Name: CONSTRAINT colloqui_uq ON colloqui; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT colloqui_uq ON colloqui IS 'Un docente non può avere più di un colloquio in un determinato momento';


--
-- TOC entry 2461 (class 2606 OID 2228594)
-- Name: comuni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_pk PRIMARY KEY (comune);


--
-- TOC entry 2463 (class 2606 OID 3245635)
-- Name: comuni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_uq_descrizione UNIQUE (descrizione, provincia);


--
-- TOC entry 3172 (class 0 OID 0)
-- Dependencies: 2463
-- Name: CONSTRAINT comuni_uq_descrizione ON comuni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT comuni_uq_descrizione ON comuni IS 'Non ci possono essere due comuni con la stessa descrizione nella stessa provincia';


--
-- TOC entry 2688 (class 2606 OID 2781440)
-- Name: conversazioni_invitati_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_pk PRIMARY KEY (conversazione_invitato);


--
-- TOC entry 2690 (class 2606 OID 3245643)
-- Name: conversazioni_invitati_uq_invitato; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_uq_invitato UNIQUE (conversazione, invitato);


--
-- TOC entry 3173 (class 0 OID 0)
-- Dependencies: 2690
-- Name: CONSTRAINT conversazioni_invitati_uq_invitato ON conversazioni_invitati; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT conversazioni_invitati_uq_invitato ON conversazioni_invitati IS 'Non è possibile, per una determinata conversazione, invitare la stessa persona più volte';


--
-- TOC entry 2466 (class 2606 OID 2228596)
-- Name: conversazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_pk PRIMARY KEY (conversazione);


--
-- TOC entry 2469 (class 2606 OID 2228598)
-- Name: festivi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_pk PRIMARY KEY (festivo);


--
-- TOC entry 2471 (class 2606 OID 2228600)
-- Name: festivi_uq_giorno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_uq_giorno UNIQUE (istituto, giorno);


--
-- TOC entry 3174 (class 0 OID 0)
-- Dependencies: 2471
-- Name: CONSTRAINT festivi_uq_giorno ON festivi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT festivi_uq_giorno ON festivi IS 'Nello stesso istituto ogni giorno deve essere indicato al massimo una volta';


--
-- TOC entry 2475 (class 2606 OID 2228602)
-- Name: firme_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_pk PRIMARY KEY (firma);


--
-- TOC entry 2477 (class 2606 OID 3245638)
-- Name: firme_uq_docente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_uq_docente UNIQUE (classe, giorno, ora);


--
-- TOC entry 3175 (class 0 OID 0)
-- Dependencies: 2477
-- Name: CONSTRAINT firme_uq_docente ON firme; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT firme_uq_docente ON firme IS 'Un docente non può firmare più di una volta nello stesso giorno e  nella stessa ora (indipendentemente dalla classe)';


--
-- TOC entry 2479 (class 2606 OID 2228604)
-- Name: fuori_classe_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_pk PRIMARY KEY (fuori_classe);


--
-- TOC entry 2486 (class 2606 OID 2228606)
-- Name: giustificazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_pk PRIMARY KEY (giustificazione);


--
-- TOC entry 2489 (class 2606 OID 2228626)
-- Name: indirizzi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi
    ADD CONSTRAINT indirizzi_pk PRIMARY KEY (indirizzo);


--
-- TOC entry 2492 (class 2606 OID 2228628)
-- Name: indirizzi_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_pk PRIMARY KEY (indirizzo_scolastico);


--
-- TOC entry 2494 (class 2606 OID 2228630)
-- Name: indirizzi_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2496 (class 2606 OID 2228632)
-- Name: istituti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_pk PRIMARY KEY (istituto);


--
-- TOC entry 2498 (class 2606 OID 2228634)
-- Name: istituti_uq_codice_meccanografico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_codice_meccanografico UNIQUE (codice_meccanografico);


--
-- TOC entry 2500 (class 2606 OID 2228636)
-- Name: istituti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2502 (class 2606 OID 2228638)
-- Name: istituti_uq_mnemonico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_mnemonico UNIQUE (mnemonico);


--
-- TOC entry 2507 (class 2606 OID 2228640)
-- Name: lezioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_pk PRIMARY KEY (lezione);


--
-- TOC entry 2512 (class 2606 OID 2228642)
-- Name: mancanze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_pk PRIMARY KEY (mancanza);


--
-- TOC entry 2515 (class 2606 OID 2228644)
-- Name: materie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_pk PRIMARY KEY (materia);


--
-- TOC entry 2517 (class 2606 OID 2228646)
-- Name: materie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2527 (class 2606 OID 2228648)
-- Name: messaggi_letti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_pk PRIMARY KEY (messaggio_letto);


--
-- TOC entry 2521 (class 2606 OID 2228650)
-- Name: messaggi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_pk PRIMARY KEY (messaggio);


--
-- TOC entry 2529 (class 2606 OID 2228652)
-- Name: messaggi_sistema_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_sistema
    ADD CONSTRAINT messaggi_sistema_pk PRIMARY KEY (messaggio_sistema);


--
-- TOC entry 2531 (class 2606 OID 2407198)
-- Name: messaggi_sistema_uq_id; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_sistema
    ADD CONSTRAINT messaggi_sistema_uq_id UNIQUE (function_name, id, lingua);


--
-- TOC entry 2523 (class 2606 OID 2781406)
-- Name: messaggi_uq_da; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_uq_da UNIQUE (conversazione, scritto_il, testo, da);


--
-- TOC entry 2534 (class 2606 OID 2228658)
-- Name: metriche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_pk PRIMARY KEY (metrica);


--
-- TOC entry 2536 (class 2606 OID 2228660)
-- Name: metriche_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2540 (class 2606 OID 2228662)
-- Name: mezzi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_pk PRIMARY KEY (mezzo_comunicazione);


--
-- TOC entry 2542 (class 2606 OID 2228664)
-- Name: mezzi_di_comunicazione_uq_percorso; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_di_comunicazione_uq_percorso UNIQUE (persona, tipo_comunicazione, descrizione, percorso);


--
-- TOC entry 2544 (class 2606 OID 2228666)
-- Name: nazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_pk PRIMARY KEY (nazione);


--
-- TOC entry 2546 (class 2606 OID 2228668)
-- Name: nazioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2555 (class 2606 OID 2228670)
-- Name: note_docenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_pk PRIMARY KEY (nota_docente);


--
-- TOC entry 2550 (class 2606 OID 2228672)
-- Name: note_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_pk PRIMARY KEY (nota);


--
-- TOC entry 2696 (class 2606 OID 2781625)
-- Name: note_visti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_pk PRIMARY KEY (nota_visto);


--
-- TOC entry 2668 (class 2606 OID 2389077)
-- Name: orari_settimanali_giorni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_pk PRIMARY KEY (orario_settimanale_giorno);


--
-- TOC entry 2558 (class 2606 OID 2228674)
-- Name: orari_settimanali_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_pk PRIMARY KEY (orario_settimanale);


--
-- TOC entry 2567 (class 2606 OID 2228676)
-- Name: persone_indirizzi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_pk PRIMARY KEY (persona_indirizzo);


--
-- TOC entry 2563 (class 2606 OID 2228680)
-- Name: persone_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_pk PRIMARY KEY (persona);


--
-- TOC entry 2571 (class 2606 OID 2228678)
-- Name: persone_relazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_pk PRIMARY KEY (persona_relazione);


--
-- TOC entry 2574 (class 2606 OID 2228682)
-- Name: plessi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_pk PRIMARY KEY (plesso);


--
-- TOC entry 2576 (class 2606 OID 2228684)
-- Name: plessi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2578 (class 2606 OID 2228686)
-- Name: provincie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_pk PRIMARY KEY (provincia);


--
-- TOC entry 2580 (class 2606 OID 2228688)
-- Name: provincie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2585 (class 2606 OID 2228690)
-- Name: qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_pk PRIMARY KEY (qualifica);


--
-- TOC entry 2686 (class 2606 OID 2536658)
-- Name: qualifiche_pof_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_pk PRIMARY KEY (qualifica_pof);


--
-- TOC entry 2587 (class 2606 OID 2228692)
-- Name: regioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_pk PRIMARY KEY (regione);


--
-- TOC entry 2589 (class 2606 OID 2228694)
-- Name: regioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2594 (class 2606 OID 2228696)
-- Name: ritardi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_pk PRIMARY KEY (ritardo);


--
-- TOC entry 2597 (class 2606 OID 2228698)
-- Name: scrutini_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_pk PRIMARY KEY (scrutinio);


--
-- TOC entry 2599 (class 2606 OID 2228700)
-- Name: scrutini_uq_data; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_data UNIQUE (anno_scolastico, data);


--
-- TOC entry 2601 (class 2606 OID 2228702)
-- Name: scrutini_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_descrizione UNIQUE (anno_scolastico, descrizione);


--
-- TOC entry 2609 (class 2606 OID 2228704)
-- Name: scrutini_valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_pk PRIMARY KEY (scrutinio_valutazione);


--
-- TOC entry 2615 (class 2606 OID 2228706)
-- Name: scrutini_valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_pk PRIMARY KEY (scrutinio_valutazione_qualifica);


--
-- TOC entry 2617 (class 2606 OID 2228708)
-- Name: scrutini_valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_uq_qualifica UNIQUE (scrutinio_valutazione, qualifica);


--
-- TOC entry 2677 (class 2606 OID 2526593)
-- Name: spazi_lavoro_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_pk PRIMARY KEY (spazio_lavoro);


--
-- TOC entry 2679 (class 2606 OID 2526595)
-- Name: spazi_lavoro_uq; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_uq UNIQUE (utente, istituto, anno_scolastico, classe, materia);


--
-- TOC entry 2681 (class 2606 OID 3245595)
-- Name: spazi_lavoro_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_uq_descrizione UNIQUE (utente, descrizione);


--
-- TOC entry 2619 (class 2606 OID 2228710)
-- Name: tipi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_pk PRIMARY KEY (tipo_comunicazione);


--
-- TOC entry 2621 (class 2606 OID 2228712)
-- Name: tipi_comunicazione_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2623 (class 2606 OID 2228714)
-- Name: tipi_voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voti_uq_descrizione UNIQUE (materia, descrizione);


--
-- TOC entry 2626 (class 2606 OID 2228716)
-- Name: tipi_voto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_pk PRIMARY KEY (tipo_voto);


--
-- TOC entry 2631 (class 2606 OID 2228718)
-- Name: uscite_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_pk PRIMARY KEY (uscita);


--
-- TOC entry 2641 (class 2606 OID 2228720)
-- Name: utenti_istituti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_pk PRIMARY KEY (utente_istituto);


--
-- TOC entry 2643 (class 2606 OID 3245677)
-- Name: utenti_istituti_uq_persona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_uq_persona UNIQUE (persona);


--
-- TOC entry 3176 (class 0 OID 0)
-- Dependencies: 2643
-- Name: CONSTRAINT utenti_istituti_uq_persona ON utenti_istituti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT utenti_istituti_uq_persona ON utenti_istituti IS 'Una persona può essere associata ad un utente e ad un istituto una sola volta';


--
-- TOC entry 2645 (class 2606 OID 2228722)
-- Name: utenti_istituti_uq_utente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_uq_utente UNIQUE (utente, istituto);


--
-- TOC entry 3177 (class 0 OID 0)
-- Dependencies: 2645
-- Name: CONSTRAINT utenti_istituti_uq_utente ON utenti_istituti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT utenti_istituti_uq_utente ON utenti_istituti IS 'Ogni utente può avere una solo associazione con un istituto';


--
-- TOC entry 2634 (class 2606 OID 2228724)
-- Name: utenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_pk PRIMARY KEY (utente);


--
-- TOC entry 2636 (class 2606 OID 2781646)
-- Name: utenti_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_uq_usename UNIQUE (usename);


--
-- TOC entry 3178 (class 0 OID 0)
-- Dependencies: 2636
-- Name: CONSTRAINT utenti_uq_usename ON utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT utenti_uq_usename ON utenti IS 'ad ogni utente di sistema deve corrispondere un solo utente ';


--
-- TOC entry 2651 (class 2606 OID 2228730)
-- Name: valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_pk PRIMARY KEY (valutazione);


--
-- TOC entry 2656 (class 2606 OID 2228732)
-- Name: valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_pk PRIMARY KEY (valutazione_qualifica);


--
-- TOC entry 2658 (class 2606 OID 2228734)
-- Name: valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_uq_qualifica UNIQUE (valutazione, qualifica);


--
-- TOC entry 2661 (class 2606 OID 2228736)
-- Name: voti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_pk PRIMARY KEY (voto);


--
-- TOC entry 2663 (class 2606 OID 2228738)
-- Name: voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_uq_descrizione UNIQUE (metrica, descrizione);


--
-- TOC entry 2423 (class 1259 OID 2228739)
-- Name: anni_scolastici_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX anni_scolastici_fx_istituto ON anni_scolastici USING btree (istituto);


--
-- TOC entry 2428 (class 1259 OID 2228740)
-- Name: argomenti_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_fx_indirizzo_scolastico ON argomenti USING btree (indirizzo_scolastico);


--
-- TOC entry 2429 (class 1259 OID 2228741)
-- Name: argomenti_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_fx_materia ON argomenti USING btree (materia);


--
-- TOC entry 3179 (class 0 OID 0)
-- Dependencies: 2429
-- Name: INDEX argomenti_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX argomenti_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2434 (class 1259 OID 2228742)
-- Name: assenze_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_alunno ON assenze USING btree (alunno);


--
-- TOC entry 3180 (class 0 OID 0)
-- Dependencies: 2434
-- Name: INDEX assenze_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2435 (class 1259 OID 2228743)
-- Name: assenze_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_docente ON assenze USING btree (docente);


--
-- TOC entry 3181 (class 0 OID 0)
-- Dependencies: 2435
-- Name: INDEX assenze_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2436 (class 1259 OID 2228744)
-- Name: assenze_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_fx_giustificazione ON assenze USING btree (giustificazione);


--
-- TOC entry 3182 (class 0 OID 0)
-- Dependencies: 2436
-- Name: INDEX assenze_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2450 (class 1259 OID 2228746)
-- Name: classi_alunni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_alunni_fx_classe ON classi_alunni USING btree (classe);


--
-- TOC entry 3183 (class 0 OID 0)
-- Dependencies: 2450
-- Name: INDEX classi_alunni_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_alunni_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2439 (class 1259 OID 2228747)
-- Name: classi_fx_anno_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_anno_scolastico ON classi USING btree (anno_scolastico);


--
-- TOC entry 3184 (class 0 OID 0)
-- Dependencies: 2439
-- Name: INDEX classi_fx_anno_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_fx_anno_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2440 (class 1259 OID 2228748)
-- Name: classi_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_indirizzo_scolastico ON classi USING btree (indirizzo_scolastico);


--
-- TOC entry 3185 (class 0 OID 0)
-- Dependencies: 2440
-- Name: INDEX classi_fx_indirizzo_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_fx_indirizzo_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2441 (class 1259 OID 2228749)
-- Name: classi_fx_plesso; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_fx_plesso ON classi USING btree (plesso);


--
-- TOC entry 2453 (class 1259 OID 2228750)
-- Name: colloqui_fx_con; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_fx_con ON colloqui USING btree (con);


--
-- TOC entry 2454 (class 1259 OID 2228751)
-- Name: colloqui_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_fx_docente ON colloqui USING btree (docente);


--
-- TOC entry 2459 (class 1259 OID 2228756)
-- Name: comuni_fx_provincia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX comuni_fx_provincia ON comuni USING btree (provincia);


--
-- TOC entry 2464 (class 1259 OID 2228752)
-- Name: conversazioni_fx_libretto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_fx_libretto ON conversazioni USING btree (libretto);


--
-- TOC entry 3186 (class 0 OID 0)
-- Dependencies: 2464
-- Name: INDEX conversazioni_fx_libretto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX conversazioni_fx_libretto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2691 (class 1259 OID 2781427)
-- Name: conversazioni_partecipanti_fx_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_partecipanti_fx_conversazione ON conversazioni_invitati USING btree (conversazione);


--
-- TOC entry 2692 (class 1259 OID 2781433)
-- Name: conversazioni_partecipanti_fx_partecipante; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_partecipanti_fx_partecipante ON conversazioni_invitati USING btree (invitato);


--
-- TOC entry 2467 (class 1259 OID 2228753)
-- Name: festivi_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX festivi_fx_istituto ON festivi USING btree (istituto);


--
-- TOC entry 3187 (class 0 OID 0)
-- Dependencies: 2467
-- Name: INDEX festivi_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX festivi_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2472 (class 1259 OID 2228754)
-- Name: firme_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_fx_classe ON firme USING btree (classe);


--
-- TOC entry 3188 (class 0 OID 0)
-- Dependencies: 2472
-- Name: INDEX firme_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2473 (class 1259 OID 2228755)
-- Name: firme_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_fx_docente ON firme USING btree (docente);


--
-- TOC entry 3189 (class 0 OID 0)
-- Dependencies: 2473
-- Name: INDEX firme_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2480 (class 1259 OID 2228757)
-- Name: fuori_classi_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_fx_alunno ON fuori_classi USING btree (alunno);


--
-- TOC entry 3190 (class 0 OID 0)
-- Dependencies: 2480
-- Name: INDEX fuori_classi_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2481 (class 1259 OID 2228758)
-- Name: fuori_classi_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_fx_docente ON fuori_classi USING btree (addetto_scolastico);


--
-- TOC entry 3191 (class 0 OID 0)
-- Dependencies: 2481
-- Name: INDEX fuori_classi_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2482 (class 1259 OID 2228760)
-- Name: giustificazioni_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_alunno ON giustificazioni USING btree (alunno);


--
-- TOC entry 3192 (class 0 OID 0)
-- Dependencies: 2482
-- Name: INDEX giustificazioni_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2483 (class 1259 OID 2781533)
-- Name: giustificazioni_fx_creata_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_creata_da ON giustificazioni USING btree (creata_da);


--
-- TOC entry 2484 (class 1259 OID 2781539)
-- Name: giustificazioni_fx_usata_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_fx_usata_da ON giustificazioni USING btree (registrata_da);


--
-- TOC entry 2693 (class 1259 OID 2781626)
-- Name: idx_note_visti; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_note_visti ON note_visti USING btree (persona);


--
-- TOC entry 2694 (class 1259 OID 2781632)
-- Name: idx_note_visti_0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_note_visti_0 ON note_visti USING btree (nota);


--
-- TOC entry 2669 (class 1259 OID 3245419)
-- Name: idx_spazi_lavoro; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro ON spazi_lavoro USING btree (docente);


--
-- TOC entry 2670 (class 1259 OID 3245425)
-- Name: idx_spazi_lavoro_0; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro_0 ON spazi_lavoro USING btree (famigliare);


--
-- TOC entry 2671 (class 1259 OID 3245431)
-- Name: idx_spazi_lavoro_1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_spazi_lavoro_1 ON spazi_lavoro USING btree (alunno);


--
-- TOC entry 2632 (class 1259 OID 2781639)
-- Name: idx_utenti; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_utenti ON utenti USING btree (spazio_lavoro);


--
-- TOC entry 2637 (class 1259 OID 2797592)
-- Name: idx_utenti_istituti; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_utenti_istituti ON utenti_istituti USING btree (persona);


--
-- TOC entry 2487 (class 1259 OID 2228768)
-- Name: indirizzi_fx_nazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indirizzi_fx_nazione ON indirizzi USING btree (nazione);


--
-- TOC entry 3193 (class 0 OID 0)
-- Dependencies: 2487
-- Name: INDEX indirizzi_fx_nazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX indirizzi_fx_nazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2490 (class 1259 OID 2228769)
-- Name: indirizzi_scolastici_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indirizzi_scolastici_fx_istituto ON indirizzi_scolastici USING btree (istituto);


--
-- TOC entry 3194 (class 0 OID 0)
-- Dependencies: 2490
-- Name: INDEX indirizzi_scolastici_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX indirizzi_scolastici_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2503 (class 1259 OID 2228770)
-- Name: lezioni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_classe ON lezioni USING btree (classe);


--
-- TOC entry 3195 (class 0 OID 0)
-- Dependencies: 2503
-- Name: INDEX lezioni_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2504 (class 1259 OID 2228771)
-- Name: lezioni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_docente ON lezioni USING btree (docente);


--
-- TOC entry 3196 (class 0 OID 0)
-- Dependencies: 2504
-- Name: INDEX lezioni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2505 (class 1259 OID 2228772)
-- Name: lezioni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_fx_materia ON lezioni USING btree (materia);


--
-- TOC entry 3197 (class 0 OID 0)
-- Dependencies: 2505
-- Name: INDEX lezioni_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2524 (class 1259 OID 2228773)
-- Name: libretti_messaggi_letti_fx_libretto_mess; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_fx_libretto_mess ON messaggi_letti USING btree (messaggio);


--
-- TOC entry 3198 (class 0 OID 0)
-- Dependencies: 2524
-- Name: INDEX libretti_messaggi_letti_fx_libretto_mess; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_fx_libretto_mess IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2525 (class 1259 OID 2228774)
-- Name: libretti_messaggi_letti_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_fx_persona ON messaggi_letti USING btree (da);


--
-- TOC entry 3199 (class 0 OID 0)
-- Dependencies: 2525
-- Name: INDEX libretti_messaggi_letti_fx_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_fx_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2508 (class 1259 OID 2228775)
-- Name: mancanze_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_fx_alunno ON mancanze USING btree (alunno);


--
-- TOC entry 3200 (class 0 OID 0)
-- Dependencies: 2508
-- Name: INDEX mancanze_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2509 (class 1259 OID 2228776)
-- Name: mancanze_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_fx_docente ON mancanze USING btree (docente);


--
-- TOC entry 3201 (class 0 OID 0)
-- Dependencies: 2509
-- Name: INDEX mancanze_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2510 (class 1259 OID 2228777)
-- Name: mancanze_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_fx_giustificazione ON mancanze USING btree (giustificazione);


--
-- TOC entry 3202 (class 0 OID 0)
-- Dependencies: 2510
-- Name: INDEX mancanze_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2513 (class 1259 OID 2228778)
-- Name: materie_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX materie_fx_istituto ON materie USING btree (istituto);


--
-- TOC entry 3203 (class 0 OID 0)
-- Dependencies: 2513
-- Name: INDEX materie_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX materie_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2518 (class 1259 OID 2228780)
-- Name: messaggi_fx_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_fx_conversazione ON messaggi USING btree (conversazione);


--
-- TOC entry 3204 (class 0 OID 0)
-- Dependencies: 2518
-- Name: INDEX messaggi_fx_conversazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_fx_conversazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2519 (class 1259 OID 2228781)
-- Name: messaggi_fx_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_fx_da ON messaggi USING btree (da);


--
-- TOC entry 3205 (class 0 OID 0)
-- Dependencies: 2519
-- Name: INDEX messaggi_fx_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_fx_da IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2532 (class 1259 OID 2228782)
-- Name: metriche_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX metriche_fx_istituto ON metriche USING btree (istituto);


--
-- TOC entry 3206 (class 0 OID 0)
-- Dependencies: 2532
-- Name: INDEX metriche_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX metriche_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2537 (class 1259 OID 2228783)
-- Name: mezzi_comunicazione_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_persona ON mezzi_comunicazione USING btree (persona);


--
-- TOC entry 3207 (class 0 OID 0)
-- Dependencies: 2537
-- Name: INDEX mezzi_comunicazione_ix_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2538 (class 1259 OID 2228784)
-- Name: mezzi_comunicazione_ix_tipo_comunicazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_tipo_comunicazione ON mezzi_comunicazione USING btree (tipo_comunicazione);


--
-- TOC entry 3208 (class 0 OID 0)
-- Dependencies: 2538
-- Name: INDEX mezzi_comunicazione_ix_tipo_comunicazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_tipo_comunicazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2551 (class 1259 OID 2228785)
-- Name: note_docenti_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_alunno ON note_docenti USING btree (alunno);


--
-- TOC entry 3209 (class 0 OID 0)
-- Dependencies: 2551
-- Name: INDEX note_docenti_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2552 (class 1259 OID 2830175)
-- Name: note_docenti_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_classe ON note_docenti USING btree (classe);


--
-- TOC entry 2553 (class 1259 OID 2228786)
-- Name: note_docenti_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_fx_docente ON note_docenti USING btree (docente);


--
-- TOC entry 3210 (class 0 OID 0)
-- Dependencies: 2553
-- Name: INDEX note_docenti_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2547 (class 1259 OID 2228787)
-- Name: note_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_fx_alunno ON note USING btree (alunno);


--
-- TOC entry 3211 (class 0 OID 0)
-- Dependencies: 2547
-- Name: INDEX note_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2548 (class 1259 OID 2228789)
-- Name: note_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_fx_docente ON note USING btree (docente);


--
-- TOC entry 3212 (class 0 OID 0)
-- Dependencies: 2548
-- Name: INDEX note_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2556 (class 1259 OID 2228790)
-- Name: orari_settimanali_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_fx_classe ON orari_settimanali USING btree (classe);


--
-- TOC entry 3213 (class 0 OID 0)
-- Dependencies: 2556
-- Name: INDEX orari_settimanali_fx_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_fx_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2664 (class 1259 OID 2389094)
-- Name: orari_settimanali_giorni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_docente ON orari_settimanali_giorni USING btree (docente);


--
-- TOC entry 3214 (class 0 OID 0)
-- Dependencies: 2664
-- Name: INDEX orari_settimanali_giorni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2665 (class 1259 OID 2389095)
-- Name: orari_settimanali_giorni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_materia ON orari_settimanali_giorni USING btree (materia);


--
-- TOC entry 3215 (class 0 OID 0)
-- Dependencies: 2665
-- Name: INDEX orari_settimanali_giorni_fx_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2666 (class 1259 OID 2389093)
-- Name: orari_settimanali_giorni_fx_orario_settimanale; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_giorni_fx_orario_settimanale ON orari_settimanali_giorni USING btree (orario_settimanale);


--
-- TOC entry 3216 (class 0 OID 0)
-- Dependencies: 2666
-- Name: INDEX orari_settimanali_giorni_fx_orario_settimanale; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_giorni_fx_orario_settimanale IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2559 (class 1259 OID 2228795)
-- Name: persone_fx_comune_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_comune_nascita ON persone USING btree (comune_nascita);


--
-- TOC entry 2560 (class 1259 OID 2228796)
-- Name: persone_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_istituto ON persone USING btree (istituto);


--
-- TOC entry 2561 (class 1259 OID 2228797)
-- Name: persone_fx_nazione_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_fx_nazione_nascita ON persone USING btree (nazione_nascita);


--
-- TOC entry 2564 (class 1259 OID 2228793)
-- Name: persone_indirizzi_fx_indirizzo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_fx_indirizzo ON persone_indirizzi USING btree (indirizzo);


--
-- TOC entry 2565 (class 1259 OID 2228794)
-- Name: persone_indirizzi_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_fx_persona ON persone_indirizzi USING btree (persona);


--
-- TOC entry 2568 (class 1259 OID 2228799)
-- Name: persone_relazioni_fx_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_relazioni_fx_persona ON persone_relazioni USING btree (persona);


--
-- TOC entry 3217 (class 0 OID 0)
-- Dependencies: 2568
-- Name: INDEX persone_relazioni_fx_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_relazioni_fx_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2569 (class 1259 OID 2228798)
-- Name: persone_relazioni_fx_persona_relazionata; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_relazioni_fx_persona_relazionata ON persone_relazioni USING btree (persona_relazionata);


--
-- TOC entry 3218 (class 0 OID 0)
-- Dependencies: 2569
-- Name: INDEX persone_relazioni_fx_persona_relazionata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_relazioni_fx_persona_relazionata IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2572 (class 1259 OID 2228800)
-- Name: plessi_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX plessi_fx_istituto ON plessi USING btree (istituto);


--
-- TOC entry 2581 (class 1259 OID 2228802)
-- Name: qualifiche_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_istituto ON qualifiche USING btree (istituto);


--
-- TOC entry 3219 (class 0 OID 0)
-- Dependencies: 2581
-- Name: INDEX qualifiche_fx_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_fx_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2582 (class 1259 OID 2228804)
-- Name: qualifiche_fx_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_metrica ON qualifiche USING btree (metrica);


--
-- TOC entry 3220 (class 0 OID 0)
-- Dependencies: 2582
-- Name: INDEX qualifiche_fx_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_fx_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2583 (class 1259 OID 2536648)
-- Name: qualifiche_fx_riferimento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_fx_riferimento ON qualifiche USING btree (qualifica_padre);


--
-- TOC entry 2682 (class 1259 OID 2536665)
-- Name: qualifiche_pof_fx_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_indirizzo_scolastico ON qualifiche_pof USING btree (indirizzo_scolastico);


--
-- TOC entry 2683 (class 1259 OID 2536677)
-- Name: qualifiche_pof_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_materia ON qualifiche_pof USING btree (materia);


--
-- TOC entry 2684 (class 1259 OID 2536659)
-- Name: qualifiche_pof_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_pof_fx_qualifica ON qualifiche_pof USING btree (qualifica);


--
-- TOC entry 2590 (class 1259 OID 2228805)
-- Name: ritardi_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_alunno ON ritardi USING btree (alunno);


--
-- TOC entry 3221 (class 0 OID 0)
-- Dependencies: 2590
-- Name: INDEX ritardi_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2591 (class 1259 OID 2228806)
-- Name: ritardi_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_docente ON ritardi USING btree (docente);


--
-- TOC entry 3222 (class 0 OID 0)
-- Dependencies: 2591
-- Name: INDEX ritardi_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2592 (class 1259 OID 2228807)
-- Name: ritardi_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_fx_giustificazione ON ritardi USING btree (giustificazione);


--
-- TOC entry 3223 (class 0 OID 0)
-- Dependencies: 2592
-- Name: INDEX ritardi_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2595 (class 1259 OID 2228808)
-- Name: scrutini_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_fx_istituto ON scrutini USING btree (anno_scolastico);


--
-- TOC entry 2602 (class 1259 OID 2228809)
-- Name: scrutini_valutazioni_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_alunno ON scrutini_valutazioni USING btree (alunno);


--
-- TOC entry 2603 (class 1259 OID 2228810)
-- Name: scrutini_valutazioni_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_classe ON scrutini_valutazioni USING btree (classe);


--
-- TOC entry 2604 (class 1259 OID 2228811)
-- Name: scrutini_valutazioni_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_materia ON scrutini_valutazioni USING btree (materia);


--
-- TOC entry 2605 (class 1259 OID 2228812)
-- Name: scrutini_valutazioni_fx_scrutinio; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_scrutinio ON scrutini_valutazioni USING btree (scrutinio);


--
-- TOC entry 2606 (class 1259 OID 2228814)
-- Name: scrutini_valutazioni_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_voto ON scrutini_valutazioni USING btree (voto);


--
-- TOC entry 2607 (class 1259 OID 2228815)
-- Name: scrutini_valutazioni_fx_voto_proposto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_fx_voto_proposto ON scrutini_valutazioni USING btree (voto_proposto);


--
-- TOC entry 2610 (class 1259 OID 2228816)
-- Name: scrutini_valutazioni_qualifiche_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_qualifica ON scrutini_valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 3224 (class 0 OID 0)
-- Dependencies: 2610
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2611 (class 1259 OID 2228817)
-- Name: scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione ON scrutini_valutazioni_qualifiche USING btree (scrutinio_valutazione);


--
-- TOC entry 3225 (class 0 OID 0)
-- Dependencies: 2611
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_scrutinio_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2612 (class 1259 OID 2228818)
-- Name: scrutini_valutazioni_qualifiche_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_voto ON scrutini_valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 3226 (class 0 OID 0)
-- Dependencies: 2612
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2613 (class 1259 OID 2228819)
-- Name: scrutini_valutazioni_qualifiche_fx_voto_proposto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_fx_voto_proposto ON scrutini_valutazioni_qualifiche USING btree (voto_proposto);


--
-- TOC entry 3227 (class 0 OID 0)
-- Dependencies: 2613
-- Name: INDEX scrutini_valutazioni_qualifiche_fx_voto_proposto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_fx_voto_proposto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2672 (class 1259 OID 2544927)
-- Name: spazi_lavoro_fx_anno_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_anno_scolastico ON spazi_lavoro USING btree (anno_scolastico);


--
-- TOC entry 2673 (class 1259 OID 2544933)
-- Name: spazi_lavoro_fx_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_classe ON spazi_lavoro USING btree (classe);


--
-- TOC entry 2674 (class 1259 OID 2544921)
-- Name: spazi_lavoro_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_istituto ON spazi_lavoro USING btree (istituto);


--
-- TOC entry 2675 (class 1259 OID 2544939)
-- Name: spazi_lavoro_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX spazi_lavoro_fx_materia ON spazi_lavoro USING btree (materia);


--
-- TOC entry 2624 (class 1259 OID 2228820)
-- Name: tipi_voto_fx_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX tipi_voto_fx_materia ON tipi_voto USING btree (materia);


--
-- TOC entry 2627 (class 1259 OID 2228821)
-- Name: uscite_fx_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_alunno ON uscite USING btree (alunno);


--
-- TOC entry 3228 (class 0 OID 0)
-- Dependencies: 2627
-- Name: INDEX uscite_fx_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_fx_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2628 (class 1259 OID 2228822)
-- Name: uscite_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_docente ON uscite USING btree (docente);


--
-- TOC entry 3229 (class 0 OID 0)
-- Dependencies: 2628
-- Name: INDEX uscite_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2629 (class 1259 OID 2228823)
-- Name: uscite_fx_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_fx_giustificazione ON uscite USING btree (giustificazione);


--
-- TOC entry 3230 (class 0 OID 0)
-- Dependencies: 2629
-- Name: INDEX uscite_fx_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_fx_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2638 (class 1259 OID 2228824)
-- Name: utenti_istituti_fx_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX utenti_istituti_fx_istituto ON utenti_istituti USING btree (istituto);


--
-- TOC entry 2639 (class 1259 OID 2228825)
-- Name: utenti_istituti_fx_utente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX utenti_istituti_fx_utente ON utenti_istituti USING btree (utente);


--
-- TOC entry 2646 (class 1259 OID 2228826)
-- Name: valutazioni_fx_argomento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_argomento ON valutazioni USING btree (argomento);


--
-- TOC entry 3231 (class 0 OID 0)
-- Dependencies: 2646
-- Name: INDEX valutazioni_fx_argomento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_argomento IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2647 (class 1259 OID 2228767)
-- Name: valutazioni_fx_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_conversazione ON valutazioni USING btree (conversazione);


--
-- TOC entry 2648 (class 1259 OID 2228827)
-- Name: valutazioni_fx_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_docente ON valutazioni USING btree (docente);


--
-- TOC entry 3232 (class 0 OID 0)
-- Dependencies: 2648
-- Name: INDEX valutazioni_fx_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2649 (class 1259 OID 2228828)
-- Name: valutazioni_fx_tipo_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_fx_tipo_voto ON valutazioni USING btree (tipo_voto);


--
-- TOC entry 3233 (class 0 OID 0)
-- Dependencies: 2649
-- Name: INDEX valutazioni_fx_tipo_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_fx_tipo_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2652 (class 1259 OID 2228829)
-- Name: valutazioni_qualifiche_fx_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_qualifica ON valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 3234 (class 0 OID 0)
-- Dependencies: 2652
-- Name: INDEX valutazioni_qualifiche_fx_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2653 (class 1259 OID 2228830)
-- Name: valutazioni_qualifiche_fx_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_valutazione ON valutazioni_qualifiche USING btree (valutazione);


--
-- TOC entry 3235 (class 0 OID 0)
-- Dependencies: 2653
-- Name: INDEX valutazioni_qualifiche_fx_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2654 (class 1259 OID 2228831)
-- Name: valutazioni_qualifiche_fx_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_fx_voto ON valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 3236 (class 0 OID 0)
-- Dependencies: 2654
-- Name: INDEX valutazioni_qualifiche_fx_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_fx_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2659 (class 1259 OID 2228832)
-- Name: voti_fx_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX voti_fx_metrica ON voti USING btree (metrica);


--
-- TOC entry 3237 (class 0 OID 0)
-- Dependencies: 2659
-- Name: INDEX voti_fx_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX voti_fx_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2929 (class 2618 OID 2228833)
-- Name: _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO residenza_grp_comune DO INSTEAD  SELECT p.istituto, 
    c.descrizione, 
    count(p.persona) AS count
   FROM (((persone p
   JOIN persone_indirizzi pi ON ((pi.persona = p.persona)))
   JOIN indirizzi i ON ((pi.indirizzo = i.indirizzo)))
   JOIN comuni c ON ((i.comune = c.comune)))
  WHERE (pi.tipo_indirizzo = 'Residenza'::tipo_indirizzo)
  GROUP BY p.istituto, c.comune;


--
-- TOC entry 2807 (class 2620 OID 3237244)
-- Name: argomenti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER argomenti_iu AFTER INSERT OR UPDATE ON argomenti FOR EACH ROW EXECUTE PROCEDURE tr_argomenti_iu();


--
-- TOC entry 2808 (class 2620 OID 3237242)
-- Name: assenze_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER assenze_iu AFTER INSERT OR UPDATE ON assenze FOR EACH ROW EXECUTE PROCEDURE tr_assenze_iu();


--
-- TOC entry 2810 (class 2620 OID 3245618)
-- Name: classi_alunni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classi_alunni_iu AFTER INSERT OR UPDATE ON classi_alunni FOR EACH ROW EXECUTE PROCEDURE tr_classi_alunni_iu();


--
-- TOC entry 2809 (class 2620 OID 3245602)
-- Name: classi_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classi_iu AFTER INSERT OR UPDATE ON classi FOR EACH ROW EXECUTE PROCEDURE tr_classi_iu();


--
-- TOC entry 2811 (class 2620 OID 3245626)
-- Name: colloqui_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER colloqui_iu AFTER INSERT OR UPDATE ON colloqui FOR EACH ROW EXECUTE PROCEDURE tr_colloqui_iu();


--
-- TOC entry 2821 (class 2620 OID 3245652)
-- Name: conversazioni_invitati_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER conversazioni_invitati_iu AFTER INSERT OR UPDATE ON conversazioni_invitati FOR EACH ROW EXECUTE PROCEDURE tr_conversazioni_invitati_iu();


--
-- TOC entry 2812 (class 2620 OID 3245699)
-- Name: firme_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER firme_iu AFTER INSERT OR UPDATE ON firme FOR EACH ROW EXECUTE PROCEDURE tr_firme_iu();


--
-- TOC entry 2813 (class 2620 OID 2796497)
-- Name: mezzi_comunicazione_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER mezzi_comunicazione_iu AFTER INSERT OR UPDATE ON mezzi_comunicazione FOR EACH ROW EXECUTE PROCEDURE tr_mezzi_comunicazione_iu();


--
-- TOC entry 2814 (class 2620 OID 2798058)
-- Name: note_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER note_iu AFTER INSERT OR UPDATE ON note FOR EACH ROW EXECUTE PROCEDURE tr_note_iu();


--
-- TOC entry 2815 (class 2620 OID 3245770)
-- Name: scrutini_valutazioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_iu AFTER INSERT OR UPDATE ON scrutini_valutazioni FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_iu();


--
-- TOC entry 2816 (class 2620 OID 3245808)
-- Name: scrutini_valutazioni_qualifiche_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scrutini_valutazioni_qualifiche_iu AFTER INSERT OR UPDATE ON scrutini_valutazioni_qualifiche FOR EACH ROW EXECUTE PROCEDURE tr_scrutini_valutazioni_qualifiche_iu();


--
-- TOC entry 2818 (class 2620 OID 3245799)
-- Name: utenti_istituti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER utenti_istituti_iu AFTER INSERT OR UPDATE ON utenti_istituti FOR EACH ROW EXECUTE PROCEDURE tr_utenti_istituti_iu();


--
-- TOC entry 2817 (class 2620 OID 2407195)
-- Name: utenti_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER utenti_iu AFTER INSERT OR UPDATE ON utenti FOR EACH ROW EXECUTE PROCEDURE tr_utenti_iu();


--
-- TOC entry 2819 (class 2620 OID 2493759)
-- Name: valutazioni_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutazioni_iu AFTER INSERT OR UPDATE ON valutazioni FOR EACH ROW EXECUTE PROCEDURE tr_valutazioni_iu();


--
-- TOC entry 2820 (class 2620 OID 3245786)
-- Name: valutazioni_qualifiche_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutazioni_qualifiche_iu AFTER INSERT OR UPDATE ON valutazioni_qualifiche FOR EACH ROW EXECUTE PROCEDURE tr_valutazioni_qualifiche_iu();


--
-- TOC entry 2697 (class 2606 OID 2228835)
-- Name: anni_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2698 (class 2606 OID 2228840)
-- Name: argomenti_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2699 (class 2606 OID 2228845)
-- Name: argomenti_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2700 (class 2606 OID 2228850)
-- Name: assenze_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2703 (class 2606 OID 2764979)
-- Name: assenze_fk_alunno_bis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_alunno_bis FOREIGN KEY (alunno) REFERENCES classi_alunni(alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2701 (class 2606 OID 2228855)
-- Name: assenze_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2702 (class 2606 OID 2228860)
-- Name: assenze_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2707 (class 2606 OID 2228865)
-- Name: classi_alunni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2708 (class 2606 OID 2228870)
-- Name: classi_alunni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2704 (class 2606 OID 2228875)
-- Name: classi_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2705 (class 2606 OID 2228880)
-- Name: classi_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2706 (class 2606 OID 2228885)
-- Name: classi_fk_plesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_plesso FOREIGN KEY (plesso) REFERENCES plessi(plesso) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2709 (class 2606 OID 2228890)
-- Name: colloqui_fk_con; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_con FOREIGN KEY (con) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2710 (class 2606 OID 2228895)
-- Name: colloqui_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2711 (class 2606 OID 2228900)
-- Name: comuni_fk_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_fk_provincia FOREIGN KEY (provincia) REFERENCES provincie(provincia);


--
-- TOC entry 2712 (class 2606 OID 2228905)
-- Name: conversazioni_fk_libretto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_fk_libretto FOREIGN KEY (libretto) REFERENCES classi_alunni(classe_alunno);


--
-- TOC entry 2804 (class 2606 OID 2830191)
-- Name: conversazioni_invitati_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2803 (class 2606 OID 2781434)
-- Name: conversazioni_invitati_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni_invitati
    ADD CONSTRAINT conversazioni_invitati_fk_persona FOREIGN KEY (invitato) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2713 (class 2606 OID 2228910)
-- Name: festivi_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2714 (class 2606 OID 2228915)
-- Name: firme_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2715 (class 2606 OID 2228920)
-- Name: firme_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2717 (class 2606 OID 2228930)
-- Name: fuori_classe_fk_addetto_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_fk_addetto_scolastico FOREIGN KEY (addetto_scolastico) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2716 (class 2606 OID 2228925)
-- Name: fuori_classe_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2718 (class 2606 OID 2764999)
-- Name: fuori_classi_fk_alunno_bis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classi_fk_alunno_bis FOREIGN KEY (alunno) REFERENCES classi_alunni(alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2719 (class 2606 OID 2228940)
-- Name: giustificazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2720 (class 2606 OID 2781534)
-- Name: giustificazioni_fk_creata_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_creata_da FOREIGN KEY (creata_da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2721 (class 2606 OID 2781540)
-- Name: giustificazioni_fk_registrata_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_registrata_da FOREIGN KEY (registrata_da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2722 (class 2606 OID 2228975)
-- Name: indirizzi_fk_nazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY indirizzi
    ADD CONSTRAINT indirizzi_fk_nazione FOREIGN KEY (nazione) REFERENCES nazioni(nazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2723 (class 2606 OID 2228980)
-- Name: indirizzi_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2724 (class 2606 OID 2228985)
-- Name: lezioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2725 (class 2606 OID 2228990)
-- Name: lezioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2726 (class 2606 OID 2228995)
-- Name: lezioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2727 (class 2606 OID 2229000)
-- Name: mancanze_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2728 (class 2606 OID 2229005)
-- Name: mancanze_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2729 (class 2606 OID 2229010)
-- Name: mancanze_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2730 (class 2606 OID 2229015)
-- Name: materie_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2732 (class 2606 OID 2830196)
-- Name: messaggi_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2731 (class 2606 OID 2229030)
-- Name: messaggi_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2733 (class 2606 OID 2229035)
-- Name: messaggi_letti_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2734 (class 2606 OID 2830211)
-- Name: messaggi_letti_fk_messaggio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_messaggio FOREIGN KEY (messaggio) REFERENCES messaggi(messaggio) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2735 (class 2606 OID 2229045)
-- Name: metriche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2737 (class 2606 OID 2830181)
-- Name: mezzi_comunicazione_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2736 (class 2606 OID 2229055)
-- Name: mezzi_comunicazione_fk_tipo_comunicazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_tipo_comunicazione FOREIGN KEY (tipo_comunicazione) REFERENCES tipi_comunicazione(tipo_comunicazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2741 (class 2606 OID 2229060)
-- Name: note_docenti_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2743 (class 2606 OID 2830170)
-- Name: note_docenti_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2742 (class 2606 OID 2229065)
-- Name: note_docenti_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2738 (class 2606 OID 2229070)
-- Name: note_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2740 (class 2606 OID 2764994)
-- Name: note_fk_alunno_bis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_alunno_bis FOREIGN KEY (alunno) REFERENCES classi_alunni(alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2739 (class 2606 OID 2229080)
-- Name: note_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2805 (class 2606 OID 2781633)
-- Name: note_visti_fk_nota; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_fk_nota FOREIGN KEY (nota) REFERENCES note(nota) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2806 (class 2606 OID 2781627)
-- Name: note_visti_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_visti
    ADD CONSTRAINT note_visti_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2744 (class 2606 OID 2229085)
-- Name: orari_settimanali_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2791 (class 2606 OID 2389083)
-- Name: orari_settimanali_giorni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2790 (class 2606 OID 2389088)
-- Name: orari_settimanali_giorni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2789 (class 2606 OID 2830176)
-- Name: orari_settimanali_giorni_fk_orario_settimanale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali_giorni
    ADD CONSTRAINT orari_settimanali_giorni_fk_orario_settimanale FOREIGN KEY (orario_settimanale) REFERENCES orari_settimanali(orario_settimanale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2745 (class 2606 OID 2229100)
-- Name: persone_fk_comune_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_comune_nascita FOREIGN KEY (comune_nascita) REFERENCES comuni(comune);


--
-- TOC entry 2746 (class 2606 OID 2229105)
-- Name: persone_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2747 (class 2606 OID 2229110)
-- Name: persone_fk_nazione_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_nazione_nascita FOREIGN KEY (nazione_nascita) REFERENCES nazioni(nazione);


--
-- TOC entry 2749 (class 2606 OID 3040718)
-- Name: persone_indirizzi_fk_indirizzo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_indirizzo FOREIGN KEY (indirizzo) REFERENCES indirizzi(indirizzo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2748 (class 2606 OID 3040708)
-- Name: persone_indirizzi_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2751 (class 2606 OID 3040728)
-- Name: persone_relazioni_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2750 (class 2606 OID 3040723)
-- Name: persone_relazioni_fk_persona_relazionata; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_relazioni
    ADD CONSTRAINT persone_relazioni_fk_persona_relazionata FOREIGN KEY (persona_relazionata) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2752 (class 2606 OID 2229135)
-- Name: plessi_fk_istituti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_fk_istituti FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2753 (class 2606 OID 2229140)
-- Name: provincie_fk_regione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_fk_regione FOREIGN KEY (regione) REFERENCES regioni(regione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2754 (class 2606 OID 2229150)
-- Name: qualifiche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2755 (class 2606 OID 2229160)
-- Name: qualifiche_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2756 (class 2606 OID 2536649)
-- Name: qualifiche_fk_qualifica_padre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_qualifica_padre FOREIGN KEY (qualifica_padre) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2802 (class 2606 OID 2536666)
-- Name: qualifiche_pof_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2801 (class 2606 OID 2536678)
-- Name: qualifiche_pof_fk_materie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_materie FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2800 (class 2606 OID 2830186)
-- Name: qualifiche_pof_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche_pof
    ADD CONSTRAINT qualifiche_pof_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2760 (class 2606 OID 2764984)
-- Name: ritardi_fk_allunno_bis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_allunno_bis FOREIGN KEY (alunno) REFERENCES classi_alunni(alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2757 (class 2606 OID 2229165)
-- Name: ritardi_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2758 (class 2606 OID 2229170)
-- Name: ritardi_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2759 (class 2606 OID 2229175)
-- Name: ritardi_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2761 (class 2606 OID 2229180)
-- Name: scrutini_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2762 (class 2606 OID 2229185)
-- Name: scrutini_valutazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2763 (class 2606 OID 2229190)
-- Name: scrutini_valutazioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2764 (class 2606 OID 2229195)
-- Name: scrutini_valutazioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2765 (class 2606 OID 2229200)
-- Name: scrutini_valutazioni_fk_scrutinio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_scrutinio FOREIGN KEY (scrutinio) REFERENCES scrutini(scrutinio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2766 (class 2606 OID 2229205)
-- Name: scrutini_valutazioni_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2767 (class 2606 OID 2229210)
-- Name: scrutini_valutazioni_fk_voto_proposto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_voto_proposto FOREIGN KEY (voto_proposto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2768 (class 2606 OID 2229215)
-- Name: scrutini_valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2769 (class 2606 OID 2229220)
-- Name: scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione FOREIGN KEY (scrutinio_valutazione) REFERENCES scrutini_valutazioni(scrutinio_valutazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2770 (class 2606 OID 2229225)
-- Name: scrutini_valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2771 (class 2606 OID 2229230)
-- Name: scrutini_valutazioni_qualifiche_fk_voto_proposto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_voto_proposto FOREIGN KEY (voto_proposto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2793 (class 2606 OID 3245432)
-- Name: spazi_lavoro_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2798 (class 2606 OID 2544928)
-- Name: spazi_lavoro_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2797 (class 2606 OID 2544934)
-- Name: spazi_lavoro_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2796 (class 2606 OID 3245420)
-- Name: spazi_lavoro_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2794 (class 2606 OID 3245426)
-- Name: spazi_lavoro_fk_famigliare; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_famigliare FOREIGN KEY (famigliare) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2799 (class 2606 OID 2544922)
-- Name: spazi_lavoro_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2795 (class 2606 OID 2544940)
-- Name: spazi_lavoro_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2792 (class 2606 OID 3245666)
-- Name: spazi_lavoro_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY spazi_lavoro
    ADD CONSTRAINT spazi_lavoro_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2772 (class 2606 OID 2229235)
-- Name: tipi_voto_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2776 (class 2606 OID 2764989)
-- Name: uscite_alunno_bis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_alunno_bis FOREIGN KEY (alunno) REFERENCES classi_alunni(alunno) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2773 (class 2606 OID 2229240)
-- Name: uscite_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2774 (class 2606 OID 2229245)
-- Name: uscite_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2775 (class 2606 OID 2229250)
-- Name: uscite_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2777 (class 2606 OID 2781640)
-- Name: utenti_fk_spazio_lavoro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_fk_spazio_lavoro FOREIGN KEY (spazio_lavoro) REFERENCES spazi_lavoro(spazio_lavoro) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2778 (class 2606 OID 2229260)
-- Name: utenti_istituti_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2779 (class 2606 OID 2797593)
-- Name: utenti_istituti_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2780 (class 2606 OID 3245671)
-- Name: utenti_istituti_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2781 (class 2606 OID 2229270)
-- Name: valutazioni_fk_argomento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_argomento FOREIGN KEY (argomento) REFERENCES argomenti(argomento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2782 (class 2606 OID 2229275)
-- Name: valutazioni_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2783 (class 2606 OID 2229280)
-- Name: valutazioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona);


--
-- TOC entry 2784 (class 2606 OID 2229285)
-- Name: valutazioni_fk_tipo_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_tipo_voto FOREIGN KEY (tipo_voto) REFERENCES tipi_voto(tipo_voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2785 (class 2606 OID 2229290)
-- Name: valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2786 (class 2606 OID 2229295)
-- Name: valutazioni_qualifiche_fk_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_valutazione FOREIGN KEY (valutazione) REFERENCES valutazioni(valutazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2787 (class 2606 OID 2229300)
-- Name: valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2788 (class 2606 OID 2229305)
-- Name: voti_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2976 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO docenti;
GRANT USAGE ON SCHEMA public TO gestori;


--
-- TOC entry 2979 (class 0 OID 0)
-- Dependencies: 338
-- Name: anni_scolastici_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_del(p_rv bigint, p_anno_scolastico bigint) TO postgres;


--
-- TOC entry 2980 (class 0 OID 0)
-- Dependencies: 322
-- Name: anni_scolastici_ins(bigint, character varying, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO postgres;


--
-- TOC entry 2981 (class 0 OID 0)
-- Dependencies: 339
-- Name: anni_scolastici_ins(bigint, character varying, date, date, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_ins(OUT p_rv bigint, OUT p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO postgres;


--
-- TOC entry 2982 (class 0 OID 0)
-- Dependencies: 340
-- Name: anni_scolastici_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_list(p_istituto bigint) TO postgres;


--
-- TOC entry 2983 (class 0 OID 0)
-- Dependencies: 341
-- Name: anni_scolastici_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_sel(OUT p_rv bigint, p_anno_scolastico bigint, OUT p_istituto bigint, OUT p_descrizione character varying, OUT p_inizio date, OUT p_fine_lezioni date, OUT p_inizio_lezioni date, OUT p_fine date) TO postgres;


--
-- TOC entry 2984 (class 0 OID 0)
-- Dependencies: 342
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date) TO postgres;


--
-- TOC entry 2985 (class 0 OID 0)
-- Dependencies: 343
-- Name: anni_scolastici_upd(bigint, bigint, bigint, character varying, date, date, date, date); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM PUBLIC;
REVOKE ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) FROM postgres;
GRANT ALL ON FUNCTION anni_scolastici_upd(p_rv bigint, p_anno_scolastico bigint, p_istituto bigint, p_descrizione character varying, p_inizio date, p_fine_lezioni date, p_inizio_lezioni date, p_fine date) TO postgres;


--
-- TOC entry 2986 (class 0 OID 0)
-- Dependencies: 344
-- Name: classi_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_del(p_rv bigint, p_classe bigint) TO postgres;


--
-- TOC entry 2987 (class 0 OID 0)
-- Dependencies: 345
-- Name: classi_ins(bigint, bigint, character varying, smallint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_ins(OUT p_rv bigint, OUT p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO postgres;


--
-- TOC entry 2988 (class 0 OID 0)
-- Dependencies: 346
-- Name: classi_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_list(p_anno_scolastico bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_list(p_anno_scolastico bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_list(p_anno_scolastico bigint) TO postgres;


--
-- TOC entry 2989 (class 0 OID 0)
-- Dependencies: 348
-- Name: classi_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_sel(OUT p_rv bigint, p_classe bigint, OUT p_anno_scolastico bigint, OUT p_indirizzo_scolastico bigint, OUT p_sezione character varying, OUT p_anno_corso smallint, OUT p_descrizione character varying, OUT p_plesso bigint) TO postgres;


--
-- TOC entry 2990 (class 0 OID 0)
-- Dependencies: 349
-- Name: classi_upd(bigint, bigint, bigint, bigint, character varying, smallint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) FROM postgres;
GRANT ALL ON FUNCTION classi_upd(p_rv bigint, p_classe bigint, p_anno_scolastico bigint, p_indirizzo_scolastico bigint, p_sezione character varying, p_anno_corso smallint, p_descrizione character varying, p_plesso bigint) TO postgres;


--
-- TOC entry 2992 (class 0 OID 0)
-- Dependencies: 359
-- Name: delete_istituto(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION delete_istituto(istituto_da_cancellare bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION delete_istituto(istituto_da_cancellare bigint) FROM postgres;
GRANT ALL ON FUNCTION delete_istituto(istituto_da_cancellare bigint) TO postgres;


--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 298
-- Name: function_sqlcode(character varying, character); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) FROM PUBLIC;
REVOKE ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) FROM postgres;
GRANT ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) TO postgres;
GRANT ALL ON FUNCTION function_sqlcode(p_function character varying, p_id character) TO PUBLIC;


--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 319
-- Name: istituti_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION istituti_del(p_rv bigint, p_istituto bigint) TO postgres;


--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 333
-- Name: istituti_ins(character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO postgres;


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 321
-- Name: istituti_ins(character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_ins(OUT p_rv bigint, OUT p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO postgres;


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 324
-- Name: istituti_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_list() FROM postgres;
GRANT ALL ON FUNCTION istituti_list() TO postgres;
GRANT ALL ON FUNCTION istituti_list() TO PUBLIC;


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 334
-- Name: istituti_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_sel(OUT p_rv bigint, p_istituto bigint, OUT p_descrizione character varying, OUT p_codice_meccanografico character varying, OUT p_mnemonico character varying, OUT p_esempio boolean, OUT p_logo bytea) TO postgres;


--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 335
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) FROM postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean) TO postgres;


--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 336
-- Name: istituti_upd(bigint, bigint, character varying, character varying, character varying, boolean, bytea); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM PUBLIC;
REVOKE ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) FROM postgres;
GRANT ALL ON FUNCTION istituti_upd(p_rv bigint, p_istituto bigint, p_descrizione character varying, p_codice_meccanografico character varying, p_mnemonico character varying, p_esempio boolean, p_logo bytea) TO postgres;


--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 347
-- Name: materie_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_del(p_rv bigint, p_materia bigint) TO postgres;


--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 302
-- Name: materie_ins(bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying) TO postgres;


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 308
-- Name: materie_ins(bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_ins(OUT p_rv bigint, OUT p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO postgres;


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 350
-- Name: materie_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_list(p_istituto bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_list(p_istituto bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_list(p_istituto bigint) TO postgres;


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 326
-- Name: materie_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_sel(OUT p_rv bigint, p_materia bigint, OUT p_istituto bigint, OUT p_descrizione character varying) TO postgres;


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 327
-- Name: materie_upd(bigint, bigint, bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) FROM postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying) TO postgres;


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 351
-- Name: materie_upd(bigint, bigint, bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) FROM postgres;
GRANT ALL ON FUNCTION materie_upd(p_rv bigint, p_materia bigint, p_istituto bigint, p_descrizione character varying, p_metrica bigint) TO postgres;


--
-- TOC entry 3014 (class 0 OID 0)
-- Dependencies: 304
-- Name: max_sequence(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION max_sequence(name text) FROM PUBLIC;
REVOKE ALL ON FUNCTION max_sequence(name text) FROM postgres;
GRANT ALL ON FUNCTION max_sequence(name text) TO postgres;


--
-- TOC entry 3015 (class 0 OID 0)
-- Dependencies: 352
-- Name: messaggi_sistema_locale(character varying, integer); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) FROM postgres;
GRANT ALL ON FUNCTION messaggi_sistema_locale(p_function_name character varying, p_id integer) TO postgres;


--
-- TOC entry 3016 (class 0 OID 0)
-- Dependencies: 300
-- Name: nome_giorno(giorno_settimana); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) FROM PUBLIC;
REVOKE ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) FROM postgres;
GRANT ALL ON FUNCTION nome_giorno(p_giorno_settimana giorno_settimana) TO postgres;


--
-- TOC entry 3017 (class 0 OID 0)
-- Dependencies: 283
-- Name: orari_settimanali_xt_docente(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) FROM postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_docente(p_orario_settimanale bigint) TO postgres;


--
-- TOC entry 3018 (class 0 OID 0)
-- Dependencies: 284
-- Name: orari_settimanali_xt_materia(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) FROM postgres;
GRANT ALL ON FUNCTION orari_settimanali_xt_materia(p_orario_settimanale bigint) TO postgres;


--
-- TOC entry 3019 (class 0 OID 0)
-- Dependencies: 328
-- Name: persone_cognome_nome(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persone_cognome_nome(p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION persone_cognome_nome(p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION persone_cognome_nome(p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION persone_cognome_nome(p_persona bigint) TO PUBLIC;


--
-- TOC entry 3020 (class 0 OID 0)
-- Dependencies: 306
-- Name: persone_sel_foto_miniatura(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) FROM postgres;
GRANT ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) TO postgres;
GRANT ALL ON FUNCTION persone_sel_foto_miniatura(p_persona bigint) TO PUBLIC;


--
-- TOC entry 3021 (class 0 OID 0)
-- Dependencies: 303
-- Name: qualifiche_tree(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION qualifiche_tree() FROM PUBLIC;
REVOKE ALL ON FUNCTION qualifiche_tree() FROM postgres;
GRANT ALL ON FUNCTION qualifiche_tree() TO postgres;


--
-- TOC entry 3022 (class 0 OID 0)
-- Dependencies: 360
-- Name: rolnames_by_session_user(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION rolnames_by_session_user() FROM PUBLIC;
REVOKE ALL ON FUNCTION rolnames_by_session_user() FROM postgres;
GRANT ALL ON FUNCTION rolnames_by_session_user() TO postgres;
GRANT ALL ON FUNCTION rolnames_by_session_user() TO PUBLIC;


--
-- TOC entry 3025 (class 0 OID 0)
-- Dependencies: 329
-- Name: session_utente(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION session_utente() FROM PUBLIC;
REVOKE ALL ON FUNCTION session_utente() FROM postgres;
GRANT ALL ON FUNCTION session_utente() TO postgres;
GRANT ALL ON FUNCTION session_utente() TO PUBLIC;


--
-- TOC entry 3027 (class 0 OID 0)
-- Dependencies: 289
-- Name: set_max_sequence(text); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION set_max_sequence(name text) FROM PUBLIC;
REVOKE ALL ON FUNCTION set_max_sequence(name text) FROM postgres;
GRANT ALL ON FUNCTION set_max_sequence(name text) TO postgres;


--
-- TOC entry 3028 (class 0 OID 0)
-- Dependencies: 317
-- Name: set_spazio_lavoro_default(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) FROM postgres;
GRANT ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) TO postgres;
GRANT ALL ON FUNCTION set_spazio_lavoro_default(p_spazio_lavoro bigint) TO PUBLIC;


--
-- TOC entry 3029 (class 0 OID 0)
-- Dependencies: 299
-- Name: spazi_lavoro_del(bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) TO postgres;
GRANT ALL ON FUNCTION spazi_lavoro_del(p_rv bigint, p_spazio_lavoro bigint) TO PUBLIC;


--
-- TOC entry 3030 (class 0 OID 0)
-- Dependencies: 364
-- Name: spazi_lavoro_ins(character varying, bigint, bigint, bigint, bigint, bigint, bigint, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) TO postgres;
GRANT ALL ON FUNCTION spazi_lavoro_ins(OUT p_rv bigint, OUT p_spazio_lavoro bigint, p_descrizione character varying, p_istituto bigint, p_anno_scolastico bigint, p_classe bigint, p_materia bigint, p_docente bigint, p_famigliare bigint, p_alunno bigint) TO PUBLIC;


--
-- TOC entry 3031 (class 0 OID 0)
-- Dependencies: 366
-- Name: spazi_lavoro_list(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION spazi_lavoro_list() FROM PUBLIC;
REVOKE ALL ON FUNCTION spazi_lavoro_list() FROM postgres;
GRANT ALL ON FUNCTION spazi_lavoro_list() TO postgres;


--
-- TOC entry 3032 (class 0 OID 0)
-- Dependencies: 282
-- Name: test(integer); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION test(p_istituto integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION test(p_istituto integer) FROM postgres;
GRANT ALL ON FUNCTION test(p_istituto integer) TO postgres;


--
-- TOC entry 3038 (class 0 OID 0)
-- Dependencies: 171
-- Name: anni_scolastici; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE anni_scolastici FROM PUBLIC;
REVOKE ALL ON TABLE anni_scolastici FROM postgres;
GRANT ALL ON TABLE anni_scolastici TO postgres;


--
-- TOC entry 3041 (class 0 OID 0)
-- Dependencies: 173
-- Name: assenze; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE assenze FROM PUBLIC;
REVOKE ALL ON TABLE assenze FROM postgres;
GRANT ALL ON TABLE assenze TO postgres;


--
-- TOC entry 3042 (class 0 OID 0)
-- Dependencies: 174
-- Name: classi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi FROM PUBLIC;
REVOKE ALL ON TABLE classi FROM postgres;
GRANT ALL ON TABLE classi TO postgres;


--
-- TOC entry 3043 (class 0 OID 0)
-- Dependencies: 175
-- Name: classi_alunni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_alunni FROM PUBLIC;
REVOKE ALL ON TABLE classi_alunni FROM postgres;
GRANT ALL ON TABLE classi_alunni TO postgres;


--
-- TOC entry 3046 (class 0 OID 0)
-- Dependencies: 177
-- Name: comuni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE comuni FROM PUBLIC;
REVOKE ALL ON TABLE comuni FROM postgres;
GRANT ALL ON TABLE comuni TO postgres;


--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 181
-- Name: fuori_classi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE fuori_classi FROM PUBLIC;
REVOKE ALL ON TABLE fuori_classi FROM postgres;
GRANT ALL ON TABLE fuori_classi TO postgres;


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 185
-- Name: istituti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE istituti FROM PUBLIC;
REVOKE ALL ON TABLE istituti FROM postgres;


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 195
-- Name: note; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note FROM PUBLIC;
REVOKE ALL ON TABLE note FROM postgres;
GRANT ALL ON TABLE note TO postgres;


--
-- TOC entry 3059 (class 0 OID 0)
-- Dependencies: 198
-- Name: persone; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone FROM PUBLIC;
REVOKE ALL ON TABLE persone FROM postgres;
GRANT ALL ON TABLE persone TO postgres;


--
-- TOC entry 3061 (class 0 OID 0)
-- Dependencies: 206
-- Name: ritardi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE ritardi FROM PUBLIC;
REVOKE ALL ON TABLE ritardi FROM postgres;
GRANT ALL ON TABLE ritardi TO postgres;


--
-- TOC entry 3065 (class 0 OID 0)
-- Dependencies: 212
-- Name: uscite; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE uscite FROM PUBLIC;
REVOKE ALL ON TABLE uscite FROM postgres;
GRANT ALL ON TABLE uscite TO postgres;


--
-- TOC entry 3071 (class 0 OID 0)
-- Dependencies: 213
-- Name: utenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE utenti FROM PUBLIC;
REVOKE ALL ON TABLE utenti FROM postgres;
GRANT ALL ON TABLE utenti TO postgres;


--
-- TOC entry 3074 (class 0 OID 0)
-- Dependencies: 214
-- Name: utenti_istituti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE utenti_istituti FROM PUBLIC;
REVOKE ALL ON TABLE utenti_istituti FROM postgres;
GRANT ALL ON TABLE utenti_istituti TO postgres;


--
-- TOC entry 3075 (class 0 OID 0)
-- Dependencies: 238
-- Name: classi_alunni_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_alunni_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_alunni_ex FROM postgres;
GRANT ALL ON TABLE classi_alunni_ex TO postgres;


--
-- TOC entry 3076 (class 0 OID 0)
-- Dependencies: 330
-- Name: w_classi_alunni_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classi_alunni_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_classi_alunni_ex() FROM postgres;
GRANT ALL ON FUNCTION w_classi_alunni_ex() TO postgres;


--
-- TOC entry 3077 (class 0 OID 0)
-- Dependencies: 201
-- Name: plessi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE plessi FROM PUBLIC;
REVOKE ALL ON TABLE plessi FROM postgres;
GRANT ALL ON TABLE plessi TO postgres;


--
-- TOC entry 3078 (class 0 OID 0)
-- Dependencies: 226
-- Name: classi_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE classi_ex FROM PUBLIC;
REVOKE ALL ON TABLE classi_ex FROM postgres;
GRANT ALL ON TABLE classi_ex TO postgres;


--
-- TOC entry 3079 (class 0 OID 0)
-- Dependencies: 301
-- Name: w_classi_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classi_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_classi_ex() FROM postgres;
GRANT ALL ON FUNCTION w_classi_ex() TO postgres;
GRANT ALL ON FUNCTION w_classi_ex() TO docenti;
GRANT ALL ON FUNCTION w_classi_ex() TO gestori;


--
-- TOC entry 3080 (class 0 OID 0)
-- Dependencies: 197
-- Name: orari_settimanali; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali FROM postgres;
GRANT ALL ON TABLE orari_settimanali TO postgres;


--
-- TOC entry 3081 (class 0 OID 0)
-- Dependencies: 225
-- Name: orari_settimanali_ex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_ex FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_ex FROM postgres;
GRANT ALL ON TABLE orari_settimanali_ex TO postgres;


--
-- TOC entry 3082 (class 0 OID 0)
-- Dependencies: 307
-- Name: w_orari_settimanali_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_orari_settimanali_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_orari_settimanali_ex() FROM postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_ex() TO postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_ex() TO docenti;
GRANT ALL ON FUNCTION w_orari_settimanali_ex() TO gestori;


--
-- TOC entry 3083 (class 0 OID 0)
-- Dependencies: 188
-- Name: materie; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE materie FROM PUBLIC;
REVOKE ALL ON TABLE materie FROM postgres;
GRANT ALL ON TABLE materie TO postgres;


--
-- TOC entry 3086 (class 0 OID 0)
-- Dependencies: 218
-- Name: orari_settimanali_giorni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE orari_settimanali_giorni FROM PUBLIC;
REVOKE ALL ON TABLE orari_settimanali_giorni FROM postgres;
GRANT ALL ON TABLE orari_settimanali_giorni TO postgres;


--
-- TOC entry 3087 (class 0 OID 0)
-- Dependencies: 311
-- Name: w_orari_settimanali_giorni_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_orari_settimanali_giorni_ex() FROM PUBLIC;
REVOKE ALL ON FUNCTION w_orari_settimanali_giorni_ex() FROM postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_giorni_ex() TO postgres;
GRANT ALL ON FUNCTION w_orari_settimanali_giorni_ex() TO docenti;
GRANT ALL ON FUNCTION w_orari_settimanali_giorni_ex() TO gestori;


--
-- TOC entry 3089 (class 0 OID 0)
-- Dependencies: 353
-- Name: where_sequence(text, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION where_sequence(name text, search_value bigint) FROM PUBLIC;
REVOKE ALL ON FUNCTION where_sequence(name text, search_value bigint) FROM postgres;
GRANT ALL ON FUNCTION where_sequence(name text, search_value bigint) TO postgres;


--
-- TOC entry 3091 (class 0 OID 0)
-- Dependencies: 172
-- Name: argomenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE argomenti FROM PUBLIC;
REVOKE ALL ON TABLE argomenti FROM postgres;
GRANT ALL ON TABLE argomenti TO postgres;


--
-- TOC entry 3101 (class 0 OID 0)
-- Dependencies: 182
-- Name: giustificazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE giustificazioni FROM PUBLIC;
REVOKE ALL ON TABLE giustificazioni FROM postgres;
GRANT ALL ON TABLE giustificazioni TO postgres;


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 186
-- Name: lezioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE lezioni FROM PUBLIC;
REVOKE ALL ON TABLE lezioni FROM postgres;
GRANT ALL ON TABLE lezioni TO postgres;


--
-- TOC entry 3105 (class 0 OID 0)
-- Dependencies: 180
-- Name: firme; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE firme FROM PUBLIC;
REVOKE ALL ON TABLE firme FROM postgres;
GRANT ALL ON TABLE firme TO postgres;


--
-- TOC entry 3115 (class 0 OID 0)
-- Dependencies: 176
-- Name: colloqui; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE colloqui FROM PUBLIC;
REVOKE ALL ON TABLE colloqui FROM postgres;
GRANT ALL ON TABLE colloqui TO postgres;


--
-- TOC entry 3119 (class 0 OID 0)
-- Dependencies: 178
-- Name: conversazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE conversazioni FROM PUBLIC;
REVOKE ALL ON TABLE conversazioni FROM postgres;
GRANT ALL ON TABLE conversazioni TO postgres;


--
-- TOC entry 3121 (class 0 OID 0)
-- Dependencies: 179
-- Name: festivi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE festivi FROM PUBLIC;
REVOKE ALL ON TABLE festivi FROM postgres;
GRANT ALL ON TABLE festivi TO postgres;


--
-- TOC entry 3122 (class 0 OID 0)
-- Dependencies: 183
-- Name: indirizzi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE indirizzi FROM PUBLIC;
REVOKE ALL ON TABLE indirizzi FROM postgres;
GRANT ALL ON TABLE indirizzi TO postgres;


--
-- TOC entry 3124 (class 0 OID 0)
-- Dependencies: 184
-- Name: indirizzi_scolastici; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE indirizzi_scolastici FROM PUBLIC;
REVOKE ALL ON TABLE indirizzi_scolastici FROM postgres;
GRANT ALL ON TABLE indirizzi_scolastici TO postgres;


--
-- TOC entry 3125 (class 0 OID 0)
-- Dependencies: 222
-- Name: istituti_anni_scolastici_classi_orari_settimanali; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali FROM PUBLIC;
REVOKE ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali FROM postgres;
GRANT ALL ON TABLE istituti_anni_scolastici_classi_orari_settimanali TO postgres;


--
-- TOC entry 3127 (class 0 OID 0)
-- Dependencies: 187
-- Name: mancanze; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE mancanze FROM PUBLIC;
REVOKE ALL ON TABLE mancanze FROM postgres;
GRANT ALL ON TABLE mancanze TO postgres;


--
-- TOC entry 3129 (class 0 OID 0)
-- Dependencies: 189
-- Name: messaggi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi FROM PUBLIC;
REVOKE ALL ON TABLE messaggi FROM postgres;
GRANT ALL ON TABLE messaggi TO postgres;


--
-- TOC entry 3131 (class 0 OID 0)
-- Dependencies: 190
-- Name: messaggi_letti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi_letti FROM PUBLIC;
REVOKE ALL ON TABLE messaggi_letti FROM postgres;
GRANT ALL ON TABLE messaggi_letti TO postgres;


--
-- TOC entry 3132 (class 0 OID 0)
-- Dependencies: 191
-- Name: messaggi_sistema; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE messaggi_sistema FROM PUBLIC;
REVOKE ALL ON TABLE messaggi_sistema FROM postgres;
GRANT ALL ON TABLE messaggi_sistema TO postgres;


--
-- TOC entry 3133 (class 0 OID 0)
-- Dependencies: 192
-- Name: metriche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE metriche FROM PUBLIC;
REVOKE ALL ON TABLE metriche FROM postgres;
GRANT ALL ON TABLE metriche TO postgres;


--
-- TOC entry 3135 (class 0 OID 0)
-- Dependencies: 193
-- Name: mezzi_comunicazione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE mezzi_comunicazione FROM PUBLIC;
REVOKE ALL ON TABLE mezzi_comunicazione FROM postgres;
GRANT ALL ON TABLE mezzi_comunicazione TO postgres;


--
-- TOC entry 3136 (class 0 OID 0)
-- Dependencies: 194
-- Name: nazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE nazioni FROM PUBLIC;
REVOKE ALL ON TABLE nazioni FROM postgres;
GRANT ALL ON TABLE nazioni TO postgres;


--
-- TOC entry 3138 (class 0 OID 0)
-- Dependencies: 196
-- Name: note_docenti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE note_docenti FROM PUBLIC;
REVOKE ALL ON TABLE note_docenti FROM postgres;
GRANT ALL ON TABLE note_docenti TO postgres;


--
-- TOC entry 3141 (class 0 OID 0)
-- Dependencies: 199
-- Name: persone_indirizzi; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone_indirizzi FROM PUBLIC;
REVOKE ALL ON TABLE persone_indirizzi FROM postgres;
GRANT ALL ON TABLE persone_indirizzi TO postgres;


--
-- TOC entry 3144 (class 0 OID 0)
-- Dependencies: 200
-- Name: persone_relazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE persone_relazioni FROM PUBLIC;
REVOKE ALL ON TABLE persone_relazioni FROM postgres;
GRANT ALL ON TABLE persone_relazioni TO postgres;


--
-- TOC entry 3145 (class 0 OID 0)
-- Dependencies: 202
-- Name: provincie; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE provincie FROM PUBLIC;
REVOKE ALL ON TABLE provincie FROM postgres;
GRANT ALL ON TABLE provincie TO postgres;


--
-- TOC entry 3148 (class 0 OID 0)
-- Dependencies: 203
-- Name: qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE qualifiche FROM postgres;
GRANT ALL ON TABLE qualifiche TO postgres;


--
-- TOC entry 3150 (class 0 OID 0)
-- Dependencies: 204
-- Name: regioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE regioni FROM PUBLIC;
REVOKE ALL ON TABLE regioni FROM postgres;
GRANT ALL ON TABLE regioni TO postgres;


--
-- TOC entry 3152 (class 0 OID 0)
-- Dependencies: 205
-- Name: residenza_grp_comune; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE residenza_grp_comune FROM PUBLIC;
REVOKE ALL ON TABLE residenza_grp_comune FROM postgres;
GRANT ALL ON TABLE residenza_grp_comune TO postgres;


--
-- TOC entry 3154 (class 0 OID 0)
-- Dependencies: 207
-- Name: scrutini; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini FROM PUBLIC;
REVOKE ALL ON TABLE scrutini FROM postgres;
GRANT ALL ON TABLE scrutini TO postgres;


--
-- TOC entry 3157 (class 0 OID 0)
-- Dependencies: 208
-- Name: scrutini_valutazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini_valutazioni FROM PUBLIC;
REVOKE ALL ON TABLE scrutini_valutazioni FROM postgres;
GRANT ALL ON TABLE scrutini_valutazioni TO postgres;


--
-- TOC entry 3158 (class 0 OID 0)
-- Dependencies: 209
-- Name: scrutini_valutazioni_qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE scrutini_valutazioni_qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE scrutini_valutazioni_qualifiche FROM postgres;
GRANT ALL ON TABLE scrutini_valutazioni_qualifiche TO postgres;


--
-- TOC entry 3160 (class 0 OID 0)
-- Dependencies: 210
-- Name: tipi_comunicazione; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipi_comunicazione FROM PUBLIC;
REVOKE ALL ON TABLE tipi_comunicazione FROM postgres;
GRANT ALL ON TABLE tipi_comunicazione TO postgres;


--
-- TOC entry 3161 (class 0 OID 0)
-- Dependencies: 211
-- Name: tipi_voto; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipi_voto FROM PUBLIC;
REVOKE ALL ON TABLE tipi_voto FROM postgres;
GRANT ALL ON TABLE tipi_voto TO postgres;


--
-- TOC entry 3165 (class 0 OID 0)
-- Dependencies: 215
-- Name: valutazioni; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE valutazioni FROM PUBLIC;
REVOKE ALL ON TABLE valutazioni FROM postgres;
GRANT ALL ON TABLE valutazioni TO postgres;


--
-- TOC entry 3167 (class 0 OID 0)
-- Dependencies: 216
-- Name: valutazioni_qualifiche; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE valutazioni_qualifiche FROM PUBLIC;
REVOKE ALL ON TABLE valutazioni_qualifiche FROM postgres;
GRANT ALL ON TABLE valutazioni_qualifiche TO postgres;


--
-- TOC entry 3169 (class 0 OID 0)
-- Dependencies: 217
-- Name: voti; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE voti FROM PUBLIC;
REVOKE ALL ON TABLE voti FROM postgres;
GRANT ALL ON TABLE voti TO postgres;


-- Completed on 2014-04-19 09:37:02

--
-- PostgreSQL database dump complete
--

