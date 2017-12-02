-- This file is part of Scuola247.
--
-- Scuola247 is free software: you can redistribute it and/or modify it
-- under the terms of the GNU Affero General Public License version 3
-- as published by the Free Software Foundation.
--
-- Scuola247 is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Nome-Programma.  If not, see <http://www.gnu.org/licenses/>.
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: datasets; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA datasets;


ALTER SCHEMA datasets OWNER TO postgres;

SET search_path = datasets, pg_catalog;

CREATE SEQUENCE datasets.pk_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE datasets.pk_seq
  OWNER TO postgres;
COMMENT ON SEQUENCE datasets.pk_seq
  IS 'a sequence for all datasets schema''s primary key';

--
-- Name: entity2char(text); Type: FUNCTION; Schema: datasets; Owner: postgres
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


ALTER FUNCTION datasets.entity2char(t text) OWNER TO postgres;

--
-- Name: FUNCTION entity2char(t text); Type: COMMENT; Schema: datasets; Owner: postgres
--

COMMENT ON FUNCTION entity2char(t text) IS '<utility>';


--
-- Name: entity_coding(); Type: FUNCTION; Schema: datasets; Owner: postgres
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


ALTER FUNCTION datasets.entity_coding() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ip_addresses; Type: TABLE; Schema: datasets; Owner: postgres
--

CREATE TABLE ip_addresses (
    ip_address bigint DEFAULT nextval('datasets.pk_seq'::regclass) NOT NULL,
    from_ip inet NOT NULL,
    to_ip inet NOT NULL,
    country character varying(2) NOT NULL
);


ALTER TABLE ip_addresses OWNER TO postgres;

--
-- Name: TABLE ip_addresses; Type: COMMENT; Schema: datasets; Owner: postgres
--

COMMENT ON TABLE ip_addresses IS 'ip addresses allocate by ripe get from: 
https://db-ip.com/';


--
-- Name: apache2_conf; Type: VIEW; Schema: datasets; Owner: postgres
--

CREATE VIEW apache2_conf AS
 SELECT ('Require ip '::text || inet_merge(ip_addresses.from_ip, ip_addresses.to_ip)) AS command
   FROM ip_addresses
  WHERE ((ip_addresses.country)::text = ANY (ARRAY[('IT'::character varying)::text, ('FR'::character varying)::text, ('DE'::character varying)::text]))
  ORDER BY ip_addresses.country, ip_addresses.from_ip;


ALTER TABLE apache2_conf OWNER TO postgres;

--
-- Name: VIEW apache2_conf; Type: COMMENT; Schema: datasets; Owner: postgres
--

COMMENT ON VIEW apache2_conf IS 'list of statement to put in apache2_conf to allow connection from listed addresses ip';


--
-- Name: entity_coding; Type: TABLE; Schema: datasets; Owner: postgres
--

CREATE TABLE entity_coding (
    entity text NOT NULL,
    coding character(1) NOT NULL
);


ALTER TABLE entity_coding OWNER TO postgres;

--
-- Name: TABLE entity_coding; Type: COMMENT; Schema: datasets; Owner: postgres
--

COMMENT ON TABLE entity_coding IS 'Entities codig are used to implement reserved characters or to express characters that cannot easily be entered with the keyboard.
They include mathematical symbols, Greek characters, various arrows, technical symbols and shapes.';


--
-- Name: ip_addresses_country_list; Type: VIEW; Schema: datasets; Owner: postgres
--

CREATE VIEW ip_addresses_country_list AS
 SELECT DISTINCT ip_addresses.country
   FROM ip_addresses
  ORDER BY ip_addresses.country;


ALTER TABLE ip_addresses_country_list OWNER TO postgres;

--
-- Name: entity_coding entity_coding_pk; Type: CONSTRAINT; Schema: datasets; Owner: postgres
--

ALTER TABLE ONLY entity_coding
    ADD CONSTRAINT entity_coding_pk PRIMARY KEY (entity);


--
-- Name: entity_coding entity_coding_uq_coding; Type: CONSTRAINT; Schema: datasets; Owner: postgres
--

ALTER TABLE ONLY entity_coding
    ADD CONSTRAINT entity_coding_uq_coding UNIQUE (coding);


--
-- Name: ip_addresses ip_addresses_pk; Type: CONSTRAINT; Schema: datasets; Owner: postgres
--

ALTER TABLE ONLY ip_addresses
    ADD CONSTRAINT ip_addresses_pk PRIMARY KEY (ip_address);
