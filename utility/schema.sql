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

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 17 (class 2615 OID 18777)
-- Name: utility; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA utility;

ALTER SCHEMA utility OWNER TO postgres;

--
-- TOC entry 3704 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA utility; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA utility IS 'Contains all the objects in a database that although very useful are not large enough or numerous enough to warrant a separate scheme';


SET search_path = utility, pg_catalog;

--
-- TOC entry 1333 (class 1247 OID 18944)
-- Name: language; Type: TYPE; Schema: utility; Owner: postgres
--

CREATE TYPE language AS ENUM (
    'de',
    'it',
    'en',
    'es',
    'fr',
    'nl',
    'sr',
    'sl',
    'bs',
    'hr',
    'sq',
    'lb',
    'pt'
);


ALTER TYPE language OWNER TO postgres;

--
-- TOC entry 3705 (class 0 OID 0)
-- Dependencies: 1333
-- Name: TYPE language; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON TYPE language IS '''de'' Deutsch
''it'' Italian
''en'' English
''es'' Spanish
''fr'' French
''nl'' Dutch
''sr'' Serbian
''sl'' Slovenian
''bs'' Bosnia
''hr'' Croatian
''sq'' Albanian
''lb'' Luxembourgish
''pt'' Portoguese';


--
-- TOC entry 1697 (class 1247 OID 759688)
-- Name: number_base34; Type: DOMAIN; Schema: utility; Owner: postgres
--

CREATE DOMAIN number_base34 AS character varying(12)
	CONSTRAINT number_base34_check_characters CHECK (((VALUE)::text ~ similar_escape('[0-9A-HJ-NP-Z]{0,12}'::text, NULL::text)));


ALTER DOMAIN number_base34 OWNER TO postgres;

--
-- TOC entry 3706 (class 0 OID 0)
-- Dependencies: 1697
-- Name: DOMAIN number_base34; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON DOMAIN number_base34 IS 'This is a number in base 34 
Number means that its value can be converted to a bigint this is because the maximun length is 12 characters
Base 34 means that the digits are: ''0123456789ABCEDFGHJKLMNPQRSTUWXYZ''
The digits: ''O'' and ''I'' was leave out to avoid error with ''0'' and ''1''';


--
-- TOC entry 1336 (class 1247 OID 18957)
-- Name: system_message; Type: TYPE; Schema: utility; Owner: postgres
--

CREATE TYPE system_message AS (
	language language,
	id smallint,
	message text
);


ALTER TYPE system_message OWNER TO postgres;

--
-- TOC entry 1339 (class 1247 OID 18958)
-- Name: week_day; Type: DOMAIN; Schema: utility; Owner: postgres
--

CREATE DOMAIN week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN week_day OWNER TO postgres;

--
-- TOC entry 3707 (class 0 OID 0)
-- Dependencies: 1339
-- Name: DOMAIN week_day; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON DOMAIN week_day IS '<utility>';


--
-- TOC entry 499 (class 1255 OID 19225)
-- Name: day_name(week_day); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION day_name(_weekday week_day) RETURNS character varying
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context               text;
  full_function_name 	text;
BEGIN
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  RETURN to_char('2000-01-02'::date + _weekday, 'TMDay');
END;
$$;


ALTER FUNCTION utility.day_name(_weekday week_day) OWNER TO postgres;

--
-- TOC entry 3708 (class 0 OID 0)
-- Dependencies: 499
-- Name: FUNCTION day_name(_weekday week_day); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION day_name(_weekday week_day) IS '<utility>';


--
-- TOC entry 636 (class 1255 OID 19378)
-- Name: count_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION count_value(search_db text, search_schema text, search_table text) RETURNS TABLE(on_datebase_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, count_value bigint, count_null_value bigint, count_not_null_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Visualizza per tutte le columns che possono contenere null della tabella, schema e catalogo indicati 
   quante valori null e not null ci sono
*/
<<me>>
DECLARE
  results record;
BEGIN 
  FOR results IN SELECT
		   columns.table_catalog, 
		   columns.table_schema,
		   columns.table_name, 
		   columns.column_name
		 FROM
		   information_schema.columns 
		WHERE
		    columns.table_catalog = search_db
		AND columns.table_schema = search_schema
		AND columns.table_name = search_table
		AND is_nullable = 'YES'
  LOOP
    on_datebase_name := results.table_catalog;
    schema_name := results.table_schema;
    table_name := results.table_name;
    column_name := results.column_name;
    EXECUTE 'SELECT COUNT(*), count(' || column_name || '), count(*) - count(' || column_name || ') FROM ' || table_name into strict count_value, count_null_value, count_not_null_value;
    RETURN NEXT;
   END LOOP;
 END;
$$;


ALTER FUNCTION utility.count_value(search_db text, search_schema text, search_table text) OWNER TO postgres;

--
-- TOC entry 3709 (class 0 OID 0)
-- Dependencies: 636
-- Name: FUNCTION count_value(search_db text, search_schema text, search_table text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION count_value(search_db text, search_schema text, search_table text) IS '<utility>
Restituisce l''elenco delle colonne che ammettono valori null person l''indicazione del numero di valori contenuti person la sottodivisione fra quelli che non hanno valori nulle quelli che si.';


--
-- TOC entry 542 (class 1255 OID 19379)
-- Name: entity2char(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION entity2char(t text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
    r record;
begin
    for r in
        select distinct ce.coding as ch, ce.entity as name
        from
            datasets.entity_coding() ce
            inner join (
                select name[1] "name"
                from regexp_matches(t, '&([A-Za-z]+?);', 'g') r(name)
            ) s on ce.entity = s.name
    loop
        t := replace(t, '&' || r.name || ';', r.ch);
    end loop;

    for r in
        select distinct
            hex[1] hex,
            ('x' || repeat('0', 8 - length(hex[1])) || hex[1])::bit(32)::int codepoint
        from regexp_matches(t, '&#x([0-9a-f]{1,8}?);', 'gi') s(hex)
    loop
        t := regexp_replace(t, '&#x' || r.hex || ';', chr(r.codepoint), 'gi');
    end loop;

    for r in
        select distinct
            chr(codepoint[1]::int) ch,
            codepoint[1] codepoint
        from regexp_matches(t, '&#([0-9]{1,10}?);', 'g') s(codepoint)
    loop
        t := replace(t, '&#' || r.codepoint || ';', r.ch);
    end loop;

    return t;
end;
$$;


ALTER FUNCTION utility.entity2char(t text) OWNER TO postgres;

--
-- TOC entry 3711 (class 0 OID 0)
-- Dependencies: 542
-- Name: FUNCTION entity2char(t text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION entity2char(t text) IS '<utility>';


--
-- TOC entry 538 (class 1255 OID 19380)
-- Name: entity_coding(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION entity_coding() RETURNS TABLE(entity text, coding character)
    LANGUAGE plpgsql IMMUTABLE SECURITY DEFINER
    AS $$
DECLARE
BEGIN 
  entity := 'Aacute'::text; coding := E'\u00C1'::character; RETURN NEXT;
  entity := 'Acirc'::text; coding := E'\u00C2'::character; RETURN NEXT;
  entity := 'AElig'::text; coding := E'\u00C6'::character; RETURN NEXT;
  entity := 'Agrave'::text; coding := E'\u00C0'::character; RETURN NEXT;
  entity := 'Alpha'::text; coding := E'\u0391'::character; RETURN NEXT;
  entity := 'Aring'::text; coding := E'\u00C5'::character; RETURN NEXT;
  entity := 'Atilde'::text; coding := E'\u00C3'::character; RETURN NEXT;
  entity := 'Auml'::text; coding := E'\u00C4'::character; RETURN NEXT;
  entity := 'Beta'::text; coding := E'\u0392'::character; RETURN NEXT;
  entity := 'Ccedil'::text; coding := E'\u00C7'::character; RETURN NEXT;
  entity := 'Chi'::text; coding := E'\u03A7'::character; RETURN NEXT;
  entity := 'Dagger'::text; coding := E'\u2021'::character; RETURN NEXT;
  entity := 'Delta'::text; coding := E'\u0394'::character; RETURN NEXT;
  entity := 'ETH'::text; coding := E'\u00D0'::character; RETURN NEXT;
  entity := 'Eacute'::text; coding := E'\u00C9'::character; RETURN NEXT;
  entity := 'Ecirc'::text; coding := E'\u00CA'::character; RETURN NEXT;
  entity := 'Egrave'::text; coding := E'\u00C8'::character; RETURN NEXT;
  entity := 'Epsilon'::text; coding := E'\u0395'::character; RETURN NEXT;
  entity := 'Eta'::text; coding := E'\u0397'::character; RETURN NEXT;
  entity := 'Euml'::text; coding := E'\u00CB'::character; RETURN NEXT;
  entity := 'Gamma'::text; coding := E'\u0393'::character; RETURN NEXT;
  entity := 'Iacute'::text; coding := E'\u00CD'::character; RETURN NEXT;
  entity := 'Icirc'::text; coding := E'\u00CE'::character; RETURN NEXT;
  entity := 'Igrave'::text; coding := E'\u00CC'::character; RETURN NEXT;
  entity := 'Iota'::text; coding := E'\u0399'::character; RETURN NEXT;
  entity := 'Iuml'::text; coding := E'\u00CF'::character; RETURN NEXT;
  entity := 'Kappa'::text; coding := E'\u039A'::character; RETURN NEXT;
  entity := 'Lambda'::text; coding := E'\u039B'::character; RETURN NEXT;
  entity := 'Mu'::text; coding := E'\u039C'::character; RETURN NEXT;
  entity := 'Ntilde'::text; coding := E'\u00D1'::character; RETURN NEXT;
  entity := 'Nu'::text; coding := E'\u039D'::character; RETURN NEXT;
  entity := 'OElig'::text; coding := E'\u0152'::character; RETURN NEXT;
  entity := 'Oacute'::text; coding := E'\u00D3'::character; RETURN NEXT;
  entity := 'Ocirc'::text; coding := E'\u00D4'::character; RETURN NEXT;
  entity := 'Ograve'::text; coding := E'\u00D2'::character; RETURN NEXT;
  entity := 'Omega'::text; coding := E'\u03A9'::character; RETURN NEXT;
  entity := 'Omicron'::text; coding := E'\u039F'::character; RETURN NEXT;
  entity := 'Oslash'::text; coding := E'\u00D8'::character; RETURN NEXT;
  entity := 'Otilde'::text; coding := E'\u00D5'::character; RETURN NEXT;
  entity := 'Ouml'::text; coding := E'\u00D6'::character; RETURN NEXT;
  entity := 'Phi'::text; coding := E'\u03A6'::character; RETURN NEXT;
  entity := 'Pi'::text; coding := E'\u03A0'::character; RETURN NEXT;
  entity := 'Prime'::text; coding := E'\u2033'::character; RETURN NEXT;
  entity := 'Psi'::text; coding := E'\u03A8'::character; RETURN NEXT;
  entity := 'Rho'::text; coding := E'\u03A1'::character; RETURN NEXT;
  entity := 'Scaron'::text; coding := E'\u0160'::character; RETURN NEXT;
  entity := 'Sigma'::text; coding := E'\u03A3'::character; RETURN NEXT;
  entity := 'THORN'::text; coding := E'\u00DE'::character; RETURN NEXT;
  entity := 'Tau'::text; coding := E'\u03A4'::character; RETURN NEXT;
  entity := 'Theta'::text; coding := E'\u0398'::character; RETURN NEXT;
  entity := 'Uacute'::text; coding := E'\u00DA'::character; RETURN NEXT;
  entity := 'Ucirc'::text; coding := E'\u00DB'::character; RETURN NEXT;
  entity := 'Ugrave'::text; coding := E'\u00D9'::character; RETURN NEXT;
  entity := 'Upsilon'::text; coding := E'\u03A5'::character; RETURN NEXT;
  entity := 'Uuml'::text; coding := E'\u00DC'::character; RETURN NEXT;
  entity := 'Xi'::text; coding := E'\u039E'::character; RETURN NEXT;
  entity := 'Yacute'::text; coding := E'\u00DD'::character; RETURN NEXT;
  entity := 'Yuml'::text; coding := E'\u0178'::character; RETURN NEXT;
  entity := 'Zeta'::text; coding := E'\u0396'::character; RETURN NEXT;
  entity := 'aacute'::text; coding := E'\u00E1'::character; RETURN NEXT;
  entity := 'acirc'::text; coding := E'\u00E2'::character; RETURN NEXT;
  entity := 'acute'::text; coding := E'\u00B4'::character; RETURN NEXT;
  entity := 'aelig'::text; coding := E'\u00E6'::character; RETURN NEXT;
  entity := 'agrave'::text; coding := E'\u00E0'::character; RETURN NEXT;
  entity := 'alefsym'::text; coding := E'\u2135'::character; RETURN NEXT;
  entity := 'alpha'::text; coding := E'\u03B1'::character; RETURN NEXT;
  entity := 'amp'::text; coding := E'\u0026'::character; RETURN NEXT;
  entity := 'and'::text; coding := E'\u2227'::character; RETURN NEXT;
  entity := 'ang'::text; coding := E'\u2220'::character; RETURN NEXT;
  entity := 'aring'::text; coding := E'\u00E5'::character; RETURN NEXT;
  entity := 'asymp'::text; coding := E'\u2248'::character; RETURN NEXT;
  entity := 'atilde'::text; coding := E'\u00E3'::character; RETURN NEXT;
  entity := 'auml'::text; coding := E'\u00E4'::character; RETURN NEXT;
  entity := 'bdquo'::text; coding := E'\u201E'::character; RETURN NEXT;
  entity := 'beta'::text; coding := E'\u03B2'::character; RETURN NEXT;
  entity := 'brvbar'::text; coding := E'\u00A6'::character; RETURN NEXT;
  entity := 'bull'::text; coding := E'\u2022'::character; RETURN NEXT;
  entity := 'cap'::text; coding := E'\u2229'::character; RETURN NEXT;
  entity := 'ccedil'::text; coding := E'\u00E7'::character; RETURN NEXT;
  entity := 'cedil'::text; coding := E'\u00B8'::character; RETURN NEXT;
  entity := 'cent'::text; coding := E'\u00A2'::character; RETURN NEXT;
  entity := 'chi'::text; coding := E'\u03C7'::character; RETURN NEXT;
  entity := 'circ'::text; coding := E'\u02C6'::character; RETURN NEXT;
  entity := 'clubs'::text; coding := E'\u2663'::character; RETURN NEXT;
  entity := 'cong'::text; coding := E'\u2245'::character; RETURN NEXT;
  entity := 'copy'::text; coding := E'\u00A9'::character; RETURN NEXT;
  entity := 'crarr'::text; coding := E'\u21B5'::character; RETURN NEXT;
  entity := 'cup'::text; coding := E'\u222A'::character; RETURN NEXT;
  entity := 'curren'::text; coding := E'\u00A4'::character; RETURN NEXT;
  entity := 'dArr'::text; coding := E'\u21D3'::character; RETURN NEXT;
  entity := 'dagger'::text; coding := E'\u2020'::character; RETURN NEXT;
  entity := 'darr'::text; coding := E'\u2193'::character; RETURN NEXT;
  entity := 'deg'::text; coding := E'\u00B0'::character; RETURN NEXT;
  entity := 'delta'::text; coding := E'\u03B4'::character; RETURN NEXT;
  entity := 'diams'::text; coding := E'\u2666'::character; RETURN NEXT;
  entity := 'divide'::text; coding := E'\u00F7'::character; RETURN NEXT;
  entity := 'eacute'::text; coding := E'\u00E9'::character; RETURN NEXT;
  entity := 'ecirc'::text; coding := E'\u00EA'::character; RETURN NEXT;
  entity := 'egrave'::text; coding := E'\u00E8'::character; RETURN NEXT;
  entity := 'empty'::text; coding := E'\u2205'::character; RETURN NEXT;
  entity := 'emsp'::text; coding := E'\u2003'::character; RETURN NEXT;
  entity := 'ensp'::text; coding := E'\u2002'::character; RETURN NEXT;
  entity := 'epsilon'::text; coding := E'\u03B5'::character; RETURN NEXT;
  entity := 'equiv'::text; coding := E'\u2261'::character; RETURN NEXT;
  entity := 'eta'::text; coding := E'\u03B7'::character; RETURN NEXT;
  entity := 'eth'::text; coding := E'\u00F0'::character; RETURN NEXT;
  entity := 'euml'::text; coding := E'\u00EB'::character; RETURN NEXT;
  entity := 'euro'::text; coding := E'\u20AC'::character; RETURN NEXT;
  entity := 'exist'::text; coding := E'\u2203'::character; RETURN NEXT;
  entity := 'fnof'::text; coding := E'\u0192'::character; RETURN NEXT;
  entity := 'forall'::text; coding := E'\u2200'::character; RETURN NEXT;
  entity := 'frac12'::text; coding := E'\u00BD'::character; RETURN NEXT;
  entity := 'frac14'::text; coding := E'\u00BC'::character; RETURN NEXT;
  entity := 'frac34'::text; coding := E'\u00BE'::character; RETURN NEXT;
  entity := 'frasl'::text; coding := E'\u2044'::character; RETURN NEXT;
  entity := 'gamma'::text; coding := E'\u03B3'::character; RETURN NEXT;
  entity := 'ge'::text; coding := E'\u2265'::character; RETURN NEXT;
  entity := 'gt'::text; coding := E'\u003E'::character; RETURN NEXT;
  entity := 'hArr'::text; coding := E'\u21D4'::character; RETURN NEXT;
  entity := 'harr'::text; coding := E'\u2194'::character; RETURN NEXT;
  entity := 'hearts'::text; coding := E'\u2665'::character; RETURN NEXT;
  entity := 'hellip'::text; coding := E'\u2026'::character; RETURN NEXT;
  entity := 'iacute'::text; coding := E'\u00ED'::character; RETURN NEXT;
  entity := 'icirc'::text; coding := E'\u00EE'::character; RETURN NEXT;
  entity := 'iexcl'::text; coding := E'\u00A1'::character; RETURN NEXT;
  entity := 'igrave'::text; coding := E'\u00EC'::character; RETURN NEXT;
  entity := 'image'::text; coding := E'\u2111'::character; RETURN NEXT;
  entity := 'infin'::text; coding := E'\u221E'::character; RETURN NEXT;
  entity := 'int'::text; coding := E'\u222B'::character; RETURN NEXT;
  entity := 'iota'::text; coding := E'\u03B9'::character; RETURN NEXT;
  entity := 'iquest'::text; coding := E'\u00BF'::character; RETURN NEXT;
  entity := 'isin'::text; coding := E'\u2208'::character; RETURN NEXT;
  entity := 'iuml'::text; coding := E'\u00EF'::character; RETURN NEXT;
  entity := 'kappa'::text; coding := E'\u03BA'::character; RETURN NEXT;
  entity := 'lArr'::text; coding := E'\u21D0'::character; RETURN NEXT;
  entity := 'lambda'::text; coding := E'\u03BB'::character; RETURN NEXT;
  entity := 'lang'::text; coding := E'\u2329'::character; RETURN NEXT;
  entity := 'laquo'::text; coding := E'\u00AB'::character; RETURN NEXT;
  entity := 'larr'::text; coding := E'\u2190'::character; RETURN NEXT;
  entity := 'lceil'::text; coding := E'\u2308'::character; RETURN NEXT;
  entity := 'ldquo'::text; coding := E'\u201C'::character; RETURN NEXT;
  entity := 'le'::text; coding := E'\u2264'::character; RETURN NEXT;
  entity := 'lfloor'::text; coding := E'\u230A'::character; RETURN NEXT;
  entity := 'lowast'::text; coding := E'\u2217'::character; RETURN NEXT;
  entity := 'loz'::text; coding := E'\u25CA'::character; RETURN NEXT;
  entity := 'lrm'::text; coding := E'\u200E'::character; RETURN NEXT;
  entity := 'lsaquo'::text; coding := E'\u2039'::character; RETURN NEXT;
  entity := 'lsquo'::text; coding := E'\u2018'::character; RETURN NEXT;
  entity := 'lt'::text; coding := E'\u003C'::character; RETURN NEXT;
  entity := 'macr'::text; coding := E'\u00AF'::character; RETURN NEXT;
  entity := 'mdash'::text; coding := E'\u2014'::character; RETURN NEXT;
  entity := 'micro'::text; coding := E'\u00B5'::character; RETURN NEXT;
  entity := 'middot'::text; coding := E'\u00B7'::character; RETURN NEXT;
  entity := 'minus'::text; coding := E'\u2212'::character; RETURN NEXT;
  entity := 'mu'::text; coding := E'\u03BC'::character; RETURN NEXT;
  entity := 'nabla'::text; coding := E'\u2207'::character; RETURN NEXT;
  entity := 'nbsp'::text; coding := E'\u00A0'::character; RETURN NEXT;
  entity := 'ndash'::text; coding := E'\u2013'::character; RETURN NEXT;
  entity := 'ne'::text; coding := E'\u2260'::character; RETURN NEXT;
  entity := 'ni'::text; coding := E'\u220B'::character; RETURN NEXT;
  entity := 'not'::text; coding := E'\u00AC'::character; RETURN NEXT;
  entity := 'notin'::text; coding := E'\u2209'::character; RETURN NEXT;
  entity := 'nsub'::text; coding := E'\u2284'::character; RETURN NEXT;
  entity := 'ntilde'::text; coding := E'\u00F1'::character; RETURN NEXT;
  entity := 'nu'::text; coding := E'\u03BD'::character; RETURN NEXT;
  entity := 'oacute'::text; coding := E'\u00F3'::character; RETURN NEXT;
  entity := 'ocirc'::text; coding := E'\u00F4'::character; RETURN NEXT;
  entity := 'oelig'::text; coding := E'\u0153'::character; RETURN NEXT;
  entity := 'ograve'::text; coding := E'\u00F2'::character; RETURN NEXT;
  entity := 'oline'::text; coding := E'\u203E'::character; RETURN NEXT;
  entity := 'omega'::text; coding := E'\u03C9'::character; RETURN NEXT;
  entity := 'omicron'::text; coding := E'\u03BF'::character; RETURN NEXT;
  entity := 'oplus'::text; coding := E'\u2295'::character; RETURN NEXT;
  entity := 'or'::text; coding := E'\u2228'::character; RETURN NEXT;
  entity := 'ordf'::text; coding := E'\u00AA'::character; RETURN NEXT;
  entity := 'ordm'::text; coding := E'\u00BA'::character; RETURN NEXT;
  entity := 'oslash'::text; coding := E'\u00F8'::character; RETURN NEXT;
  entity := 'otilde'::text; coding := E'\u00F5'::character; RETURN NEXT;
  entity := 'otimes'::text; coding := E'\u2297'::character; RETURN NEXT;
  entity := 'ouml'::text; coding := E'\u00F6'::character; RETURN NEXT;
  entity := 'para'::text; coding := E'\u00B6'::character; RETURN NEXT;
  entity := 'part'::text; coding := E'\u2202'::character; RETURN NEXT;
  entity := 'permil'::text; coding := E'\u2030'::character; RETURN NEXT;
  entity := 'perp'::text; coding := E'\u22A5'::character; RETURN NEXT;
  entity := 'phi'::text; coding := E'\u03C6'::character; RETURN NEXT;
  entity := 'pi'::text; coding := E'\u03C0'::character; RETURN NEXT;
  entity := 'piv'::text; coding := E'\u03D6'::character; RETURN NEXT;
  entity := 'plusmn'::text; coding := E'\u00B1'::character; RETURN NEXT;
  entity := 'pound'::text; coding := E'\u00A3'::character; RETURN NEXT;
  entity := 'prime'::text; coding := E'\u2032'::character; RETURN NEXT;
  entity := 'prod'::text; coding := E'\u220F'::character; RETURN NEXT;
  entity := 'prop'::text; coding := E'\u221D'::character; RETURN NEXT;
  entity := 'psi'::text; coding := E'\u03C8'::character; RETURN NEXT;
  entity := 'quot'::text; coding := E'\u0022'::character; RETURN NEXT;
  entity := 'rArr'::text; coding := E'\u21D2'::character; RETURN NEXT;
  entity := 'radic'::text; coding := E'\u221A'::character; RETURN NEXT;
  entity := 'rang'::text; coding := E'\u232A'::character; RETURN NEXT;
  entity := 'raquo'::text; coding := E'\u00BB'::character; RETURN NEXT;
  entity := 'rarr'::text; coding := E'\u2192'::character; RETURN NEXT;
  entity := 'rceil'::text; coding := E'\u2309'::character; RETURN NEXT;
  entity := 'rdquo'::text; coding := E'\u201D'::character; RETURN NEXT;
  entity := 'real'::text; coding := E'\u211C'::character; RETURN NEXT;
  entity := 'reg'::text; coding := E'\u00AE'::character; RETURN NEXT;
  entity := 'rfloor'::text; coding := E'\u230B'::character; RETURN NEXT;
  entity := 'rho'::text; coding := E'\u03C1'::character; RETURN NEXT;
  entity := 'rlm'::text; coding := E'\u200F'::character; RETURN NEXT;
  entity := 'rsaquo'::text; coding := E'\u203A'::character; RETURN NEXT;
  entity := 'rsquo'::text; coding := E'\u2019'::character; RETURN NEXT;
  entity := 'sbquo'::text; coding := E'\u201A'::character; RETURN NEXT;
  entity := 'scaron'::text; coding := E'\u0161'::character; RETURN NEXT;
  entity := 'sdot'::text; coding := E'\u22C5'::character; RETURN NEXT;
  entity := 'sect'::text; coding := E'\u00A7'::character; RETURN NEXT;
  entity := 'shy'::text; coding := E'\u00AD'::character; RETURN NEXT;
  entity := 'sigma'::text; coding := E'\u03C3'::character; RETURN NEXT;
  entity := 'sigmaf'::text; coding := E'\u03C2'::character; RETURN NEXT;
  entity := 'sim'::text; coding := E'\u223C'::character; RETURN NEXT;
  entity := 'spades'::text; coding := E'\u2660'::character; RETURN NEXT;
  entity := 'sub'::text; coding := E'\u2282'::character; RETURN NEXT;
  entity := 'sube'::text; coding := E'\u2286'::character; RETURN NEXT;
  entity := 'sum'::text; coding := E'\u2211'::character; RETURN NEXT;
  entity := 'sup'::text; coding := E'\u2283'::character; RETURN NEXT;
  entity := 'sup1'::text; coding := E'\u00B9'::character; RETURN NEXT;
  entity := 'sup2'::text; coding := E'\u00B2'::character; RETURN NEXT;
  entity := 'sup3'::text; coding := E'\u00B3'::character; RETURN NEXT;
  entity := 'supe'::text; coding := E'\u2287'::character; RETURN NEXT;
  entity := 'szlig'::text; coding := E'\u00DF'::character; RETURN NEXT;
  entity := 'tau'::text; coding := E'\u03C4'::character; RETURN NEXT;
  entity := 'there4'::text; coding := E'\u2234'::character; RETURN NEXT;
  entity := 'theta'::text; coding := E'\u03B8'::character; RETURN NEXT;
  entity := 'thetasym'::text; coding := E'\u03D1'::character; RETURN NEXT;
  entity := 'thinsp'::text; coding := E'\u2009'::character; RETURN NEXT;
  entity := 'thorn'::text; coding := E'\u00FE'::character; RETURN NEXT;
  entity := 'tilde'::text; coding := E'\u02DC'::character; RETURN NEXT;
  entity := 'times'::text; coding := E'\u00D7'::character; RETURN NEXT;
  entity := 'trade'::text; coding := E'\u2122'::character; RETURN NEXT;
  entity := 'uArr'::text; coding := E'\u21D1'::character; RETURN NEXT;
  entity := 'uacute'::text; coding := E'\u00FA'::character; RETURN NEXT;
  entity := 'uarr'::text; coding := E'\u2191'::character; RETURN NEXT;
  entity := 'ucirc'::text; coding := E'\u00FB'::character; RETURN NEXT;
  entity := 'ugrave'::text; coding := E'\u00F9'::character; RETURN NEXT;
  entity := 'uml'::text; coding := E'\u00A8'::character; RETURN NEXT;
  entity := 'upsih'::text; coding := E'\u03D2'::character; RETURN NEXT;
  entity := 'upsilon'::text; coding := E'\u03C5'::character; RETURN NEXT;
  entity := 'uuml'::text; coding := E'\u00FC'::character; RETURN NEXT;
  entity := 'weierp'::text; coding := E'\u2118'::character; RETURN NEXT;
  entity := 'xi'::text; coding := E'\u03BE'::character; RETURN NEXT;
  entity := 'yacute'::text; coding := E'\u00FD'::character; RETURN NEXT;
  entity := 'yen'::text; coding := E'\u00A5'::character; RETURN NEXT;
  entity := 'yuml'::text; coding := E'\u00FF'::character; RETURN NEXT;
  entity := 'zeta'::text; coding := E'\u03B6'::character; RETURN NEXT;
  entity := 'zwj'::text; coding := E'\u200D'::character; RETURN NEXT;
  entity := 'zwnj'::text; coding := E'\u200C'::character; RETURN NEXT;
  RETURN;
END;
$$;


ALTER FUNCTION utility.entity_coding() OWNER TO postgres;

--
-- TOC entry 3712 (class 0 OID 0)
-- Dependencies: 538
-- Name: FUNCTION entity_coding(); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION entity_coding() IS '<utility>';


--
-- TOC entry 900 (class 1255 OID 11538470)
-- Name: enum2array(anyenum); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION enum2array(_enum anyenum) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE COST 1
    AS $$
BEGIN
  RETURN enum_range(_enum)::text[];
END;
$$;


ALTER FUNCTION utility.enum2array(_enum anyenum) OWNER TO postgres;

--
-- TOC entry 3713 (class 0 OID 0)
-- Dependencies: 900
-- Name: FUNCTION enum2array(_enum anyenum); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION enum2array(_enum anyenum) IS 'Return un text array filled with the enum values';


--
-- TOC entry 537 (class 1255 OID 19383)
-- Name: get_max_column_value(text, text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

BEGIN 

  IF schema_name = ''
  OR table_name = ''
  OR column_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: get_max_column_value(''schema'', ''table'', ''column'')'; 
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
 EXECUTE 'SELECT MAX(' || quote_ident(column_name) || ') FROM ' || quote_ident(schema_name) || '.' || quote_ident(table_name) INTO STRICT max_value;
END;
$$;


ALTER FUNCTION utility.get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) OWNER TO postgres;

--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 537
-- Name: FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION get_max_column_value(schema_name text, table_name text, column_name text, OUT max_value bigint) IS '<utility>
given the name of the schema, table, and column, it returns the maximum value of the column';


--
-- TOC entry 803 (class 1255 OID 759704)
-- Name: int8(number_base34); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION int8(_in_value number_base34, OUT _out_value bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER COST 10
    AS $$
<<me>>
DECLARE
  digit_value			integer;
  digits 			text = '0123456789ABCDEFGHJKLMNPQRSTUVWXYZ'; 
  base				integer;
  context 			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  IF _in_value IS NuLL THEN
    _out_value = NULL
    RETURN;
  END IF;

  base = length(digits);
  
  _out_value = 0;
  
--
-- elaboro il valore in input
--            
  
  FOR i in 1..length(_in_value) LOOP

    digit_value = position(SUBSTRING(_in_value FROM i FOR 1) in digits) -1;

    IF i = length(_in_value) THEN
      _out_value = _out_value + digit_value;
    ELSE
      _out_value = _out_value + (digit_value * (base ^ (length(_in_value) - i)));
    END IF;
    
  END LOOP;

  RETURN;
END;
$$;


ALTER FUNCTION utility.int8(_in_value number_base34, OUT _out_value bigint) OWNER TO postgres;

--
-- TOC entry 798 (class 1255 OID 759703)
-- Name: number_base34(bigint); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION number_base34(_in_value bigint, OUT _out_value number_base34) RETURNS number_base34
    LANGUAGE plpgsql SECURITY DEFINER COST 10
    AS $$
<<me>>
DECLARE
  digits 			char[] = ARRAY['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','J','K','L','M','N','P','Q','R','S','T','U','V','W','X','Y','Z']; 
  reminder			integer;
  base				integer;
  context 			text;
  full_function_name		text;
BEGIN 
--
-- Recupero il nome della funzione
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  base = array_length(digits, 1);
--
-- elaboro il valore in input
--            
  IF _in_value = 0 THEN 
    _out_value = '0'::utility.number_base34;
    RETURN;
  ELSE
    _out_value = '';
  END IF;
  
  WHILE _in_value > 0 LOOP
  
    reminder = _in_value % base;
    _in_value = _in_value / base;

    _out_value = concat(digits[reminder+1], _out_value );
    
  END LOOP;

  RETURN;
END;
$$;


ALTER FUNCTION utility.number_base34(_in_value bigint, OUT _out_value number_base34) OWNER TO postgres;

--
-- TOC entry 799 (class 1255 OID 759692)
-- Name: number_base34_pl(number_base34, integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION number_base34_pl(number_base34, integer) RETURNS number_base34
    LANGUAGE plpgsql SECURITY DEFINER COST 1
    AS $_$
DECLARE
BEGIN 
  RETURN utility.number_base34(utility.int8($1) + $2);
END;
$_$;


ALTER FUNCTION utility.number_base34_pl(number_base34, integer) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 19385)
-- Name: set_all_sequences_2_the_max(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION set_all_sequences_2_the_max() RETURNS TABLE(sequence_namespace name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
BEGIN 
  RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
  FROM utility.sequence_references t
  GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_all_sequences_2_the_max() OWNER TO postgres;

--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 543
-- Name: FUNCTION set_all_sequences_2_the_max(); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_all_sequences_2_the_max() IS '<utility>
sets all database sequences to the highest value found in the database';


--
-- TOC entry 929 (class 1255 OID 11538469)
-- Name: set_sequence_2_the_max(text, text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) RETURNS TABLE(sequence_schema_name name, sequence_name name, sequence_value bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE
 
BEGIN 

  IF _sequence_schema_name = ''
  OR _sequence_name = ''
  THEN
    RAISE NOTICE ''; 
    RAISE NOTICE 'FUNCTION SYNTAX: set_sequence_2_the_max(sequence_namespace, sequence_name)';
    RAISE NOTICE ''; 
    RAISE invalid_parameter_value USING MESSAGE = 'Input parameters are missing', HINT = 'Check the parameters and rerun the comand';
  END IF;
  
RETURN QUERY SELECT t.sequence_schema_name, t.sequence_name, setval(quote_ident(t.sequence_schema_name) || '.' || quote_ident(t.sequence_name), max(t.max_value))
               FROM utility.sequence_references t
              WHERE t.sequence_schema_name = _sequence_schema_name
                AND t.sequence_name = _sequence_name
           GROUP BY t.sequence_schema_name, t.sequence_name;
END;
$$;


ALTER FUNCTION utility.set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) OWNER TO postgres;

--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 929
-- Name: FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION set_sequence_2_the_max(_sequence_schema_name text, _sequence_name text) IS '<utility>
sets the sequences in input to the highest value found in the database';


--
-- TOC entry 544 (class 1255 OID 19387)
-- Name: strip_tags(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION strip_tags(text) RETURNS text
    LANGUAGE sql
    AS $_$
    SELECT regexp_replace(regexp_replace($1, E'(?x)<[^>]*?(\s alt \s* = \s* ([\'"]) ([^>]*?) \2) [^>]*? >', E'\3'), E'(?x)(< [^>]*? >)', '', 'g')
$_$;


ALTER FUNCTION utility.strip_tags(text) OWNER TO postgres;

--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 544
-- Name: FUNCTION strip_tags(text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION strip_tags(text) IS '<utility>
Strip out the HTML tags from a string';


--
-- TOC entry 494 (class 1255 OID 4120185)
-- Name: system_messages_locale(system_message[], integer); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION system_messages_locale(_system_messages system_message[], _id integer, OUT _return_message text) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, utility, pg_temp
    AS $$
<<me>>
DECLARE
  message_language	utility.language;
  system_lc_messages    text;
-- variables for system tool
  full_function_name	varchar;
  context		text;
BEGIN 
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
-- You can show the system language with:
--   SHOW lc_messages
-- and you can set it with:
--   SET lc_message = 'xxx'
-- If you want to set a variable:
--   SHOW lc_messages INTO pippo
-- un paio di esempi:
--   it_IT.UTF-8
--   en_US.UTF-8

  SHOW lc_messages INTO system_lc_messages;

  -- search for  the user language
  SELECT language 
    INTO me.message_language 
    FROM utility.usenames_ex 
   WHERE usename = session_user;

  -- if not found try to get system langiage and if not set it to english
  IF NOT FOUND THEN
    BEGIN
      me.message_language = left(system_lc_messages,2)::utility.language;
    EXCEPTION WHEN OTHERS THEN
      me.message_language = 'en'::utility.language;
    END;
  END IF;

  -- search for the message in the system_messages table 
  SELECT t.message 
    INTO _return_message
    FROM unnest(_system_messages) t
   WHERE t.id = _id 
     AND t.language = me.message_language;

  -- if not found  try with english
  IF NOT FOUND THEN

    SELECT t.message 
      INTO _return_message
      FROM unnest(_system_messages) t
     WHERE t.id = _id 
       AND t.language = 'en';
  
    -- if i cannot find it setting a warning
    IF NOT FOUND THEN   
      _return_message = format('*** MESSAGE: %L WAS NOT FOUND in ''system_messages'' table ***',_id );
    END IF;
    
  END IF;

  _return_message = '(' || _id::text || ') ' || _return_message
  
  RETURN;
  
END;
$$;


ALTER FUNCTION utility.system_messages_locale(_system_messages system_message[], _id integer, OUT _return_message text) OWNER TO postgres;

--
-- TOC entry 547 (class 1255 OID 19389)
-- Name: tr_usenames_ex_iu(); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION tr_usenames_ex_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The user proposed wasn'' in the current installation.')::utility.system_message,
    ('en', 2, 'The user: %L wasn''t in the pg_shadow table.')::utility.system_message,
    ('en', 3, 'Probably in specifying the user name was an error, please check the data again and reprocess the operation.')::utility.system_message,
    ('it', 1, 'L''utente indicato non è presente nell''installazione corrente.')::utility.system_message,
    ('it', 2, 'L''utente: %L non è presente nella tabella pg_shadow.')::utility.system_message,
    ('it', 3, 'Probabilmente nello specificare il nome utente è stato compiuto un errore, si prega di ricontrollare i dati e riproporre l''operazione.')::utility.system_message];
BEGIN
  --
  -- Retrieve the name of the funcion
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  --
  -- check user name
  --
  PERFORM 1 
     FROM pg_shadow 
    WHERE usename = new.usename;
    
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.usename),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.usename),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION utility.tr_usenames_ex_iu() OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 19390)
-- Name: url_decode(text); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION url_decode(encode_url text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
	bin bytea = '';
	byte text;
BEGIN
	FOR byte IN (select (regexp_matches(encode_url, '(%..|.)', 'g'))[1]) LOOP
		IF length(byte) = 3 THEN
			bin = bin || decode(substring(byte, 2, 2), 'hex');
		ELSE
			bin = bin || byte::bytea;
		END IF;
	END LOOP;
RETURN convert_from(bin, 'utf8');
END
$$;


ALTER FUNCTION utility.url_decode(encode_url text) OWNER TO postgres;

--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 545
-- Name: FUNCTION url_decode(encode_url text); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION url_decode(encode_url text) IS '<utility>';


--
-- TOC entry 546 (class 1255 OID 19391)
-- Name: where_sequence(text, text, text, bigint); Type: FUNCTION; Schema: utility; Owner: postgres
--

CREATE FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) RETURNS TABLE(catalog_name information_schema.sql_identifier, schema_name information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, times_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$

DECLARE

  results record;
  stack text;
  proname text;
  proargs text;
  prodesc text;

BEGIN 
  IF p_catalog = ''
  OR p_schema = ''
  OR p_sequence = ''
  OR p_value = 0 
  THEN
    GET DIAGNOSTICS stack = PG_CONTEXT;
    SELECT p.proname, pg_get_function_arguments(oid), obj_description(oid,'pg_proc') INTO proname, proargs, prodesc FROM pg_proc p WHERE oid = substring(stack from 'funzione .*? (.*?) riga')::regprocedure::oid; 
    RAISE NOTICE ''; 
    RAISE NOTICE 'SYNTAX ERROR !!! command format is: %s(%s)', proname, proargs; 
    RAISE NOTICE ''; 
    RAISE NOTICE '%', prodesc; 
    RAISE NOTICE ''; 
   RAISE invalid_parameter_value USING MESSAGE = 'Some parameters are missings e/o wrong', HINT = 'Check the parameters and rerun the command';
  END IF;

  catalog_name := p_catalog;
  schema_name := p_schema;
  
  FOR results IN
    SELECT
      columns.table_catalog, 
      columns.table_schema,
      columns.table_name, 
      columns.column_name
    FROM
      information_schema.columns, 
      information_schema.tables
    WHERE
      columns.table_catalog = tables.table_catalog AND
      columns.table_schema = tables.table_schema AND
      columns.table_name = tables.table_name AND
      tables.table_catalog = p_catalog AND 
      tables.table_schema = p_schema AND 
      tables.table_type = 'BASE TABLE' AND 
      columns.column_default =  'nextval(''' || p_sequence || '''::regclass)'
  LOOP
      table_name := results.table_name;
      column_name := results.column_name;
      EXECUTE 'SELECT COUNT(''x'') FROM ' || table_name || ' WHERE ' || column_name || ' = ' || p_value INTO STRICT times_found;
      RETURN NEXT;
  END LOOP;
END;
$$;


ALTER FUNCTION utility.where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) OWNER TO postgres;

--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 546
-- Name: FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint); Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(p_catalog text, p_schema text, p_sequence text, p_value bigint) IS '<utility>
The function takes as input the name of a database, a schema, a sequence and a value of itself and looks in all the columns of all tables of all schemas in the database to find the specified value.
The usage scenario is to a database where all the primary key refer to only one sequence, in this case a value of the sequence is unique in the entire database.
So it can be usefull, starting from a value of the sequence, go back to the table to which it was attributed.';


--
-- TOC entry 2654 (class 2617 OID 759710)
-- Name: +; Type: OPERATOR; Schema: utility; Owner: postgres
--

CREATE OPERATOR + (
    PROCEDURE = number_base34_pl,
    LEFTARG = number_base34,
    RIGHTARG = integer,
    COMMUTATOR = OPERATOR(public.+)
);


ALTER OPERATOR utility.+ (number_base34, integer) OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 19948)
-- Name: enums_values; Type: VIEW; Schema: utility; Owner: postgres
--

CREATE VIEW enums_values AS
 SELECT n.nspname AS schema_name,
    t.typname AS enum_name,
    e.enumlabel AS enum_value
   FROM ((pg_type t
     JOIN pg_enum e ON ((t.oid = e.enumtypid)))
     JOIN pg_namespace n ON ((n.oid = t.typnamespace)));


ALTER TABLE enums_values OWNER TO postgres;

--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 332
-- Name: VIEW enums_values; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW enums_values IS 'List all enum and all related values';


--
-- TOC entry 333 (class 1259 OID 19957)
-- Name: pk_seq; Type: SEQUENCE; Schema: utility; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 19959)
-- Name: sequence_references; Type: VIEW; Schema: utility; Owner: postgres
--

CREATE VIEW sequence_references AS
 SELECT sns.nspname AS sequence_schema_name,
    s.relname AS sequence_name,
    tns.nspname AS reference_schema_name,
    t.relname AS reference_table_name,
    a.attname AS reference_column_name,
    get_max_column_value((tns.nspname)::text, (t.relname)::text, (a.attname)::text) AS max_value
   FROM ((((((pg_class s
     JOIN pg_namespace sns ON ((sns.oid = s.relnamespace)))
     JOIN pg_depend d ON ((d.refobjid = s.oid)))
     JOIN pg_attrdef ad ON ((ad.oid = d.objid)))
     JOIN pg_class t ON ((t.oid = ad.adrelid)))
     JOIN pg_attribute a ON (((a.attrelid = ad.adrelid) AND (a.attnum = ad.adnum))))
     JOIN pg_namespace tns ON ((tns.oid = t.relnamespace)))
  WHERE (s.relkind = 'S'::"char");


ALTER TABLE sequence_references OWNER TO postgres;

--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 334
-- Name: VIEW sequence_references; Type: COMMENT; Schema: utility; Owner: postgres
--

COMMENT ON VIEW sequence_references IS 'List tables and columns where sequences are refererred and his max value';


--
-- TOC entry 3710 (class 0 OID 0)
-- Dependencies: 636
-- Name: count_value(text, text, text); Type: ACL; Schema: utility; Owner: postgres
--

REVOKE ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) FROM PUBLIC;
GRANT ALL ON FUNCTION count_value(search_db text, search_schema text, search_table text) TO scuola247_relative;

