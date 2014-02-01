--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.1
-- Dumped by pg_dump version 9.3.0
-- Started on 2014-01-16 15:27:00

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 221 (class 3079 OID 11791)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 221
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 570 (class 1247 OID 60785)
-- Name: anno_corso; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN anno_corso AS smallint
	CONSTRAINT anno_corso_range CHECK (((VALUE >= 1) AND (VALUE <= 6)));


ALTER DOMAIN public.anno_corso OWNER TO postgres;

--
-- TOC entry 572 (class 1247 OID 60787)
-- Name: giorno_settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN giorno_settimana AS smallint
	CONSTRAINT giorno_settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN public.giorno_settimana OWNER TO postgres;

--
-- TOC entry 574 (class 1247 OID 60790)
-- Name: parentela; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE parentela AS ENUM (
    'Madre/Padre',
    'Fratello/Sorella',
    'Zio/a',
    'Nonno/a',
    'Tutore'
);


ALTER TYPE public.parentela OWNER TO postgres;

--
-- TOC entry 577 (class 1247 OID 60801)
-- Name: periodo_lezione; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN periodo_lezione AS smallint
	CONSTRAINT periodo_lezione_range CHECK (((VALUE >= 1) AND (VALUE <= 24)));


ALTER DOMAIN public.periodo_lezione OWNER TO postgres;

--
-- TOC entry 579 (class 1247 OID 60804)
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
-- TOC entry 582 (class 1247 OID 60816)
-- Name: ruolo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE ruolo AS ENUM (
    'Alunno',
    'Amministrativo',
    'Dirigente',
    'Docente',
    'Genitore'
);


ALTER TYPE public.ruolo OWNER TO postgres;

--
-- TOC entry 585 (class 1247 OID 60828)
-- Name: sesso; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sesso AS ENUM (
    'Maschio',
    'Femmina'
);


ALTER TYPE public.sesso OWNER TO postgres;

--
-- TOC entry 588 (class 1247 OID 60833)
-- Name: settimana; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN settimana AS smallint
	CONSTRAINT settimana_range CHECK (((VALUE >= 1) AND (VALUE <= 4)));


ALTER DOMAIN public.settimana OWNER TO postgres;

--
-- TOC entry 590 (class 1247 OID 60836)
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
-- TOC entry 593 (class 1247 OID 60846)
-- Name: tipo_indirizzo; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_indirizzo AS ENUM (
    'Domicilio',
    'Lavoro',
    'Residenza'
);


ALTER TYPE public.tipo_indirizzo OWNER TO postgres;

--
-- TOC entry 596 (class 1247 OID 60854)
-- Name: tipo_qualifica; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_qualifica AS ENUM (
    'Competenza',
    'Conoscenza',
    'Abilità'
);


ALTER TYPE public.tipo_qualifica OWNER TO postgres;

--
-- TOC entry 599 (class 1247 OID 60862)
-- Name: tipo_soggetto; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE tipo_soggetto AS ENUM (
    'Persona fisica',
    'Persona giuridica'
);


ALTER TYPE public.tipo_soggetto OWNER TO postgres;

--
-- TOC entry 236 (class 1255 OID 60867)
-- Name: delete_istituto(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION delete_istituto(istituto_da_cancellare bigint) RETURNS TABLE(table_name character varying, record_deleted bigint)
    LANGUAGE plpgsql
    AS $$
declare
     rowcount bigint;
begin 

delete from gruppi_utenti ;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'gruppi_utenti ......................... : % righe cancellate', rowcount;
table_name := 'gruppi_utenti';
record_deleted := rowcount;
return next;

delete from gruppi ;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'gruppi ................................ : % righe cancellate', rowcount;
table_name := 'gruppi';
record_deleted := rowcount;
return next;

delete from utenti_istituti;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'utenti_istituti ....................... : % righe cancellate', rowcount;
table_name := 'utenti_istituti';
record_deleted := rowcount;
return next;

delete from utenti;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'utenti ................................ : % righe cancellate', rowcount;
table_name := 'utenti';
record_deleted := rowcount;
return next;

delete from messaggi_letti 
      using messaggi, conversazioni, libretti, classi, anni_scolastici
      where messaggi_letti.messaggio=messaggi.messaggio
        and messaggi.conversazione = conversazioni.conversazione
        and conversazioni.libretto = libretti.libretto
        and libretti.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'messaggi_letti ........................ : % righe cancellate', rowcount;
table_name := 'messaggi_letti';
record_deleted := rowcount;
return next;

delete from messaggi
      using conversazioni, libretti, classi, anni_scolastici
      where messaggi.conversazione = conversazioni.conversazione
        and conversazioni.libretto = libretti.libretto
        and libretti.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'messaggi .............................. : % righe cancellate', rowcount;
table_name := 'messaggi';
record_deleted := rowcount;
return next;

delete from conversazioni
      using libretti, classi, anni_scolastici
      where conversazioni.libretto = libretti.libretto
        and libretti.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'conversazioni ......................... : % righe cancellate', rowcount;
table_name := 'conversazioni';
record_deleted := rowcount;
return next;

delete from libretti
      using classi, anni_scolastici
      where libretti.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'libretti .............................. : % righe cancellate', rowcount;
table_name := 'libretti';
record_deleted := rowcount;
return next;

delete from giustificazioni 
      using classi, anni_scolastici
      where giustificazioni.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'giustificazioni ....................... : % righe cancellate', rowcount;
table_name := 'giustificazioni';
record_deleted := rowcount;
return next;

delete from firme
      using classi, anni_scolastici
      where firme.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'firme ................................. : % righe cancellate', rowcount;
table_name := 'firme';
record_deleted := rowcount;
return next;

delete from lezioni
      using classi, anni_scolastici
      where lezioni.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'lezioni ............................... : % righe cancellate', rowcount;
table_name := 'lezioni';
record_deleted := rowcount;
return next;

delete from assenze
      using classi, anni_scolastici
      where assenze.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'assenze ............................... : % righe cancellate', rowcount;
table_name := 'assenze';
record_deleted := rowcount;
return next;

delete from ritardi
      using classi, anni_scolastici
      where ritardi.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'ritardi ............................... : % righe cancellate', rowcount;
table_name := 'ritardi';
record_deleted := rowcount;
return next;

delete from uscite
      using classi, anni_scolastici
      where uscite.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
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
      using classi, anni_scolastici
      where fuori_classi.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'fuori_classi .......................... : % righe cancellate', rowcount;
table_name := 'fuori_classi';
record_deleted := rowcount;
return next;

delete from mancanze
      using classi, anni_scolastici
      where mancanze.classe = classi.classe
        and classi.anno_scolastico = anni_scolastici.anno_scolastico
        and anni_scolastici.istituto = istituto_da_cancellare;
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

delete from persone_indirizzi
      using persone
      where persone_indirizzi.persona = persone.persona
        and persone.istituto  = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'persone_indirizzi ..................... : % righe cancellate', rowcount;
table_name := 'persone_indirizzi';
record_deleted := rowcount;
return next;

delete from indirizzi
      where indirizzo not in (select indirizzo from persone_indirizzi);
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'indirizzi ............................. : % righe cancellate', rowcount;
table_name := 'indirizzi';
record_deleted := rowcount;
return next;

delete from persone_parenti
      using persone
      where persone_parenti.persona = persone.persona
        and persone.istituto = istituto_da_cancellare;
GET DIAGNOSTICS rowcount = ROW_COUNT;
RAISE NOTICE 'persone_parenti ....................... : % righe cancellate', rowcount;
table_name := 'persone_parenti';
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
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 236
-- Name: FUNCTION delete_istituto(istituto_da_cancellare bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION delete_istituto(istituto_da_cancellare bigint) IS 'Il comando prende in input il codice di un istituto e cancella tutti i record di tutte le tabelle collegate all''istituto';


--
-- TOC entry 234 (class 1255 OID 60868)
-- Name: max_sequence(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION max_sequence(name text) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, max_value bigint)
    LANGUAGE plpgsql
    AS $$
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
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 234
-- Name: FUNCTION max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION max_sequence(name text) IS 'Restituisce una tabella con le seguenti colonne: table_catalog, table_schema, table_name, column_name, max_value popolandola con una riga per ogni colonna del database che contiena una clausola default uguale a: "nextval(''<name>''::regclass)"  (dove il <name> si intende sostitutito dal parametro name passato alla funzione nel momento in cui viene richiamata) abbinandola al valore massimo contenuto dalla colonna.';


--
-- TOC entry 235 (class 1255 OID 60869)
-- Name: set_max_sequence(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION set_max_sequence(name text) RETURNS bigint
    LANGUAGE plpgsql
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
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 235
-- Name: FUNCTION set_max_sequence(name text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION set_max_sequence(name text) IS 'Il comando prende il valore massimo fra quelli restitutiti dalla funzione max_sequence, richiamata con il parametro ricevuti in input, e lo imposta nella sequenza il cui nome riceve come parametro di input nella chiamata';


--
-- TOC entry 170 (class 1259 OID 60870)
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
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 170
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'genera la primary key per tutte le tabelle del progetto';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 171 (class 1259 OID 60872)
-- Name: anni_scolastici; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE anni_scolastici (
    anno_scolastico bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL,
    inizio date NOT NULL,
    fine_lezioni date NOT NULL,
    CONSTRAINT anni_scolastici_ck_date CHECK ((fine_lezioni > inizio))
);


ALTER TABLE public.anni_scolastici OWNER TO postgres;

--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 171
-- Name: TABLE anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE anni_scolastici IS 'Rappresenta l''anno scolastico ed è suddiviso per istituto';


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN anni_scolastici.inizio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.inizio IS 'Indica la data di inizio dell''anno scolastico, non necessariamente deve corrispondere con l''inizio delle lezioni. Chiaramente la data di fine dell''anno scolastico è considerata il giorno prima dell''anno dopo la data di inizio delle lezioni.
I dati dei registro relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio dell''anno scolastico e la data di fine delle lezioni.';


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 171
-- Name: COLUMN anni_scolastici.fine_lezioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN anni_scolastici.fine_lezioni IS 'Indica la data di fine delle lezioni.
E'' necessario indicarla perchè in anticipo rispetto alla data di fine anno scolastico che è il giorno prima dell''anno dopo la data di inizio_anno_scolastico.
I dati dei registri relativi alle lezioni si potranno inserire solo se con data compresa tra la data di inizio dell''anno scolastico e la data di fine delle lezioni.';


--
-- TOC entry 172 (class 1259 OID 60877)
-- Name: argomenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE argomenti (
    argomento bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    materia bigint NOT NULL,
    descrizione character varying(60) NOT NULL,
    anno_corso anno_corso,
    indirizzo_scolastico bigint NOT NULL
);


ALTER TABLE public.argomenti OWNER TO postgres;

--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 172
-- Name: TABLE argomenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE argomenti IS 'Contiene gli argomenti oggetto di una valutazione';


--
-- TOC entry 173 (class 1259 OID 60881)
-- Name: assenze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE assenze (
    assenza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    giorno date NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint
);


ALTER TABLE public.assenze OWNER TO postgres;

--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 173
-- Name: TABLE assenze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE assenze IS 'Rileva le assenze di un alunno';


--
-- TOC entry 174 (class 1259 OID 60885)
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
-- TOC entry 175 (class 1259 OID 60889)
-- Name: classi_alunni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE classi_alunni (
    classe_alunno bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL
);


ALTER TABLE public.classi_alunni OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 176 (class 1259 OID 60893)
-- Name: colloqui; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE colloqui (
    colloquio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    docente bigint NOT NULL,
    con bigint,
    il timestamp(0) with time zone
);


ALTER TABLE public.colloqui OWNER TO postgres;

--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 176
-- Name: TABLE colloqui; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE colloqui IS 'in questa tabella sono memorizzati tutti i periodi di disponibilità per i colloqui con gli esercenti la patria ';


--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN colloqui.con; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.con IS 'persona con la quale è stato prenotato il colloquio';


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 176
-- Name: COLUMN colloqui.il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN colloqui.il IS 'data e ora in cui il docente è disponibile per un colloquio';


SET default_with_oids = true;

--
-- TOC entry 177 (class 1259 OID 60897)
-- Name: comuni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE comuni (
    comune character varying(4) NOT NULL,
    descrizione character varying(160) NOT NULL,
    provincia character(2) NOT NULL
);


ALTER TABLE public.comuni OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 60900)
-- Name: conversazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conversazioni (
    conversazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    libretto bigint NOT NULL,
    oggetto character varying(160) NOT NULL
);


ALTER TABLE public.conversazioni OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 60904)
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
-- TOC entry 180 (class 1259 OID 60908)
-- Name: firme; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE firme (
    firma bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    timbro_orario timestamp(0) with time zone NOT NULL,
    docente bigint NOT NULL
);


ALTER TABLE public.firme OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 60912)
-- Name: fuori_classi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fuori_classi (
    fuori_classe bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    descrizione character varying(60) NOT NULL,
    timbro_orario timestamp(0) with time zone
);


ALTER TABLE public.fuori_classi OWNER TO postgres;

--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 181
-- Name: TABLE fuori_classi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE fuori_classi IS 'Rileva i fuori classe di un alunno';


--
-- TOC entry 182 (class 1259 OID 60916)
-- Name: giustificazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE giustificazioni (
    giustificazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    addetto_scolastico bigint NOT NULL,
    conversazione bigint,
    timbro_orario timestamp(0) with time zone
);


ALTER TABLE public.giustificazioni OWNER TO postgres;

--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 182
-- Name: COLUMN giustificazioni.conversazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN giustificazioni.conversazione IS 'la conversazione sul libretto personale relativa alla giustificazione';


SET default_with_oids = false;

--
-- TOC entry 183 (class 1259 OID 60923)
-- Name: gruppi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gruppi (
    gruppo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    nome character varying(60) NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.gruppi OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 184 (class 1259 OID 60927)
-- Name: gruppi_qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gruppi_qualifiche (
    gruppo_qualifiche bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.gruppi_qualifiche OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 60931)
-- Name: gruppi_qualifiche_dettaglio; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gruppi_qualifiche_dettaglio (
    gruppo_qualifiche_detaglio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    gruppo_qualifiche bigint NOT NULL,
    qualifica bigint NOT NULL
);


ALTER TABLE public.gruppi_qualifiche_dettaglio OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 60935)
-- Name: gruppi_utenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE gruppi_utenti (
    gruppo_utente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    gruppo bigint NOT NULL,
    utente bigint NOT NULL
);


ALTER TABLE public.gruppi_utenti OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 187 (class 1259 OID 60939)
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
-- TOC entry 188 (class 1259 OID 60943)
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
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN indirizzi_scolastici.anni_corso; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN indirizzi_scolastici.anni_corso IS 'anni del corso ad esempio:
5 per le primarie
3 per le secondarie di primo grado
5 per le secondarie di secondo grado';


--
-- TOC entry 189 (class 1259 OID 60947)
-- Name: istituti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE istituti (
    istituto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL,
    codice_meccanografico character varying(160) NOT NULL,
    mnemonico character varying(30) NOT NULL,
    esempio boolean DEFAULT false NOT NULL
);


ALTER TABLE public.istituti OWNER TO postgres;

--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 189
-- Name: COLUMN istituti.esempio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN istituti.esempio IS 'Indica se l''istituto e tutti i dati collegati sono stati inseriti per essere di esempio.
Se il dato è impostato a vero l''istituto verrà usato come sorgente dati per la compilazione dei dati di esempio.';


--
-- TOC entry 190 (class 1259 OID 60952)
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
    dalle time(0) with time zone,
    alle time(0) with time zone
);


ALTER TABLE public.lezioni OWNER TO postgres;

--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN lezioni.supplenza; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.supplenza IS 'Indica se la lezione è di supplenza cioè tenuta da un insegnante non titolare della cattedra';


--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN lezioni.dalle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.dalle IS 'inizio della lezione';


--
-- TOC entry 2670 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN lezioni.alle; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lezioni.alle IS 'fine della lezione';


--
-- TOC entry 191 (class 1259 OID 60960)
-- Name: libretti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE libretti (
    libretto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL
);


ALTER TABLE public.libretti OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 60964)
-- Name: mancanze; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mancanze (
    mancanza bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    descrizione character varying(2048) NOT NULL,
    il date
);


ALTER TABLE public.mancanze OWNER TO postgres;

--
-- TOC entry 2671 (class 0 OID 0)
-- Dependencies: 192
-- Name: TABLE mancanze; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE mancanze IS 'Rileva le mancanze di un alunno';


--
-- TOC entry 193 (class 1259 OID 60971)
-- Name: materie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE materie (
    materia bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL,
    metrica bigint NOT NULL
);


ALTER TABLE public.materie OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 60975)
-- Name: messaggi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi (
    messaggio bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversazione bigint NOT NULL,
    scritto_il timestamp(0) with time zone DEFAULT now() NOT NULL,
    testo character varying(2048) NOT NULL,
    da bigint NOT NULL
);


ALTER TABLE public.messaggi OWNER TO postgres;

--
-- TOC entry 2672 (class 0 OID 0)
-- Dependencies: 194
-- Name: COLUMN messaggi.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi.da IS 'La persona fisica che ha scritto il messaggio';


--
-- TOC entry 195 (class 1259 OID 60983)
-- Name: messaggi_letti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE messaggi_letti (
    messaggio_letto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    messaggio bigint NOT NULL,
    da bigint NOT NULL,
    letto_il timestamp(0) with time zone
);


ALTER TABLE public.messaggi_letti OWNER TO postgres;

--
-- TOC entry 2673 (class 0 OID 0)
-- Dependencies: 195
-- Name: COLUMN messaggi_letti.da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messaggi_letti.da IS 'Persona fisica che ha letto il messaggio';


--
-- TOC entry 196 (class 1259 OID 60987)
-- Name: metriche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE metriche (
    metrica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.metriche OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 60991)
-- Name: mezzi_comunicazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE mezzi_comunicazione (
    mezzo_comunicazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    tipo_comunicazione bigint NOT NULL,
    descrizione character varying(160),
    percorso character varying(255) NOT NULL
);


ALTER TABLE public.mezzi_comunicazione OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 60995)
-- Name: nazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nazioni (
    nazione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    esistente boolean DEFAULT true NOT NULL
);


ALTER TABLE public.nazioni OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 60999)
-- Name: note; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note (
    nota bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    disciplinare boolean NOT NULL,
    conversazione bigint,
    il date
);


ALTER TABLE public.note OWNER TO postgres;

--
-- TOC entry 2674 (class 0 OID 0)
-- Dependencies: 199
-- Name: COLUMN note.disciplinare; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN note.disciplinare IS 'Indica che l''annotazione è di tipo disciplinare verrà quindi riportata sul libretto personale per la firma di visione del genitore.
L''annotazione è rivolta a tutta la classe a meno che non sia indicato il singolo alunno.
Se si vuole fare una nota disciplinare (ma anche normale) a due o più alunni è necesario inserire la nota per ciascuno.';


--
-- TOC entry 200 (class 1259 OID 61006)
-- Name: note_docenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE note_docenti (
    nota_docente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    descrizione character varying(2048) NOT NULL,
    docente bigint NOT NULL,
    il date
);


ALTER TABLE public.note_docenti OWNER TO postgres;

--
-- TOC entry 2675 (class 0 OID 0)
-- Dependencies: 200
-- Name: TABLE note_docenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE note_docenti IS 'Svolge le stesse funzioni della tabella note ma per il registro del professore.
L''unica differenza è che non è stato necessario replicare anche la colonna ''disciplinare'' perchè le note disciplinari si fanno solo sul registro di classe mentre queste note sono principalmente ad uso privato dell''insegnante.';


--
-- TOC entry 201 (class 1259 OID 61013)
-- Name: orari_settimanali; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE orari_settimanali (
    orario_settimanale bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    giorno_settimana giorno_settimana NOT NULL,
    docente bigint NOT NULL,
    materia bigint,
    settimana settimana,
    dalle time(0) with time zone,
    alle time(0) with time zone
);


ALTER TABLE public.orari_settimanali OWNER TO postgres;

--
-- TOC entry 2676 (class 0 OID 0)
-- Dependencies: 201
-- Name: COLUMN orari_settimanali.settimana; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN orari_settimanali.settimana IS 'Indica il numero della settimana dell''orario si usa quando ci sono orari diversi fra settimana e settimana';


--
-- TOC entry 202 (class 1259 OID 61017)
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
    comune_nascita character(4)
);


ALTER TABLE public.persone OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 61024)
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
-- TOC entry 204 (class 1259 OID 61028)
-- Name: persone_parenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE persone_parenti (
    persona_parente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    persona bigint NOT NULL,
    parentela parentela NOT NULL,
    parente bigint NOT NULL
);


ALTER TABLE public.persone_parenti OWNER TO postgres;

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 61032)
-- Name: plessi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE plessi (
    plesso bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.plessi OWNER TO postgres;

SET default_with_oids = true;

--
-- TOC entry 206 (class 1259 OID 61036)
-- Name: provincie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincie (
    provincia character(2) NOT NULL,
    descrizione character varying(160) NOT NULL,
    regione smallint
);


ALTER TABLE public.provincie OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 61039)
-- Name: qualifiche; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE qualifiche (
    qualifica bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    istituto bigint,
    indirizzo_scolastico bigint,
    anno_corso anno_corso,
    materia bigint,
    nome character varying(160) NOT NULL,
    descrizione character varying(4000) NOT NULL,
    metrica bigint NOT NULL,
    tipo tipo_qualifica NOT NULL
);


ALTER TABLE public.qualifiche OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 61046)
-- Name: regioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE regioni (
    regione smallint NOT NULL,
    descrizione character varying(160) NOT NULL,
    ripartizione_geografica ripartizione_geografica
);


ALTER TABLE public.regioni OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 61049)
-- Name: ritardi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ritardi (
    ritardo bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    timbro_orario timestamp(0) with time zone
);


ALTER TABLE public.ritardi OWNER TO postgres;

--
-- TOC entry 2677 (class 0 OID 0)
-- Dependencies: 209
-- Name: TABLE ritardi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE ritardi IS 'Rileva i ritardi di un alunno';


SET default_with_oids = false;

--
-- TOC entry 210 (class 1259 OID 61053)
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
-- TOC entry 2678 (class 0 OID 0)
-- Dependencies: 210
-- Name: COLUMN scrutini.data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini.data IS 'Data dello scrutinio';


--
-- TOC entry 211 (class 1259 OID 61057)
-- Name: scrutini_valutazioni; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scrutini_valutazioni (
    scrutinio_valutazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    scrutinio bigint NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    materia bigint NOT NULL,
    tipo_voto bigint NOT NULL,
    voto_proposto bigint NOT NULL,
    voto bigint,
    note character varying(2048),
    carenze_formative boolean DEFAULT false NOT NULL,
    voto_di_consiglio boolean DEFAULT false NOT NULL
);


ALTER TABLE public.scrutini_valutazioni OWNER TO postgres;

--
-- TOC entry 2679 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN scrutini_valutazioni.carenze_formative; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.carenze_formative IS 'indica se l''alunno ha dimostrato di avere carenze formative';


--
-- TOC entry 2680 (class 0 OID 0)
-- Dependencies: 211
-- Name: COLUMN scrutini_valutazioni.voto_di_consiglio; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN scrutini_valutazioni.voto_di_consiglio IS 'Indica che il voto è stato deciso dal consiglio di classe in difformità a quanto proposto dal docente';


SET default_with_oids = true;

--
-- TOC entry 212 (class 1259 OID 61066)
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

--
-- TOC entry 213 (class 1259 OID 61073)
-- Name: tipi_comunicazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_comunicazione (
    tipo_comunicazione bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(160) NOT NULL
);


ALTER TABLE public.tipi_comunicazione OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 61077)
-- Name: tipi_voto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipi_voto (
    tipo_voto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    descrizione character varying(60) NOT NULL,
    materia bigint NOT NULL
);


ALTER TABLE public.tipi_voto OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 61081)
-- Name: uscite; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE uscite (
    uscita bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classe bigint NOT NULL,
    alunno bigint NOT NULL,
    docente bigint NOT NULL,
    giustificazione bigint,
    timbro_orario timestamp(0) with time zone
);


ALTER TABLE public.uscite OWNER TO postgres;

--
-- TOC entry 2681 (class 0 OID 0)
-- Dependencies: 215
-- Name: TABLE uscite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE uscite IS 'Rileva i uscite di un alunno';


SET default_with_oids = false;

--
-- TOC entry 216 (class 1259 OID 61085)
-- Name: utenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti (
    utente bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    nome character varying(60) NOT NULL,
    password character varying(160) NOT NULL,
    token character varying(1024),
    persona bigint
);


ALTER TABLE public.utenti OWNER TO postgres;

--
-- TOC entry 2682 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE utenti IS 'Tutti gli utenti del sistema';


--
-- TOC entry 2683 (class 0 OID 0)
-- Dependencies: 216
-- Name: COLUMN utenti.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN utenti.token IS 'serve per il ripristino della password via email';


--
-- TOC entry 217 (class 1259 OID 61092)
-- Name: utenti_istituti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti_istituti (
    utente_istituto bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    utente bigint NOT NULL,
    istituto bigint NOT NULL
);


ALTER TABLE public.utenti_istituti OWNER TO postgres;

--
-- TOC entry 2684 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE utenti_istituti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE utenti_istituti IS 'Indica gli istituti autorizzati per il singolo utente';


SET default_with_oids = true;

--
-- TOC entry 218 (class 1259 OID 61096)
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
    docente bigint,
    il date
);


ALTER TABLE public.valutazioni OWNER TO postgres;

--
-- TOC entry 2685 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE valutazioni; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni IS 'Contiene le valutazioni di tutti gli alunni fatti da tutti gli insegnati ';


--
-- TOC entry 2686 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN valutazioni.privato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.privato IS 'Indica che il voto è visibile al solo docente che lo ha inserito';


--
-- TOC entry 2687 (class 0 OID 0)
-- Dependencies: 218
-- Name: COLUMN valutazioni.docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutazioni.docente IS 'La colonna docente è stata inserita poichè il docente durante l`anno potrebbe cambiare in questo modo viene tenuto traccia di chi ha inserito il dato';


--
-- TOC entry 219 (class 1259 OID 61101)
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
-- TOC entry 2688 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE valutazioni_qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutazioni_qualifiche IS 'Per ogni valutazione inserita nella tabella valutazioni è possibile collegare anche la valutazione delle qualifiche collegate che vengono memorizzate qui';


--
-- TOC entry 220 (class 1259 OID 61108)
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
-- TOC entry 2689 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE voti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE voti IS 'Contiene i voti delle varie metriche';


--
-- TOC entry 2162 (class 2606 OID 61113)
-- Name: anni_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_pk PRIMARY KEY (anno_scolastico);


--
-- TOC entry 2164 (class 2606 OID 61115)
-- Name: anni_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2690 (class 0 OID 0)
-- Dependencies: 2164
-- Name: CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT anni_scolastici_uq_descrizione ON anni_scolastici IS 'La descrizione deve essere univoca all''interno di un istituto';


--
-- TOC entry 2168 (class 2606 OID 61117)
-- Name: argomenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_pk PRIMARY KEY (argomento);


--
-- TOC entry 2170 (class 2606 OID 105068)
-- Name: argomenti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_uq_descrizione UNIQUE (indirizzo_scolastico, anno_corso, materia, descrizione);


--
-- TOC entry 2176 (class 2606 OID 61121)
-- Name: assenze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_pk PRIMARY KEY (assenza);


--
-- TOC entry 2189 (class 2606 OID 61123)
-- Name: classi_alunni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_pk PRIMARY KEY (classe_alunno);


--
-- TOC entry 2191 (class 2606 OID 61125)
-- Name: classi_alunni_uq_alunno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_uq_alunno UNIQUE (classe, alunno);


--
-- TOC entry 2181 (class 2606 OID 61127)
-- Name: classi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_pk PRIMARY KEY (classe);


--
-- TOC entry 2183 (class 2606 OID 61129)
-- Name: classi_uq_classe; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_classe UNIQUE (anno_scolastico, plesso, indirizzo_scolastico, sezione, anno_corso);


--
-- TOC entry 2185 (class 2606 OID 61131)
-- Name: classi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_uq_descrizione UNIQUE (anno_scolastico, plesso, descrizione);


--
-- TOC entry 2195 (class 2606 OID 61133)
-- Name: colloqui_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_pk PRIMARY KEY (colloquio);


--
-- TOC entry 2197 (class 2606 OID 61135)
-- Name: comuni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_pk PRIMARY KEY (comune);


--
-- TOC entry 2201 (class 2606 OID 61137)
-- Name: conversazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_pk PRIMARY KEY (conversazione);


--
-- TOC entry 2204 (class 2606 OID 61139)
-- Name: festivi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_pk PRIMARY KEY (festivo);


--
-- TOC entry 2206 (class 2606 OID 61141)
-- Name: festivi_uq_giorno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_uq_giorno UNIQUE (istituto, giorno);


--
-- TOC entry 2210 (class 2606 OID 61143)
-- Name: firme_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_pk PRIMARY KEY (firma);


--
-- TOC entry 2212 (class 2606 OID 61145)
-- Name: fuori_classe_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_pk PRIMARY KEY (fuori_classe);


--
-- TOC entry 2221 (class 2606 OID 61147)
-- Name: giustificazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_pk PRIMARY KEY (giustificazione);


--
-- TOC entry 2223 (class 2606 OID 61149)
-- Name: gruppi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi
    ADD CONSTRAINT gruppi_pk PRIMARY KEY (gruppo);


--
-- TOC entry 2236 (class 2606 OID 61151)
-- Name: gruppi_qualifiche_dettaglio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_qualifiche_dettaglio
    ADD CONSTRAINT gruppi_qualifiche_dettaglio_pk PRIMARY KEY (gruppo_qualifiche_detaglio);


--
-- TOC entry 2238 (class 2606 OID 61153)
-- Name: gruppi_qualifiche_dettaglio_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_qualifiche_dettaglio
    ADD CONSTRAINT gruppi_qualifiche_dettaglio_uq_qualifica UNIQUE (gruppo_qualifiche, qualifica);


--
-- TOC entry 2230 (class 2606 OID 61155)
-- Name: gruppi_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_qualifiche
    ADD CONSTRAINT gruppi_qualifiche_pk PRIMARY KEY (gruppo_qualifiche);


--
-- TOC entry 2232 (class 2606 OID 61157)
-- Name: gruppi_qualifiche_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_qualifiche
    ADD CONSTRAINT gruppi_qualifiche_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2691 (class 0 OID 0)
-- Dependencies: 2232
-- Name: CONSTRAINT gruppi_qualifiche_uq_descrizione ON gruppi_qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT gruppi_qualifiche_uq_descrizione ON gruppi_qualifiche IS 'La descrizione deve essere univoca a livello di istituto';


--
-- TOC entry 2225 (class 2606 OID 61159)
-- Name: gruppi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi
    ADD CONSTRAINT gruppi_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2227 (class 2606 OID 61161)
-- Name: gruppi_uq_nome; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi
    ADD CONSTRAINT gruppi_uq_nome UNIQUE (nome);


--
-- TOC entry 2692 (class 0 OID 0)
-- Dependencies: 2227
-- Name: CONSTRAINT gruppi_uq_nome ON gruppi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT gruppi_uq_nome ON gruppi IS 'Il nome del gruppo deve essere univoco all`interno del sistema';


--
-- TOC entry 2240 (class 2606 OID 61163)
-- Name: gruppi_utente_uq_utente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_utenti
    ADD CONSTRAINT gruppi_utente_uq_utente UNIQUE (gruppo, utente);


--
-- TOC entry 2244 (class 2606 OID 61165)
-- Name: gruppi_utenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY gruppi_utenti
    ADD CONSTRAINT gruppi_utenti_pk PRIMARY KEY (gruppo_utente);


--
-- TOC entry 2247 (class 2606 OID 61167)
-- Name: indirizzi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi
    ADD CONSTRAINT indirizzi_pk PRIMARY KEY (indirizzo);


--
-- TOC entry 2250 (class 2606 OID 61169)
-- Name: indirizzi_scolastici_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_pk PRIMARY KEY (indirizzo_scolastico);


--
-- TOC entry 2252 (class 2606 OID 61171)
-- Name: indirizzi_scolastici_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2254 (class 2606 OID 61173)
-- Name: istituti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_pk PRIMARY KEY (istituto);


--
-- TOC entry 2256 (class 2606 OID 61175)
-- Name: istituti_uq_codice_meccanografico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_codice_meccanografico UNIQUE (codice_meccanografico);


--
-- TOC entry 2258 (class 2606 OID 61177)
-- Name: istituti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2260 (class 2606 OID 61179)
-- Name: istituti_uq_mnemonico; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY istituti
    ADD CONSTRAINT istituti_uq_mnemonico UNIQUE (mnemonico);


--
-- TOC entry 2265 (class 2606 OID 61181)
-- Name: lezioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_pk PRIMARY KEY (lezione);


--
-- TOC entry 2269 (class 2606 OID 61183)
-- Name: libretti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY libretti
    ADD CONSTRAINT libretti_pk PRIMARY KEY (libretto);


--
-- TOC entry 2271 (class 2606 OID 61185)
-- Name: libretti_uq_alunno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY libretti
    ADD CONSTRAINT libretti_uq_alunno UNIQUE (classe, alunno);


--
-- TOC entry 2277 (class 2606 OID 61187)
-- Name: mancanze_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_pk PRIMARY KEY (mancanza);


--
-- TOC entry 2281 (class 2606 OID 61189)
-- Name: materie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_pk PRIMARY KEY (materia);


--
-- TOC entry 2283 (class 2606 OID 61191)
-- Name: materie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2293 (class 2606 OID 61193)
-- Name: messaggi_letti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_pk PRIMARY KEY (messaggio_letto);


--
-- TOC entry 2287 (class 2606 OID 61195)
-- Name: messaggi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_pk PRIMARY KEY (messaggio);


--
-- TOC entry 2289 (class 2606 OID 61197)
-- Name: messaggi_uq_da; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_uq_da UNIQUE (conversazione, scritto_il, testo, da);


--
-- TOC entry 2296 (class 2606 OID 61199)
-- Name: metriche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_pk PRIMARY KEY (metrica);


--
-- TOC entry 2298 (class 2606 OID 61201)
-- Name: metriche_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2302 (class 2606 OID 61203)
-- Name: mezzi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_pk PRIMARY KEY (mezzo_comunicazione);


--
-- TOC entry 2304 (class 2606 OID 61205)
-- Name: mezzi_di_comunicazione_uq_percorso; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_di_comunicazione_uq_percorso UNIQUE (persona, tipo_comunicazione, descrizione, percorso);


--
-- TOC entry 2306 (class 2606 OID 61207)
-- Name: nazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_pk PRIMARY KEY (nazione);


--
-- TOC entry 2308 (class 2606 OID 61209)
-- Name: nazioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazioni
    ADD CONSTRAINT nazioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2319 (class 2606 OID 61211)
-- Name: note_docenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_pk PRIMARY KEY (nota_docente);


--
-- TOC entry 2314 (class 2606 OID 61213)
-- Name: note_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_pk PRIMARY KEY (nota);


--
-- TOC entry 2324 (class 2606 OID 61215)
-- Name: orari_settimanali_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_pk PRIMARY KEY (orario_settimanale);


--
-- TOC entry 2333 (class 2606 OID 61217)
-- Name: persone_indirizzi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_pk PRIMARY KEY (persona_indirizzo);


--
-- TOC entry 2337 (class 2606 OID 61219)
-- Name: persone_parenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone_parenti
    ADD CONSTRAINT persone_parenti_pk PRIMARY KEY (persona_parente);


--
-- TOC entry 2329 (class 2606 OID 61221)
-- Name: persone_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_pk PRIMARY KEY (persona);


--
-- TOC entry 2340 (class 2606 OID 61223)
-- Name: plessi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_pk PRIMARY KEY (plesso);


--
-- TOC entry 2342 (class 2606 OID 61225)
-- Name: plessi_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_uq_descrizione UNIQUE (istituto, descrizione);


--
-- TOC entry 2344 (class 2606 OID 61227)
-- Name: provincie_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_pk PRIMARY KEY (provincia);


--
-- TOC entry 2346 (class 2606 OID 61229)
-- Name: provincie_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2352 (class 2606 OID 61231)
-- Name: qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_pk PRIMARY KEY (qualifica);


--
-- TOC entry 2354 (class 2606 OID 61233)
-- Name: regioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_pk PRIMARY KEY (regione);


--
-- TOC entry 2356 (class 2606 OID 61235)
-- Name: regioni_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY regioni
    ADD CONSTRAINT regioni_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2362 (class 2606 OID 61237)
-- Name: ritardi_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_pk PRIMARY KEY (ritardo);


--
-- TOC entry 2365 (class 2606 OID 61239)
-- Name: scrutini_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_pk PRIMARY KEY (scrutinio);


--
-- TOC entry 2367 (class 2606 OID 61241)
-- Name: scrutini_uq_data; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_data UNIQUE (anno_scolastico, data);


--
-- TOC entry 2369 (class 2606 OID 61243)
-- Name: scrutini_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_uq_descrizione UNIQUE (anno_scolastico, descrizione);


--
-- TOC entry 2378 (class 2606 OID 61245)
-- Name: scrutini_valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_pk PRIMARY KEY (scrutinio_valutazione);


--
-- TOC entry 2384 (class 2606 OID 61247)
-- Name: scrutini_valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_pk PRIMARY KEY (scrutinio_valutazione_qualifica);


--
-- TOC entry 2386 (class 2606 OID 61249)
-- Name: scrutini_valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_uq_qualifica UNIQUE (scrutinio_valutazione, qualifica);


--
-- TOC entry 2388 (class 2606 OID 61251)
-- Name: tipi_comunicazione_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_pk PRIMARY KEY (tipo_comunicazione);


--
-- TOC entry 2390 (class 2606 OID 61253)
-- Name: tipi_comunicazione_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_comunicazione
    ADD CONSTRAINT tipi_comunicazione_uq_descrizione UNIQUE (descrizione);


--
-- TOC entry 2392 (class 2606 OID 61255)
-- Name: tipi_voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voti_uq_descrizione UNIQUE (materia, descrizione);


--
-- TOC entry 2395 (class 2606 OID 61257)
-- Name: tipi_voto_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_pk PRIMARY KEY (tipo_voto);


--
-- TOC entry 2401 (class 2606 OID 61259)
-- Name: uscite_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_pk PRIMARY KEY (uscita);


--
-- TOC entry 2411 (class 2606 OID 61261)
-- Name: utenti_istituti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_pk PRIMARY KEY (utente_istituto);


--
-- TOC entry 2413 (class 2606 OID 61263)
-- Name: utenti_istituti_uq_utente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_uq_utente UNIQUE (utente, istituto);


--
-- TOC entry 2403 (class 2606 OID 61265)
-- Name: utenti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_pk PRIMARY KEY (utente);


--
-- TOC entry 2405 (class 2606 OID 61267)
-- Name: utenti_uq_nome; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_uq_nome UNIQUE (nome);


--
-- TOC entry 2407 (class 2606 OID 61269)
-- Name: utenti_uq_persona; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_uq_persona UNIQUE (persona);


--
-- TOC entry 2693 (class 0 OID 0)
-- Dependencies: 2407
-- Name: CONSTRAINT utenti_uq_persona ON utenti; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT utenti_uq_persona ON utenti IS 'Ad ogni persona fisica deve corrispondere un solo utente';


--
-- TOC entry 2419 (class 2606 OID 61271)
-- Name: valutazioni_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_pk PRIMARY KEY (valutazione);


--
-- TOC entry 2424 (class 2606 OID 61273)
-- Name: valutazioni_qualifiche_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_pk PRIMARY KEY (valutazione_qualifica);


--
-- TOC entry 2426 (class 2606 OID 61275)
-- Name: valutazioni_qualifiche_uq_qualifica; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_uq_qualifica UNIQUE (valutazione, qualifica);


--
-- TOC entry 2429 (class 2606 OID 61277)
-- Name: voti_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_pk PRIMARY KEY (voto);


--
-- TOC entry 2431 (class 2606 OID 61279)
-- Name: voti_uq_descrizione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_uq_descrizione UNIQUE (metrica, descrizione);


--
-- TOC entry 2160 (class 1259 OID 61280)
-- Name: anni_scolastici_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX anni_scolastici_ix_istituto ON anni_scolastici USING btree (istituto);


--
-- TOC entry 2694 (class 0 OID 0)
-- Dependencies: 2160
-- Name: INDEX anni_scolastici_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX anni_scolastici_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2165 (class 1259 OID 105066)
-- Name: argomenti_ix_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_ix_indirizzo_scolastico ON argomenti USING btree (indirizzo_scolastico);


--
-- TOC entry 2166 (class 1259 OID 61282)
-- Name: argomenti_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX argomenti_ix_materia ON argomenti USING btree (materia);


--
-- TOC entry 2695 (class 0 OID 0)
-- Dependencies: 2166
-- Name: INDEX argomenti_ix_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX argomenti_ix_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2171 (class 1259 OID 61283)
-- Name: assenze_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_ix_alunno ON assenze USING btree (alunno);


--
-- TOC entry 2696 (class 0 OID 0)
-- Dependencies: 2171
-- Name: INDEX assenze_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2172 (class 1259 OID 61284)
-- Name: assenze_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_ix_classe ON assenze USING btree (classe);


--
-- TOC entry 2697 (class 0 OID 0)
-- Dependencies: 2172
-- Name: INDEX assenze_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2173 (class 1259 OID 61285)
-- Name: assenze_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_ix_docente ON assenze USING btree (docente);


--
-- TOC entry 2698 (class 0 OID 0)
-- Dependencies: 2173
-- Name: INDEX assenze_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2174 (class 1259 OID 61286)
-- Name: assenze_ix_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX assenze_ix_giustificazione ON assenze USING btree (giustificazione);


--
-- TOC entry 2699 (class 0 OID 0)
-- Dependencies: 2174
-- Name: INDEX assenze_ix_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX assenze_ix_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2186 (class 1259 OID 61287)
-- Name: classi_alunni_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_alunni_ix_alunno ON classi_alunni USING btree (alunno);


--
-- TOC entry 2700 (class 0 OID 0)
-- Dependencies: 2186
-- Name: INDEX classi_alunni_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_alunni_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2187 (class 1259 OID 61288)
-- Name: classi_alunni_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_alunni_ix_classe ON classi_alunni USING btree (classe);


--
-- TOC entry 2701 (class 0 OID 0)
-- Dependencies: 2187
-- Name: INDEX classi_alunni_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_alunni_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2177 (class 1259 OID 61289)
-- Name: classi_ix_anno_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_ix_anno_scolastico ON classi USING btree (anno_scolastico);


--
-- TOC entry 2702 (class 0 OID 0)
-- Dependencies: 2177
-- Name: INDEX classi_ix_anno_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_ix_anno_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2178 (class 1259 OID 61290)
-- Name: classi_ix_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_ix_indirizzo_scolastico ON classi USING btree (indirizzo_scolastico);


--
-- TOC entry 2703 (class 0 OID 0)
-- Dependencies: 2178
-- Name: INDEX classi_ix_indirizzo_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classi_ix_indirizzo_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2179 (class 1259 OID 61291)
-- Name: classi_ix_plesso; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX classi_ix_plesso ON classi USING btree (plesso);


--
-- TOC entry 2192 (class 1259 OID 61292)
-- Name: colloqui_ix_con; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_ix_con ON colloqui USING btree (con);


--
-- TOC entry 2193 (class 1259 OID 61293)
-- Name: colloqui_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX colloqui_ix_docente ON colloqui USING btree (docente);


--
-- TOC entry 2199 (class 1259 OID 61294)
-- Name: conversazioni_ix_libretto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX conversazioni_ix_libretto ON conversazioni USING btree (libretto);


--
-- TOC entry 2704 (class 0 OID 0)
-- Dependencies: 2199
-- Name: INDEX conversazioni_ix_libretto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX conversazioni_ix_libretto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2202 (class 1259 OID 61295)
-- Name: festivi_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX festivi_ix_istituto ON festivi USING btree (istituto);


--
-- TOC entry 2705 (class 0 OID 0)
-- Dependencies: 2202
-- Name: INDEX festivi_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX festivi_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2207 (class 1259 OID 61296)
-- Name: firme_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_ix_classe ON firme USING btree (classe);


--
-- TOC entry 2706 (class 0 OID 0)
-- Dependencies: 2207
-- Name: INDEX firme_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2208 (class 1259 OID 61297)
-- Name: firme_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX firme_ix_docente ON firme USING btree (docente);


--
-- TOC entry 2707 (class 0 OID 0)
-- Dependencies: 2208
-- Name: INDEX firme_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX firme_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2198 (class 1259 OID 61298)
-- Name: fki_comuni_fk_provincia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fki_comuni_fk_provincia ON comuni USING btree (provincia);


--
-- TOC entry 2213 (class 1259 OID 61299)
-- Name: fuori_classi_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_ix_alunno ON fuori_classi USING btree (alunno);


--
-- TOC entry 2708 (class 0 OID 0)
-- Dependencies: 2213
-- Name: INDEX fuori_classi_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2214 (class 1259 OID 61300)
-- Name: fuori_classi_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_ix_classe ON fuori_classi USING btree (classe);


--
-- TOC entry 2709 (class 0 OID 0)
-- Dependencies: 2214
-- Name: INDEX fuori_classi_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2215 (class 1259 OID 61301)
-- Name: fuori_classi_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX fuori_classi_ix_docente ON fuori_classi USING btree (docente);


--
-- TOC entry 2710 (class 0 OID 0)
-- Dependencies: 2215
-- Name: INDEX fuori_classi_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX fuori_classi_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2216 (class 1259 OID 61302)
-- Name: giustificazioni_ix_addetto_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_ix_addetto_scolastico ON giustificazioni USING btree (addetto_scolastico);


--
-- TOC entry 2711 (class 0 OID 0)
-- Dependencies: 2216
-- Name: INDEX giustificazioni_ix_addetto_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_ix_addetto_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2217 (class 1259 OID 61303)
-- Name: giustificazioni_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_ix_alunno ON giustificazioni USING btree (alunno);


--
-- TOC entry 2712 (class 0 OID 0)
-- Dependencies: 2217
-- Name: INDEX giustificazioni_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2218 (class 1259 OID 61304)
-- Name: giustificazioni_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_ix_classe ON giustificazioni USING btree (classe);


--
-- TOC entry 2713 (class 0 OID 0)
-- Dependencies: 2218
-- Name: INDEX giustificazioni_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2219 (class 1259 OID 61305)
-- Name: giustificazioni_ix_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX giustificazioni_ix_conversazione ON giustificazioni USING btree (conversazione);


--
-- TOC entry 2714 (class 0 OID 0)
-- Dependencies: 2219
-- Name: INDEX giustificazioni_ix_conversazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX giustificazioni_ix_conversazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2233 (class 1259 OID 61306)
-- Name: gruppi_qualifiche_dettaglio_ix_gruppo_qualifiche; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX gruppi_qualifiche_dettaglio_ix_gruppo_qualifiche ON gruppi_qualifiche_dettaglio USING btree (gruppo_qualifiche);


--
-- TOC entry 2715 (class 0 OID 0)
-- Dependencies: 2233
-- Name: INDEX gruppi_qualifiche_dettaglio_ix_gruppo_qualifiche; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX gruppi_qualifiche_dettaglio_ix_gruppo_qualifiche IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2234 (class 1259 OID 61307)
-- Name: gruppi_qualifiche_dettaglio_ix_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX gruppi_qualifiche_dettaglio_ix_qualifica ON gruppi_qualifiche_dettaglio USING btree (qualifica);


--
-- TOC entry 2716 (class 0 OID 0)
-- Dependencies: 2234
-- Name: INDEX gruppi_qualifiche_dettaglio_ix_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX gruppi_qualifiche_dettaglio_ix_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2228 (class 1259 OID 61308)
-- Name: gruppi_qualifiche_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX gruppi_qualifiche_ix_istituto ON gruppi_qualifiche USING btree (istituto);


--
-- TOC entry 2717 (class 0 OID 0)
-- Dependencies: 2228
-- Name: INDEX gruppi_qualifiche_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX gruppi_qualifiche_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2241 (class 1259 OID 61309)
-- Name: gruppi_utenti_ix_gruppo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX gruppi_utenti_ix_gruppo ON gruppi_utenti USING btree (gruppo);


--
-- TOC entry 2242 (class 1259 OID 61310)
-- Name: gruppi_utenti_ix_utente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX gruppi_utenti_ix_utente ON gruppi_utenti USING btree (utente);


--
-- TOC entry 2414 (class 1259 OID 61311)
-- Name: idx_valutazioni; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_valutazioni ON valutazioni USING btree (conversazione);


--
-- TOC entry 2245 (class 1259 OID 61312)
-- Name: indirizzi_ix_nazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indirizzi_ix_nazione ON indirizzi USING btree (nazione);


--
-- TOC entry 2718 (class 0 OID 0)
-- Dependencies: 2245
-- Name: INDEX indirizzi_ix_nazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX indirizzi_ix_nazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2248 (class 1259 OID 61313)
-- Name: indirizzi_scolastici_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX indirizzi_scolastici_ix_istituto ON indirizzi_scolastici USING btree (istituto);


--
-- TOC entry 2719 (class 0 OID 0)
-- Dependencies: 2248
-- Name: INDEX indirizzi_scolastici_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX indirizzi_scolastici_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2261 (class 1259 OID 61314)
-- Name: lezioni_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_ix_classe ON lezioni USING btree (classe);


--
-- TOC entry 2720 (class 0 OID 0)
-- Dependencies: 2261
-- Name: INDEX lezioni_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2262 (class 1259 OID 61315)
-- Name: lezioni_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_ix_docente ON lezioni USING btree (docente);


--
-- TOC entry 2721 (class 0 OID 0)
-- Dependencies: 2262
-- Name: INDEX lezioni_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2263 (class 1259 OID 61316)
-- Name: lezioni_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX lezioni_ix_materia ON lezioni USING btree (materia);


--
-- TOC entry 2722 (class 0 OID 0)
-- Dependencies: 2263
-- Name: INDEX lezioni_ix_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lezioni_ix_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2266 (class 1259 OID 61317)
-- Name: libretti_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_ix_alunno ON libretti USING btree (alunno);


--
-- TOC entry 2723 (class 0 OID 0)
-- Dependencies: 2266
-- Name: INDEX libretti_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2267 (class 1259 OID 61318)
-- Name: libretti_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_ix_classe ON libretti USING btree (classe);


--
-- TOC entry 2724 (class 0 OID 0)
-- Dependencies: 2267
-- Name: INDEX libretti_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2290 (class 1259 OID 61319)
-- Name: libretti_messaggi_letti_ix_libretto_mess; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_ix_libretto_mess ON messaggi_letti USING btree (messaggio);


--
-- TOC entry 2725 (class 0 OID 0)
-- Dependencies: 2290
-- Name: INDEX libretti_messaggi_letti_ix_libretto_mess; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_ix_libretto_mess IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2291 (class 1259 OID 61320)
-- Name: libretti_messaggi_letti_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX libretti_messaggi_letti_ix_persona ON messaggi_letti USING btree (da);


--
-- TOC entry 2726 (class 0 OID 0)
-- Dependencies: 2291
-- Name: INDEX libretti_messaggi_letti_ix_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messaggi_letti_ix_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2272 (class 1259 OID 61321)
-- Name: mancanze_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_ix_alunno ON mancanze USING btree (alunno);


--
-- TOC entry 2727 (class 0 OID 0)
-- Dependencies: 2272
-- Name: INDEX mancanze_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2273 (class 1259 OID 61322)
-- Name: mancanze_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_ix_classe ON mancanze USING btree (classe);


--
-- TOC entry 2728 (class 0 OID 0)
-- Dependencies: 2273
-- Name: INDEX mancanze_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2274 (class 1259 OID 61323)
-- Name: mancanze_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_ix_docente ON mancanze USING btree (docente);


--
-- TOC entry 2729 (class 0 OID 0)
-- Dependencies: 2274
-- Name: INDEX mancanze_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2275 (class 1259 OID 61324)
-- Name: mancanze_ix_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mancanze_ix_giustificazione ON mancanze USING btree (giustificazione);


--
-- TOC entry 2730 (class 0 OID 0)
-- Dependencies: 2275
-- Name: INDEX mancanze_ix_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mancanze_ix_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2278 (class 1259 OID 61325)
-- Name: materie_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX materie_ix_istituto ON materie USING btree (istituto);


--
-- TOC entry 2731 (class 0 OID 0)
-- Dependencies: 2278
-- Name: INDEX materie_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX materie_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2279 (class 1259 OID 61326)
-- Name: materie_ix_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX materie_ix_metrica ON materie USING btree (metrica);


--
-- TOC entry 2732 (class 0 OID 0)
-- Dependencies: 2279
-- Name: INDEX materie_ix_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX materie_ix_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2284 (class 1259 OID 61327)
-- Name: messaggi_ix_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_ix_conversazione ON messaggi USING btree (conversazione);


--
-- TOC entry 2733 (class 0 OID 0)
-- Dependencies: 2284
-- Name: INDEX messaggi_ix_conversazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_ix_conversazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2285 (class 1259 OID 61328)
-- Name: messaggi_ix_da; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX messaggi_ix_da ON messaggi USING btree (da);


--
-- TOC entry 2734 (class 0 OID 0)
-- Dependencies: 2285
-- Name: INDEX messaggi_ix_da; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messaggi_ix_da IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2294 (class 1259 OID 61329)
-- Name: metriche_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX metriche_ix_istituto ON metriche USING btree (istituto);


--
-- TOC entry 2735 (class 0 OID 0)
-- Dependencies: 2294
-- Name: INDEX metriche_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX metriche_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2299 (class 1259 OID 61330)
-- Name: mezzi_comunicazione_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_persona ON mezzi_comunicazione USING btree (persona);


--
-- TOC entry 2736 (class 0 OID 0)
-- Dependencies: 2299
-- Name: INDEX mezzi_comunicazione_ix_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2300 (class 1259 OID 61331)
-- Name: mezzi_comunicazione_ix_tipo_comunicazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX mezzi_comunicazione_ix_tipo_comunicazione ON mezzi_comunicazione USING btree (tipo_comunicazione);


--
-- TOC entry 2737 (class 0 OID 0)
-- Dependencies: 2300
-- Name: INDEX mezzi_comunicazione_ix_tipo_comunicazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX mezzi_comunicazione_ix_tipo_comunicazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2315 (class 1259 OID 61332)
-- Name: note_docenti_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_ix_alunno ON note_docenti USING btree (alunno);


--
-- TOC entry 2738 (class 0 OID 0)
-- Dependencies: 2315
-- Name: INDEX note_docenti_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2316 (class 1259 OID 61333)
-- Name: note_docenti_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_ix_classe ON note_docenti USING btree (classe);


--
-- TOC entry 2739 (class 0 OID 0)
-- Dependencies: 2316
-- Name: INDEX note_docenti_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2317 (class 1259 OID 61334)
-- Name: note_docenti_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_docenti_ix_docente ON note_docenti USING btree (docente);


--
-- TOC entry 2740 (class 0 OID 0)
-- Dependencies: 2317
-- Name: INDEX note_docenti_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_docenti_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2309 (class 1259 OID 61335)
-- Name: note_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_ix_alunno ON note USING btree (alunno);


--
-- TOC entry 2741 (class 0 OID 0)
-- Dependencies: 2309
-- Name: INDEX note_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2310 (class 1259 OID 61336)
-- Name: note_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_ix_classe ON note USING btree (classe);


--
-- TOC entry 2742 (class 0 OID 0)
-- Dependencies: 2310
-- Name: INDEX note_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2311 (class 1259 OID 61337)
-- Name: note_ix_conversazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_ix_conversazione ON note USING btree (conversazione);


--
-- TOC entry 2312 (class 1259 OID 61338)
-- Name: note_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX note_ix_docente ON note USING btree (docente);


--
-- TOC entry 2743 (class 0 OID 0)
-- Dependencies: 2312
-- Name: INDEX note_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX note_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2320 (class 1259 OID 61339)
-- Name: orari_settimanali_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_ix_classe ON orari_settimanali USING btree (classe);


--
-- TOC entry 2744 (class 0 OID 0)
-- Dependencies: 2320
-- Name: INDEX orari_settimanali_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2321 (class 1259 OID 61340)
-- Name: orari_settimanali_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_ix_docente ON orari_settimanali USING btree (docente);


--
-- TOC entry 2745 (class 0 OID 0)
-- Dependencies: 2321
-- Name: INDEX orari_settimanali_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2322 (class 1259 OID 61341)
-- Name: orari_settimanali_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX orari_settimanali_ix_materia ON orari_settimanali USING btree (materia);


--
-- TOC entry 2746 (class 0 OID 0)
-- Dependencies: 2322
-- Name: INDEX orari_settimanali_ix_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX orari_settimanali_ix_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2330 (class 1259 OID 61342)
-- Name: persone_indirizzi_ix_indirizzo; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_ix_indirizzo ON persone_indirizzi USING btree (indirizzo);


--
-- TOC entry 2331 (class 1259 OID 61343)
-- Name: persone_indirizzi_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_indirizzi_ix_persona ON persone_indirizzi USING btree (persona);


--
-- TOC entry 2325 (class 1259 OID 61344)
-- Name: persone_ix_comune_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_ix_comune_nascita ON persone USING btree (comune_nascita);


--
-- TOC entry 2326 (class 1259 OID 61345)
-- Name: persone_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_ix_istituto ON persone USING btree (istituto);


--
-- TOC entry 2327 (class 1259 OID 61346)
-- Name: persone_ix_nazione_nascita; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_ix_nazione_nascita ON persone USING btree (nazione_nascita);


--
-- TOC entry 2334 (class 1259 OID 61347)
-- Name: persone_parenti_ix_parente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_parenti_ix_parente ON persone_parenti USING btree (parente);


--
-- TOC entry 2747 (class 0 OID 0)
-- Dependencies: 2334
-- Name: INDEX persone_parenti_ix_parente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_parenti_ix_parente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2335 (class 1259 OID 61348)
-- Name: persone_parenti_ix_persona; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX persone_parenti_ix_persona ON persone_parenti USING btree (persona);


--
-- TOC entry 2748 (class 0 OID 0)
-- Dependencies: 2335
-- Name: INDEX persone_parenti_ix_persona; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persone_parenti_ix_persona IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2338 (class 1259 OID 61349)
-- Name: plessi_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX plessi_ix_istituto ON plessi USING btree (istituto);


--
-- TOC entry 2347 (class 1259 OID 61350)
-- Name: qualifiche_ix_indirizzo_scolastico; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_ix_indirizzo_scolastico ON qualifiche USING btree (indirizzo_scolastico);


--
-- TOC entry 2749 (class 0 OID 0)
-- Dependencies: 2347
-- Name: INDEX qualifiche_ix_indirizzo_scolastico; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_ix_indirizzo_scolastico IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2348 (class 1259 OID 61351)
-- Name: qualifiche_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_ix_istituto ON qualifiche USING btree (istituto);


--
-- TOC entry 2750 (class 0 OID 0)
-- Dependencies: 2348
-- Name: INDEX qualifiche_ix_istituto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_ix_istituto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2349 (class 1259 OID 61352)
-- Name: qualifiche_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_ix_materia ON qualifiche USING btree (materia);


--
-- TOC entry 2751 (class 0 OID 0)
-- Dependencies: 2349
-- Name: INDEX qualifiche_ix_materia; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_ix_materia IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2350 (class 1259 OID 61353)
-- Name: qualifiche_ix_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX qualifiche_ix_metrica ON qualifiche USING btree (metrica);


--
-- TOC entry 2752 (class 0 OID 0)
-- Dependencies: 2350
-- Name: INDEX qualifiche_ix_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualifiche_ix_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2357 (class 1259 OID 61354)
-- Name: ritardi_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_ix_alunno ON ritardi USING btree (alunno);


--
-- TOC entry 2753 (class 0 OID 0)
-- Dependencies: 2357
-- Name: INDEX ritardi_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2358 (class 1259 OID 61355)
-- Name: ritardi_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_ix_classe ON ritardi USING btree (classe);


--
-- TOC entry 2754 (class 0 OID 0)
-- Dependencies: 2358
-- Name: INDEX ritardi_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2359 (class 1259 OID 61356)
-- Name: ritardi_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_ix_docente ON ritardi USING btree (docente);


--
-- TOC entry 2755 (class 0 OID 0)
-- Dependencies: 2359
-- Name: INDEX ritardi_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2360 (class 1259 OID 61357)
-- Name: ritardi_ix_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX ritardi_ix_giustificazione ON ritardi USING btree (giustificazione);


--
-- TOC entry 2756 (class 0 OID 0)
-- Dependencies: 2360
-- Name: INDEX ritardi_ix_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX ritardi_ix_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2363 (class 1259 OID 61358)
-- Name: scrutini_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_ix_istituto ON scrutini USING btree (anno_scolastico);


--
-- TOC entry 2370 (class 1259 OID 61359)
-- Name: scrutini_valutazioni_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_alunno ON scrutini_valutazioni USING btree (alunno);


--
-- TOC entry 2371 (class 1259 OID 61360)
-- Name: scrutini_valutazioni_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_classe ON scrutini_valutazioni USING btree (classe);


--
-- TOC entry 2372 (class 1259 OID 61361)
-- Name: scrutini_valutazioni_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_materia ON scrutini_valutazioni USING btree (materia);


--
-- TOC entry 2373 (class 1259 OID 61362)
-- Name: scrutini_valutazioni_ix_scrutinio; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_scrutinio ON scrutini_valutazioni USING btree (scrutinio);


--
-- TOC entry 2374 (class 1259 OID 61363)
-- Name: scrutini_valutazioni_ix_tipo_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_tipo_voto ON scrutini_valutazioni USING btree (tipo_voto);


--
-- TOC entry 2375 (class 1259 OID 61364)
-- Name: scrutini_valutazioni_ix_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_voto ON scrutini_valutazioni USING btree (voto);


--
-- TOC entry 2376 (class 1259 OID 61365)
-- Name: scrutini_valutazioni_ix_voto_proposto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_ix_voto_proposto ON scrutini_valutazioni USING btree (voto_proposto);


--
-- TOC entry 2379 (class 1259 OID 61366)
-- Name: scrutini_valutazioni_qualifiche_ix_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_ix_qualifica ON scrutini_valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 2757 (class 0 OID 0)
-- Dependencies: 2379
-- Name: INDEX scrutini_valutazioni_qualifiche_ix_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_ix_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2380 (class 1259 OID 61367)
-- Name: scrutini_valutazioni_qualifiche_ix_scrutinio_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_ix_scrutinio_valutazione ON scrutini_valutazioni_qualifiche USING btree (scrutinio_valutazione);


--
-- TOC entry 2758 (class 0 OID 0)
-- Dependencies: 2380
-- Name: INDEX scrutini_valutazioni_qualifiche_ix_scrutinio_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_ix_scrutinio_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2381 (class 1259 OID 61368)
-- Name: scrutini_valutazioni_qualifiche_ix_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_ix_voto ON scrutini_valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 2759 (class 0 OID 0)
-- Dependencies: 2381
-- Name: INDEX scrutini_valutazioni_qualifiche_ix_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_ix_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2382 (class 1259 OID 61369)
-- Name: scrutini_valutazioni_qualifiche_ix_voto_proposto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX scrutini_valutazioni_qualifiche_ix_voto_proposto ON scrutini_valutazioni_qualifiche USING btree (voto_proposto);


--
-- TOC entry 2760 (class 0 OID 0)
-- Dependencies: 2382
-- Name: INDEX scrutini_valutazioni_qualifiche_ix_voto_proposto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX scrutini_valutazioni_qualifiche_ix_voto_proposto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2393 (class 1259 OID 61370)
-- Name: tipi_voto_ix_materia; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX tipi_voto_ix_materia ON tipi_voto USING btree (materia);


--
-- TOC entry 2396 (class 1259 OID 61371)
-- Name: uscite_ix_alunno; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_ix_alunno ON uscite USING btree (alunno);


--
-- TOC entry 2761 (class 0 OID 0)
-- Dependencies: 2396
-- Name: INDEX uscite_ix_alunno; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_ix_alunno IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2397 (class 1259 OID 61372)
-- Name: uscite_ix_classe; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_ix_classe ON uscite USING btree (classe);


--
-- TOC entry 2762 (class 0 OID 0)
-- Dependencies: 2397
-- Name: INDEX uscite_ix_classe; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_ix_classe IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2398 (class 1259 OID 61373)
-- Name: uscite_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_ix_docente ON uscite USING btree (docente);


--
-- TOC entry 2763 (class 0 OID 0)
-- Dependencies: 2398
-- Name: INDEX uscite_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2399 (class 1259 OID 61374)
-- Name: uscite_ix_giustificazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX uscite_ix_giustificazione ON uscite USING btree (giustificazione);


--
-- TOC entry 2764 (class 0 OID 0)
-- Dependencies: 2399
-- Name: INDEX uscite_ix_giustificazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX uscite_ix_giustificazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2408 (class 1259 OID 61375)
-- Name: utenti_istituti_ix_istituto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX utenti_istituti_ix_istituto ON utenti_istituti USING btree (istituto);


--
-- TOC entry 2409 (class 1259 OID 61376)
-- Name: utenti_istituti_ix_utente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX utenti_istituti_ix_utente ON utenti_istituti USING btree (utente);


--
-- TOC entry 2415 (class 1259 OID 61377)
-- Name: valutazioni_ix_argomento; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_ix_argomento ON valutazioni USING btree (argomento);


--
-- TOC entry 2765 (class 0 OID 0)
-- Dependencies: 2415
-- Name: INDEX valutazioni_ix_argomento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_ix_argomento IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2416 (class 1259 OID 61378)
-- Name: valutazioni_ix_docente; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_ix_docente ON valutazioni USING btree (docente);


--
-- TOC entry 2766 (class 0 OID 0)
-- Dependencies: 2416
-- Name: INDEX valutazioni_ix_docente; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_ix_docente IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2417 (class 1259 OID 61379)
-- Name: valutazioni_ix_tipo_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_ix_tipo_voto ON valutazioni USING btree (tipo_voto);


--
-- TOC entry 2767 (class 0 OID 0)
-- Dependencies: 2417
-- Name: INDEX valutazioni_ix_tipo_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_ix_tipo_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2420 (class 1259 OID 61380)
-- Name: valutazioni_qualifiche_ix_qualifica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_ix_qualifica ON valutazioni_qualifiche USING btree (qualifica);


--
-- TOC entry 2768 (class 0 OID 0)
-- Dependencies: 2420
-- Name: INDEX valutazioni_qualifiche_ix_qualifica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_ix_qualifica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2421 (class 1259 OID 61381)
-- Name: valutazioni_qualifiche_ix_valutazione; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_ix_valutazione ON valutazioni_qualifiche USING btree (valutazione);


--
-- TOC entry 2769 (class 0 OID 0)
-- Dependencies: 2421
-- Name: INDEX valutazioni_qualifiche_ix_valutazione; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_ix_valutazione IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2422 (class 1259 OID 61382)
-- Name: valutazioni_qualifiche_ix_voto; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX valutazioni_qualifiche_ix_voto ON valutazioni_qualifiche USING btree (voto);


--
-- TOC entry 2770 (class 0 OID 0)
-- Dependencies: 2422
-- Name: INDEX valutazioni_qualifiche_ix_voto; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutazioni_qualifiche_ix_voto IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2427 (class 1259 OID 61383)
-- Name: voti_ix_metrica; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX voti_ix_metrica ON voti USING btree (metrica);


--
-- TOC entry 2771 (class 0 OID 0)
-- Dependencies: 2427
-- Name: INDEX voti_ix_metrica; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX voti_ix_metrica IS 'Indice per l''acceso dalla relativa chiave esterna';


--
-- TOC entry 2432 (class 2606 OID 61384)
-- Name: anni_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY anni_scolastici
    ADD CONSTRAINT anni_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2434 (class 2606 OID 105069)
-- Name: argomenti_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2433 (class 2606 OID 61394)
-- Name: argomenti_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY argomenti
    ADD CONSTRAINT argomenti_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2435 (class 2606 OID 61399)
-- Name: assenze_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2436 (class 2606 OID 61404)
-- Name: assenze_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2437 (class 2606 OID 61409)
-- Name: assenze_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2438 (class 2606 OID 61414)
-- Name: assenze_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY assenze
    ADD CONSTRAINT assenze_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2442 (class 2606 OID 61419)
-- Name: classi_alunni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2443 (class 2606 OID 61424)
-- Name: classi_alunni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi_alunni
    ADD CONSTRAINT classi_alunni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2439 (class 2606 OID 61429)
-- Name: classi_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2440 (class 2606 OID 61434)
-- Name: classi_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2441 (class 2606 OID 61439)
-- Name: classi_fk_plesso; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classi
    ADD CONSTRAINT classi_fk_plesso FOREIGN KEY (plesso) REFERENCES plessi(plesso) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2444 (class 2606 OID 61444)
-- Name: colloqui_fk_con; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_con FOREIGN KEY (con) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2445 (class 2606 OID 61449)
-- Name: colloqui_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY colloqui
    ADD CONSTRAINT colloqui_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2446 (class 2606 OID 61454)
-- Name: comuni_fk_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY comuni
    ADD CONSTRAINT comuni_fk_provincia FOREIGN KEY (provincia) REFERENCES provincie(provincia);


--
-- TOC entry 2447 (class 2606 OID 61459)
-- Name: conversazioni_fk_libretto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversazioni
    ADD CONSTRAINT conversazioni_fk_libretto FOREIGN KEY (libretto) REFERENCES libretti(libretto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2448 (class 2606 OID 61464)
-- Name: festivi_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY festivi
    ADD CONSTRAINT festivi_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2449 (class 2606 OID 61469)
-- Name: firme_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2450 (class 2606 OID 61474)
-- Name: firme_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY firme
    ADD CONSTRAINT firme_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2451 (class 2606 OID 61479)
-- Name: fuori_classe_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2452 (class 2606 OID 61484)
-- Name: fuori_classe_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2453 (class 2606 OID 61489)
-- Name: fuori_classe_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fuori_classi
    ADD CONSTRAINT fuori_classe_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2454 (class 2606 OID 61494)
-- Name: giustificazioni_fk_addetto_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_addetto_scolastico FOREIGN KEY (addetto_scolastico) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2455 (class 2606 OID 61499)
-- Name: giustificazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2456 (class 2606 OID 61504)
-- Name: giustificazioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2457 (class 2606 OID 61509)
-- Name: giustificazioni_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY giustificazioni
    ADD CONSTRAINT giustificazioni_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2459 (class 2606 OID 61514)
-- Name: gruppi_qualifiche_dettaglio_fk_gruppo_qualifiche; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruppi_qualifiche_dettaglio
    ADD CONSTRAINT gruppi_qualifiche_dettaglio_fk_gruppo_qualifiche FOREIGN KEY (gruppo_qualifiche) REFERENCES gruppi_qualifiche(gruppo_qualifiche) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2460 (class 2606 OID 61519)
-- Name: gruppi_qualifiche_dettaglio_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruppi_qualifiche_dettaglio
    ADD CONSTRAINT gruppi_qualifiche_dettaglio_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2458 (class 2606 OID 61524)
-- Name: gruppi_qualifiche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruppi_qualifiche
    ADD CONSTRAINT gruppi_qualifiche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2461 (class 2606 OID 61529)
-- Name: gruppi_utenti_fk_gruppo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruppi_utenti
    ADD CONSTRAINT gruppi_utenti_fk_gruppo FOREIGN KEY (gruppo) REFERENCES gruppi(gruppo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2462 (class 2606 OID 61534)
-- Name: gruppi_utenti_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gruppi_utenti
    ADD CONSTRAINT gruppi_utenti_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2463 (class 2606 OID 61539)
-- Name: indirizzi_fk_nazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY indirizzi
    ADD CONSTRAINT indirizzi_fk_nazione FOREIGN KEY (nazione) REFERENCES nazioni(nazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2464 (class 2606 OID 61544)
-- Name: indirizzi_scolastici_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY indirizzi_scolastici
    ADD CONSTRAINT indirizzi_scolastici_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2465 (class 2606 OID 61549)
-- Name: lezioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2466 (class 2606 OID 61554)
-- Name: lezioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2467 (class 2606 OID 61559)
-- Name: lezioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lezioni
    ADD CONSTRAINT lezioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2468 (class 2606 OID 61564)
-- Name: libretti_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY libretti
    ADD CONSTRAINT libretti_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2469 (class 2606 OID 61569)
-- Name: libretti_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY libretti
    ADD CONSTRAINT libretti_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2470 (class 2606 OID 61574)
-- Name: mancanze_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2471 (class 2606 OID 61579)
-- Name: mancanze_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2472 (class 2606 OID 61584)
-- Name: mancanze_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2473 (class 2606 OID 61589)
-- Name: mancanze_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mancanze
    ADD CONSTRAINT mancanze_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2474 (class 2606 OID 61594)
-- Name: materie_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2475 (class 2606 OID 61599)
-- Name: materie_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY materie
    ADD CONSTRAINT materie_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2476 (class 2606 OID 61604)
-- Name: messaggi_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2477 (class 2606 OID 61609)
-- Name: messaggi_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi
    ADD CONSTRAINT messaggi_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2478 (class 2606 OID 61614)
-- Name: messaggi_letti_fk_da; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_da FOREIGN KEY (da) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2479 (class 2606 OID 61619)
-- Name: messaggi_letti_fk_messaggio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messaggi_letti
    ADD CONSTRAINT messaggi_letti_fk_messaggio FOREIGN KEY (messaggio) REFERENCES messaggi(messaggio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2480 (class 2606 OID 61624)
-- Name: metriche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metriche
    ADD CONSTRAINT metriche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2481 (class 2606 OID 61629)
-- Name: mezzi_comunicazione_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2482 (class 2606 OID 61634)
-- Name: mezzi_comunicazione_fk_tipo_comunicazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mezzi_comunicazione
    ADD CONSTRAINT mezzi_comunicazione_fk_tipo_comunicazione FOREIGN KEY (tipo_comunicazione) REFERENCES tipi_comunicazione(tipo_comunicazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2487 (class 2606 OID 61639)
-- Name: note_docenti_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2488 (class 2606 OID 61644)
-- Name: note_docenti_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2489 (class 2606 OID 61649)
-- Name: note_docenti_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note_docenti
    ADD CONSTRAINT note_docenti_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2483 (class 2606 OID 61654)
-- Name: note_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2484 (class 2606 OID 61659)
-- Name: note_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2485 (class 2606 OID 61664)
-- Name: note_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2486 (class 2606 OID 61669)
-- Name: note_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY note
    ADD CONSTRAINT note_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2490 (class 2606 OID 61674)
-- Name: orari_settimanali_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2491 (class 2606 OID 61679)
-- Name: orari_settimanali_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2492 (class 2606 OID 61684)
-- Name: orari_settimanali_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY orari_settimanali
    ADD CONSTRAINT orari_settimanali_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2493 (class 2606 OID 61689)
-- Name: persone_fk_comune_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_comune_nascita FOREIGN KEY (comune_nascita) REFERENCES comuni(comune);


--
-- TOC entry 2494 (class 2606 OID 61694)
-- Name: persone_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2495 (class 2606 OID 61699)
-- Name: persone_fk_nazione_nascita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone
    ADD CONSTRAINT persone_fk_nazione_nascita FOREIGN KEY (nazione_nascita) REFERENCES nazioni(nazione);


--
-- TOC entry 2496 (class 2606 OID 61704)
-- Name: persone_indirizzi_fk_indirizzo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_indirizzo FOREIGN KEY (indirizzo) REFERENCES indirizzi(indirizzo);


--
-- TOC entry 2497 (class 2606 OID 61709)
-- Name: persone_indirizzi_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_indirizzi
    ADD CONSTRAINT persone_indirizzi_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona);


--
-- TOC entry 2498 (class 2606 OID 61714)
-- Name: persone_parenti_fk_parente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_parenti
    ADD CONSTRAINT persone_parenti_fk_parente FOREIGN KEY (parente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2499 (class 2606 OID 61719)
-- Name: persone_parenti_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persone_parenti
    ADD CONSTRAINT persone_parenti_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2500 (class 2606 OID 61724)
-- Name: plessi_fk_istituti; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY plessi
    ADD CONSTRAINT plessi_fk_istituti FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2501 (class 2606 OID 61729)
-- Name: provincie_fk_regione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY provincie
    ADD CONSTRAINT provincie_fk_regione FOREIGN KEY (regione) REFERENCES regioni(regione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2502 (class 2606 OID 61734)
-- Name: qualifiche_fk_indirizzo_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_indirizzo_scolastico FOREIGN KEY (indirizzo_scolastico) REFERENCES indirizzi_scolastici(indirizzo_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2503 (class 2606 OID 61739)
-- Name: qualifiche_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2504 (class 2606 OID 61744)
-- Name: qualifiche_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2505 (class 2606 OID 61749)
-- Name: qualifiche_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifiche
    ADD CONSTRAINT qualifiche_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2506 (class 2606 OID 61754)
-- Name: ritardi_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2507 (class 2606 OID 61759)
-- Name: ritardi_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2508 (class 2606 OID 61764)
-- Name: ritardi_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2509 (class 2606 OID 61769)
-- Name: ritardi_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ritardi
    ADD CONSTRAINT ritardi_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2510 (class 2606 OID 61774)
-- Name: scrutini_fk_anno_scolastico; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini
    ADD CONSTRAINT scrutini_fk_anno_scolastico FOREIGN KEY (anno_scolastico) REFERENCES anni_scolastici(anno_scolastico) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2511 (class 2606 OID 61779)
-- Name: scrutini_valutazioni_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2512 (class 2606 OID 61784)
-- Name: scrutini_valutazioni_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2513 (class 2606 OID 61789)
-- Name: scrutini_valutazioni_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2514 (class 2606 OID 61794)
-- Name: scrutini_valutazioni_fk_scrutinio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_scrutinio FOREIGN KEY (scrutinio) REFERENCES scrutini(scrutinio) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2515 (class 2606 OID 61799)
-- Name: scrutini_valutazioni_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2516 (class 2606 OID 61804)
-- Name: scrutini_valutazioni_fk_voto_proposto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni
    ADD CONSTRAINT scrutini_valutazioni_fk_voto_proposto FOREIGN KEY (voto_proposto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2517 (class 2606 OID 61809)
-- Name: scrutini_valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2518 (class 2606 OID 61814)
-- Name: scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_scrutinio_valutazione FOREIGN KEY (scrutinio_valutazione) REFERENCES scrutini_valutazioni(scrutinio_valutazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2519 (class 2606 OID 61819)
-- Name: scrutini_valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2520 (class 2606 OID 61824)
-- Name: scrutini_valutazioni_qualifiche_fk_voto_proposto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scrutini_valutazioni_qualifiche
    ADD CONSTRAINT scrutini_valutazioni_qualifiche_fk_voto_proposto FOREIGN KEY (voto_proposto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2521 (class 2606 OID 61829)
-- Name: tipi_voto_fk_materia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipi_voto
    ADD CONSTRAINT tipi_voto_fk_materia FOREIGN KEY (materia) REFERENCES materie(materia) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2522 (class 2606 OID 61834)
-- Name: uscite_fk_alunno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_alunno FOREIGN KEY (alunno) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2523 (class 2606 OID 61839)
-- Name: uscite_fk_classe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_classe FOREIGN KEY (classe) REFERENCES classi(classe) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2524 (class 2606 OID 61844)
-- Name: uscite_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2525 (class 2606 OID 61849)
-- Name: uscite_fk_giustificazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY uscite
    ADD CONSTRAINT uscite_fk_giustificazione FOREIGN KEY (giustificazione) REFERENCES giustificazioni(giustificazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2526 (class 2606 OID 61854)
-- Name: utenti_fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_fk_persona FOREIGN KEY (persona) REFERENCES persone(persona);


--
-- TOC entry 2527 (class 2606 OID 61859)
-- Name: utenti_istituti_fk_istituto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_fk_istituto FOREIGN KEY (istituto) REFERENCES istituti(istituto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2528 (class 2606 OID 61864)
-- Name: utenti_istituti_fk_utente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY utenti_istituti
    ADD CONSTRAINT utenti_istituti_fk_utente FOREIGN KEY (utente) REFERENCES utenti(utente) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2529 (class 2606 OID 61869)
-- Name: valutazioni_fk_argomento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_argomento FOREIGN KEY (argomento) REFERENCES argomenti(argomento) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2530 (class 2606 OID 61874)
-- Name: valutazioni_fk_conversazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_conversazione FOREIGN KEY (conversazione) REFERENCES conversazioni(conversazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2531 (class 2606 OID 61879)
-- Name: valutazioni_fk_docente; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_docente FOREIGN KEY (docente) REFERENCES persone(persona);


--
-- TOC entry 2532 (class 2606 OID 61884)
-- Name: valutazioni_fk_tipo_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni
    ADD CONSTRAINT valutazioni_fk_tipo_voto FOREIGN KEY (tipo_voto) REFERENCES tipi_voto(tipo_voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2533 (class 2606 OID 61889)
-- Name: valutazioni_qualifiche_fk_qualifica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_qualifica FOREIGN KEY (qualifica) REFERENCES qualifiche(qualifica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2534 (class 2606 OID 61894)
-- Name: valutazioni_qualifiche_fk_valutazione; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_valutazione FOREIGN KEY (valutazione) REFERENCES valutazioni(valutazione) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2535 (class 2606 OID 61899)
-- Name: valutazioni_qualifiche_fk_voto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutazioni_qualifiche
    ADD CONSTRAINT valutazioni_qualifiche_fk_voto FOREIGN KEY (voto) REFERENCES voti(voto) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2536 (class 2606 OID 61904)
-- Name: voti_fk_metrica; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY voti
    ADD CONSTRAINT voti_fk_metrica FOREIGN KEY (metrica) REFERENCES metriche(metrica) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2014-01-16 15:27:01

--
-- PostgreSQL database dump complete
--

