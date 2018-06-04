--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: diagnostic; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA diagnostic;


ALTER SCHEMA diagnostic OWNER TO postgres;

SET search_path = diagnostic, pg_catalog;

--
-- Name: error; Type: TYPE; Schema: diagnostic; Owner: postgres
--

CREATE TYPE error AS (
	returned_sqlstate text,
	message_text text,
	schema_name text,
	table_name text,
	column_name text,
	constraint_name text,
	pg_exception_context text,
	pg_exception_detail text,
	pg_exception_hint text,
	pg_datatype_name text
);


ALTER TYPE error OWNER TO postgres;

--
-- Name: TYPE error; Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON TYPE error IS '<diagnostic>';


--
-- Name: build_my_sqlcode(); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION build_my_sqlcode() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, utility, pg_temp
    AS $$
<<me>>
DECLARE
  result 			record;
  max_my_sqlcode		TEXT;
  ctr_code			utility.number_base34 =0;
  sql_prefix			TEXT;
  sql_code			TEXT;
  sql_suffix			TEXT;
  sql_nl			char = E'\n';
  context 			text;
  full_function_name		text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  sql_prefix = concat(sql_nl,
    '<<me>>',sql_nl,
    'DECLARE',sql_nl,
    '  context 		text;',sql_nl,
    '  full_function_name	text;',sql_nl,
    'BEGIN ',sql_nl,
    '--',sql_nl,
    '-- Recupero il nome della funzione',sql_nl,
    '--',sql_nl,
    '  GET DIAGNOSTICS me.context = PG_CONTEXT;',sql_nl,
    '  full_function_name = diagnostic.full_function_name(context);',sql_nl,
    '--',sql_nl,
    '-- questi codici sono stati generati da: diagnostic.build_my_sqlcode',sql_nl,
    '--',sql_nl);

  sql_suffix = concat(
    '--',sql_nl,
    '-- se la functionsignature non è stata gestita si imposta un errore generico',sql_nl,
    '--',sql_nl,
    '  RETURN ''UZZZ'' || _id;',sql_nl,
    'END;',sql_nl,
    sql_nl);
--
-- prendo il valore più alto assgnato ad una funzione e imposto il contatore
--
  SELECT (MAX(substring(my_sqlcode from 2 for 3)))
    INTO me.max_my_sqlcode
    FROM diagnostic.functions_list
   WHERE my_sqlcode <> 'UZZZ0';

  IF me.max_my_sqlcode IS NULL THEN
    ctr_code = '0';
  ELSE
    ctr_code = max_my_sqlcode;
  END IF;
--
-- I codici già assegnati non vengono toccati
--
  FOR result IN SELECT function_signature, my_sqlcode
                  FROM diagnostic.functions_list
                 WHERE my_sqlcode <> 'UZZZ0'
              ORDER BY my_sqlcode
  LOOP
    sql_code = concat(sql_code, format('  IF _function = %L THEN RETURN %L || _id; END IF;',result.function_signature, left(result.my_sqlcode,4)) ,sql_nl);
  END LOOP;
--
-- recupero i buchi
--
  IF me.max_my_sqlcode IS NULL THEN
  ELSE
    FOR result IN WITH my_sqlcode_available AS ( SELECT RIGHT('00' || utility.number_base34(generate_series(0::bigint, int8(me.max_my_sqlcode::utility.number_base34))),3) AS my_sqlcode),
                       my_sqlcode_existing  AS ( SELECT SUBSTRING(my_sqlcode FROM 2 FOR 3) AS my_sqlcode FROM diagnostic.functions_list WHERE my_sqlcode <> 'UZZZ0'),
                       my_sqlcode_to_reuse  AS ( SELECT a.my_sqlcode, row_number()
                                                   OVER (ORDER BY a.my_sqlcode ) as id
                                                   FROM my_sqlcode_available a
                                                   LEFT JOIN my_sqlcode_existing e ON e.my_sqlcode = a.my_sqlcode
                                                  WHERE e.my_sqlcode IS NULL),
                       my_sqlcode_new       AS ( SELECT function_signature, row_number()
                                                   OVER (ORDER BY function_signature ) AS id
                                                   FROM diagnostic.functions_list
                                                  WHERE my_sqlcode = 'UZZZ0')
                       SELECT n.function_signature, r.my_sqlcode
                         from my_sqlcode_to_reuse r
                         JOIN my_sqlcode_new n ON n.id = r.id
    LOOP
      sql_code = concat(sql_code, format('  IF _function = %L THEN RETURN %L || _id; END IF;', result.function_signature, 'U' || result.my_sqlcode), sql_nl);
    END LOOP;
   --
   -- aggiorno la funzione altrimenti i buchi appena recuperati non vengono inclusi nella prossima query
   -- e ripeto l'operazione di recuero dei codici già usati
   --
    UPDATE pg_catalog.pg_proc
       set prosrc = concat(sql_prefix, sql_code, sql_suffix)
     WHERE proname = 'my_sqlcode'
       AND pronamespace = 'diagnostic'::regnamespace::oid;

    sql_code = '';
    --
    -- I codici già assegnati non vengono toccati
    --
    FOR result IN SELECT function_signature, my_sqlcode
                    FROM diagnostic.functions_list
                   WHERE my_sqlcode <> 'UZZZ0'
                ORDER BY my_sqlcode
    LOOP
      sql_code = concat(sql_code, format('  IF _function = %L THEN RETURN %L || _id; END IF;',result.function_signature, left(result.my_sqlcode,4)) ,sql_nl);
    END LOOP;

  END IF;
--
-- Assegno i nuovi codici
--
  FOR result IN SELECT function_signature, my_sqlcode
                  FROM diagnostic.functions_list
                 WHERE my_sqlcode = 'UZZZ0'
              ORDER BY function_signature
  LOOP
    sql_code = concat(sql_code, format('  IF _function = %L THEN RETURN %L || _id; END IF;',result.function_signature, 'U' || RIGHT('00' || ctr_code,3)), sql_nl);
    ctr_code = ctr_code + 1;
  END LOOP;
 --
 -- aggiorno il codice della funzione
 --
 RAISE INFO '%', concat(sql_prefix, sql_code, sql_suffix);

   UPDATE pg_catalog.pg_proc
      set prosrc = concat(sql_prefix, sql_code, sql_suffix)
    WHERE proname = 'my_sqlcode'
      AND pronamespace = 'diagnostic'::regnamespace::oid;

  RETURN;
END;
$$;


ALTER FUNCTION diagnostic.build_my_sqlcode() OWNER TO postgres;

--
-- Name: full_function_name(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION full_function_name(_context text, OUT _function_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  -- >>>>> the full_function_name is the only function that cannot call full_function_name  :) >>>>>
  -- >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
BEGIN
  _function_name = (regexp_matches(_context, 'funzione PL\/pgSQL (.*?\))'))[1];
  IF _function_name IS NULL THEN -- tento in inglese
      _function_name = (regexp_matches(_context, 'PL\/pgSQL function (.*?\))'))[1];
  END IF;
  IF _function_name IS NULL THEN
  ELSE
    IF position('.' IN _function_name) = 0 THEN
      _function_name = 'public.' || _function_name;
    END IF;
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.full_function_name(_context text, OUT _function_name text) OWNER TO postgres;

--
-- Name: FUNCTION full_function_name(_context text, OUT _function_name text); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION full_function_name(_context text, OUT _function_name text) IS '<diagnostic>
The function return the current function name with his signature, this is dependent from the language choose from client, so you have to customize the function for language other than italian.
You can also change the code to manage multiple languade (please send me back your code)
The tipcal usage is:
$BODY$
<<me>>
DECLARE
  context text;
BEGIN
  get diagnostics me.context = pg_context;
  RETURN utility.full_function_name(me.context);
END
$BODY$
I would prefer something like:
me.full_function_name = function_name();
But you have to manage the different ways you function will called (from another function, from pgadmin)';


--
-- Name: function_exists(regprocedure); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_exists(_function_signature regprocedure, OUT _found boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  PERFORM 1 FROM diagnostic.functions_list WHERE function_signature = _function_signature::text;
  _found = FOUND;
END
$$;


ALTER FUNCTION diagnostic.function_exists(_function_signature regprocedure, OUT _found boolean) OWNER TO postgres;

--
-- Name: FUNCTION function_exists(_function_signature regprocedure, OUT _found boolean); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION function_exists(_function_signature regprocedure, OUT _found boolean) IS '<diagnostic>';


--
-- Name: function_name(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_name(_context text, OUT _function_name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _function_name = (regexp_matches(_context, 'funzione PL\/pgSQL (.*?)\('))[1];
  IF _function_name IS NULL THEN -- tento in inglese
      _function_name = (regexp_matches(_context, 'PL\/pgSQL function (.*?)\('))[1];
  END IF;
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.function_name(_context text, OUT _function_name text) OWNER TO postgres;

--
-- Name: FUNCTION function_name(_context text, OUT _function_name text); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION function_name(_context text, OUT _function_name text) IS '<diagnostic>
The function return the current function name, this is dependent from the language choose from client, so you have to customize the function for language other than italian.
You can also change the code to manage multiple languade (please send me back your code)
The tipcal usage is:
$BODY$
<<me>>
DECLARE
  context text;
BEGIN
  get diagnostics me.context = pg_context;
  RETURN utility.function_name(me.context);
END
$BODY$
I would prefer something like:
me.function_name = function_name();
But you have to manage the different ways you function will called (from another function, from pgadmin)';


--
-- Name: function_syntax_error(text, text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION function_syntax_error(_function_name text, _message_text text) RETURNS void
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  function_signature_ex  text;
  function_description   text;
  context 		 text;
  full_function_name	 text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  SELECT p.proname || '(' || pg_get_function_arguments(oid) || ')', obj_description(oid,'pg_proc') INTO function_signature_ex, function_description FROM pg_proc p WHERE oid = _function_name::regprocedure::oid;
  IF function_description IS NULL THEN
    function_description = 'N/A';
  ELSE
    RAISE invalid_parameter_value USING
      MESSAGE = 'FUNCTION SYNTAX: ' || _message_text,
      DETAIL = 'FUNCTION SYNTAX: ' || function_signature_ex,
      HINT = 'Check the parameters and rerun the command, FUNCTION DESCRIPTION: ' || function_description;
  END IF;
END
$$;


ALTER FUNCTION diagnostic.function_syntax_error(_function_name text, _message_text text) OWNER TO postgres;

--
-- Name: FUNCTION function_syntax_error(_function_name text, _message_text text); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION function_syntax_error(_function_name text, _message_text text) IS '<diagnostic>';


--
-- Name: if_function_compile(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION if_function_compile(_functionid text, OUT _compile boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  PERFORM 1 FROM diagnostic.functions_check WHERE functionid::text = _functionid AND level = 'error';
  IF FOUND THEN
    _compile = FALSE;
  ELSE
    _compile =  TRUE;
  END IF;
END;
$$;


ALTER FUNCTION diagnostic.if_function_compile(_functionid text, OUT _compile boolean) OWNER TO postgres;

--
-- Name: FUNCTION if_function_compile(_functionid text, OUT _compile boolean); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION if_function_compile(_functionid text, OUT _compile boolean) IS '<diagnostic>';


--
-- Name: if_view_works(text); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION if_view_works(_view_name text, OUT _works boolean) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  sql_command		text;
  error			diagnostic.error;
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _works = TRUE;
  BEGIN
    sql_command := 'SELECT * FROM ' || _view_name || ' WHERE FALSE;';
    EXECUTE sql_command;
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    _works = FALSE;
    PERFORM diagnostic.show(error);
  END;
RETURN;
END;
$$;


ALTER FUNCTION diagnostic.if_view_works(_view_name text, OUT _works boolean) OWNER TO postgres;

--
-- Name: FUNCTION if_view_works(_view_name text, OUT _works boolean); Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON FUNCTION if_view_works(_view_name text, OUT _works boolean) IS '<diagnostic>';


--
-- Name: my_sqlcode(character varying, character); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION my_sqlcode(_function character varying, _id character) RETURNS character
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- questi codici sono stati generati da: diagnostic.build_my_sqlcode
--
  IF _function = 'assert.are_equals(text,text,anyarray)' THEN RETURN 'U000' || _id; END IF;
  IF _function = 'assert.are_not_equals(text,text,anyarray)' THEN RETURN 'U001' || _id; END IF;
  IF _function = 'assert.fail(text,text,text,diagnostic.error)' THEN RETURN 'U002' || _id; END IF;
  IF _function = 'assert.is_false(text,text,boolean)' THEN RETURN 'U003' || _id; END IF;
  IF _function = 'assert.is_greater_than(text,text,anyelement,anyelement)' THEN RETURN 'U004' || _id; END IF;
  IF _function = 'assert.is_less_than(text,text,anyelement,anyelement)' THEN RETURN 'U005' || _id; END IF;
  IF _function = 'assert.is_not_null(text,text,anyelement)' THEN RETURN 'U006' || _id; END IF;
  IF _function = 'assert.is_null(text,text,anyelement)' THEN RETURN 'U007' || _id; END IF;
  IF _function = 'assert.is_true(text,text,boolean)' THEN RETURN 'U008' || _id; END IF;
  IF _function = 'assert.pass(text,text,text)' THEN RETURN 'U009' || _id; END IF;
  IF _function = 'assert.sqlstate_equals(text,text,diagnostic.error,text[])' THEN RETURN 'U00A' || _id; END IF;
  IF _function = 'count_value(text,text,text)' THEN RETURN 'U00B' || _id; END IF;
  IF _function = 'day_name(utility.week_day)' THEN RETURN 'U00C' || _id; END IF;
  IF _function = 'diagnostic.build_my_sqlcode()' THEN RETURN 'U00D' || _id; END IF;
  IF _function = 'diagnostic.full_function_name(text)' THEN RETURN 'U00E' || _id; END IF;
  IF _function = 'diagnostic.function_exists(regprocedure)' THEN RETURN 'U00F' || _id; END IF;
  IF _function = 'diagnostic.function_name(text)' THEN RETURN 'U00G' || _id; END IF;
  IF _function = 'diagnostic.function_syntax_error(text,text)' THEN RETURN 'U00H' || _id; END IF;
  IF _function = 'diagnostic.if_function_compile(text)' THEN RETURN 'U00J' || _id; END IF;
  IF _function = 'diagnostic.if_view_works(text)' THEN RETURN 'U00K' || _id; END IF;
  IF _function = 'diagnostic.my_sqlcode(character varying,character)' THEN RETURN 'U00L' || _id; END IF;
  IF _function = 'diagnostic.show(diagnostic.error)' THEN RETURN 'U00M' || _id; END IF;
  IF _function = 'diagnostic.show(text[])' THEN RETURN 'U00N' || _id; END IF;
  IF _function = 'diagnostic.test_full_function_name()' THEN RETURN 'U00P' || _id; END IF;
  IF _function = 'diagnostic.test_function_name()' THEN RETURN 'U00Q' || _id; END IF;
  IF _function = 'entity2char(text)' THEN RETURN 'U00R' || _id; END IF;
  IF _function = 'entity_coding()' THEN RETURN 'U00S' || _id; END IF;
  IF _function = 'enum2array(anyenum)' THEN RETURN 'U00T' || _id; END IF;
  IF _function = 'fol()' THEN RETURN 'U00U' || _id; END IF;
  IF _function = 'get_max_column_value(text,text,text)' THEN RETURN 'U00V' || _id; END IF;
  IF _function = 'grant_all2(text)' THEN RETURN 'U00W' || _id; END IF;
  IF _function = 'int8(number_base34)' THEN RETURN 'U00X' || _id; END IF;
  IF _function = 'it.albero_qualifiche()' THEN RETURN 'U00Y' || _id; END IF;
  IF _function = 'it.anni_scolastici_abilitati()' THEN RETURN 'U00Z' || _id; END IF;
  IF _function = 'it.argomenti_del(bigint,bigint)' THEN RETURN 'U010' || _id; END IF;
  IF _function = 'it.argomenti_ins_rid(bigint,character varying,bigint)' THEN RETURN 'U011' || _id; END IF;
  IF _function = 'it.argomenti_upd_rid(bigint,bigint,character varying)' THEN RETURN 'U012' || _id; END IF;
  IF _function = 'it.classi_abilitate()' THEN RETURN 'U013' || _id; END IF;
  IF _function = 'it.codice_fiscale_italiano(character varying,character varying,sex,date,smallint,character varying)' THEN RETURN 'U014' || _id; END IF;
  IF _function = 'it.consulta_scuole(bigint)' THEN RETURN 'U015' || _id; END IF;
  IF _function = 'it.consulta_scuole(integer)' THEN RETURN 'U016' || _id; END IF;
  IF _function = 'it.dove_sequenza(text,bigint)' THEN RETURN 'U017' || _id; END IF;
  IF _function = 'it.estensione_file(mime_type)' THEN RETURN 'U018' || _id; END IF;
  IF _function = 'it.foto_default()' THEN RETURN 'U019' || _id; END IF;
  IF _function = 'it.foto_miniatura_demancanza()' THEN RETURN 'U01A' || _id; END IF;
  IF _function = 'it.griglia_valutazioni_righe_by_classe_docente_materia(bigint,bigint,bigint)' THEN RETURN 'U01B' || _id; END IF;
  IF _function = 'it.imposta_work_space_default(bigint)' THEN RETURN 'U01C' || _id; END IF;
  IF _function = 'it.in_qualsiasi_ruolo(bigint,role[])' THEN RETURN 'U01D' || _id; END IF;
  IF _function = 'it.in_qualsiasi_ruolo(character varying,role[])' THEN RETURN 'U01E' || _id; END IF;
  IF _function = 'it.in_qualsiasi_ruolo(role[])' THEN RETURN 'U01F' || _id; END IF;
  IF _function = 'it.istituti_del(bigint,bigint)' THEN RETURN 'U01G' || _id; END IF;
  IF _function = 'it.istituti_del_cascade(bigint)' THEN RETURN 'U01H' || _id; END IF;
  IF _function = 'it.istituti_ins(character varying,character varying,character varying,boolean,bytea)' THEN RETURN 'U01J' || _id; END IF;
  IF _function = 'it.istituti_sel(bigint)' THEN RETURN 'U01K' || _id; END IF;
  IF _function = 'it.istituti_upd(bigint,bigint,character varying,character varying,character varying,boolean,bytea)' THEN RETURN 'U01L' || _id; END IF;
  IF _function = 'it.istituti_upd_logo(bigint,bigint,bytea)' THEN RETURN 'U01M' || _id; END IF;
  IF _function = 'it.materie_del(bigint,bigint)' THEN RETURN 'U01N' || _id; END IF;
  IF _function = 'it.materie_ins(bigint,character varying)' THEN RETURN 'U01P' || _id; END IF;
  IF _function = 'it.materie_ins(bigint,character varying,bigint)' THEN RETURN 'U01Q' || _id; END IF;
  IF _function = 'it.materie_sel(bigint)' THEN RETURN 'U01R' || _id; END IF;
  IF _function = 'it.materie_upd(bigint,bigint,bigint,character varying,bigint)' THEN RETURN 'U01S' || _id; END IF;
  IF _function = 'it.orario_settimanale_xt_docente(bigint)' THEN RETURN 'U01T' || _id; END IF;
  IF _function = 'it.orario_settimanale_xt_materia(bigint)' THEN RETURN 'U01U' || _id; END IF;
  IF _function = 'it.personae_cognome_nome(bigint)' THEN RETURN 'U01V' || _id; END IF;
  IF _function = 'it.persone_sel_foto_miniatura(bigint)' THEN RETURN 'U01W' || _id; END IF;
  IF _function = 'it.scuole_attive()' THEN RETURN 'U01X' || _id; END IF;
  IF _function = 'it.scuole_ins(character varying,character varying,character varying,boolean)' THEN RETURN 'U01Y' || _id; END IF;
  IF _function = 'it.scuole_upd(bigint,bigint,character varying,character varying,character varying,boolean)' THEN RETURN 'U01Z' || _id; END IF;
  IF _function = 'it.sel_logo_scuole(bigint)' THEN RETURN 'U020' || _id; END IF;
  IF _function = 'it.sessione_persona(bigint)' THEN RETURN 'U021' || _id; END IF;
  IF _function = 'it.sessione_utente()' THEN RETURN 'U022' || _id; END IF;
  IF _function = 'it.statistiche()' THEN RETURN 'U023' || _id; END IF;
  IF _function = 'it.tipo_mime(file_extension)' THEN RETURN 'U024' || _id; END IF;
  IF _function = 'it.update_persona_foto_and_foto_miniatura()' THEN RETURN 'U025' || _id; END IF;
  IF _function = 'it.valutazioni_del(bigint,bigint)' THEN RETURN 'U026' || _id; END IF;
  IF _function = 'it.valutazioni_ins(bigint,bigint,bigint,bigint,bigint,bigint,character varying,boolean,bigint,date)' THEN RETURN 'U027' || _id; END IF;
  IF _function = 'it.valutazioni_ins_nota(bigint)' THEN RETURN 'U028' || _id; END IF;
  IF _function = 'it.valutazioni_sel(bigint)' THEN RETURN 'U029' || _id; END IF;
  IF _function = 'it.valutazioni_upd(bigint,bigint,character varying,boolean,boolean)' THEN RETURN 'U02A' || _id; END IF;
  IF _function = 'it.valutazioni_upd_voto(bigint,bigint,bigint)' THEN RETURN 'U02B' || _id; END IF;
  IF _function = 'it.w_classi_alunni_ex()' THEN RETURN 'U02C' || _id; END IF;
  IF _function = 'it.w_classi_docenti_materie_ex()' THEN RETURN 'U02D' || _id; END IF;
  IF _function = 'it.w_classi_ex()' THEN RETURN 'U02E' || _id; END IF;
  IF _function = 'it.wikimedia_0_resetta()' THEN RETURN 'U02F' || _id; END IF;
  IF _function = 'it.wikimedia_1_ricrea_files_persone_wikimedia()' THEN RETURN 'U02G' || _id; END IF;
  IF _function = 'it.wikimedia_2_idratazione_files_wikimedia(integer)' THEN RETURN 'U02H' || _id; END IF;
  IF _function = 'it.wikimedia_3_popolazione_files_wikimedia()' THEN RETURN 'U02J' || _id; END IF;
  IF _function = 'it.wikimedia_4_idratazione_persone()' THEN RETURN 'U02K' || _id; END IF;
  IF _function = 'it.wikimedia_5_popolazione_persone_files()' THEN RETURN 'U02L' || _id; END IF;
  IF _function = 'it.w_orario_settimanale_ex()' THEN RETURN 'U02M' || _id; END IF;
  IF _function = 'it.w_orari_settimanali_giorni_ex()' THEN RETURN 'U02N' || _id; END IF;
  IF _function = 'number_base34(bigint)' THEN RETURN 'U02P' || _id; END IF;
  IF _function = 'number_base34_pl(number_base34,integer)' THEN RETURN 'U02Q' || _id; END IF;
  IF _function = 'public.classrooms_enabled()' THEN RETURN 'U02R' || _id; END IF;
  IF _function = 'public.classrooms_list(bigint)' THEN RETURN 'U02S' || _id; END IF;
  IF _function = 'public.classrooms_students_addresses_ex_by_classroom(bigint)' THEN RETURN 'U02T' || _id; END IF;
  IF _function = 'public.classroom_students_ex(bigint)' THEN RETURN 'U02U' || _id; END IF;
  IF _function = 'public.file_extension(mime_type)' THEN RETURN 'U02V' || _id; END IF;
  IF _function = 'public.grades_by_metric(bigint)' THEN RETURN 'U02W' || _id; END IF;
  IF _function = 'public.grade_types_by_subject(bigint)' THEN RETURN 'U02X' || _id; END IF;
  IF _function = 'public.grid_valutations_columns_by_classroom_teacher_subject(bigint,bigint,bigint)' THEN RETURN 'U02Y' || _id; END IF;
  IF _function = 'public.grid_valutations_rows_by_classroom_teacher_subject(bigint,bigint,bigint)' THEN RETURN 'U02Z' || _id; END IF;
  IF _function = 'public.in_any_roles(bigint,role[])' THEN RETURN 'U030' || _id; END IF;
  IF _function = 'public.in_any_roles(character varying,role[])' THEN RETURN 'U031' || _id; END IF;
  IF _function = 'public.in_any_roles(role[])' THEN RETURN 'U032' || _id; END IF;
  IF _function = 'public.italian_fiscal_code(character varying,character varying,sex,date,smallint,character varying)' THEN RETURN 'U033' || _id; END IF;
  IF _function = 'public.lessons_by_teacher_classroom_subject(bigint,bigint,bigint)' THEN RETURN 'U034' || _id; END IF;
  IF _function = 'public.metrics_by_school(bigint)' THEN RETURN 'U035' || _id; END IF;
  IF _function = 'public.mime_type(file_extension)' THEN RETURN 'U036' || _id; END IF;
  IF _function = 'public.persons_sel_thumbnail(bigint)' THEN RETURN 'U037' || _id; END IF;
  IF _function = 'public.persons_surname_name(bigint)' THEN RETURN 'U038' || _id; END IF;
  IF _function = 'public.photo_default()' THEN RETURN 'U039' || _id; END IF;
  IF _function = 'public.qualifications_tree()' THEN RETURN 'U03A' || _id; END IF;
  IF _function = 'public.relatives_by_classroom(bigint)' THEN RETURN 'U03B' || _id; END IF;
  IF _function = 'public.rs_columns_list()' THEN RETURN 'U03C' || _id; END IF;
  IF _function = 'public.rs_rows_list()' THEN RETURN 'U03D' || _id; END IF;
  IF _function = 'public.ruoli_by_session_user()' THEN RETURN 'U03E' || _id; END IF;
  IF _function = 'public.schools_by_description(character varying)' THEN RETURN 'U03F' || _id; END IF;
  IF _function = 'public.schools_del(bigint,bigint)' THEN RETURN 'U03G' || _id; END IF;
  IF _function = 'public.schools_del_cascade(bigint)' THEN RETURN 'U03H' || _id; END IF;
  IF _function = 'public.schools_enabled()' THEN RETURN 'U03J' || _id; END IF;
  IF _function = 'public.schools_ins(character varying,character varying,character varying,boolean)' THEN RETURN 'U03K' || _id; END IF;
  IF _function = 'public.schools_ins(character varying,character varying,character varying,boolean,bytea)' THEN RETURN 'U03L' || _id; END IF;
  IF _function = 'public.schools_list()' THEN RETURN 'U03M' || _id; END IF;
  IF _function = 'public.schools_lookup(bigint)' THEN RETURN 'U03N' || _id; END IF;
  IF _function = 'public.schools_lookup(integer)' THEN RETURN 'U03P' || _id; END IF;
  IF _function = 'public.schools_sel(bigint)' THEN RETURN 'U03Q' || _id; END IF;
  IF _function = 'public.schools_sel_logo(bigint)' THEN RETURN 'U03R' || _id; END IF;
  IF _function = 'public.schools_upd(bigint,bigint,character varying,character varying,character varying,boolean)' THEN RETURN 'U03S' || _id; END IF;
  IF _function = 'public.schools_upd(bigint,bigint,character varying,character varying,character varying,boolean,bytea)' THEN RETURN 'U03T' || _id; END IF;
  IF _function = 'public.schools_upd_logo(bigint,bigint,bytea)' THEN RETURN 'U03U' || _id; END IF;
  IF _function = 'public.school_years_enabled()' THEN RETURN 'U03V' || _id; END IF;
  IF _function = 'public.school_years_list(bigint)' THEN RETURN 'U03W' || _id; END IF;
  IF _function = 'public.session_db_user()' THEN RETURN 'U03X' || _id; END IF;
  IF _function = 'public.session_person(bigint)' THEN RETURN 'U03Y' || _id; END IF;
  IF _function = 'public.set_work_space_default(bigint)' THEN RETURN 'U03Z' || _id; END IF;
  IF _function = 'public.signatures_by_teacher_classroom(bigint,bigint)' THEN RETURN 'U040' || _id; END IF;
  IF _function = 'public.statistics()' THEN RETURN 'U041' || _id; END IF;
  IF _function = 'public.students_by_classroom(bigint)' THEN RETURN 'U042' || _id; END IF;
  IF _function = 'public.subjects_del(bigint,bigint)' THEN RETURN 'U043' || _id; END IF;
  IF _function = 'public.subjects_ins(bigint,character varying)' THEN RETURN 'U044' || _id; END IF;
  IF _function = 'public.subjects_ins(bigint,character varying,bigint)' THEN RETURN 'U045' || _id; END IF;
  IF _function = 'public.subjects_list(bigint)' THEN RETURN 'U046' || _id; END IF;
  IF _function = 'public.subjects_sel(bigint)' THEN RETURN 'U047' || _id; END IF;
  IF _function = 'public.subjects_upd(bigint,bigint,bigint,character varying,bigint)' THEN RETURN 'U048' || _id; END IF;
  IF _function = 'public.teachers_by_school(bigint)' THEN RETURN 'U049' || _id; END IF;
  IF _function = 'public.thumbnail_default()' THEN RETURN 'U04A' || _id; END IF;
  IF _function = 'public.topics_by_subject_classroom(bigint,bigint)' THEN RETURN 'U04B' || _id; END IF;
  IF _function = 'public.topics_del(bigint,bigint)' THEN RETURN 'U04C' || _id; END IF;
  IF _function = 'public.topics_ins_rid(bigint,character varying,bigint)' THEN RETURN 'U04D' || _id; END IF;
  IF _function = 'public.topics_upd_rid(bigint,bigint,character varying)' THEN RETURN 'U04E' || _id; END IF;
  IF _function = 'public.tr_absences_iu()' THEN RETURN 'U04F' || _id; END IF;
  IF _function = 'public.tr_classrooms_iu()' THEN RETURN 'U04G' || _id; END IF;
  IF _function = 'public.tr_classrooms_students_iu()' THEN RETURN 'U04H' || _id; END IF;
  IF _function = 'public.tr_communications_media_iu()' THEN RETURN 'U04J' || _id; END IF;
  IF _function = 'public.tr_conversations_invites_iu()' THEN RETURN 'U04K' || _id; END IF;
  IF _function = 'public.tr_delays_iu()' THEN RETURN 'U04L' || _id; END IF;
  IF _function = 'public.tr_explanations_iu()' THEN RETURN 'U04M' || _id; END IF;
  IF _function = 'public.tr_faults_iu()' THEN RETURN 'U04N' || _id; END IF;
  IF _function = 'public.tr_grading_meetings_iu()' THEN RETURN 'U04P' || _id; END IF;
  IF _function = 'public.tr_grading_meetings_valutations_d()' THEN RETURN 'U04Q' || _id; END IF;
  IF _function = 'public.tr_grading_meetings_valutations_iu()' THEN RETURN 'U04R' || _id; END IF;
  IF _function = 'public.tr_grading_meetings_valutations_qua_d()' THEN RETURN 'U04S' || _id; END IF;
  IF _function = 'public.tr_grading_meetings_valutations_qua_iu()' THEN RETURN 'U04T' || _id; END IF;
  IF _function = 'public.tr_leavings_iu()' THEN RETURN 'U04U' || _id; END IF;
  IF _function = 'public.tr_lessons_iu()' THEN RETURN 'U04V' || _id; END IF;
  IF _function = 'public.tr_messages_iu()' THEN RETURN 'U04W' || _id; END IF;
  IF _function = 'public.tr_messages_read_iu()' THEN RETURN 'U04X' || _id; END IF;
  IF _function = 'public.tr_notes_iu()' THEN RETURN 'U04Y' || _id; END IF;
  IF _function = 'public.tr_notes_signed_iu()' THEN RETURN 'U04Z' || _id; END IF;
  IF _function = 'public.tr_out_of_classrooms_iu()' THEN RETURN 'U050' || _id; END IF;
  IF _function = 'public.tr_parents_meetings_iu()' THEN RETURN 'U051' || _id; END IF;
  IF _function = 'public.tr_schools_iu()' THEN RETURN 'U052' || _id; END IF;
  IF _function = 'public.tr_signatures_iu()' THEN RETURN 'U053' || _id; END IF;
  IF _function = 'public.tr_teachears_notes_iu()' THEN RETURN 'U054' || _id; END IF;
  IF _function = 'public.tr_topics_iu()' THEN RETURN 'U055' || _id; END IF;
  IF _function = 'public.tr_usename_iu()' THEN RETURN 'U056' || _id; END IF;
  IF _function = 'public.tr_valutations_iu()' THEN RETURN 'U057' || _id; END IF;
  IF _function = 'public.tr_valutations_qualifications_iu()' THEN RETURN 'U058' || _id; END IF;
  IF _function = 'public.tr_weekly_timetables_days_iu()' THEN RETURN 'U059' || _id; END IF;
  IF _function = 'public.update_person_photo_and_thumbnail()' THEN RETURN 'U05A' || _id; END IF;
  IF _function = 'public.valutations_del(bigint,bigint)' THEN RETURN 'U05B' || _id; END IF;
  IF _function = 'public.valutations_ex_by_classroom_teacher_subject(bigint,bigint,bigint)' THEN RETURN 'U05C' || _id; END IF;
  IF _function = 'public.valutations_ins(bigint,bigint,bigint,bigint,bigint,bigint,character varying,boolean,bigint,date)' THEN RETURN 'U05D' || _id; END IF;
  IF _function = 'public.valutations_ins_note(bigint)' THEN RETURN 'U05E' || _id; END IF;
  IF _function = 'public.valutations_sel(bigint)' THEN RETURN 'U05F' || _id; END IF;
  IF _function = 'public.valutations_upd(bigint,bigint,character varying,boolean,boolean)' THEN RETURN 'U05G' || _id; END IF;
  IF _function = 'public.valutations_upd_grade(bigint,bigint,bigint)' THEN RETURN 'U05H' || _id; END IF;
  IF _function = 'public.w_classrooms_ex()' THEN RETURN 'U05J' || _id; END IF;
  IF _function = 'public.w_classrooms_students_ex()' THEN RETURN 'U05K' || _id; END IF;
  IF _function = 'public.w_classrooms_teachers_subjects_ex()' THEN RETURN 'U05L' || _id; END IF;
  IF _function = 'public.weekly_timetable_xt_subject(bigint)' THEN RETURN 'U05M' || _id; END IF;
  IF _function = 'public.weekly_timetable_xt_teacher(bigint)' THEN RETURN 'U05N' || _id; END IF;
  IF _function = 'public.where_sequence(text,bigint)' THEN RETURN 'U05P' || _id; END IF;
  IF _function = 'public.wikimedia_0_reset()' THEN RETURN 'U05Q' || _id; END IF;
  IF _function = 'public.wikimedia_1_recreate_wikimedia_files_persons()' THEN RETURN 'U05R' || _id; END IF;
  IF _function = 'public.wikimedia_2_wikimedia_files_hydration(integer)' THEN RETURN 'U05S' || _id; END IF;
  IF _function = 'public.wikimedia_3_wikimedia_files_popolate_files()' THEN RETURN 'U05T' || _id; END IF;
  IF _function = 'public.wikimedia_4_persons_hydration()' THEN RETURN 'U05U' || _id; END IF;
  IF _function = 'public.wikimedia_5_persons_popolate_files()' THEN RETURN 'U05V' || _id; END IF;
  IF _function = 'public.w_weekly_timetable_ex()' THEN RETURN 'U05W' || _id; END IF;
  IF _function = 'public.w_weekly_timetables_days_ex()' THEN RETURN 'U05X' || _id; END IF;
  IF _function = 'set_all_sequences_2_the_max()' THEN RETURN 'U05Y' || _id; END IF;
  IF _function = 'set_sequence_2_the_max(text,text)' THEN RETURN 'U05Z' || _id; END IF;
  IF _function = 'strip_tags(text)' THEN RETURN 'U060' || _id; END IF;
  IF _function = 'system_messages_locale_old(system_message[],integer)' THEN RETURN 'U061' || _id; END IF;
  IF _function = 'system_messages_locale(system_message[],integer)' THEN RETURN 'U062' || _id; END IF;
  IF _function = 'translate.synch()' THEN RETURN 'U063' || _id; END IF;
  IF _function = 'translate.translation()' THEN RETURN 'U064' || _id; END IF;
  IF _function = 'tr_usenames_ex_iu()' THEN RETURN 'U065' || _id; END IF;
  IF _function = 'unit_testing.build_function_dependencies(text,text[])' THEN RETURN 'U066' || _id; END IF;
  IF _function = 'unit_testing.count_unit_tests()' THEN RETURN 'U067' || _id; END IF;
  IF _function = 'unit_testing.count_unit_tests_level()' THEN RETURN 'U068' || _id; END IF;
  IF _function = 'unit_testing.export_table(text,text)' THEN RETURN 'U069' || _id; END IF;
  IF _function = 'unit_testing.function_versions_synch()' THEN RETURN 'U06A' || _id; END IF;
  IF _function = 'unit_testing.run_ex(boolean,boolean,boolean,bigint,oid,text,text)' THEN RETURN 'U06B' || _id; END IF;
  IF _function = 'unit_testing.run_ex(text,boolean,boolean,boolean,bigint,oid,text)' THEN RETURN 'U06C' || _id; END IF;
  IF _function = 'unit_testing.run(text,boolean,boolean,boolean,bigint,oid,text)' THEN RETURN 'U06D' || _id; END IF;
  IF _function = 'unit_testing.set_continuous_integration(boolean)' THEN RETURN 'U06E' || _id; END IF;
  IF _function = 'unit_testing.show_test_errors(bigint)' THEN RETURN 'U06F' || _id; END IF;
  IF _function = 'unit_testing.show(unit_testing.check_point)' THEN RETURN 'U06G' || _id; END IF;
  IF _function = 'unit_testing.tr_continuous_integration()' THEN RETURN 'U06H' || _id; END IF;
  IF _function = 'unit_testing.tr_dependencies_iu()' THEN RETURN 'U06J' || _id; END IF;
  IF _function = 'unit_testing.tr_function_versions_iu()' THEN RETURN 'U06K' || _id; END IF;
  IF _function = 'unit_testing.tr_unit_test_sets_details_iu()' THEN RETURN 'U06L' || _id; END IF;
  IF _function = 'unit_tests.absences(boolean)' THEN RETURN 'U06M' || _id; END IF;
  IF _function = 'unit_tests.absences_trigger(boolean)' THEN RETURN 'U06N' || _id; END IF;
  IF _function = 'unit_tests._after_data_insert(boolean)' THEN RETURN 'U06P' || _id; END IF;
  IF _function = 'unit_tests.branches(boolean)' THEN RETURN 'U06Q' || _id; END IF;
  IF _function = 'unit_tests.cities(boolean)' THEN RETURN 'U06R' || _id; END IF;
  IF _function = 'unit_tests.classrooms(boolean)' THEN RETURN 'U06S' || _id; END IF;
  IF _function = 'unit_tests.classrooms_students(boolean)' THEN RETURN 'U06T' || _id; END IF;
  IF _function = 'unit_tests.classrooms_students_trigger(boolean)' THEN RETURN 'U06U' || _id; END IF;
  IF _function = 'unit_tests.classrooms_trigger(boolean)' THEN RETURN 'U06V' || _id; END IF;
  IF _function = 'unit_tests.communications_media(boolean)' THEN RETURN 'U06W' || _id; END IF;
  IF _function = 'unit_tests.communications_media_trigger(boolean)' THEN RETURN 'U06X' || _id; END IF;
  IF _function = 'unit_tests.communication_types(boolean)' THEN RETURN 'U06Y' || _id; END IF;
  IF _function = 'unit_tests.conversations(boolean)' THEN RETURN 'U06Z' || _id; END IF;
  IF _function = 'unit_tests.conversations_invites(boolean)' THEN RETURN 'U070' || _id; END IF;
  IF _function = 'unit_tests.countries(boolean)' THEN RETURN 'U071' || _id; END IF;
  IF _function = 'unit_tests.degrees(boolean)' THEN RETURN 'U072' || _id; END IF;
  IF _function = 'unit_tests.delays(boolean)' THEN RETURN 'U073' || _id; END IF;
  IF _function = 'unit_tests.delays_triggers(boolean)' THEN RETURN 'U074' || _id; END IF;
  IF _function = 'unit_tests.districts(boolean)' THEN RETURN 'U075' || _id; END IF;
  IF _function = 'unit_tests.explanations(boolean)' THEN RETURN 'U076' || _id; END IF;
  IF _function = 'unit_tests.explanations_triggers(boolean)' THEN RETURN 'U077' || _id; END IF;
  IF _function = 'unit_tests.faults(boolean)' THEN RETURN 'U078' || _id; END IF;
  IF _function = 'unit_tests.faults_triggers(boolean)' THEN RETURN 'U079' || _id; END IF;
  IF _function = 'unit_tests.grades(boolean)' THEN RETURN 'U07A' || _id; END IF;
  IF _function = 'unit_tests.grade_types(boolean)' THEN RETURN 'U07B' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings(boolean)' THEN RETURN 'U07C' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings_close(boolean)' THEN RETURN 'U07D' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings_triggers(boolean)' THEN RETURN 'U07E' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings_valutations(boolean)' THEN RETURN 'U07F' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings_valutations_qua(boolean)' THEN RETURN 'U07G' || _id; END IF;
  IF _function = 'unit_tests.grading_meetings_valutations_triggers(boolean)' THEN RETURN 'U07H' || _id; END IF;
  IF _function = 'unit_tests.holidays(boolean)' THEN RETURN 'U07J' || _id; END IF;
  IF _function = 'unit_tests.leavings(boolean)' THEN RETURN 'U07K' || _id; END IF;
  IF _function = 'unit_tests.leavings_triggers(boolean)' THEN RETURN 'U07L' || _id; END IF;
  IF _function = 'unit_tests.lessons(boolean)' THEN RETURN 'U07M' || _id; END IF;
  IF _function = 'unit_tests.messages(boolean)' THEN RETURN 'U07N' || _id; END IF;
  IF _function = 'unit_tests.messages_read(boolean)' THEN RETURN 'U07P' || _id; END IF;
  IF _function = 'unit_tests.metrics(boolean)' THEN RETURN 'U07Q' || _id; END IF;
  IF _function = 'unit_tests.mime_type(boolean)' THEN RETURN 'U07R' || _id; END IF;
  IF _function = 'unit_tests.my_sqlcode(boolean)' THEN RETURN 'U07S' || _id; END IF;
  IF _function = 'unit_tests.notes(boolean)' THEN RETURN 'U07T' || _id; END IF;
  IF _function = 'unit_tests.notes_signed(boolean)' THEN RETURN 'U07U' || _id; END IF;
  IF _function = 'unit_tests.out_of_classrooms(boolean)' THEN RETURN 'U07V' || _id; END IF;
  IF _function = 'unit_tests.parents_meetings(boolean)' THEN RETURN 'U07W' || _id; END IF;
  IF _function = 'unit_tests.persons_addresses(boolean)' THEN RETURN 'U07X' || _id; END IF;
  IF _function = 'unit_tests.persons(boolean)' THEN RETURN 'U07Y' || _id; END IF;
  IF _function = 'unit_tests.persons_relations(boolean)' THEN RETURN 'U07Z' || _id; END IF;
  IF _function = 'unit_tests.persons_roles(boolean)' THEN RETURN 'U080' || _id; END IF;
  IF _function = 'unit_tests.qualifications(boolean)' THEN RETURN 'U081' || _id; END IF;
  IF _function = 'unit_tests.regions(boolean)' THEN RETURN 'U082' || _id; END IF;
  IF _function = 'unit_tests.schools_behavior(boolean)' THEN RETURN 'U083' || _id; END IF;
  IF _function = 'unit_tests.schools(boolean)' THEN RETURN 'U084' || _id; END IF;
  IF _function = 'unit_tests.schools_check(boolean)' THEN RETURN 'U085' || _id; END IF;
  IF _function = 'unit_tests.schools_foreign_key(boolean)' THEN RETURN 'U086' || _id; END IF;
  IF _function = 'unit_tests.schools_trigger(boolean)' THEN RETURN 'U087' || _id; END IF;
  IF _function = 'unit_tests.school_years(boolean)' THEN RETURN 'U088' || _id; END IF;
  IF _function = 'unit_tests.subjects(boolean)' THEN RETURN 'U089' || _id; END IF;
  IF _function = 'unit_tests.teachears_notes(boolean)' THEN RETURN 'U08A' || _id; END IF;
  IF _function = 'unit_tests.topics(boolean)' THEN RETURN 'U08B' || _id; END IF;
  IF _function = 'unit_tests.usenames_ex(boolean)' THEN RETURN 'U08C' || _id; END IF;
  IF _function = 'unit_tests.valutations(boolean)' THEN RETURN 'U08D' || _id; END IF;
  IF _function = 'unit_tests.weekly_timetables(boolean)' THEN RETURN 'U08E' || _id; END IF;
  IF _function = 'unit_tests.weekly_timetables_days(boolean)' THEN RETURN 'U08F' || _id; END IF;
  IF _function = 'unit_tests.wikimedia_files(boolean)' THEN RETURN 'U08G' || _id; END IF;
  IF _function = 'unit_tests.wikimedia_files_persons(boolean)' THEN RETURN 'U08H' || _id; END IF;
  IF _function = 'url_decode(text)' THEN RETURN 'U08J' || _id; END IF;
  IF _function = 'where_sequence(text,text,text,bigint)' THEN RETURN 'U08K' || _id; END IF;
--
-- se la functionsignature non è stata gestita si imposta un errore generico
--
  RETURN 'UZZZ' || _id;
END;

$$;


ALTER FUNCTION diagnostic.my_sqlcode(_function character varying, _id character) OWNER TO postgres;

--
-- Name: show(error); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION show(_error error) RETURNS void
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  RAISE WARNING '=====================';
  RAISE WARNING '>>>>>>> ERROR <<<<<<<';
  RAISE WARNING '=====================';
  RAISE WARNING 'Sqlcode.............: %', _error.returned_sqlstate;
  RAISE WARNING 'Message.............: %', _error.message_text;
  RAISE WARNING 'Schema..............: %', _error.schema_name;
  RAISE WARNING 'Table...............: %', _error.table_name;
  RAISE WARNING 'Column..............: %', _error.column_name;
  RAISE WARNING 'Constraint..........: %', _error.constraint_name;
  RAISE WARNING 'Exception context...: %', _error.pg_exception_context;
  RAISE WARNING 'Exception detail....: %', _error.pg_exception_detail;
  RAISE WARNING 'Exception hint......: %', _error.pg_exception_hint;
  RAISE WARNING 'Datatype............: %', _error.pg_datatype_name;
  RAISE WARNING '=====================';
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.show(_error error) OWNER TO postgres;

--
-- Name: show(text[]); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION show(VARIADIC _messages text[]) RETURNS void
    LANGUAGE plpgsql IMMUTABLE COST 1
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;

  message		text;
  max_length		int;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  SELECT max(length(unnest)) FROM unnest(_messages) INTO me.max_length;

  RAISE WARNING '%',repeat('=', me.max_length);

  FOREACH me.message IN ARRAY _messages
  LOOP
    RAISE WARNING '%',me.message;
  END LOOP;

  RAISE WARNING '%',repeat('=', me.max_length)
  RETURN;
END
$$;


ALTER FUNCTION diagnostic.show(VARIADIC _messages text[]) OWNER TO postgres;

--
-- Name: show_current_error(); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION show_current_error() RETURNS error
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE
  error			diagnostic.error;
BEGIN
  BEGIN
    RAISE EXCEPTION SQLSTATE 'ZZZZZ';
  EXCEPTION
    WHEN OTHERS THEN
     GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
     PERFORM diagnostic.show(error);
  END;
  RETURN error;
END
$$;


ALTER FUNCTION diagnostic.show_current_error() OWNER TO postgres;

--
-- Name: test_full_function_name(); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION test_full_function_name() RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  RETURN full_function_name;
END
$$;


ALTER FUNCTION diagnostic.test_full_function_name() OWNER TO postgres;

--
-- Name: test_function_name(); Type: FUNCTION; Schema: diagnostic; Owner: postgres
--

CREATE FUNCTION test_function_name() RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  RETURN full_function_name;
END
$$;


ALTER FUNCTION diagnostic.test_function_name() OWNER TO postgres;

--
-- Name: functions_check; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW functions_check AS
 SELECT ((ss.pcf).functionid)::regprocedure AS functionid,
    (ss.pcf).lineno AS lineno,
    (ss.pcf).statement AS statement,
    (ss.pcf).sqlstate AS sqlstate,
    (ss.pcf).message AS message,
    (ss.pcf).detail AS detail,
    (ss.pcf).hint AS hint,
    (ss.pcf).level AS level,
    (ss.pcf)."position" AS "position",
    (ss.pcf).query AS query,
    (ss.pcf).context AS context
   FROM ( SELECT public.plpgsql_check_function_tb((pg_proc.oid)::regprocedure, (COALESCE(pg_trigger.tgrelid, (0)::oid))::regclass) AS pcf
           FROM (pg_proc
             LEFT JOIN pg_trigger ON ((pg_trigger.tgfoid = pg_proc.oid)))
          WHERE ((pg_proc.prolang = ( SELECT lang.oid
                   FROM pg_language lang
                  WHERE (lang.lanname = 'plpgsql'::name))) AND (pg_proc.pronamespace <> ( SELECT nsp.oid
                   FROM pg_namespace nsp
                  WHERE (nsp.nspname = 'pg_catalog'::name))) AND ((pg_proc.prorettype <> ( SELECT typ.oid
                   FROM pg_type typ
                  WHERE (typ.typname = 'trigger'::name))) OR (pg_trigger.tgfoid IS NOT NULL)))
         OFFSET 0) ss
  ORDER BY (((ss.pcf).functionid)::regprocedure)::text, (ss.pcf).lineno;


ALTER TABLE functions_check OWNER TO postgres;

--
-- Name: VIEW functions_check; Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON VIEW functions_check IS 'Check all plpgsql functions (functions or trigger functions with defined triggers) if functions can be compiled and, if not, list the related error';


--
-- Name: functions_list; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW functions_list AS
 SELECT n.nspname AS schema_name,
    p.proname AS function_name,
        CASE
            WHEN (n.nspname = 'public'::name) THEN concat('public.'::text, ((p.oid)::regprocedure)::text)
            ELSE ((p.oid)::regprocedure)::text
        END AS function_signature,
    my_sqlcode((
        CASE
            WHEN (n.nspname = 'public'::name) THEN concat('public.'::text, ((p.oid)::regprocedure)::text)
            ELSE ((p.oid)::regprocedure)::text
        END)::character varying, '0'::bpchar) AS my_sqlcode
   FROM ((pg_proc p
     JOIN pg_namespace n ON ((n.oid = p.pronamespace)))
     LEFT JOIN ( SELECT 'public'::text AS schema_name,
            procedures_excluded.name
           FROM translate.procedures_excluded) pe ON (((pe.schema_name = (n.nspname)::text) AND (pe.name = (p.proname)::text))))
  WHERE ((n.nspname <> ALL (ARRAY['pg_catalog'::name, 'information_schema'::name])) AND (NOT ((n.nspname)::text IN ( SELECT languages.schema
           FROM translate.languages))) AND (pe.schema_name IS NULL));


ALTER TABLE functions_list OWNER TO postgres;

--
-- Name: VIEW functions_list; Type: COMMENT; Schema: diagnostic; Owner: postgres
--

COMMENT ON VIEW functions_list IS 'List all the function in all schema';


--
-- Name: views_working; Type: VIEW; Schema: diagnostic; Owner: postgres
--

CREATE VIEW views_working AS
 SELECT pg_views.schemaname AS schema_name,
    pg_views.viewname AS view_name,
    if_view_works(((quote_ident((pg_views.schemaname)::text) || '.'::text) || quote_ident((pg_views.viewname)::text))) AS works
   FROM pg_views
  WHERE (pg_views.schemaname <> ALL (ARRAY['information_schema'::name, 'pg_catalog'::name]));


ALTER TABLE views_working OWNER TO postgres;

--
-- Name: diagnostic; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA diagnostic TO scuola247_user;


--
-- Name: full_function_name(text); Type: ACL; Schema: diagnostic; Owner: postgres
--

GRANT ALL ON FUNCTION full_function_name(_context text, OUT _function_name text) TO scuola247_executive;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: diagnostic; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA diagnostic REVOKE ALL ON TABLES  FROM postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA diagnostic GRANT ALL ON TABLES  TO PUBLIC;


--
-- PostgreSQL database dump complete
--
