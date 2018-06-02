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

SET search_path = public, pg_catalog;

--
-- Name: address_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE address_type AS ENUM (
    'Domicile',
    'Work',
    'Residence'
);


ALTER TYPE address_type OWNER TO postgres;

--
-- Name: TYPE address_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE address_type IS '<public>';


--
-- Name: course_year; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN course_year AS smallint
	CONSTRAINT course_year_range CHECK (((VALUE >= 1) AND (VALUE <= 6)));


ALTER DOMAIN course_year OWNER TO postgres;

--
-- Name: DOMAIN course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN course_year IS '<public>';


--
-- Name: explanation_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE explanation_type AS ENUM (
    'Absent',
    'Late',
    'Leave'
);


ALTER TYPE explanation_type OWNER TO postgres;

--
-- Name: TYPE explanation_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE explanation_type IS '<public>';


--
-- Name: file_extension; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE file_extension AS ENUM (
    '.json',
    '.exe',
    '.pdf',
    '.txt',
    '.png',
    '.jpg',
    '.bmp',
    '.gif',
    '.html'
);


ALTER TYPE file_extension OWNER TO postgres;

--
-- Name: TYPE file_extension; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE file_extension IS '<public>';


--
-- Name: geographical_area; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE geographical_area AS ENUM (
    'North-west',
    'North-east',
    'Center',
    'South',
    'Islands'
);


ALTER TYPE geographical_area OWNER TO postgres;

--
-- Name: TYPE geographical_area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE geographical_area IS '<public>';


--
-- Name: mime_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE mime_type AS ENUM (
    'application/json',
    'application/octet-stream',
    'application/pdf',
    'text/plain',
    'image/png',
    'image/jpg',
    'image/bmp',
    'image/gif',
    'text/html'
);


ALTER TYPE mime_type OWNER TO postgres;

--
-- Name: TYPE mime_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE mime_type IS '<public>';


--
-- Name: mime_type_image; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN mime_type_image AS mime_type
	CONSTRAINT mime_type_image_list CHECK ((VALUE = ANY (ARRAY['image/png'::mime_type, 'image/jpg'::mime_type, 'image/bmp'::mime_type, 'image/gif'::mime_type])));


ALTER DOMAIN mime_type_image OWNER TO postgres;

--
-- Name: DOMAIN mime_type_image; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN mime_type_image IS '<public>';


--
-- Name: image; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE image AS (
	mime_type mime_type_image,
	content bytea
);


ALTER TYPE image OWNER TO postgres;

--
-- Name: TYPE image; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE image IS '<public>';


--
-- Name: language; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE language AS ENUM (
    'it',
    'en',
    'de'
);


ALTER TYPE language OWNER TO postgres;

--
-- Name: TYPE language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE language IS '<public>';


--
-- Name: marital_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE marital_status AS ENUM (
    'Single',
    'Married',
    'Widowed',
    'Separated'
);


ALTER TYPE marital_status OWNER TO postgres;

--
-- Name: TYPE marital_status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE marital_status IS '<public>';


--
-- Name: period_lesson; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN period_lesson AS smallint
	CONSTRAINT period_lesson_range CHECK (((VALUE >= 1) AND (VALUE <= 24)));


ALTER DOMAIN period_lesson OWNER TO postgres;

--
-- Name: DOMAIN period_lesson; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN period_lesson IS '<public>';


--
-- Name: qualificationtion_types; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE qualificationtion_types AS ENUM (
    'Root',
    'Axis',
    'Expertise',
    'Knowledge',
    'Skill'
);


ALTER TYPE qualificationtion_types OWNER TO postgres;

--
-- Name: TYPE qualificationtion_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE qualificationtion_types IS '<public>';


--
-- Name: relationships; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE relationships AS ENUM (
    'Parent',
    'Brother/Sister',
    'Grandparent',
    'Uncle/Aunt',
    'Tutor'
);


ALTER TYPE relationships OWNER TO postgres;

--
-- Name: TYPE relationships; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE relationships IS '<public>';


--
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE role AS ENUM (
    'Student',
    'Employee',
    'Executive',
    'Teacher',
    'Relative',
    'Supervisor'
);


ALTER TYPE role OWNER TO postgres;

--
-- Name: TYPE role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE role IS '<public>';


--
-- Name: sex; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE sex AS ENUM (
    'M',
    'F'
);


ALTER TYPE sex OWNER TO postgres;

--
-- Name: TYPE sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE sex IS '<public>';


--
-- Name: week; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN week AS smallint
	CONSTRAINT week_range CHECK (((VALUE >= 1) AND (VALUE <= 4)));


ALTER DOMAIN week OWNER TO postgres;

--
-- Name: DOMAIN week; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN week IS '<public>';


--
-- Name: week_day; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN week_day AS smallint
	CONSTRAINT week_day_range CHECK (((VALUE >= 1) AND (VALUE <= 7)));


ALTER DOMAIN week_day OWNER TO postgres;

--
-- Name: DOMAIN week_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON DOMAIN week_day IS '<public>';


--
-- Name: wikimedia_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE wikimedia_type AS ENUM (
    'Female portrait',
    'Male portrait'
);


ALTER TYPE wikimedia_type OWNER TO postgres;

--
-- Name: TYPE wikimedia_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE wikimedia_type IS '<public>';


--
-- Name: pk_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pk_seq OWNER TO postgres;

--
-- Name: SEQUENCE pk_seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON SEQUENCE pk_seq IS 'Sequence shared by all primary key in public schema';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schools (
    school bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(160) NOT NULL,
    processing_code character varying(160) NOT NULL,
    mnemonic character varying(30) NOT NULL,
    example boolean DEFAULT false NOT NULL,
    behavior bigint,
    logo image,
    CONSTRAINT schools_min_description CHECK ((length((description)::text) > 1)),
    CONSTRAINT schools_min_mnemonic CHECK ((length((mnemonic)::text) > 1)),
    CONSTRAINT schools_min_processing_code CHECK ((length((processing_code)::text) > 1))
);


ALTER TABLE schools OWNER TO postgres;

--
-- Name: TABLE schools; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE schools IS 'An institution for the instruction of children or people under college age';


--
-- Name: COLUMN schools.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.school IS 'Uniquely identifies the table row';


--
-- Name: COLUMN schools.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.description IS 'Description for the school';


--
-- Name: COLUMN schools.processing_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.processing_code IS 'A code that identify the school on the government information system';


--
-- Name: COLUMN schools.mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.mnemonic IS 'Short description to be use as code';


--
-- Name: COLUMN schools.example; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.example IS 'It indicates that the data have been inserted to be an example of the use of the data base';


--
-- Name: COLUMN schools.behavior; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.behavior IS 'Indicates the subject used for the behavior';


--
-- Name: COLUMN schools.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools.logo IS 'Picture to be used as a logo';


--
-- Name: schools_enabled(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_enabled() RETURNS bigint[]
    LANGUAGE plpgsql COST 1
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  show_result           TEXT;
 BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 

  show is_superuser INTO me.show_result;

   IF me.show_result = 'on' THEN
    RETURN ARRAY(SELECT school 
                 FROM schools); 
  ELSE
    RETURN ARRAY(SELECT school 
                 FROM usenames_schools
                WHERE usename = current_user); 
  END IF;
  
END;
$$;


ALTER FUNCTION public.schools_enabled() OWNER TO postgres;

--
-- Name: FUNCTION schools_enabled(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_enabled() IS 'Returns enabled schools';


--
-- Name: absences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE absences (
    absence bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    on_date date NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint,
    classroom_student bigint
);


ALTER TABLE absences OWNER TO postgres;

--
-- Name: TABLE absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE absences IS 'Detect the absences of a student.';


--
-- Name: COLUMN absences.absence; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.absence IS 'Unique identification code for the row';


--
-- Name: COLUMN absences.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.on_date IS 'The date when the absence has been done';


--
-- Name: COLUMN absences.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.teacher IS 'The teacher that has validated the absence.';


--
-- Name: COLUMN absences.explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.explanation IS 'Explanation for the absences';


--
-- Name: COLUMN absences.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences.classroom_student IS 'Student of the Classroom with this absence';


--
-- Name: classrooms_students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE classrooms_students (
    classroom_student bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    student bigint NOT NULL,
    retreat_on date,
    classroom_destination bigint
);


ALTER TABLE classrooms_students OWNER TO postgres;

--
-- Name: COLUMN classrooms_students.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.classroom_student IS 'Unique identification code for the row';


--
-- Name: COLUMN classrooms_students.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.classroom IS 'Classroom for these students';


--
-- Name: COLUMN classrooms_students.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.student IS 'Student of the classroom';


--
-- Name: COLUMN classrooms_students.retreat_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.retreat_on IS 'The date when the student has retreated from the classroom, or when he changed to another classroom of the same school, or another one.';


--
-- Name: COLUMN classrooms_students.classroom_destination; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students.classroom_destination IS 'It''s kept the trace about classroom where the student was transfered.';


--
-- Name: absences_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS absences
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE absences_grp OWNER TO postgres;

--
-- Name: VIEW absences_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_grp IS 'Regroup the absences for classroom (also for school year) and student';


--
-- Name: COLUMN absences_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_grp.classroom IS 'Classroom';


--
-- Name: COLUMN absences_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_grp.student IS 'The student with these absences';


--
-- Name: COLUMN absences_grp.absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_grp.absences IS 'Unique identification code for the row';


--
-- Name: absences_not_explanated_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_not_explanated_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS absences
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  WHERE (a.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE absences_not_explanated_grp OWNER TO postgres;

--
-- Name: VIEW absences_not_explanated_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_not_explanated_grp IS 'Regroup the absences for classroom (also for school year) and student but limiting to the lessons not giustified';


--
-- Name: COLUMN absences_not_explanated_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_not_explanated_grp.classroom IS 'Classroom for the absence not explained';


--
-- Name: COLUMN absences_not_explanated_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_not_explanated_grp.student IS 'Student for the absences not explanated';


--
-- Name: COLUMN absences_not_explanated_grp.absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_not_explanated_grp.absences IS 'The absences not explained';


--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE cities (
    city character(4) NOT NULL,
    description character varying(160) NOT NULL,
    district character(2) NOT NULL
);


ALTER TABLE cities OWNER TO postgres;

--
-- Name: TABLE cities; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE cities IS 'Contains all avaible cities';


--
-- Name: COLUMN cities.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cities.city IS 'Unique identification code for the row';


--
-- Name: COLUMN cities.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cities.description IS 'The description for the city';


--
-- Name: COLUMN cities.district; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN cities.district IS 'The district';


--
-- Name: delays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE delays (
    delay bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    classroom_student bigint
);


ALTER TABLE delays OWNER TO postgres;

--
-- Name: TABLE delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE delays IS 'Reveals delays of a student';


--
-- Name: COLUMN delays.delay; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.delay IS 'Unique identification code for the row';


--
-- Name: COLUMN delays.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.teacher IS 'The teacher with these delays';


--
-- Name: COLUMN delays.explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.explanation IS 'explanation for the delay';


--
-- Name: COLUMN delays.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.on_date IS 'The date for the delay';


--
-- Name: COLUMN delays.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.at_time IS 'Date of the delay';


--
-- Name: COLUMN delays.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays.classroom_student IS 'The student that did the delay';


--
-- Name: delays_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS delays
   FROM (delays d
     JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE delays_grp OWNER TO postgres;

--
-- Name: VIEW delays_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_grp IS 'Regroup the delays for classroom (also for school year) and student';


--
-- Name: COLUMN delays_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_grp.classroom IS 'The classroom with these delays';


--
-- Name: COLUMN delays_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_grp.student IS 'Student with that delay';


--
-- Name: COLUMN delays_grp.delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_grp.delays IS 'Unique identification code for the row';


--
-- Name: delays_not_explained_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_not_explained_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS delays
   FROM (delays d
     JOIN classrooms_students cs ON ((cs.classroom_student = d.classroom_student)))
  WHERE (d.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE delays_not_explained_grp OWNER TO postgres;

--
-- Name: VIEW delays_not_explained_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_not_explained_grp IS 'Regroup the delays for classroom (also for school year) and student but limiting to the lessons not giustified';


--
-- Name: COLUMN delays_not_explained_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_not_explained_grp.classroom IS 'The classroom where delay is not explained';


--
-- Name: COLUMN delays_not_explained_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_not_explained_grp.student IS 'Student with these delays not explained';


--
-- Name: COLUMN delays_not_explained_grp.delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_not_explained_grp.delays IS 'List of the delays not explained';


--
-- Name: leavings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE leavings (
    leaving bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    teacher bigint NOT NULL,
    explanation bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    classroom_student bigint
);


ALTER TABLE leavings OWNER TO postgres;

--
-- Name: TABLE leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE leavings IS 'Reveals leavings of a student';


--
-- Name: COLUMN leavings.leaving; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.leaving IS 'Unique identification code for the row';


--
-- Name: COLUMN leavings.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.teacher IS 'The teacher that giustified the leaving';


--
-- Name: COLUMN leavings.explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.explanation IS 'Explanation for the leaving';


--
-- Name: COLUMN leavings.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.on_date IS 'When the leaving has been done';


--
-- Name: COLUMN leavings.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.at_time IS 'When the student left from the classroom';


--
-- Name: COLUMN leavings.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings.classroom_student IS 'Student for the leaving';


--
-- Name: leavings_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS leavings
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE leavings_grp OWNER TO postgres;

--
-- Name: VIEW leavings_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_grp IS 'Regroup the leavings for classroom (also for school year) and student';


--
-- Name: COLUMN leavings_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_grp.classroom IS 'The classroom with these leavings';


--
-- Name: COLUMN leavings_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_grp.student IS 'Student with this leaving';


--
-- Name: COLUMN leavings_grp.leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_grp.leavings IS 'Unique identification code for the row';


--
-- Name: leavings_not_explained_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_not_explained_grp AS
 SELECT cs.classroom,
    cs.student,
    count(cs.student) AS leavings
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  WHERE (l.explanation IS NULL)
  GROUP BY cs.classroom, cs.student;


ALTER TABLE leavings_not_explained_grp OWNER TO postgres;

--
-- Name: VIEW leavings_not_explained_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_not_explained_grp IS 'Regroup the leavings for classroom (also for school year) and student but limiting to the lessons not giustified';


--
-- Name: COLUMN leavings_not_explained_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_not_explained_grp.classroom IS 'The classroom of student who did the leaving';


--
-- Name: COLUMN leavings_not_explained_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_not_explained_grp.student IS 'Student with this leaving not explained';


--
-- Name: COLUMN leavings_not_explained_grp.leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_not_explained_grp.leavings IS 'The leavings not explained';


--
-- Name: notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notes (
    note bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint,
    description character varying(2048) NOT NULL,
    teacher bigint NOT NULL,
    disciplinary boolean NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone NOT NULL,
    to_approve boolean DEFAULT false NOT NULL,
    classroom bigint NOT NULL,
    CONSTRAINT notes_ck_to_approve CHECK ((((disciplinary = false) AND (to_approve = false)) OR ((disciplinary = false) AND (to_approve = true)) OR ((disciplinary = true) AND (to_approve = true))))
);


ALTER TABLE notes OWNER TO postgres;

--
-- Name: COLUMN notes.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.note IS 'Unique identification code for the row';


--
-- Name: COLUMN notes.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.student IS 'The student with these notes';


--
-- Name: COLUMN notes.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.description IS 'The description of the note';


--
-- Name: COLUMN notes.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.teacher IS 'The teacher that insert this note';


--
-- Name: COLUMN notes.disciplinary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.disciplinary IS 'Indicates that the annotation is of disciplinary type so it will be reported at school_record for the view signature of a parent.
The annotation is for all the classroom unless it isn''t indicated a single student.
If it''s needed to do a disciplinary note (also normal) to two or more students is necessary to insert the note for everyone.';


--
-- Name: COLUMN notes.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.on_date IS 'Note insert on date';


--
-- Name: COLUMN notes.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.at_time IS 'When the note was insert';


--
-- Name: COLUMN notes.to_approve; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.to_approve IS 'Indicates that is requested the check from the student (if adult) or from someone that have the paternity authorition and have requested to be warned.
If it isn''t specified the check has to be requested for all the class, but if the note is disciplinary and is missing the student, the check will be requested only for present students';


--
-- Name: COLUMN notes.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes.classroom IS 'Indicates if the note is for all the classroom';


--
-- Name: CONSTRAINT notes_ck_to_approve ON notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT notes_ck_to_approve ON notes IS 'Se è una note disciplinary allat_time deve essere richiesto il visto';


--
-- Name: notes_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_grp AS
 SELECT notes.classroom,
    notes.student,
    count(1) AS notes
   FROM notes
  WHERE (notes.disciplinary = true)
  GROUP BY notes.classroom, notes.student;


ALTER TABLE notes_grp OWNER TO postgres;

--
-- Name: VIEW notes_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_grp IS 'Regroup the noted for classroom (also for school year) and student';


--
-- Name: COLUMN notes_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_grp.classroom IS 'The classroom with the notes';


--
-- Name: COLUMN notes_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_grp.student IS 'Student with this note';


--
-- Name: COLUMN notes_grp.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_grp.notes IS 'All the notes';


--
-- Name: out_of_classrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE out_of_classrooms (
    out_of_classroom bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_operator bigint NOT NULL,
    description character varying(160) NOT NULL,
    on_date date NOT NULL,
    from_time time without time zone NOT NULL,
    to_time time without time zone NOT NULL,
    classroom_student bigint,
    CONSTRAINT out_of_classrooms_ck_to_time CHECK ((to_time > from_time))
);


ALTER TABLE out_of_classrooms OWNER TO postgres;

--
-- Name: TABLE out_of_classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE out_of_classrooms IS 'Indicates when a student isn''t present in classroom but don''t has to be considered absent, example for sports activity';


--
-- Name: COLUMN out_of_classrooms.out_of_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.out_of_classroom IS 'Unique identification code for the row';


--
-- Name: COLUMN out_of_classrooms.school_operator; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.school_operator IS 'School operator with out of classrooms';


--
-- Name: COLUMN out_of_classrooms.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.description IS 'The description for whom out of classroom';


--
-- Name: COLUMN out_of_classrooms.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.on_date IS 'The date when out of classroom';


--
-- Name: COLUMN out_of_classrooms.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.from_time IS 'at_time of leaving';


--
-- Name: COLUMN out_of_classrooms.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.to_time IS 'at_time of return';


--
-- Name: COLUMN out_of_classrooms.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms.classroom_student IS 'The classroom of the student';


--
-- Name: out_of_classrooms_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_grp AS
 SELECT cs.classroom,
    cs.student,
    count(1) AS out_of_classrooms
   FROM (out_of_classrooms ooc
     JOIN classrooms_students cs ON ((cs.classroom_student = ooc.classroom_student)))
  GROUP BY cs.classroom, cs.student;


ALTER TABLE out_of_classrooms_grp OWNER TO postgres;

--
-- Name: VIEW out_of_classrooms_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_grp IS 'Regroup the out of the classroom for classroom (also for school year) and student';


--
-- Name: COLUMN out_of_classrooms_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_grp.classroom IS 'The classroom of these out of classrooms';


--
-- Name: COLUMN out_of_classrooms_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_grp.student IS 'The student that is out of classroom';


--
-- Name: COLUMN out_of_classrooms_grp.out_of_classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_grp.out_of_classrooms IS 'Unique identification code for the row';


--
-- Name: persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons (
    person bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    name character varying(60) NOT NULL,
    surname character varying(60) NOT NULL,
    born date,
    deceased date,
    country_of_birth smallint,
    tax_code character(16),
    sex sex NOT NULL,
    school bigint,
    sidi bigint,
    city_of_birth character(4),
    thumbnail image,
    note text,
    usename name,
    photo image
);


ALTER TABLE persons OWNER TO postgres;

--
-- Name: COLUMN persons.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.person IS 'Unique identification code for the row';


--
-- Name: COLUMN persons.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.name IS 'Name of the person';


--
-- Name: COLUMN persons.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.surname IS 'The surname of this person';


--
-- Name: COLUMN persons.born; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.born IS 'The date when person born';


--
-- Name: COLUMN persons.deceased; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.deceased IS 'Check if the person is deceased';


--
-- Name: COLUMN persons.country_of_birth; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.country_of_birth IS 'Country of birth for the person';


--
-- Name: COLUMN persons.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.tax_code IS 'The tax code for every person';


--
-- Name: COLUMN persons.sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.sex IS 'Sex of the person';


--
-- Name: COLUMN persons.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.school IS 'The school for this person';


--
-- Name: COLUMN persons.sidi; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.sidi IS 'Sidi of the person';


--
-- Name: COLUMN persons.city_of_birth; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.city_of_birth IS 'The city of birth for the person';


--
-- Name: COLUMN persons.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.thumbnail IS 'Thumbnail of the person';


--
-- Name: COLUMN persons.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.note IS 'contains addtional informatio about person';


--
-- Name: COLUMN persons.usename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.usename IS 'The usename of these persons';


--
-- Name: COLUMN persons.photo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons.photo IS 'The photo for these persons';


--
-- Name: classrooms_students_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_students_ex AS
 SELECT ca.classroom,
    ca.student,
    p.thumbnail,
    p.tax_code,
    p.name,
    p.surname,
    p.sex,
    p.born,
    co.description AS city_of_birth_description,
    COALESCE(agrp.absences, (0)::bigint) AS absences,
    COALESCE(anggrp.absences, (0)::bigint) AS absences_not_explained,
    COALESCE(rgrp.delays, (0)::bigint) AS delays,
    COALESCE(rnggrp.delays, (0)::bigint) AS delays_not_explained,
    COALESCE(ugrp.leavings, (0)::bigint) AS leavings,
    COALESCE(unggrp.leavings, (0)::bigint) AS leavings_not_explained,
    COALESCE(fcgrp.out_of_classrooms, (0)::bigint) AS out_of_classrooms,
    COALESCE(ngrp.notes, (0)::bigint) AS notes
   FROM ((((((((((classrooms_students ca
     JOIN persons p ON ((p.person = ca.student)))
     LEFT JOIN cities co ON ((co.city = p.city_of_birth)))
     LEFT JOIN absences_grp agrp ON ((agrp.student = ca.student)))
     LEFT JOIN absences_not_explanated_grp anggrp ON ((anggrp.student = ca.student)))
     LEFT JOIN delays_grp rgrp ON ((rgrp.student = ca.student)))
     LEFT JOIN delays_not_explained_grp rnggrp ON ((rnggrp.student = ca.student)))
     LEFT JOIN leavings_grp ugrp ON ((ugrp.student = ca.student)))
     LEFT JOIN leavings_not_explained_grp unggrp ON ((unggrp.student = ca.student)))
     LEFT JOIN out_of_classrooms_grp fcgrp ON ((fcgrp.student = ca.student)))
     LEFT JOIN notes_grp ngrp ON ((ngrp.student = ca.student)))
  WHERE (p.school = ANY (schools_enabled()));


ALTER TABLE classrooms_students_ex OWNER TO postgres;

--
-- Name: VIEW classrooms_students_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_students_ex IS 'Excract info of every student for classroom and for all schools';


--
-- Name: COLUMN classrooms_students_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.classroom IS 'The classroom of the student';


--
-- Name: COLUMN classrooms_students_ex.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.student IS 'The student of a classroom';


--
-- Name: COLUMN classrooms_students_ex.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.thumbnail IS 'The thumbnail of the student';


--
-- Name: COLUMN classrooms_students_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.tax_code IS 'Tax code of the student';


--
-- Name: COLUMN classrooms_students_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.name IS 'Name of the student';


--
-- Name: COLUMN classrooms_students_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.surname IS 'The surname of the student';


--
-- Name: COLUMN classrooms_students_ex.sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.sex IS 'The sex of the student';


--
-- Name: COLUMN classrooms_students_ex.born; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.born IS 'When the student is born';


--
-- Name: COLUMN classrooms_students_ex.city_of_birth_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.city_of_birth_description IS 'The description of the city of birth';


--
-- Name: COLUMN classrooms_students_ex.absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.absences IS 'Absences of students of the classroom';


--
-- Name: COLUMN classrooms_students_ex.absences_not_explained; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.absences_not_explained IS 'The absences not explained';


--
-- Name: COLUMN classrooms_students_ex.delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.delays IS 'Delays of students of the classroom';


--
-- Name: COLUMN classrooms_students_ex.delays_not_explained; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.delays_not_explained IS 'Delays not explained for the student';


--
-- Name: COLUMN classrooms_students_ex.leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.leavings IS 'Leavings of the student';


--
-- Name: COLUMN classrooms_students_ex.leavings_not_explained; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.leavings_not_explained IS 'Leavings not explained for the classrooms';


--
-- Name: COLUMN classrooms_students_ex.out_of_classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.out_of_classrooms IS 'Unique identification code for the row';


--
-- Name: COLUMN classrooms_students_ex.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_ex.notes IS 'The notes of the students';


SET default_with_oids = false;

--
-- Name: branches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE branches (
    branch bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL
);


ALTER TABLE branches OWNER TO postgres;

--
-- Name: TABLE branches; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE branches IS 'Contains branches for every school';


--
-- Name: COLUMN branches.branch; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN branches.branch IS 'Unique identification code for the row';


--
-- Name: COLUMN branches.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN branches.school IS 'School for branches';


--
-- Name: COLUMN branches.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN branches.description IS 'The description for the branch';


SET default_with_oids = true;

--
-- Name: classrooms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE classrooms (
    classroom bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_year bigint NOT NULL,
    degree bigint NOT NULL,
    section character varying(5),
    course_year course_year NOT NULL,
    description character varying(160) NOT NULL,
    branch bigint NOT NULL
);


ALTER TABLE classrooms OWNER TO postgres;

--
-- Name: TABLE classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE classrooms IS 'Contains all classrooms for every school';


--
-- Name: COLUMN classrooms.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.classroom IS 'Unique identification code for the row';


--
-- Name: COLUMN classrooms.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.school_year IS 'The school year for these classrooms';


--
-- Name: COLUMN classrooms.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.degree IS 'Indicates the degree of a classroom';


--
-- Name: COLUMN classrooms.section; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.section IS 'The section of the classroom';


--
-- Name: COLUMN classrooms.course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.course_year IS 'The course year of the classroom';


--
-- Name: COLUMN classrooms.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.description IS 'Description for the classroom';


--
-- Name: COLUMN classrooms.branch; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms.branch IS 'The branch of the class';


--
-- Name: school_years; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE school_years (
    school_year bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL,
    duration daterange,
    lessons_duration daterange,
    CONSTRAINT school_years_ck_duration CHECK ((duration @> lessons_duration))
);


ALTER TABLE school_years OWNER TO postgres;

--
-- Name: TABLE school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE school_years IS 'Rapreseant the school year and it''s separated by schools';


--
-- Name: COLUMN school_years.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN school_years.school_year IS 'Unique identification code for the row';


--
-- Name: COLUMN school_years.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN school_years.school IS 'School';


--
-- Name: COLUMN school_years.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN school_years.description IS 'The description for the school year';


--
-- Name: COLUMN school_years.duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN school_years.duration IS 'The duration for the school year';


--
-- Name: COLUMN school_years.lessons_duration; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN school_years.lessons_duration IS 'The duration of the lessons';


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE subjects (
    subject bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL
);


ALTER TABLE subjects OWNER TO postgres;

--
-- Name: TABLE subjects; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE subjects IS 'Contains subjects for every school';


--
-- Name: COLUMN subjects.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN subjects.subject IS 'Unique identification code for the row';


--
-- Name: COLUMN subjects.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN subjects.school IS 'The school with these subjects';


--
-- Name: COLUMN subjects.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN subjects.description IS 'The description of a subject';


--
-- Name: valutations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE valutations (
    valutation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    subject bigint NOT NULL,
    grade_type bigint NOT NULL,
    topic bigint,
    grade bigint NOT NULL,
    evaluation character varying(160),
    private boolean DEFAULT false NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    note bigint,
    classroom_student bigint NOT NULL
);


ALTER TABLE valutations OWNER TO postgres;

--
-- Name: TABLE valutations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutations IS 'Contains valutations of all students did by all teachers';


--
-- Name: COLUMN valutations.valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.valutation IS 'Unique identification code for the row';


--
-- Name: COLUMN valutations.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.subject IS 'The subject with these valutations';


--
-- Name: COLUMN valutations.grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.grade_type IS 'The type of grade';


--
-- Name: COLUMN valutations.topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.topic IS 'The topic for these valutations';


--
-- Name: COLUMN valutations.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.grade IS 'The grade for the valutation';


--
-- Name: COLUMN valutations.evaluation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.evaluation IS 'The evaluation';


--
-- Name: COLUMN valutations.private; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.private IS 'Indicates that the grade is visible for only the teacher that has insert it';


--
-- Name: COLUMN valutations.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.teacher IS 'The teacher coloumn has been inserted because the techer during the school year could  be changed, in this mode will be tracked who insert the value';


--
-- Name: COLUMN valutations.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.on_date IS 'When the valutation was insert';


--
-- Name: COLUMN valutations.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations.note IS 'The note associated to the valutation';


--
-- Name: classrooms_teachers_subjects_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_subjects_ex AS
 SELECT i.school,
    i.description AS school_description,
    i.logo,
    a.school_year,
    a.description AS school_year_description,
    p.description AS building_description,
    c.classroom,
    c.degree,
    c.course_year,
    c.description AS classrom_description,
    doc.person AS teacher,
    doc.name,
    doc.surname,
    doc.tax_code,
    m.subject,
    m.description AS subject_description
   FROM ((((((schools i
     JOIN school_years a ON ((i.school = a.school)))
     JOIN classrooms c ON ((a.school_year = c.school_year)))
     JOIN ( SELECT DISTINCT cs.classroom,
            v.teacher,
            v.subject
           FROM (valutations v
             JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))) cdm ON ((cdm.classroom = c.classroom)))
     JOIN branches p ON ((c.branch = p.branch)))
     JOIN persons doc ON ((doc.person = cdm.teacher)))
     JOIN subjects m ON ((m.subject = cdm.subject)));


ALTER TABLE classrooms_teachers_subjects_ex OWNER TO postgres;

--
-- Name: VIEW classrooms_teachers_subjects_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_teachers_subjects_ex IS 'Exctract all subject for every teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.school IS 'The school';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.school_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.school_description IS 'The description for the school';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.logo IS 'Logo for the subject';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.school_year IS 'School year for the teachers';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.school_year_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.school_year_description IS 'Description for the school year';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.building_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.building_description IS 'The building description';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.degree IS 'The degree for the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.course_year IS 'Course year for the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.classrom_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.classrom_description IS 'The classroom description';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.teacher IS 'The teacher with these subjects';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.name IS 'The name of the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.surname IS 'The surname of the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.tax_code IS 'Tax code of the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.subject IS 'Subject for the teacher';


--
-- Name: COLUMN classrooms_teachers_subjects_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subjects_ex.subject_description IS 'Subject description';


--
-- Name: classrooms_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_ex WITH (security_barrier='true') AS
 SELECT s.school,
    s.description AS school_description,
    s.logo,
    sy.school_year,
    sy.description AS school_year_description,
    b.description AS building_description,
    c.classroom,
    c.description AS classrom_description
   FROM (((schools s
     JOIN school_years sy ON ((sy.school = s.school)))
     JOIN classrooms c ON ((c.school_year = sy.school_year)))
     JOIN branches b ON ((b.branch = c.branch)))
  WHERE (s.school = ANY (schools_enabled()));


ALTER TABLE classrooms_ex OWNER TO postgres;

--
-- Name: VIEW classrooms_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_ex IS 'Exctract info of every class for all schools';


--
-- Name: COLUMN classrooms_ex.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.school IS 'The school of the classroom';


--
-- Name: COLUMN classrooms_ex.school_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.school_description IS 'The school description for the classroom';


--
-- Name: COLUMN classrooms_ex.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.logo IS 'The logo for the classroom';


--
-- Name: COLUMN classrooms_ex.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.school_year IS 'School year for the classroom';


--
-- Name: COLUMN classrooms_ex.school_year_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.school_year_description IS 'Description of the school year';


--
-- Name: COLUMN classrooms_ex.building_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.building_description IS 'The description of the build';


--
-- Name: COLUMN classrooms_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.classroom IS 'Unique identification code for the row';


--
-- Name: COLUMN classrooms_ex.classrom_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_ex.classrom_description IS 'The classroom description';


--
-- Name: weekly_timetables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE weekly_timetables (
    weekly_timetable bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    description character varying(160)
);


ALTER TABLE weekly_timetables OWNER TO postgres;

--
-- Name: TABLE weekly_timetables; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE weekly_timetables IS 'Contains the weekly timetables for every school';


--
-- Name: COLUMN weekly_timetables.weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables.weekly_timetable IS 'Unique identification code for the row';


--
-- Name: COLUMN weekly_timetables.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables.classroom IS 'The classroom with this weekly timetable';


--
-- Name: COLUMN weekly_timetables.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables.description IS 'The description for the weekly timetable';


--
-- Name: weekly_timetables_days; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE weekly_timetables_days (
    weekly_timetable_day bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    weekly_timetable bigint NOT NULL,
    weekday utility.week_day NOT NULL,
    teacher bigint,
    subject bigint,
    team_teaching smallint DEFAULT 1 NOT NULL,
    from_time time(0) without time zone NOT NULL,
    to_time time(0) without time zone NOT NULL,
    CONSTRAINT weekly_timetables_days_ck_teacher_subject CHECK (((teacher IS NOT NULL) OR (subject IS NOT NULL)))
);


ALTER TABLE weekly_timetables_days OWNER TO postgres;

--
-- Name: COLUMN weekly_timetables_days.weekly_timetable_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.weekly_timetable_day IS 'Unique identification code for the row';


--
-- Name: COLUMN weekly_timetables_days.weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.weekly_timetable IS 'Unique identification code for the row';


--
-- Name: COLUMN weekly_timetables_days.weekday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.weekday IS 'Weekday for the timetable';


--
-- Name: COLUMN weekly_timetables_days.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.teacher IS 'Teacher for the weekly timetable';


--
-- Name: COLUMN weekly_timetables_days.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.subject IS 'Subject in the weekly timetable';


--
-- Name: COLUMN weekly_timetables_days.team_teaching; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.team_teaching IS 'Indicates the amount of team_teaching (1 first teacher, 2 second teacher ecc.) if there''s only a teacher you have to insert 1';


--
-- Name: COLUMN weekly_timetables_days.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.from_time IS 'When the weekly timetable starts';


--
-- Name: COLUMN weekly_timetables_days.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days.to_time IS 'Time when the timetable finish';


--
-- Name: CONSTRAINT weekly_timetables_days_ck_teacher_subject ON weekly_timetables_days; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT weekly_timetables_days_ck_teacher_subject ON weekly_timetables_days IS 'Almeno uno dei campi tra teacher e subject deve essere compilato.';


--
-- Name: weekly_timetables_days_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetables_days_ex AS
 SELECT c.classroom,
    os.weekly_timetable,
    os.description AS weekly_timetable_description,
    osg.weekly_timetable_day,
    osg.weekday,
    utility.day_name(osg.weekday) AS name_weekday,
    ((to_char((('now'::text)::date + osg.from_time), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.to_time), ((('HH24:MI'::text || ' ('::text) || (osg.team_teaching)::text) || ')'::text))) AS period,
    (((p.name)::text || ' '::text) || (p.surname)::text) AS teacher_name_surname,
    p.thumbnail AS teacher_thumbnail,
    m.description AS subject_description
   FROM (((((school_years a
     JOIN classrooms c ON ((c.school_year = a.school_year)))
     JOIN weekly_timetables os ON ((os.classroom = c.classroom)))
     JOIN weekly_timetables_days osg ON ((osg.weekly_timetable = os.weekly_timetable)))
     JOIN persons p ON ((p.person = osg.teacher)))
     LEFT JOIN subjects m ON ((m.subject = osg.subject)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetables_days_ex OWNER TO postgres;

--
-- Name: VIEW weekly_timetables_days_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW weekly_timetables_days_ex IS 'Extract every info for every day of weekly timetable';


--
-- Name: COLUMN weekly_timetables_days_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.classroom IS 'Classroom with these weekly timetables';


--
-- Name: COLUMN weekly_timetables_days_ex.weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.weekly_timetable IS 'The weekly timetable';


--
-- Name: COLUMN weekly_timetables_days_ex.weekly_timetable_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.weekly_timetable_description IS 'Description for the weekly timetable';


--
-- Name: COLUMN weekly_timetables_days_ex.weekly_timetable_day; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.weekly_timetable_day IS 'Unique identification code for the row';


--
-- Name: COLUMN weekly_timetables_days_ex.weekday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.weekday IS 'Weekday of the weekly timetable';


--
-- Name: COLUMN weekly_timetables_days_ex.name_weekday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.name_weekday IS 'The name of the weekday';


--
-- Name: COLUMN weekly_timetables_days_ex.period; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.period IS 'Period of the weekly timetable';


--
-- Name: COLUMN weekly_timetables_days_ex.teacher_name_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.teacher_name_surname IS 'The name and surname of the teacher';


--
-- Name: COLUMN weekly_timetables_days_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.teacher_thumbnail IS 'The teacher thumbnail';


--
-- Name: COLUMN weekly_timetables_days_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetables_days_ex.subject_description IS 'The description of the subject';


--
-- Name: weekly_timetable_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetable_ex AS
 SELECT c.classroom,
    os.weekly_timetable,
    os.description AS weekly_timetable_description
   FROM ((weekly_timetables os
     JOIN classrooms c ON ((os.classroom = c.classroom)))
     JOIN school_years a ON ((c.school_year = a.school_year)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetable_ex OWNER TO postgres;

--
-- Name: VIEW weekly_timetable_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW weekly_timetable_ex IS 'Extract every weekly timetable for every class';


--
-- Name: COLUMN weekly_timetable_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_ex.classroom IS 'The classroom';


--
-- Name: COLUMN weekly_timetable_ex.weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_ex.weekly_timetable IS 'The weekly timetable';


--
-- Name: COLUMN weekly_timetable_ex.weekly_timetable_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_ex.weekly_timetable_description IS 'The description for the weekly timetable';


--
-- Name: cities_lookup(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION cities_lookup(_city character, OUT _cities cities) RETURNS cities
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''cities'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''cities'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _city IS NULL THEN
    _cities = NULL;
  ELSE
    SELECT city, district, description
    INTO _cities.city, _cities.district, _cities.description
    FROM cities
    WHERE city = _city;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _city),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.cities_lookup(_city character, OUT _cities cities) OWNER TO postgres;

--
-- Name: classroom_students_ex(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classroom_students_ex(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context		text;
  full_function_name	varchar;
BEGIN 
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  OPEN cur FOR SELECT classroom,
  	              student,
		      COALESCE(thumbnail,thumbnail_default()) as thumbnail,
		      tax_code,
		      name,
		      surname,
		      sex,
		      born,
		      city_of_birth_description,
		      absences,
		      absences_not_explained,
		      delays,
		      delays_not_explained,
		      leavings,
		      leavings_not_explained,
		      out_of_classrooms,
		      notes
	         FROM classrooms_students_ex
		WHERE classroom = p_classroom
	     ORDER BY surname, name, tax_code;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.classroom_students_ex(p_classroom bigint) OWNER TO postgres;

--
-- Name: classrooms_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_list(p_school_year bigint) RETURNS refcursor
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>			 
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  OPEN cur FOR SELECT xmin::text::bigint AS rv, classroom, school_year, degree, section, course_year, description, branch
                 FROM classrooms
                WHERE school_year = p_school_year
	     ORDER BY description;
  RETURN cur;
  
END;
$$;


ALTER FUNCTION public.classrooms_list(p_school_year bigint) OWNER TO postgres;

--
-- Name: classrooms_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_lookup(_classroom integer, OUT _classrooms classrooms) RETURNS classrooms
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _classrooms = classrooms_lookup(_classroom::bigint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.classrooms_lookup(_classroom integer, OUT _classrooms classrooms) OWNER TO postgres;

--
-- Name: classrooms_lookup(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_lookup(_classroom bigint, OUT _classrooms classrooms) RETURNS classrooms
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''classrooms'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''classrooms'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _classroom IS NULL THEN
    _classrooms = NULL;
  ELSE
    SELECT classroom, school_year, degree, section, course_year, description, branch
    INTO _classrooms.classroom, _classrooms.school_year, _classrooms.degree, _classrooms.section, _classrooms.course_year, _classrooms.description, _classrooms.branch
    FROM classrooms
    WHERE classroom = _classroom;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.classrooms_lookup(_classroom bigint, OUT _classrooms classrooms) OWNER TO postgres;

--
-- Name: classrooms_students_addresses_ex_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION classrooms_students_addresses_ex_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT classroom,
                      student,
                      name,
                      surname,
                      tax_code,
                      sex,
                      born,
                      city_of_birth,
                      street,
                      zip_code,
                      city,
                      province,
                      absences
		 FROM classrooms_students_addresses_ex
		WHERE classroom = p_classroom
	     ORDER BY surname, name, tax_code;
 RETURN cur;	            
END;
$$;


ALTER FUNCTION public.classrooms_students_addresses_ex_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- Name: current_persons(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION current_persons() RETURNS bigint[]
    LANGUAGE plpgsql
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  -- 
  -- return the person connect by current_user
  --
      
  RETURN ARRAY(SELECT p.person
                 FROM usenames_schools us
                 JOIN persons p ON p.usename = us.usename AND p.school = us.school 
                WHERE us.usename = current_user);
END;
$$;


ALTER FUNCTION public.current_persons() OWNER TO postgres;

--
-- Name: districts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE districts (
    district character(2) NOT NULL,
    description character varying(160) NOT NULL,
    region smallint
);


ALTER TABLE districts OWNER TO postgres;

--
-- Name: TABLE districts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE districts IS 'Contains all avaible districts';


--
-- Name: COLUMN districts.district; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN districts.district IS 'Unique identification code for the row';


--
-- Name: COLUMN districts.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN districts.description IS 'Unique identification code for the row';


--
-- Name: COLUMN districts.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN districts.region IS 'The region';


--
-- Name: districts_lookup(character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION districts_lookup(_district character, OUT _districts districts) RETURNS districts
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''districts'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''districts'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _district IS NULL THEN
    _districts = NULL;
  ELSE
    SELECT district, region, description
    INTO _districts.district, _districts.region, _districts.description
    FROM districts
    WHERE district = _district;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _district),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.districts_lookup(_district character, OUT _districts districts) OWNER TO postgres;

--
-- Name: file_extension(mime_type); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION file_extension(p_mime_type mime_type) RETURNS file_extension
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */	
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
    system_messages   utility.system_message[] = ARRAY[
   ('en', 1, 'Cast error')::utility.system_message,
   ('en', 2, 'Cannot cast value: ''%s'' to data type ''file_extension'' because it isn''t in the conversion rule')::utility.system_message,
   ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,   
   ('it', 1, 'Errore di conversione')::utility.system_message,
   ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo dato: ''file_extension'' perchè non è previsto dalla regola di conversione ')::utility.system_message,   
   ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];   
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  CASE p_mime_type
    WHEN 'application/json' THEN RETURN '.json'::file_extension;
    WHEN 'application/octet-stream' THEN RETURN '.exe'::file_extension;
    WHEN 'application/pdf' THEN RETURN '.pdf'::file_extension;
    WHEN 'text/plain' THEN RETURN '.txt'::file_extension;
    WHEN 'image/png' THEN RETURN '.png'::file_extension;
    WHEN 'image/jpg' THEN RETURN '.jpg'::file_extension;
    WHEN 'image/bmp' THEN RETURN '.bmp'::file_extension;
    WHEN 'image/gif' THEN RETURN '.gif'::file_extension;
    WHEN 'text/html' THEN RETURN '.html'::file_extension;
    WHEN NULL THEN RETURN NULL::file_extension;
    ELSE RAISE EXCEPTION USING
           ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
           MESSAGE = utility.system_messages_locale(system_messages,1),
           DETAIL = format(utility.system_messages_locale(system_messages,2), p_mime_type),
           HINT = utility.system_messages_locale(system_messages,3);
  END CASE;
END;
$$;


ALTER FUNCTION public.file_extension(p_mime_type mime_type) OWNER TO postgres;

--
-- Name: FUNCTION file_extension(p_mime_type mime_type); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION file_extension(p_mime_type mime_type) IS 'Cast to file_extension from mime_type';


--
-- Name: grade_types_by_subject(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grade_types_by_subject(p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
   OPEN cur FOR SELECT xmin::text::bigint AS rv,
		       grade_type,
		       description
		  FROM grade_types
		 WHERE subject = p_subject
	      ORDER BY description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grade_types_by_subject(p_subject bigint) OWNER TO postgres;

--
-- Name: FUNCTION grade_types_by_subject(p_subject bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION grade_types_by_subject(p_subject bigint) IS '<public>';


--
-- Name: grades_by_metric(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grades_by_metric(p_metric bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT xmin::text::bigint AS rv,
		      grade,
		      metric,
		      description,
		      mnemonic,
		      thousandths
		 FROM grades
		WHERE metric = p_metric
	     ORDER BY thousandths;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grades_by_metric(p_metric bigint) OWNER TO postgres;

--
-- Name: grid_valutations_columns_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT DISTINCT va.on_date AS on_date,
			       va.grade_type AS grade_type,
                               tv.description AS grade_type_description,
                               COALESCE(a.topic,0) AS topic,
			       COALESCE(a.description,'') AS topic_description,
                               m.metric as metric,
                               m.description AS metric_description
                          FROM valutations va
                          JOIN classrooms_students cs ON cs.classroom_student = va.classroom_student
	             LEFT JOIN topics a ON a.topic = va.topic 
			  JOIN grade_types tv ON tv.grade_type = va.grade_type
			  JOIN grades vo ON vo.grade = va.grade
			  JOIN metrics m ON m.metric = vo.metric
			 WHERE cs.classroom = p_classroom
			   AND va.teacher = p_teacher
			   AND va.subject = p_subject
		      ORDER BY on_date, grade_type_description, topic, metric;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.grid_valutations_columns_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- Name: grid_valutations_rows_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS TABLE(student bigint, surname character varying, name character varying, absences integer, delays integer, leavings integer, out_of_classroom integer, notes integer, faults integer, behavior character varying, rvs bigint[], valutations bigint[], grades bigint[])
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  v_days 		character varying[];
  v_student 		record;
  v_valutation 		record;
  v_grading_meeting 	bigint;
  v_behavior 		bigint;
  v_school_year 	bigint;
  i 			integer;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  v_days :=  ARRAY( SELECT DISTINCT va.on_date || to_char(va.grade_type,'0000000000000000000') || to_char(COALESCE(va.topic,0),'0000000000000000000')  || to_char(vo.metric,'0000000000000000000')
			       FROM valutations va
			       JOIN classrooms_students cs ON cs.classroom_student = va.classroom_student
			       JOIN grades vo ON vo.grade = va.grade 
			      WHERE cs.classroom = p_classroom
			        AND va.teacher = p_teacher
			        AND va.subject = p_subject
		           ORDER BY 1);
  SELECT i.behavior INTO v_behavior
    FROM schools i
    JOIN subjects m ON m.school = i.school
   WHERE subject = p_subject;
  SELECT school_year INTO v_school_year
    FROM classrooms
   WHERE classroom = p_classroom;
  SELECT grading_meeting into v_grading_meeting
    FROM grading_meetings
   WHERE school_year = v_school_year
     AND on_date IN (SELECT MAX(on_date) 
		  FROM grading_meetings
		 WHERE school_year = v_school_year
		   AND closed = true);
   		           
  FOR v_student IN SELECT p.person AS student,
	                 p.surname AS surname,
		         p.name AS name,
		         COALESCE(a.absences,0) AS absences,
		         COALESCE(r.delays,0) AS delays,
		         COALESCE(u.leavings,0) AS leavings,
		         COALESCE(fc.out_of_classrooms,0) AS out_of_classroom,
		         COALESCE(n.notes,0) AS notes,
		         COALESCE(m.faults,0) AS faults,
		         COALESCE(v.mnemonic,'N/D') AS behavior
	          FROM classrooms_students ca 
	          JOIN persons p ON ca.student = p.person
	          LEFT JOIN absences_grp a ON a.classroom = ca.classroom AND a.student = ca.student
	          LEFT JOIN delays_grp r ON r.classroom = ca.classroom AND r.student = ca.student
	          LEFT JOIN leavings_grp u ON u.classroom = ca.classroom AND u.student = ca.student
	          LEFT JOIN out_of_classrooms_grp fc ON fc.classroom = ca.classroom AND fc.student = ca.student
	          LEFT JOIN notes_grp n ON n.classroom = ca.classroom AND n.student = ca.student
	          LEFT JOIN faults_grp m ON m.classroom = ca.classroom AND m.student = ca.student
	          LEFT JOIN (SELECT svi.classroom, svi.student, svi.grade 
	                       FROM grading_meetings_valutations svi
	                      WHERE svi.grading_meeting = v_grading_meeting
				AND svi.subject = v_behavior) AS sv ON sv.classroom = ca.classroom AND sv.student = ca.student
	          LEFT JOIN grades v ON v.grade = sv.grade
	         WHERE ca.classroom = p_classroom
	       ORDER BY p.surname, p.name, p.tax_code
  LOOP
	student := v_student.student;
	surname := v_student.surname;
	name := v_student.name;
	absences := v_student.absences;
	delays := v_student.delays;
	leavings := v_student.leavings;
	out_of_classroom := v_student.out_of_classroom;
	notes := v_student.notes;
	faults := v_student.faults;
	behavior := v_student.behavior;
	rvs := null;
        valutations := null;
	grades := null;
	i := 1;
	RAISE NOTICE 'student... : % % %', v_student.student, v_student.surname, v_student.name;
	RAISE NOTICE 'i-------------------... : %', i;
	FOR v_valutation IN SELECT va.on_date || to_char(va.grade_type,'0000000000000000000') || to_char(COALESCE(va.topic,0),'0000000000000000000') || to_char(vo.metric,'0000000000000000000')  AS on_date ,
				    va.xmin::text::bigint AS rv,
				    va.valutation,
	                            va.grade
	                       FROM valutations va
	                       JOIN classrooms_students cs ON cs.classroom_student = va.classroom_student
	                       JOIN grades vo ON vo.grade = va.grade
	                      WHERE cs.classroom = p_classroom
	                        AND va.subject = p_subject
	                        AND va.teacher = p_teacher
	                        AND cs.student = v_student.student
	                   ORDER BY 1
	LOOP    
		RAISE NOTICE 'v_valutation.on_date... : %', v_valutation.on_date;
		RAISE NOTICE 'v_days[i]............ : %', v_days[i];
		
		WHILE v_days[i] < v_valutation.on_date AND i <= array_length(v_days,1) LOOP
			rvs[i] = null;
			valutations[i] = null;
			grades[i] = null;
			RAISE NOTICE '(a) v_days[i]............ : %', v_days[i];
			RAISE NOTICE 'i.......................... : %', i;
			i := i + 1;
		END LOOP;
		IF i <= array_length(v_days,1) THEN
			rvs[i] = v_valutation.rv;
			valutations[i] = v_valutation.valutation;
			grades[i] = v_valutation.grade;
			RAISE NOTICE '(b) v_valutation.on_date... : %', v_valutation.on_date;
			RAISE NOTICE '(b) v_days[i]............ : %', v_days[i];
			RAISE NOTICE 'i.......................... : %', i;
			i := i + 1;
		END IF;
	END LOOP;
	WHILE i <= array_length(v_days,1) LOOP
		RAISE NOTICE '(c) v_days[i]............ : %', v_days[i];
		RAISE NOTICE 'i.......................... : %', i;
		rvs[i] = null;
		valutations[i] = null;
		grades[i] = null;
		i := i +1;
	END LOOP;
	RETURN NEXT;
  END LOOP;	        
END;
$$;


ALTER FUNCTION public.grid_valutations_rows_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- Name: in_any_roles(role[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_any_roles(VARIADIC _roles role[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  -- 
  -- Check that the db_user of the current session is one of the roles indicated in the array
  --
  -- example in use: is_session_user_enable_to_any('{"Supervisor","Executive","Teacher"}')
  --	
  PERFORM 1
     FROM persons_roles pr
     JOIN persons p ON p.person = pr.person 
    WHERE p.usename = session_user
      AND pr.role = ANY(_roles);
      
  RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_any_roles(VARIADIC _roles role[]) OWNER TO postgres;

--
-- Name: in_any_roles(bigint, role[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_any_roles(_person bigint, VARIADIC _roles role[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- 
  -- Check that the db_user of the current session is one of the roles indicated in the array
  --
  -- example in use: is_session_user_enable_to_any('{"Supervisor","Executive","Teacher"}')
  --	
  PERFORM 1
     FROM persons_roles pr
    WHERE pr.person = _person
      AND pr.role = ANY(_roles);
      
  RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_any_roles(_person bigint, VARIADIC _roles role[]) OWNER TO postgres;

--
-- Name: in_any_roles(character varying, role[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION in_any_roles(_usename character varying, VARIADIC _roles role[]) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  PERFORM 1 FROM persons p 
            JOIN persons_roles pr ON pr.person = p.person 
           WHERE p.usename = _usename::name
             AND pr.role = ANY(_roles);
             
  RETURN FOUND;
END;
$$;


ALTER FUNCTION public.in_any_roles(_usename character varying, VARIADIC _roles role[]) OWNER TO postgres;

--
-- Name: italian_fiscal_code(character varying, character varying, sex, date, smallint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
<<me>>
DECLARE
  context 		text;
  message_text 	text;
  full_function_name 	text;
  month_letters 	char[] := array['A','B','C','D','E','H','L','M','P','R','S','T']; -- 0=Jan, 1=Feb, 2=Mar, Etc ...
  check_chars 	char[] := array[ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']; -- character 
  check_values 	smallint[][] := array[['1', '0', '5', '7', '9','13','15','17','19','21', '1', '0', '5', '7', '9','13','15','17','19','21', '2', '4','18','20','11', '3', '6', '8','12','14','16','10','22','25','24','23'],  -- odd position value
                                     ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '1', '2', '3', '4', '5', '6', '7', '8' ,'9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25']]; -- even position value       
  check_alphabet 	char[] := array['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];  
  buffer 		varchar := '';
  fiscal_code 	varchar(16) := '';
  i 			int := 0;
  check_digit 	int := 0;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'the parameter: ''name'' is mandatory')::utility.system_message,
    ('en', 2, 'the parameter: ''surname'' is mandatory')::utility.system_message,
    ('en', 3, 'the parameter: ''sex'' is mandatory')::utility.system_message,
    ('en', 4, 'the parameter: ''birthday'' is mandatory')::utility.system_message,
    ('en', 5, 'The parameters: ''city_of_birth'' and  ''country_of_birth'' are both NULL but one (AND ONLY ONE) of them is mandatory')::utility.system_message,
    ('en', 6, 'The parameters: ''city_of_birth'' and ''country_of_birth'' have been specified but only one is mandatory the other have to be NULL')::utility.system_message,
    ('it', 1, 'Il parametro; ''name'' è obbligatorio')::utility.system_message,
    ('it', 2, 'Il parametro: ''surname'' è obbligatorio')::utility.system_message,
    ('it', 3, 'Il parametro: ''sex'' è obbligatorio')::utility.system_message,
    ('it', 4, 'Il parametro: ''birthday'' è obbligatorio')::utility.system_message,
    ('it', 5, 'Il parametro: ''city_of_birth'' e ''country_of_birth'' sono entrambi a NULL ma uno (E SOLO UNO) di questi è obbligatorio')::utility.system_message,
    ('it', 6, 'Il parametro: ''city_of_birth'' e il parametro ''country_of_birth'' sono stati specificati, ma solo uno è necessario l''altro deve essere NULL')::utility.system_message];
BEGIN
 GET DIAGNOSTICS me.context = PG_CONTEXT;
 full_function_name = diagnostic.full_function_name(me.context);
  -- controllo parametri
  -- name is mandatory
  IF _name IS NULL THEN
    message_text = utility.system_messages_locale(system_messages ,1);
    PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
  END IF;
  -- surname is mandatory
  IF _surname IS NULL THEN
    message_text = utility.system_messages_locale(system_messages ,2);
    PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
  END IF; 
    
  -- sex is mandatory
  IF _sex IS NULL THEN
    message_text = utility.system_messages_locale(system_messages ,3);
    PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
  END IF;  
   
  -- birthday is mandatory
  IF _birthday IS NULL THEN
    message_text = utility.system_messages_locale(system_messages ,4);
    PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
  END IF;    
  -- EITHER country_of_birth OR city_of birth is mandatory
  --i cannot have both 
  IF _country_of_birth IS NOT NULL THEN
    IF _city_of_birth IS NOT NULL THEN
      message_text = utility.system_messages_locale(system_messages ,5);
      PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
    END IF;  
  END IF;  
  --but i cannot have both NULL
  IF _country_of_birth IS NULL THEN
    IF _city_of_birth IS NULL THEN
      message_text = utility.system_messages_locale(system_messages ,6);
      PERFORM diagnostic.function_syntax_error(full_function_name,message_text);
    END IF;  
  END IF;  
     
  -- calcolate surname
  _surname := translate(upper(_surname),'0123456789\/!|"£$%&()=?^*+-_.,:;@#ç°§[]{}<>''  ','');
  _surname := translate(_surname,'òàùèéì','OAUEEI');
  buffer := translate(_surname, 'AEIOU', '');
  buffer := buffer || translate(_surname, 'BCDFGHJKLMNPQRSTVWXYZ','');
  buffer := buffer || 'XXX';
  fiscal_code := left(buffer, 3);
  -- calcolate name
  _name := translate(upper(_name),'0123456789\/!|"£$%&()=?^*+-_.,:;@#ç°§[]{}<>''  ','');
  _name := translate(_name,'òàùèéì','OAUEEI');
  buffer = translate(upper(_name), 'AEIOU', '');
  IF length(buffer) > 3 THEN
     buffer = left(buffer,1) || right(buffer, length(buffer)-2); 
  END IF;
  buffer := buffer || translate(_name, 'BCDFGHJKLMNPQRSTVWXYZ','');
  buffer := buffer || 'XXX';
  fiscal_code := fiscal_code || left(buffer, 3);
  -- calcolate year birthday
  fiscal_code := fiscal_code || to_char(_birthday, 'YY');
  -- calcolate month birthday
  fiscal_code := fiscal_code || month_letters[to_number(to_char(_birthday, 'MM'), '99')];
  -- calcolate day birthday
  IF _sex = 'M' THEN
    fiscal_code := fiscal_code || to_char(_birthday, 'DD');
  ELSE
    fiscal_code := fiscal_code || trim(to_char(to_number(to_char(_birthday, 'DD'), '99') + 40, '99'));
  END IF;
  -- calcolate place of birth
  IF _country_of_birth IS NULL THEN
    fiscal_code := fiscal_code || _city_of_birth;
  ELSE
    fiscal_code := fiscal_code || 'Z' || _country_of_birth;
  END IF;
  --- check digit
  WHILE i < length(fiscal_code)
    LOOP
      i = i + 1;
        check_digit := check_digit + check_values[((i + 1) % 2) + 1][array_position(check_chars, substring(fiscal_code from i for 1)::char)];
      END LOOP;
  fiscal_code = fiscal_code || check_alphabet[(check_digit % 26) + 1];
  RETURN fiscal_code;
END;
$_$;


ALTER FUNCTION public.italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying) OWNER TO postgres;

--
-- Name: FUNCTION italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION italian_fiscal_code(_name character varying, _surname character varying, _sex sex, _birthday date, _country_of_birth smallint, _city_of_birth character varying) IS 'Generate the italian fiscal code';


--
-- Name: lessons_by_teacher_classroom_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  OPEN cur FOR SELECT substitute,
		      on_date,
		      from_time,
		      to_time,
		      description
		 FROM lessons
		WHERE teacher = p_teacher
		  AND classroom = p_classroom
	          AND subject = p_subject
	     ORDER BY on_date, from_time;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.lessons_by_teacher_classroom_subject(p_teacher bigint, p_classroom bigint, p_subject bigint) OWNER TO postgres;

--
-- Name: login(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION login(_username text, _password text) RETURNS text
    LANGUAGE plpgsql
    AS $$
	
DECLARE

BEGIN 

  RETURN 'user: ' || _username || ' password: ' || _password;
  
END;
$$;


ALTER FUNCTION public.login(_username text, _password text) OWNER TO postgres;

--
-- Name: metrics_by_school(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION metrics_by_school(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT xmin::text::bigint AS rv,
  		      metric,
		      description
		 FROM metrics
		WHERE school = p_school
	     ORDER BY description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.metrics_by_school(p_school bigint) OWNER TO postgres;

--
-- Name: mime_type(file_extension); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION mime_type(p_file_extension file_extension) RETURNS mime_type
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (14:42:15 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */	
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''mime_type'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo dato: ''mime_type'' perchè non è previsto dalla regola di conversione ')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);  

  CASE p_file_extension
  
    WHEN '.json' THEN RETURN 'application/json'::mime_type;
--    WHEN '.json' THEN RETURN 'application/pdf'::mime_type;
    WHEN '.exe' THEN RETURN 'application/octet-stream'::mime_type;
    WHEN '.pdf' THEN RETURN 'application/pdf'::mime_type;
    WHEN '.txt' THEN RETURN 'text/plain'::mime_type;
    WHEN '.png' THEN RETURN 'image/png'::mime_type;
    WHEN '.jpg' THEN RETURN 'image/jpg'::mime_type;
--    WHEN '.jpg' THEN RETURN 'image/xxx'::mime_type;
    WHEN '.bmp' THEN RETURN 'image/bmp'::mime_type;
    WHEN '.gif' THEN RETURN 'image/gif'::mime_type;
    WHEN '.html' THEN RETURN 'text/html'::mime_type;
    WHEN NULL THEN RETURN NULL::mime_type;
       ELSE RAISE EXCEPTION USING
           ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
           MESSAGE = utility.system_messages_locale(system_messages,1),
           DETAIL = format(utility.system_messages_locale(system_messages,2), p_file_extension),
           HINT = utility.system_messages_locale(system_messages,3);
  END CASE;
END;
$$;


ALTER FUNCTION public.mime_type(p_file_extension file_extension) OWNER TO postgres;

--
-- Name: FUNCTION mime_type(p_file_extension file_extension); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION mime_type(p_file_extension file_extension) IS 'Cast to mime_type from file_extension';


--
-- Name: persons_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_lookup(_person integer, OUT _persons persons) RETURNS persons
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _persons = persons_lookup(_person::bigint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.persons_lookup(_person integer, OUT _persons persons) OWNER TO postgres;

--
-- Name: persons_lookup(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_lookup(_person bigint, OUT _persons persons) RETURNS persons
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''persons'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''persons'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _person IS NULL THEN
    _persons = NULL;
  ELSE
    SELECT person, name, surname, born, deceased, country_of_birth, tax_code, sex, school, sidi, city_of_birth, note, usename
    INTO  _persons.person, _persons.name, _persons.surname, _persons.born, _persons.deceased, _persons.country_of_birth, _persons.tax_code, _persons.sex, _persons.school, _persons.sidi, _persons.city_of_birth, _persons.note, _persons.usename
    FROM persons
    WHERE person = _person;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _person),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.persons_lookup(_person bigint, OUT _persons persons) OWNER TO postgres;

--
-- Name: persons_sel_thumbnail(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_sel_thumbnail(_person bigint) RETURNS bytea
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  thumbnail_content 	bytea;
  context 		text;
  full_function_name	text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'the person has not been found: ''%s'' in the table ''people''')::utility.system_message,
    ('en', 2, 'Education origin of the error: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of the parameter ''p_person'' and repeat the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata la persona: ''%s'' nella tabella ''persone''')::utility.system_message,
    ('it', 2, 'L''istruzione origine dell''errore: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore de parametro ''p_persona'' e riproporre l''operazione')::utility.system_message]; 
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  SELECT (COALESCE(thumbnail,thumbnail_default())).content INTO me.thumbnail_content from persons where person = _person;
  IF NOT FOUND THEN 
    RAISE USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,1), _person::varchar),
      DETAIL = format(utility.system_messages_locale(system_messages,2) ,current_query()),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;  
  RETURN thumbnail_content;
END;
$$;


ALTER FUNCTION public.persons_sel_thumbnail(_person bigint) OWNER TO postgres;

--
-- Name: FUNCTION persons_sel_thumbnail(_person bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION persons_sel_thumbnail(_person bigint) IS 'Select the thumbnail of a person';


--
-- Name: persons_surname_name(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION persons_surname_name(_person bigint) RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  surname_name 		varchar;
  context 		text;
  full_function_name	text;
  system_messages   	utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in the people table with person=''%s''')::utility.system_message,
    ('en', 2, 'The education the origin of the error: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value indicated to query and try again')::utility.system_message, 
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella persone con persona=''%s''')::utility.system_message,
    ('it', 2, 'L''istruzione origine dell''errore: ''%s'' ')::utility.system_message,
    ('it', 3, 'Controllare il valore indicato alla query e riprovare')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT surname || ' ' || name INTO me.surname_name 
    FROM persons p
   WHERE p.person = _person;
   
  IF NOT FOUND THEN 
    RAISE USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,1), _person::varchar),
      DETAIL = format(utility.system_messages_locale(system_messages,2) ,current_query()),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;                   
  RETURN me.surname_name;
 END;
$$;


ALTER FUNCTION public.persons_surname_name(_person bigint) OWNER TO postgres;

--
-- Name: FUNCTION persons_surname_name(_person bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION persons_surname_name(_person bigint) IS 'Returns the name and surname of a person';


--
-- Name: photo_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION photo_default() RETURNS image
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN  ('image/png'::mime_type, decode('/9j/4AAQSkZJRgABAQEAWQBZAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
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
		AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//2Q==','base64'))::image;
END;
$$;


ALTER FUNCTION public.photo_default() OWNER TO postgres;

--
-- Name: FUNCTION photo_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION photo_default() IS 'Returns the default photo';


--
-- Name: qualifications_tree(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION qualifications_tree() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  v_min_qualification 	text;
  context 		text;
  full_function_name	text;
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  SELECT MIN(qualification)::text INTO v_min_qualification FROM qualifications;
--  EXECUTE 'SELECT repeat(''   '',level) || q.name as tree, t.qualification, q.name, t.level, t.riferimento, r.name, t.branch FROM connectby(''public.qualifications'',''qualification'',''riferimento'',' || v_min_qualification || ',100,''-'')'
 END;
$$;


ALTER FUNCTION public.qualifications_tree() OWNER TO postgres;

--
-- Name: FUNCTION qualifications_tree(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION qualifications_tree() IS 'Returns the qualification tree';


--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE regions (
    region smallint NOT NULL,
    description character varying(160) NOT NULL,
    geographical_area geographical_area
);


ALTER TABLE regions OWNER TO postgres;

--
-- Name: TABLE regions; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE regions IS 'Contains all avaible regions';


--
-- Name: COLUMN regions.region; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN regions.region IS 'Unique identification code for the row';


--
-- Name: COLUMN regions.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN regions.description IS 'The description for the region';


--
-- Name: COLUMN regions.geographical_area; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN regions.geographical_area IS 'The geographical area of the regions';


--
-- Name: regions_lookup(smallint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION regions_lookup(_region smallint, OUT _regions regions) RETURNS regions
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''regions'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''regions'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _region IS NULL THEN
    _regions = NULL;
  ELSE
    SELECT region, geographical_area, description
    INTO _regions.region, _regions.geographical_area, _regions.description
    FROM regions
    WHERE region = _region;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _region),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.regions_lookup(_region smallint, OUT _regions regions) OWNER TO postgres;

--
-- Name: regions_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION regions_lookup(_region integer, OUT _regions regions) RETURNS regions
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _regions = regions_lookup(_region::smallint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.regions_lookup(_region integer, OUT _regions regions) OWNER TO postgres;

--
-- Name: relatives_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION relatives_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The function: ''alunni_by_classe'' can only be invoked by users belonging to one of the following roles: ''Gestori'',"Dirigenti","Docenti","Famigliari","Alunni"')::utility.system_message,
    ('en', 2, 'The function: ''alunni_by_classe'' was invoked by the user: ''%s'' that not appartiena anyone roles enabled to use the function, i.e.: ''gestori'',''dirigenti'', ''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('en', 3, 'Connect with a user with one of the following roles: ''gestori'',"dirigenti","docenti","famigliari","alunni" and repeat the operation')::utility.system_message,
    ('it', 1, 'La funzione: ''alunni_by_classe'' può essere richiamata solo da utenti appartenenti ad uno dei seguenti ruoli: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('it', 2, 'La funzione: ''alunni_by_classe'' è stata richiamata dall''utente: ''%s'' che non appartiena a nessuno dei ruoli abilitati ad usare la funzione e cioè: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('it', 3, 'Collegarsi con un utente abilitato ad uno dei seguenti ruoli: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni'' e rieseguire l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  
  IF in_any_roles('Supervisor','Executive','Teacher')  THEN
    OPEN cur FOR SELECT p.person AS student,
	       p.surname,
	       p.name,
	       p.tax_code,
	       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	  FROM classrooms_students ca 
          JOIN persons_relations rel ON ca.student = rel.person
          JOIN persons p ON rel.person_related_to = p.person
	 WHERE ca.classroom = p_classroom
      ORDER BY surname, name, tax_code;
  ELSEIF in_any_roles('Relative') THEN
    OPEN cur FOR SELECT p.person AS student,
	       p.surname,
	       p.name,
	       p.tax_code,
	       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	  FROM classrooms_students ca 
          JOIN persons_relations rel ON ca.student = rel.person
          JOIN persons p ON rel.person_related_to = p.person
	 WHERE ca.classroom = p_classroom
	   AND rel.person_related_to = ANY(current_persons())
      ORDER BY surname, name, tax_code;
  ELSEIF in_any_roles('Student') THEN
    OPEN cur FOR SELECT p.person AS student,
	       p.surname,
	       p.name,
	       p.tax_code,
	       COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	  FROM classrooms_students ca 
          JOIN persons_relations rel ON ca.student = rel.person
          JOIN persons p ON rel.person_related_to = p.person
	 WHERE ca.classroom = p_classroom
	   AND ca.student = ANY(current_persons())
      ORDER BY surname, name, tax_code;
  ELSE
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), session_user),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.relatives_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- Name: roles_by_session_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION roles_by_session_user() RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT DISTINCT pr.role
	         FROM persons_roles pr 
                 JOIN persons p ON ( pr.person = p.person  )  
         	WHERE p.usename = "session_user"();
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.roles_by_session_user() OWNER TO postgres;

--
-- Name: school_years_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION school_years_list(p_school bigint) RETURNS refcursor
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>				 
DECLARE
  cur 			refcursor;  
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  OPEN cur FOR SELECT xmin::text::bigint AS rv, school_year, school, description, duration, lessons_duration 
    FROM school_years 
   WHERE school = p_school
  ORDER BY description;
  RETURN cur;
END;
$$;


ALTER FUNCTION public.school_years_list(p_school bigint) OWNER TO postgres;

--
-- Name: school_years_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION school_years_lookup(_school_year integer, OUT _school_years school_years) RETURNS school_years
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _school_years = school_years_lookup(_school_year::bigint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.school_years_lookup(_school_year integer, OUT _school_years school_years) OWNER TO postgres;

--
-- Name: school_years_lookup(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION school_years_lookup(_school_year bigint, OUT _school_years school_years) RETURNS school_years
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''school_years'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''school_year'' perchè non è stata trovata nessuna riga corrispondente nella tabella')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  SELECT school_year, school, description, duration, lessons_duration
    INTO _school_years.school_year, _school_years.school, _school_years.description, _school_years.duration, _school_years.lessons_duration
    FROM public.school_years
   WHERE school_year = _school_year;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), _school_year),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;

  RETURN;
END;
$$;


ALTER FUNCTION public.school_years_lookup(_school_year bigint, OUT _school_years school_years) OWNER TO postgres;

--
-- Name: schools_by_description(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_by_description(p_description character varying) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
    
  OPEN cur FOR SELECT i.xmin::text::bigint AS rv,
                      i.school,
                      i.description,
                      i.processing_code,
                      i.mnemonic,
                      i.example
                 FROM schools i
                WHERE i.description LIKE p_description;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.schools_by_description(p_description character varying) OWNER TO postgres;

--
-- Name: schools_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_del(p_rv bigint, p_school bigint) RETURNS void
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Nobody has been found line in the table ''instituto'' with: ''revisione'' = ''%s'', ''instituto'' = ''%s''')::utility.system_message,
    ('en', 2, 'You function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'To check the value of: ''revisione'', ''instituto'' and to retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  DELETE FROM schools t WHERE t.school = p_school AND xmin = p_rv::text::xid;
  
  IF NOT FOUND THEN 
    RAISE EXCEPTION USING
       ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
       MESSAGE = format(utility.system_messages_locale(system_messages,2),p_rv, p_school),
       DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
       HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END;
$$;


ALTER FUNCTION public.schools_del(p_rv bigint, p_school bigint) OWNER TO postgres;

--
-- Name: FUNCTION schools_del(p_rv bigint, p_school bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_del(p_rv bigint, p_school bigint) IS 'Delete a school';


--
-- Name: schools_del_cascade(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_del_cascade(_school_to_delete bigint) RETURNS TABLE(_table_name character varying, _record_deleted bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  rowcount 		bigint;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  
  delete from conversations
    using classrooms_students, persons
    where classrooms_students.classroom_student = conversations.classroom_student
      and classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'conversations ....................... : % rows cancellate', rowcount;
  _table_name := 'conversations';
  _record_deleted := rowcount;
  return next;
  
  delete from signatures
    using persons
    where signatures.teacher = persons.person
      and persons.school = _school_to_delete; 
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'signatures .......................... : % rows cancellate', rowcount;
  _table_name := 'signatures';
  _record_deleted := rowcount;
  return next;
  
  delete from faults
    using persons
    where faults.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'faults .............................. : % rows cancellate', rowcount;
  _table_name := 'faults';
  _record_deleted := rowcount;
  return next;
  
  delete from lessons
    using persons
    where lessons.teacher = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'lessons ............................. : % rows cancellate', rowcount;
  _table_name := 'lessons';
  _record_deleted := rowcount;
  return next;
  
  delete from absences
    using classrooms_students, persons
    where absences.classroom_student = classrooms_students.classroom_student
      AND classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'absences ............................ : % rows cancellate', rowcount;
  _table_name := 'absences';
  _record_deleted := rowcount;
  return next;
  
  delete from delays
    using classrooms_students, persons
    where delays.classroom_student = classrooms_students.classroom_student
      AND classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'delays .............................. : % rows cancellate', rowcount;
  _table_name := 'delays';
  _record_deleted := rowcount;
  return next;
  
  delete from leavings
    using persons, classrooms_students
    where leavings.classroom_student = classrooms_students.classroom_student
      AND classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'leavings ............................ : % rows cancellate', rowcount;
  _table_name := 'leavings';
  _record_deleted := rowcount;
  return next;
  
  delete from notes
    using classrooms, school_years
    where notes.classroom = classrooms.classroom
      and classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
      
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'notes ............................... : % rows cancellate', rowcount;
  _table_name := 'notes';
  _record_deleted := rowcount;
  return next;
  
  delete from out_of_classrooms
    using classrooms_students, persons
    where out_of_classrooms.classroom_student = classrooms_students.classroom_student
      AND classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'out_of_classrooms ................... : % rows cancellate', rowcount;
  _table_name := 'out_of_classrooms';
  _record_deleted := rowcount;
  return next;
  
  delete from teachears_notes
    using classrooms, school_years
    where teachears_notes.classroom = classrooms.classroom
      and classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'teachears_notes ..................... : % rows cancellate', rowcount;
  _table_name := 'teachears_notes';
  _record_deleted := rowcount;
  return next;
  
  delete from explanations 
    using persons
    where explanations.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'explanations ........................ : % rows cancellate', rowcount;
  _table_name := 'explanations';
  _record_deleted := rowcount;
  return next;
  
  delete from valutations_qualifications
    using valutations, classrooms_students, classrooms, school_years
    where valutations_qualifications.valutation = valutations.valutation
      AND valutations.classroom_student = classrooms_students.classroom_student
      AND classrooms_students.classroom = classrooms.classroom
      and classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'valutations_qualifications ...... : % rows cancellate', rowcount;
  _table_name := 'valutations_qualifications';
  _record_deleted := rowcount;
  return next;
  
  delete from valutations
    using classrooms_students, school_years, classrooms
    where valutations.classroom_student = classrooms_students.classroom_student
      AND classrooms.classroom = classrooms_students.classroom
      and classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'valutations ......................... : % rows cancellate', rowcount;
  _table_name := 'valutations';
  _record_deleted := rowcount;
  return next;
  
  delete from topics
    using degrees
    where topics.degree = degrees.degree
      and degrees.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'topics ............................. : % rows cancellate', rowcount;
  _table_name := 'topics';
  _record_deleted := rowcount;
  return next;
  
  delete from grade_types
    using subjects
    where grade_types.subject = subjects.subject
      and subjects.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'grade_types ........................ : % rows cancellate', rowcount;
  _table_name := 'grade_types';
  _record_deleted := rowcount;
  return next;
  --
  -- Reopen the grading_meetings otherwise I cannot delete the rows from_time grading_meetings_valutations_qua
  --
  update grading_meetings s set closed = false
    from school_years a
   where a.school_year = s.school_year
     and a.school = _school_to_delete;
     
  delete from grading_meetings_valutations_qua
    using grading_meetings_valutations, grading_meetings, school_years 
    where grading_meetings_valutations_qua.grading_meeting_valutation = grading_meetings_valutations.grading_meeting_valutation
      and grading_meetings_valutations.grading_meeting = grading_meetings.grading_meeting
      and grading_meetings.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
           
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'grading_meetings_valutations_qua ... : % rows cancellate', rowcount;
  _table_name := 'grading_meetings_valutations_qua';
  _record_deleted := rowcount;
  return next;
  
  delete from grading_meetings_valutations
    using grading_meetings, school_years 
    where grading_meetings_valutations.grading_meeting = grading_meetings.grading_meeting
      and grading_meetings.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'grading_meetings_valutations ....... : % rows cancellate', rowcount;
  _table_name := 'grading_meetings_valutations';
  _record_deleted := rowcount;
  return next;
  
  delete from grading_meetings
    using school_years 
    where grading_meetings.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'grading_meetings .................. : % rows cancellate', rowcount;
  _table_name := 'grading_meetings';
  _record_deleted := rowcount;
  return next;
  
  delete from weekly_timetables
    using classrooms, school_years
    where weekly_timetables.classroom = classrooms.classroom
      and classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'weekly_timetable .................. : % rows cancellate', rowcount;
  _table_name := 'weekly_timetable';
  _record_deleted := rowcount;
  return next;
  
  delete from holidays 
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'holidays .......................... : % rows cancellate', rowcount;
  _table_name := 'holidays';
  _record_deleted := rowcount;
  return next;
  
  delete from classrooms_students
    using persons
    where classrooms_students.student = persons.person
      and persons.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'classrooms_students ............... : % rows cancellate', rowcount;
  _table_name := 'classrooms_students';
  _record_deleted := rowcount;
  return next;
 
  delete from parents_meetings
    using persons
    where parents_meetings.teacher = persons.person
      and school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'parents_meetings .................. : % rows cancellate', rowcount;
  _table_name := 'parents_meetings';
  _record_deleted := rowcount;
  return next;
  
  delete from persons
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'persons ........................... : % rows cancellate', rowcount;
  _table_name := 'persons';
  _record_deleted := rowcount;
  return next;
  
  delete from classrooms 
    using school_years
    where classrooms.school_year = school_years.school_year
      and school_years.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'classrooms ........................ : % rows cancellate', rowcount;
  _table_name := 'classrooms';
  _record_deleted := rowcount;
  return next;
  
  delete from qualifications
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'qualifications ................ : % rows cancellate', rowcount;
  _table_name := 'qualifications';
  _record_deleted := rowcount;
  return next;
    
  delete from school_years
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'school_years ...................... : % rows cancellate', rowcount;
  _table_name := 'school_years';
  _record_deleted := rowcount;
  return next;
  
  delete from degrees
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'degrees ........................... : % rows cancellate', rowcount;
  _table_name := 'degrees';
  _record_deleted := rowcount;
  return next;
  
  delete from branches
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'branches .......................... : % rows cancellate', rowcount;
  _table_name := 'buildings';
  _record_deleted := rowcount;
  return next;
  --
  -- Take off the possible subject of behavior from_timel'school
  --
  update schools set behavior = null 
    where school = _school_to_delete;
 
  delete from subjects 
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'subjects .......................... : % rows cancellate', rowcount;
  _table_name := 'subjects';
  _record_deleted := rowcount;
  return next;
      
  delete from grades
    using metrics
    where grades.metric = metrics.metric
      and metrics.school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'grades ............................ : % rows cancellate', rowcount;
  _table_name := 'grades';
  _record_deleted := rowcount;
  return next;
  
  delete from metrics
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'metrics ........................... : % rows cancellate', rowcount;
  _table_name := 'metrics';
  _record_deleted := rowcount;
  return next;
  
  delete from communication_types
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'communication_types ............... : % rows cancellate', rowcount;
  _table_name := 'communication_types';
  _record_deleted := rowcount;
  return next;
  
  delete from schools
    where school = _school_to_delete;
  GET DIAGNOSTICS rowcount = ROW_COUNT;
  RAISE NOTICE 'schools ........................... : % rows cancellate', rowcount;
  _table_name := 'schools';
  _record_deleted := rowcount;
  return next;
  
  return ;
 end;
$$;


ALTER FUNCTION public.schools_del_cascade(_school_to_delete bigint) OWNER TO postgres;

--
-- Name: FUNCTION schools_del_cascade(_school_to_delete bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_del_cascade(_school_to_delete bigint) IS 'Delete a school and others dependecies';


--
-- Name: schools_ins(character varying, character varying, character varying, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean) RETURNS record
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
 <<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  INSERT INTO schools (description, processing_code, mnemonic, example)
    VALUES (_description, _processing_code, _mnemonic, _example);
       
  SELECT currval('pk_seq') INTO _school;
  SELECT xmin::text::bigint INTO _rv FROM schools WHERE school = _school;
END;
$$;


ALTER FUNCTION public.schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean) OWNER TO postgres;

--
-- Name: FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean) IS 'Insert a school';


--
-- Name: schools_ins(character varying, character varying, character varying, boolean, image); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _logo image) RETURNS record
    LANGUAGE plpgsql
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
 <<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  INSERT INTO schools (description, processing_code, mnemonic, example, logo)
               VALUES (_description, _processing_code, _mnemonic, _example, _logo);
       
  SELECT currval('pk_seq') INTO _school;
  SELECT xmin::text::bigint INTO _rv FROM schools WHERE school = _school;
END;
$$;


ALTER FUNCTION public.schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _logo image) OWNER TO postgres;

--
-- Name: schools_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_lookup(_school integer, OUT _schools schools) RETURNS schools
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _schools = schools_lookup(_school::bigint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.schools_lookup(_school integer, OUT _schools schools) OWNER TO postgres;

--
-- Name: schools_lookup(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_lookup(_school bigint, OUT _schools schools) RETURNS schools
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''schools'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''school'' perchè non è stata trovata nessuna riga corrispondente nella tabella')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  SELECT school, description, processing_code, mnemonic, example, behavior
  INTO _schools.school, _schools.description, _schools.processing_code, _schools.mnemonic, _schools.example, _schools.behavior
  FROM schools
  WHERE school = _school;
  
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), _school),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;

  RETURN;
END;
$$;


ALTER FUNCTION public.schools_lookup(_school bigint, OUT _schools schools) OWNER TO postgres;

--
-- Name: schools_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea) RETURNS record
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in table ''instituti'' with: ''istituto'' = %L')::utility.system_message,
    ('en', 2, 'The function in error is: %L')::utility.system_message,
    ('en', 3, 'Check the value of: ''instituto'' and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''istituti'' con:  ''istituto'' = %L')::utility.system_message,
    ('it', 2, 'La funzione in errore è: %L')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''istituto'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  SELECT xmin::text::bigint, school, description, processing_code, mnemonic, example, behavior, (logo).mime_type, (logo).content
    INTO _rv, _school, _description, _processing_code, _mnemonic, _example, _behavior, _logo_mime_type, _logo_content
    FROM schools
    WHERE school = _school;
    
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),_school),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;

END;
$$;


ALTER FUNCTION public.schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea) OWNER TO postgres;

--
-- Name: FUNCTION schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea) IS 'Select a school';


--
-- Name: schools_sel_logo(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_sel_logo(_school bigint, OUT _logo image) RETURNS image
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Was not found no row in table institutes with institute=''%s''')::utility.system_message,
    ('en', 2, 'The education the origin of the error: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value indicated to query and try again')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella istituti con istituto=''%s''')::utility.system_message,
    ('it', 2, 'L''istruzione origine dell''errore: ''%s'' ')::utility.system_message,
    ('it', 3, 'Controllare il valore indicato alla query e riprovare')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT logo INTO _logo from schools where school = _school;
  IF NOT FOUND THEN 
    RAISE USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,1), _school::varchar),
      DETAIL = format(utility.system_messages_locale(system_messages,2) ,current_query()),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;                   
  RETURN;
 END;
$$;


ALTER FUNCTION public.schools_sel_logo(_school bigint, OUT _logo image) OWNER TO postgres;

--
-- Name: FUNCTION schools_sel_logo(_school bigint, OUT _logo image); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_sel_logo(_school bigint, OUT _logo image) IS '<public>';


--
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd(_rv bigint, _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _behavior bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;

   system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in table ''istituti'' with: ''revisione'' = ''%s'', ''istituto'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''revisione'', ''istituto'' and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione')::utility.system_message]; 
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  UPDATE schools 
     SET school = _school,
         description = _description,
         processing_code = _processing_code,
         mnemonic = _mnemonic,
         example = _example,
         behavior = _behavior
  WHERE school = _school
    AND xmin = _rv::text::xid;
    
  IF NOT FOUND THEN RAISE USING
   ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
   MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _school),
   DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
   HINT = utility.system_messages_locale(system_messages,3);
  END IF;
    RETURN xmin::text::bigint  FROM schools WHERE school = _school;
END;
$$;


ALTER FUNCTION public.schools_upd(_rv bigint, _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _behavior bigint) OWNER TO postgres;

--
-- Name: schools_upd(bigint, bigint, character varying, character varying, character varying, boolean, bigint, image); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd(_rv bigint, _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _behavior bigint, _logo image) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * FulcroCodeGenerator for PostgreSQL 
 * 
 * Versione... 1.0.0
 * Date....... 22 febrary 2014
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in table ''istituti'' with: ''revisione'' = ''%s'', ''istituto'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''revisione'', ''istituto'' and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''istituti'' con: ''revisione'' = ''%s'',  ''istituto'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''istituto'' e riprovare l''operazione')::utility.system_message]; 
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  UPDATE schools 
     SET school = _school,
         description = _description,
         processing_code = _processing_code,
         mnemonic = _mnemonic,
         example = _example,
         behavior = _behavior,
         logo = _logo
  WHERE school = _school 
    AND xmin = _rv::text::xid;
    
  IF NOT FOUND THEN RAISE USING
     ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
     MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _school),
     DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
     HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  
  RETURN xmin::text::bigint FROM schools WHERE school = _school;
END;
$$;


ALTER FUNCTION public.schools_upd(_rv bigint, _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean, _behavior bigint, _logo image) OWNER TO postgres;

--
-- Name: schools_upd_logo(bigint, bigint, image); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION schools_upd_logo(_rv bigint, _school bigint, _logo image) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Was not found no row in table institutes with institute = ''%s''')::utility.system_message,
    ('en', 2, 'The education the origin of the error: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value indicated in the query and try again')::utility.system_message,    
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella istituti con istituto =''%s''')::utility.system_message,
    ('it', 2, 'L''istruzione origine dell''errore: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore indicato nella query e riprovare')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  UPDATE schools SET logo=_logo WHERE school = _school  AND xmin = _rv::text::xid;
  IF NOT FOUND THEN 
  RAISE USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,1), _school::varchar),
      DETAIL = format(utility.system_messages_locale(system_messages,1) ,current_query()),
      HINT = utility.system_messages_locale(system_messages,3);
	END IF;                   
   RETURN xmin::text::bigint FROM schools WHERE school = _school;
 END;
$$;


ALTER FUNCTION public.schools_upd_logo(_rv bigint, _school bigint, _logo image) OWNER TO postgres;

--
-- Name: FUNCTION schools_upd_logo(_rv bigint, _school bigint, _logo image); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION schools_upd_logo(_rv bigint, _school bigint, _logo image) IS 'Update the logo of a school';


--
-- Name: session_person(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_person(p_school bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
declare
  person 		bigint;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  
  SELECT p.person INTO me.person
    FROM persons p
   WHERE p.usename = CURRENT_user
     AND p.school = p_school;
  return me.person;
 end;
$$;


ALTER FUNCTION public.session_person(p_school bigint) OWNER TO postgres;

--
-- Name: session_persons(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION session_persons() RETURNS bigint[]
    LANGUAGE plpgsql
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  -- 
  -- return the person connected by the session_iuser
  --
  -- example in use: is_session_user_enable_to_any('{"Supervisor","Executive","Teacher"}')
  --	
      
  RETURN ARRAY(SELECT p.person
                 FROM usenames_schools us
                 JOIN persons p ON p.usename = us.usename AND p.school = us.school 
                WHERE us.usename = session_user);
END;
$$;


ALTER FUNCTION public.session_persons() OWNER TO postgres;

--
-- Name: signatures_by_teacher_classroom(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT on_date,
 		      at_time
		 FROM signatures
		WHERE teacher = p_teacher
		  AND classroom = p_classroom
	     ORDER BY on_date, at_time;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.signatures_by_teacher_classroom(p_teacher bigint, p_classroom bigint) OWNER TO postgres;

--
-- Name: statistics(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION statistics() RETURNS TABLE(_message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  total			int = 0;
  count_value		int = 0;
  results       	record;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  _message =   '-------------------------------------------------------------------------'; RETURN NEXT;   
  _message =   '     CTR DESCRIPTION                                                     '; RETURN NEXT;   
  _message =   '-------------------------------------------------------------------------'; RETURN NEXT;   
-- count schemas 
  SELECT count(nspname) INTO total
    FROM pg_catalog.pg_namespace
   WHERE nspname NOT LIKE('pg_%')
     AND nspname <> 'information_schema' ;
   _message =  format('%8s Schemas',total); RETURN NEXT;   
-- count tables
  SELECT count(tablename) INTO total
    FROM pg_catalog.pg_tables t 
    JOIN pg_catalog.pg_namespace ns ON t.schemaname = ns.nspname
   WHERE ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' ;	
   _message =  format('%8s Tables',total); RETURN NEXT;  
-- count views
  SELECT count(viewname) INTO total
    FROM pg_catalog.pg_views v 
    JOIN pg_catalog.pg_namespace ns ON v.schemaname = ns.nspname
   WHERE ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' ;	
   _message =  format('%8s Views',total); RETURN NEXT;  
   
-- count functions
  SELECT count(proname) INTO total
    FROM pg_catalog.pg_proc p 
    JOIN pg_catalog.pg_namespace ns ON p.pronamespace = ns.oid
    JOIN pg_description d ON d.objoid = p.oid
   WHERE ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');	
   _message =  format('%8s Functions',total); RETURN NEXT;  
-- count domain
  SELECT count(typname) INTO total
    FROM pg_catalog.pg_type t 
    JOIN pg_catalog.pg_namespace ns ON t.typnamespace = ns.oid
    JOIN pg_description d ON d.objoid = t.oid
   WHERE t.typtype = 'd'
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');
   _message =  format('%8s Domains',total); RETURN NEXT;  
   
-- count composite types
  SELECT count(typname) INTO total
    FROM pg_catalog.pg_type t 
    JOIN pg_catalog.pg_namespace ns ON t.typnamespace = ns.oid
    JOIN pg_description d ON d.objoid = t.oid
   WHERE t.typtype = 'c'
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');
   _message =  format('%8s Types (composite)',total); RETURN NEXT;  
   
-- count enum types
  SELECT count(typname) INTO total
    FROM pg_catalog.pg_type t 
    JOIN pg_catalog.pg_namespace ns ON t.typnamespace = ns.oid
    JOIN pg_description d ON d.objoid = t.oid
   WHERE t.typtype = 'e'
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');
   _message =  format('%8s Types (enum)',total); RETURN NEXT;  
/*   
-- count pseudo types
  SELECT count(typname) INTO total
    FROM pg_catalog.pg_type t 
    JOIN pg_catalog.pg_namespace ns ON t.typnamespace = ns.oid
    JOIN pg_description d ON d.objoid = t.oid
   WHERE t.typtype = 'p'
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');
   _message =  format('%8s Types (pseudo)',total); RETURN NEXT;  
   
-- count range types
  SELECT count(typname) INTO total
    FROM pg_catalog.pg_type t 
    JOIN pg_catalog.pg_namespace ns ON t.typnamespace = ns.oid
    JOIN pg_description d ON d.objoid = t.oid
   WHERE t.typtype = 'r'
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema' 
     AND (   d.description LIKE '<assert>%' 
          OR d.description LIKE '<diagnostic>%'
          OR d.description LIKE '<public>%'
          OR d.description LIKE '<translate>%'
          OR d.description LIKE '<unit_testing>%'
          OR d.description LIKE '<unit_tests>%'
          OR d.description LIKE '<utility>%');
   _message =  format('%8s Types (range)',total); RETURN NEXT;  
*/
-- count triggers
  SELECT count(tgname) INTO total
    FROM pg_catalog.pg_trigger t
    JOIN pg_catalog.pg_class c ON t.tgrelid = c.oid
    JOIN pg_catalog.pg_namespace ns ON c.relnamespace = ns.oid
   WHERE t.tgisinternal = false
     AND ns.nspname NOT LIKE('pg_%')
     AND ns.nspname <> 'information_schema';	
   _message =  format('%8s Triggers',total); RETURN NEXT;  
-- count female portrait
  SELECT count(name) INTO total
    FROM public.wikimedia_files w
   WHERE w.type = 'Female portrait';	
   _message =  format('%8s Wikimedia Female portrait (GPL like license)',total); RETURN NEXT;  
-- count male portrait
  SELECT count(name) INTO total
    FROM public.wikimedia_files w
   WHERE w.type = 'Male portrait';	
   _message =  format('%8s Wikimedia Male portrait (GPL like license)',total); RETURN NEXT;  
-- count persons
  SELECT count(name) INTO total
    FROM public.persons w;	
   _message =  format('%8s Persons',total); RETURN NEXT;  
-- count all row 
  total = 0;
  
  FOR results IN SELECT t.schemaname, t.tablename 
                   FROM pg_catalog.pg_tables t 
                   JOIN pg_catalog.pg_namespace ns ON t.schemaname = ns.nspname
                  WHERE ns.nspname NOT LIKE('pg_%')
                    AND ns.nspname <> 'information_schema' 
                    AND t.tablename <> 'persons'
                    ANd t.tablename <> 'wikimedia_files'	
  LOOP
    EXECUTE 'SELECT COUNT(*) FROM ' || results.schemaname || '.' || results.tablename into strict count_value;
    total = total + count_value;
   END LOOP;
  
   _message =  format('%8s Other rows',total); RETURN NEXT;  
END
$$;


ALTER FUNCTION public.statistics() OWNER TO postgres;

--
-- Name: FUNCTION statistics(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION statistics() IS 'Returns all statistics';


--
-- Name: students_by_classroom(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION students_by_classroom(p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The function: ''students_by_classroom'' can only be invoked by users belonging to one of the following roles: ''gestori'', ''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('en', 2, 'The function: ''students_by_classroom'' was invoked by the user: %L that not appartiena anyone roles enabled to use the function, i.e.: ''gestori'', ''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('en', 3, 'Connect with a user with one of the following roles: ''gestori'', ''dirigenti'',''docenti'',''famigliari'',''alunni'' and repeat the operation')::utility.system_message,
    ('it', 1, 'La funzione: ''students_by_classroom'' può essere richiamata solo da utenti appartenenti ad uno dei seguenti ruoli: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('it', 2, 'La funzione: ''students_by_classroom'' è stata richiamata dall''utente: %L che non appartiena a nessuno dei ruoli abilitati ad usare la funzione e cioè: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni''')::utility.system_message,
    ('it', 3, 'Collegarsi con un utente abilitato ad uno dei seguenti ruoli: ''gestori'',''dirigenti'',''docenti'',''famigliari'',''alunni'' e rieseguire l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
    
  IF in_any_roles('Supervisor','Executive','Teacher') THEN
	OPEN cur FOR SELECT p.person AS student,
		       p.surname,
		       p.name,
		       p.tax_code,
		       encode((thumbnail).content,'base64') as thumbnail_content
		  FROM classrooms_students cs
	          JOIN persons p ON cs.student = p.person
		 WHERE cs.classroom = p_classroom
	      ORDER BY surname, name, tax_code;
  ELSEIF in_any_roles('Relative') THEN
	OPEN cur FOR SELECT p.person AS student,
		       p.surname,
		       p.name,
		       p.tax_code,
		       encode((thumbnail).content,'base64') as thumbnail_content
		  FROM classrooms_students cs 
	          JOIN persons p ON cs.student = p.person
	          JOIN persons_relations pr ON cs.student = pr.person
		 WHERE cs.classroom = p_classroom
		   AND pr.person_related_to = session_person(p.school)
	      ORDER BY surname, name, tax_code;
  ELSEIF in_any_roles('Student') THEN
	OPEN cur FOR SELECT p.person AS student,
		       p.surname,
		       p.name,
		       p.tax_code,
		       encode((thumbnail).content,'base64') as thumbnail_content
		  FROM classrooms_students cs
	          JOIN persons p ON cs.student = p.person
		 WHERE cs.classroom = p_classroom
		   AND cs.student = session_person(p.school)
	      ORDER BY surname, name, tax_code;
  ELSE
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), session_user),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
RETURN cur;	        
END;
$$;


ALTER FUNCTION public.students_by_classroom(p_classroom bigint) OWNER TO postgres;

--
-- Name: subjects_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_del(p_rv bigint, p_subject bigint) RETURNS void
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in the table ''materie'' with: ''revisione'' = ''%s'',  ''materia'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''revisione'', ''materia'' and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''materie'' con: ''revisione'' = ''%s'',  ''materia'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''materia'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  DELETE FROM subjects t
      WHERE t.subject = p_subject AND
            xmin = p_rv::text::xid;
  
  IF NOT FOUND THEN 
     RAISE EXCEPTION USING
     ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
     MESSAGE = format(utility.system_messages_locale(system_messages,2),p_rv, p_subject),
     DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
     HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END;
$$;


ALTER FUNCTION public.subjects_del(p_rv bigint, p_subject bigint) OWNER TO postgres;

--
-- Name: FUNCTION subjects_del(p_rv bigint, p_subject bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION subjects_del(p_rv bigint, p_subject bigint) IS 'Delete a subject';


--
-- Name: subjects_ins(bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_ins(OUT _rv bigint, OUT _subject bigint, _school bigint, _description character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
 <<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  INSERT INTO subjects (school, description)
    VALUES (_school, _description);
       
  SELECT currval('pk_seq') INTO _subject;
  SELECT xmin::text::bigint INTO _rv FROM subjects WHERE subject = _subject;
END;
$$;


ALTER FUNCTION public.subjects_ins(OUT _rv bigint, OUT _subject bigint, _school bigint, _description character varying) OWNER TO postgres;

--
-- Name: subjects_list(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_list(p_school bigint) RETURNS refcursor
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>			 
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  OPEN cur FOR SELECT xmin::text::bigint AS rv, subject, school, description
      FROM subjects 
     WHERE school = p_school
    ORDER BY description;
  RETURN cur;
END;
$$;


ALTER FUNCTION public.subjects_list(p_school bigint) OWNER TO postgres;

--
-- Name: FUNCTION subjects_list(p_school bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION subjects_list(p_school bigint) IS '<public>';


--
-- Name: subjects_lookup(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_lookup(_subject integer, OUT _subjects subjects) RETURNS subjects
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  _subjects = subjects_lookup(_subject::bigint);
  
  RETURN;
END;
$$;


ALTER FUNCTION public.subjects_lookup(_subject integer, OUT _subjects subjects) OWNER TO postgres;

--
-- Name: subjects_lookup(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_lookup(_subject bigint, OUT _subjects subjects) RETURNS subjects
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
 <<me>>		 
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Cast error')::utility.system_message,
    ('en', 2, 'Cannot cast value: ''%s'' to data type ''subjects'' because it isn''t in the conversion rule')::utility.system_message,
    ('en', 3, 'Check the parameter''s value and retry the operation')::utility.system_message,
    ('it', 1, 'Errore di conversione')::utility.system_message,
    ('it', 2, 'Non è possibile convertire il valore: ''%s'' nel tipo: ''subjects'' perchè non è stata trovata nessuna riga corrispondente nella tabella relativa')::utility.system_message,
    ('it', 3, 'Controllare il valore specificato e riprovare l''operazione')::utility.system_message];  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);

  IF _subject IS NULL THEN
    _subjects = NULL;
  ELSE
    SELECT subject, school, description
    INTO _subjects.subject, _subjects.school, _subjects.description
    FROM subjects
    WHERE subject = _subject;

    IF NOT FOUND THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), _subject),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN;
END;
$$;


ALTER FUNCTION public.subjects_lookup(_subject bigint, OUT _subjects subjects) OWNER TO postgres;

--
-- Name: subjects_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) RETURNS record
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in the table ''materie'' with: ''materia'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''materia'' and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''materie'' con:  ''materia'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''materia'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  SELECT xmin::text::bigint, subject, school, description
  INTO p_rv, p_subject, p_school, p_description
  FROM subjects
  WHERE subject = p_subject;
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),p_subject),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END;
$$;


ALTER FUNCTION public.subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) OWNER TO postgres;

--
-- Name: FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) IS 'Select a subject';


--
-- Name: subjects_upd(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION subjects_upd(_rv bigint, _subject bigint, _school bigint, _description character varying) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
/* 
 * 
 * Copyright (C) 2014 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... sabato 22 marzo 2014 (11:55:10 CET)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'Was not found no row in the table ''materie'' with: ''revisione'' = ''%s'', ''materia'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''revisione'', ''materia'' and retry the operation')::utility.system_message,    
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''materie'' con: ''revisione'' = ''%s'',  ''materia'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''materia'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  UPDATE subjects 
     SET subject = _subject,
         school = _school,
         description = _description
   WHERE subject = _subject 
     AND xmin = _rv::text::xid;
     
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _subject),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN xmin::text::bigint  FROM schools WHERE school = _school;
END;
$$;


ALTER FUNCTION public.subjects_upd(_rv bigint, _subject bigint, _school bigint, _description character varying) OWNER TO postgres;

--
-- Name: FUNCTION subjects_upd(_rv bigint, _subject bigint, _school bigint, _description character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION subjects_upd(_rv bigint, _subject bigint, _school bigint, _description character varying) IS 'Update a subject';


--
-- Name: teachers_by_school(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION teachers_by_school(p_school bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  IF in_any_roles('Supervisor','Executive','Employee')  THEN
	OPEN cur FOR SELECT p.person AS teacher,
			    p.surname,
			    p.name,
			    p.tax_code,
			    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	               FROM persons p
		       JOIN persons_roles pr ON p.person = pr.person
		      WHERE school = p_school
			AND pr.role = 'Teacher'
		   ORDER BY surname, name, tax_code;
  ELSEIF in_any_roles('Teacher') THEN
	OPEN cur FOR SELECT p.person AS teacher,
			    p.surname,
			    p.name,
			    p.tax_code,
			    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	               FROM persons p
		       JOIN persons_roles pr ON p.person = pr.person
		      WHERE school = p_school
		        AND p.person = session_person(p_school)
			AND pr.role = 'Teacher'
		   ORDER BY surname, name, tax_code;
  ELSE
	OPEN cur FOR SELECT p.person AS teacher,
			    p.surname,
			    p.name,
			    p.tax_code,
			    COALESCE(p.thumbnail,thumbnail_default()) as thumbnail
	               FROM persons p
		       JOIN persons_roles pr ON p.person = pr.person
		      WHERE 1=0;
  END IF;
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.teachers_by_school(p_school bigint) OWNER TO postgres;

--
-- Name: thumbnail_default(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION thumbnail_default() RETURNS image
    LANGUAGE plpgsql IMMUTABLE
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN  ('image/png'::mime_type, decode('/9j/4AAQSkZJRgABAQEAFgAWAAD/2wBDABALDA4MChAODQ4SERATGCgaGBYWGDEjJR0oOjM9PDkz
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
		JOVk5Tk+bk92fIAHTHvnjXwuqe04vdGux9VxLqIWSuhXKS4xk+KZjQAAAAAAAAAAAAAAf//Z','base64'))::image;
END;
$$;


ALTER FUNCTION public.thumbnail_default() OWNER TO postgres;

--
-- Name: FUNCTION thumbnail_default(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION thumbnail_default() IS 'Returns the default thumbnail';


--
-- Name: topics_by_subject_classroom(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_by_subject_classroom(p_subject bigint, p_classroom bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  OPEN cur FOR SELECT a.xmin::text::bigint AS rv,
	       a.topic,
	       a.description
	  FROM topics a, classrooms c 
	 WHERE c.classroom = p_classroom
	   AND a.subject = p_subject
	   AND a.course_year = c.course_year
	   AND a.degree = c.degree  
	ORDER BY a.description;
  RETURN cur;	        
END;
$$;


ALTER FUNCTION public.topics_by_subject_classroom(p_subject bigint, p_classroom bigint) OWNER TO postgres;

--
-- Name: topics_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_del(p_rv bigint, p_topic bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedì 02 settembre 2014 (18:39:17 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
    system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found no row in table ''arguments'' with: ''revision'' = ''%s'', ''topic'' = ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of: ''revision'', ''topic'' and retry the operation')::utility.system_message,    
    ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''argomenti'' con: ''revisione'' = ''%s'',  ''argomento'' = ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore di: ''revisione'', ''argomento'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  DELETE FROM topics t
     WHERE t.topic = p_topic AND
           xmin = p_rv::text::xid;
   
   IF NOT FOUND THEN 
      RAISE EXCEPTION USING
     ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
     MESSAGE = format(utility.system_messages_locale(system_messages,2),p_rv, p_topic),
     DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
     HINT = utility.system_messages_locale(system_messages,3);
   END IF;
END;
$$;


ALTER FUNCTION public.topics_del(p_rv bigint, p_topic bigint) OWNER TO postgres;

--
-- Name: FUNCTION topics_del(p_rv bigint, p_topic bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION topics_del(p_rv bigint, p_topic bigint) IS 'Delete a topic';


--
-- Name: topics_ins_rid(bigint, character varying, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedì 02 settembre 2014 (18:39:17 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
 <<me>>
DECLARE
  context 		text;
  full_function_name	text;
  
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'was not found the class: ''%s''')::utility.system_message,
    ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
    ('en', 3, 'Check the value of the class and retry the operation')::utility.system_message,
    ('it', 1, 'Non è stata trovata la classe: ''%s''')::utility.system_message,
    ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare il valore della classe e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  PERFORM 1 FROM classrooms WHERE classroom = _classroom;
  
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,1),_classroom),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  
  INSERT INTO topics 
              (subject, description, course_year, degree)
       SELECT _subject, _description, course_year, degree
         FROM classrooms
        WHERE classroom = _classroom;
     
  SELECT currval('pk_seq') INTO _topic;
  SELECT xmin::text::bigint INTO _rv FROM topics WHERE topic = _topic;
END;
$$;


ALTER FUNCTION public.topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint) OWNER TO postgres;

--
-- Name: FUNCTION topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint) IS 'Insert a topic';


--
-- Name: topics_upd_rid(bigint, bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION topics_upd_rid(_rv bigint, _topic bigint, _description character varying) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
 * 
 * Copyright (C) 2013 FULCRO SRL (http://www.fulcro.net)
 *
 * Progetto... Scuola247
 * Versione... 1.0.0
 * Date....... martedì 02 settembre 2014 (18:55:26 CEST)
 * 
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY[
   ('en', 1, 'was not found no row in table ''arguments'' with: ''revision'' = ''%s'', ''topic'' = ''%s''')::utility.system_message,
   ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
   ('en', 3, 'Check the value of: ''revision'', ''topic'' and retry the operation')::utility.system_message,
   ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''argomenti'' con: ''revisione'' = ''%s'',  ''argomento'' = ''%s''')::utility.system_message,
   ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
   ('it', 3, 'Controllare il valore di: ''revisione'', ''argomento'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  UPDATE topics SET topic = _topic,description = _description
  WHERE topic = _topic AND xmin = _rv::text::xid;
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _topic),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN xmin::text::bigint FROM topics WHERE topic = _topic;
END;
$$;


ALTER FUNCTION public.topics_upd_rid(_rv bigint, _topic bigint, _description character varying) OWNER TO postgres;

--
-- Name: FUNCTION topics_upd_rid(_rv bigint, _topic bigint, _description character varying); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION topics_upd_rid(_rv bigint, _topic bigint, _description character varying) IS 'Update a topic';


--
-- Name: tr_absences_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_absences_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
  classroom		bigint;
  student		bigint;

  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The absence was marked in a day where there are no lessons.')::utility.system_message,
    ('en', 2, 'On date: %L, was marked the absence: %L, day when class: %L has no lesson')::utility.system_message,
    ('en', 3, 'Try to re-insert the absent date you want to insert.')::utility.system_message,
    ('en', 4, 'On date:% L the class: %L has no lesson, so the absence can not be entered.')::utility.system_message,
    ('en', 5, 'On the absent day the pupil is already marked as '' delay ''.')::utility.system_message,
    ('en', 6, 'In absence: %L with description: %L of the student: %L in date %L, the student is already marked as '' delay''.')::utility.system_message,
    ('en', 7, 'Try re-entering the absence date or the name of the pupil.')::utility.system_message,
    ('en', 8, 'In absence:  L with description: %L of the student: %L in date %L, the student is already marked as '' delay ''.')::utility.system_message,
    ('en', 9, 'The school assigned to the pupil marked in absentia is not equivalent to the school of the class')::utility.system_message,
    ('en', 10, 'In absence: %L of the student: %L. School: %L does not match class: %L.')::utility.system_message,
    ('en', 11, 'Try re-inserting a pupil assigned to absent.')::utility.system_message,
    ('en', 12, 'In the absence of the student: %L, the School %L does not match school''s class:% L.')::utility.system_message,
    ('en', 13, 'The school assigned to the absent teacher. Does not match the class assigned to the class.')::utility.system_message,
    ('en', 14, 'In absence: %L entered by the teacher: %L, does not match school: %L with class assigned: %L.')::utility.system_message,
    ('en', 15, 'Try re-enter the data.')::utility.system_message,
    ('en', 16, 'In the teacher''s absence: %L, does not match school: %L with class assigned: %L.')::utility.system_message,
    ('en', 17, 'On the absent day the pupil is already marked as '' delay ''.')::utility.system_message,
    ('en', 18, 'In absence: %L with description: %L of the student: %L in date %L, the student is already marked as '' delay''.')::utility.system_message,
    ('en', 19, 'Try re-entering the absence date or the name of the pupil.')::utility.system_message,
    ('en', 20, 'With description: %L of the student: %L in date %L, the student is already marked as '' delay ''.')::utility.system_message,
    ('en', 21, 'On the absent day the student entered is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 22, 'In the absence. %L of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 23, 'Try and re-enter the absence date.')::utility.system_message,
    ('en', 24, 'In the absence of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 25, 'On the absent day, the entered student is already registered as '' Leaving''.')::utility.system_message,
    ('en', 26, 'In the absence. %L of the student: %L of the class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 27, 'Try and re-enter the absence date.')::utility.system_message,
    ('en', 28, 'In absence of student: %L of class: %L on date: %L is already registered as '' Leaving ''.')::utility.system_message,
    ('en', 29, 'The student entered in the absences is not recognized as a ''student''.')::utility.system_message,
    ('en', 30, 'In absence: %L, the student %L entered is not recognized as the ''student'' role.')::utility.system_message,
    ('en', 31, 'Try and re-enter the data.')::utility.system_message,
    ('en', 32, 'In the absence of student %L assignment is not recognized with the role of '' student ''.')::utility.system_message,
    ('en', 33, 'The teacher who entered the absence is not recognized as a ''teacher''.')::utility.system_message,
    ('en', 34, 'In absence: %L, entered by the teacher %L is not recognized as the ''teacher'' role.')::utility.system_message,
    ('en', 35, 'Try and re-enter the data.')::utility.system_message,
    ('en', 36, 'In the absence of the teacher %L is not recognized as the '' teacher '' role.')::utility.system_message,
    ('it', 1, 'L''assenza è stata segnata in un giorno dove non vi sono lezioni.')::utility.system_message,
    ('it', 2, 'In data: %L, e stata segnata l''assenza: %L, giornata in cui la classe: %L non ha lezione')::utility.system_message,
    ('it', 3, 'Riprovare a riinserire la data dell''assenza che si vuole inserire.')::utility.system_message,
    ('it', 4, 'In data: %L la classe: %L non ha lezione, perciò l''assenza non può essere inserita.')::utility.system_message,
    ('it', 5, 'Nel giorno dell''assenza inserita l''alunno è gia segnato come ''in ritardo''.')::utility.system_message,
    ('it', 6, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritartdo''.')::utility.system_message,
    ('it', 7, 'Provare a re-inserire la data dell''assenza oppure il nome dell''alunno.')::utility.system_message,
    ('it', 8, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritartdo''.')::utility.system_message,
    ('it', 9, 'La scuola assegnata all''alunno contrassegnato nell''assenza non equivale alla scuola della classe ')::utility.system_message,
    ('it', 10, 'Nell''assenza: %L dello studente: %L. la scuola: %L non corrisponde a quella della classe: %L.')::utility.system_message,
    ('it', 11, 'Provare a re-inserire l''alunno assegnato all''assenza.')::utility.system_message,
    ('it', 12, 'Nell''assenza inserita dello studente: %L . la scuola %L non corrisponde alla scuola segnata alla classe: %L.')::utility.system_message,
    ('it', 13, 'La scuola assegnata all''insegnante dell''assenza. Non corrisponde alla scuola assegnata alla classe.')::utility.system_message,
    ('it', 14, 'Nell''assenza: %L inserita dall''insegnante: %L, non corrisponde la scuola: %L con quella assegnata alla classe: %L.')::utility.system_message,
    ('it', 15, 'Provare a re-inserire i dati.')::utility.system_message,
    ('it', 16, 'Nell''assenza inserita dall''insegnante: %L, non corrisponde la scuola: %L con quella assegnata alla classe: %L.')::utility.system_message,
    ('it', 17, 'Nel giorno dell''assenza inserita l''alunno è gia segnato come ''in ritardo''.')::utility.system_message,
    ('it', 18, 'Nell''assenza: %L con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritardo''.')::utility.system_message,
    ('it', 19, 'Provare a re-inserire la data dell''assenza oppure il nome dell''alunno.')::utility.system_message,
    ('it', 20, 'Nell''assenza con descrizione : %L dello studente: %L in data %L, lo studente è già segnato come ''in ritardo''.')::utility.system_message,
    ('it', 21, 'Nel giorno inserito dell''assenza lo studente inserito è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 22, 'Nell''assenza. %L dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 23, 'Provare e re-inserire la data dell''assenza.')::utility.system_message,
    ('it', 24, 'Nell''assenza dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito in anticipo''.')::utility.system_message,
    ('it', 25, 'Nel giorno inserito dell''assenza lo studente inserito è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 26, 'Nell''assenza. %L dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 27, 'Provare e re-inserire la data dell''assenza.')::utility.system_message,
    ('it', 28, 'Nell''assenza dello studente: %L della classe: %L in data: %L è già registrato come ''Uscito dalla classe''.')::utility.system_message,
    ('it', 29, 'Lo studente inserito nell''assenza non è riconosciuto come ''studente''.')::utility.system_message,
    ('it', 30, 'Nell''assenza: %L, lo studente %L inserito non è riconosciuto con il ruolo di ''studente''.')::utility.system_message,
    ('it', 31, 'Provare e re-inserire i dati.')::utility.system_message,
    ('it', 32, 'Nell''assenza inserita dello studente %L assegnato non è riconosciuto con il ruolo di ''studente''.')::utility.system_message,
    ('it', 33, 'L''insengnante che ha inserito l''assenza non è riconosciuto come ''insegnante''.')::utility.system_message,
    ('it', 34, 'Nell''assenza: %L, inserita dall''insegnante %L  non è riconosciuto con il ruolo di ''insegnante''.')::utility.system_message,
    ('it', 35, 'Provare e re-inserire i dati.')::utility.system_message,
    ('it', 36, 'Nell''assenza inserita dall''insegnante %L  non è riconosciuto con il ruolo di ''insengnate''.')::utility.system_message];
BEGIN
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT s.school, cs.classroom , cs.student
    INTO me.school , me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years s ON s.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that in the on_date of absence there is at least one lesson
--
  PERFORM DISTINCT 1 
     FROM lessons l
     JOIN classrooms_students cs ON cs.classroom = l.classroom
    WHERE cs.classroom_student = new.classroom_student
      AND l.on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.absence,  me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	  
  END IF;
--
-- Check that the student, in the on_date, has not already been recorded as delay
--
  IF new.explanation IS NOT NULL THEN
  
    PERFORM 1 
       FROM explanations e
      WHERE e.explanation=new.explanation 
        AND e.student = me.student
        AND e.created_on >= new.on_date 
        AND new.on_date BETWEEN from_time AND to_time ;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
	RAISE EXCEPTION USING
	  ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
	  MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.absence, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
	  ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
	  MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;	   
    END IF;
  END IF;
--
-- Check that the school of the student equals that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = me.student
      AND p.school = me.school;
      
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.absence, me.student, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), me.student, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;	   
    END IF;
--
-- Checking that the school of the teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.absence, new.teacher, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;	   
    END IF;	
--
-- Checking that the student, in the on_date, has not already been recorded as delay
--
  PERFORM 1 
     FROM delays d
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;

  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.absence, me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;	   
  END IF;
-- 
-- Checking that the student, in the on_date, has not already been recorded as exit
--
  PERFORM 1
     FROM leavings 
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;
    
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,22),new.absence, me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,23);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,24),me.student, me.classroom, new.on_date),
        HINT = utility.system_messages_locale(system_messages,23);
    END IF;	   
  END IF;
--
-- Checking that the student, in the on_date, has not already been recorded as exit of class
--
  PERFORM 1 
     FROM out_of_classrooms 
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;
      
      IF FOUND THEN
        IF (TG_OP = 'UPDATE') THEN
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'D'),
            MESSAGE = utility.system_messages_locale(system_messages,25),
	    DETAIL = format(utility.system_messages_locale(system_messages,26), new.absence, me.student, me.classroom, new.on_date),
	    HINT = utility.system_messages_locale(system_messages,27);
        ELSE
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'E'),
            MESSAGE = utility.system_messages_locale(system_messages,25),
            DETAIL = format(utility.system_messages_locale(system_messages,28), me.student, me.classroom, new.on_date),
            HINT = utility.system_messages_locale(system_messages,27);
        END IF;	   
      END IF;
--
-- Check that the student is in rule students
--
  IF NOT in_any_roles(me.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
        MESSAGE = utility.system_messages_locale(system_messages,29),
        DETAIL = format(utility.system_messages_locale(system_messages,30), new.absence, me.student),
        HINT = utility.system_messages_locale(system_messages,31);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
        MESSAGE = utility.system_messages_locale(system_messages,29),
        DETAIL = format(utility.system_messages_locale(system_messages,32), me.student),
        HINT = utility.system_messages_locale(system_messages,31);
      END IF;	   
    END IF;
--
-- Check that the teachers is in rule teachers
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.absence, new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'L'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;	   
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_absences_iu() OWNER TO postgres;

--
-- Name: tr_classrooms_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classrooms_iu() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO public, utility, pg_temp
    AS $$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The''schools_years'' and ''degrees'' aren''t about the same school.')::utility.system_message,
    ('en', 2, 'In the classroom: %L , the ''schools_years'': %L and the ''degrees'': %L aren''t about the same school.')::utility.system_message,
    ('en', 3, 'Edit  the value of: ''school_year'' and ''degree'' and repeat the operation.')::utility.system_message,
    ('it', 1, 'L''anno scolastico e l''indirizzo scolastico non sono dello stesso istituto.')::utility.system_message,
    ('it', 2, 'Nella classe: %L l''anno_scolastico: %L e l''indirizzo_scolastico: %L non sono dello stesso istituto.')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''school_year'' e ''degree'' e riproporre l''operazione.')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that school_year and degree are of the same school
--
  PERFORM 1 
     FROM school_years a
     JOIN degrees i ON i.school = a.school
    WHERE a.school_year = new.school_year
      AND i.degree = new.degree;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom, new.school_year, new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom, new.school_year, new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
  
RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classrooms_iu() OWNER TO postgres;

--
-- Name: tr_classrooms_students_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_classrooms_students_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  full_function_name 	varchar; 
  context 		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The classroom and the student aren''t about the same school')::utility.system_message,
    ('en', 2, 'On the association classrooms_students: %L , the classroom: %L and the student: %L aren''t about the same school')::utility.system_message,
    ('en', 3, 'Correct the values of: ''classrooms'' and ''students'' and repeat the operation ')::utility.system_message,
    ('en', 4, 'On the association classrooms_students which is being inserted, the classroom: %L and the student: %L aren''t about the same school.')::utility.system_message,
    ('it', 1, 'La classe e alunno non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nell''associazione classi_alunni: %L , la classe: %L e l''alunno: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''classe'' e ''alunno'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nell''associazione classi_alunni che si sta inserendo la classe: %L e l''alunno: %L non sono dello stesso istituto')::utility.system_message];
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that classroom and student are of the same school
--
  PERFORM 1 
     FROM classrooms c
     JOIN school_years a ON a.school_year = c.school_year
     JOIN persons p ON a.school = p.school
    WHERE c.classroom = new.classroom
      AND p.person = new.student;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.classroom_student, new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
--
-- A student may be part of multiple classes in the case, for example, wherein there are classes for 
-- language teaching sraniera transverse to the sections for pupils (4a, 4b, 4c are english 
-- i.e. class 4en and other students, always of 4a, 4b, 4c are Chinese i.e. 4cn)
-- This comment was made to avoid repeating the mistake of adding an incorrect control: 
-- that the student will face only part of a class
--
 RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_classrooms_students_iu() OWNER TO postgres;

--
-- Name: tr_communications_media_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_communications_media_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'Is impossible request the notification if the communications mean doesn''t handle it')::utility.system_message,
    ('en', 2, 'Is impossibile to upgrade to ''TRUE'' the ''notification'' of ''communication_media'': %L about the table ''communications_medias'' ')::utility.system_message,
    ('en', 3, 'For ''type_communication'' indicated the unique value permissible for the column ''notification'' is ''FALSE'',refresh the value or change ''type_communication'' and repeat the operation. ')::utility.system_message,
    ('en', 4, 'Is impossible to insert a ''communication_media'' about the table ''communications_medias'' with the column ''notifications'' set to ''TRUE'' if the ''communications_media'' indicated: %L of the table ''communications_media'' doesn''t runs the notifications (column ''notifications_gesture'' = ''FALSE'')')::utility.system_message,
    ('en', 5, 'The ''school'' of ''person'' isn''t the same of the ''communication_type''')::utility.system_message,
    ('en', 6, 'The ''comunication_type'': %L of ''communication_media'' %L hasn''t the same ''school'' of the ''person'': %L.')::utility.system_message,
    ('en', 7, 'Change the code either for the ''communication_type'' or ''person'' and resubmit the operation')::utility.system_message,
    ('en', 8, 'The ''communication_media'' %L hasn''t the same ''school'' of the ''person'': %L.')::utility.system_message,
    ('it', 1, 'Non è possibile richiedere la notifica se il tipo di comunicazione non la gestisce')::utility.system_message,
    ('it', 2, 'Non è possibile aggiornare a ''TRUE'' la ''notifica'' del ''mezzo_di_comunicazione'': %L della tabella ''mezzi_comunicazione'' perchè il ''tipo_comunicazione'': %L della tabella ''tipi_comunicazione'' non lo gestisce (colonna ''gestione_notifica'' = ''FALSE''٩.')::utility.system_message,
    ('it', 3, 'Per il ''tipo_comunicazione'' indicato l''unico valore ammisibile per la colonna ''notifica'' è ''FALSE'' aggiornare il dato o cambiare ''tipo_comunicazione'' e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Non è possibile inserire un ''mezzo_comunicazione'' della tabella ''mezzi_comunicazione'' con la colonna ''notifica'' impostata a ''TRUE'' se il ''mezzo_di_comunicazione'' indicato: %L della tabella ''mezzi_comunicazione'' non gestisce la notifica (colonna ''gestione_notifica'' = ''FALSE'')')::utility.system_message,	
    ('it', 5, 'La ''school'' della ''person'' non è lo stesso del ''coomunication_type''')::utility.system_message,
    ('it', 6, 'Il ''comunication_type'': %L del ''communication_media'' %L non ha lo stesso ''school'' della ''person'': %L.')::utility.system_message,
    ('it', 7, 'Cambiare il codice per il dato ''communication_type'' o ''person'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Il ''communication_media'' %L non ha lo stesso ''school'' della ''person'': %L.')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- if requested the notification check that communication_media manages it 
--
  IF new.notification = TRUE THEN
  
    PERFORM 1 
       FROM communication_types 
      WHERE communication_type = new.communication_type 
        AND notification_management = TRUE;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.communication_media, new.communication_type),
          HINT = utility.system_messages_locale(system_messages,3);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,4), new.communication_type),
          HINT = utility.system_messages_locale(system_messages,3);
      END IF;	   
    END IF;
  END IF;
--
-- Check that the school of communication_type is equal to that of the person
--
  PERFORM 1 
     FROM communication_types ct
     JOIN persons p ON p.school = ct.school
    WHERE ct.communication_type = new.communication_type
      AND p.person = new.person;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.communication_media, new.communication_type, new.person),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.communication_type, new.person),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;	   
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_communications_media_iu() OWNER TO postgres;

--
-- Name: tr_conversations_invites_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_conversations_invites_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  full_function_name	varchar;
  context		text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'In ''conversations_invites'': %L the conversations student: %L and the invites: %L aren'' form the same school ')::utility.system_message,
    ('en', 2, 'In ''conversations_invites'': %L the conversations student: %L and the invites: %L aren'' form the same school ')::utility.system_message,
    ('en', 3, 'Correct the value of: ''conversation'' and ''invites'' and repeat the operation. ')::utility.system_message,
    ('en', 4, 'In ''conversation_invite'' or is being the insert of ''conversation'': %L and ''invite'': %L aren''t from the same school  ')::utility.system_message,
    ('it', 1, 'Nella ''conversazione_invitato'': %L l''alunno della conversazione: %L e l''invitato: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nella ''conversazione_invitato'': %L l''alunno della conversazione: %L e l''invitato: %L non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''conversazione'' e ''invitato'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella ''conversazione_invitato'' o che si sta inserendo la ''conversazione'': %L e ''invitato'': %L non sono dello stesso istituto')::utility.system_message];	
BEGIN
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the person invited both of the same institute of student 
--
  PERFORM 1 
     FROM conversations c
     JOIN classrooms_students ca ON c.classroom_student = ca.classroom_student
     JOIN persons s ON s.person = ca.student 
     JOIN persons i ON i.school = s.school
    WHERE c.conversation = new.conversation
      AND i.person = new.invited;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.conversation_invite, new.conversation, new.invited),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.conversation, new.invited),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;	   
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_conversations_invites_iu() OWNER TO postgres;

--
-- Name: tr_delays_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_delays_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
  classroom		bigint;
  student		bigint;
-- variables for system tool
  context		text;
  full_function_name    text;
  system_messages    utility.system_message[] = ARRAY [
    ('en', 1, 'There is no lesson on the day of the delay.')::utility.system_message,
    ('en', 2, 'In day: %L delay: %L class: %L did not have lesson.')::utility.system_message,
    ('en', 3, 'Before inserting a delay you need to enter the lessons then enter the required data or check the proposed values ​​and, if necessary, correct them.')::utility.system_message,
    ('en', 4, 'In day: %L of delay that you want to enter class: %L has no lesson.')::utility.system_message,
    ('en', 5, 'The justification indicated is invalid.')::utility.system_message,
    ('en', 6, 'Delay: %L has the justification: %L which is not valid because it is not relative to the student: %L or the margin of the criterion: %L is not greater than or equal To the creation of justification or even the day of the criterion is not included in the data '' from '' and '' to the justification .')::utility.system_message,
    ('en', 7, 'Check that justifications have the correct values ​​for the fields: ''created at'', ''from'' and ''to'' .')::utility.system_message,
    ('en', 8, 'The delay you are entering has the justification: %L which is not valid because it is not relative to the student: %L or the margin of the criterion: %L is not greater than Equal to that of creating justifications, or even the day of judgment is not included in data '' from '' and '' to justification .')::utility.system_message,
    ('en', 9, 'The student does not belong to the same institute of the class.')::utility.system_message,
    ('en', 10, 'Late: %L who is updating the student: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 11, 'Check the student or class indicated and retry the operation.')::utility.system_message,
    ('en', 12, 'In the delay you are entering the student: %L (a person in the person table) does not belong to the same institution: %L of the class: %L.')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same class institute.')::utility.system_message,
    ('en', 14, 'In Late: %L who is updating the teacher: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 15, 'Check the instructor or class indicated and retry the operation.')::utility.system_message,
    ('en', 16, 'In the delay you are entering the teacher: %L (a person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 17, 'It is not possible to enter a delay if, on the day indicated, the student has already been reported as absent.')::utility.system_message,
    ('en', 18, 'In delay: %L who is updating the classroom_student: %L in day: %L is also entered as absent.')::utility.system_message,
    ('en', 19, 'Correct the classroom_student or the day and retry the operation.')::utility.system_message,
    ('en', 20, 'In the delay that you are entering the classroom_student: %L in the day: %L is also entered as absent.')::utility.system_message,
    ('en', 33, 'The instructor indicated is not in the ''teachers'' role.')::utility.system_message,
    ('en', 34, 'In absence: %L is updating, the instructor indicated: %L did not assign the ''Teacher'' role.')::utility.system_message,
    ('en', 35, 'Checking the teacher''s value and reproposing the'' operation'' .')::utility.system_message,
    ('en', 36, 'In the absence that is being entered, the instructor indicated: %L did not assign the ''Teacher'' role.')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno del ritardo.')::utility.system_message,
    ('it', 2, 'Nel giorno: %L del ritardo: %L la classe: %L non ha avuto lezione.')::utility.system_message,
    ('it', 3, 'Prima di inserire un ritardo è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli.')::utility.system_message,
    ('it', 4, 'Nel giorno: %L del ritardo che si vuole inserire la classe: %L non ha avuto lezione.')::utility.system_message,
    ('it', 5, 'La giustificazione indicata non è valida.')::utility.system_message,
    ('it', 6, 'Il ritardo: %L ha la giustificazione: %L che non è valida perchè: non è relativa all''alunno: %L oppure il gorno dell''ritardo: %L non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''ritardo non è compreso nei dati ''dal'' e ''al'' della giustificazione.')::utility.system_message,
    ('it', 7, 'Controllare che la giustificazione abbia i corretti valori per i campi: ''creata_il'', ''dal'' e ''al''.')::utility.system_message,
    ('it', 8, 'Il ritardo che si sta inserendo ha la giustificazione: %L che non è valida perchè: non è relativa all''alunno: %L oppure il gorno dell''ritardo: %L non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''ritardo non è compreso nei dati ''dal'' e ''al'' della giustificazione.')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 10, 'Nel ritardo: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 12, 'Nel ritardo che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 14, 'Nel ritardo: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'Nel ritardo che si sta inserendo il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 17, 'Non è possibile inserire un ritardo se, nel giorno indicato, l''alunno è già stato segnalato come assente.')::utility.system_message,
    ('it', 18, 'Nel ritardo: %L che si sta aggiornando il classroom_student: %L nel giorno: %L è anche inserito come assente.')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione.')::utility.system_message,
    ('it', 20, 'Nel ritardo che si sta inserendo il classroom_student: %L nel giorno: %L è anche inserito come assente.')::utility.system_message,
    ('it', 33, 'Il docente indicato non è nel ruolo ''docenti''.')::utility.system_message,
    ('it', 34, 'Nell''assenza: %L che si sta aggiornando, il docente indicato: %L non ha assegnato il ruolo ''Teacher''.')::utility.system_message,
    ('it', 35, 'Controllare il valore del docente e riproporre l''operazione.')::utility.system_message,
    ('it', 36, 'Nell''assenza che si sta inserendo, il docente indicato: %L non ha assegnato il ruolo ''Teacher''.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT s.school, cs.classroom , cs.student
    INTO me.school , me.classroom, me.student
    FROM delays d
    JOIN classrooms_students cs ON cs.classroom_student = d.classroom_student
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years s ON s.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- Check that the on_dates of delay there is at least one lesson
--
  PERFORM 1 
     FROM lessons l
    WHERE l.classroom = me.classroom
      AND on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.delay,  me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- control that the explanation, if indicated, both related to that student, at that on_dates of delay and created after or to_time maximum on_dates same as delay
--
  IF new.explanation IS NOT NULL THEN

    PERFORM 1 
       FROM explanations e
      WHERE e.explanation = new.explanation 
        AND e.student = me.student 
        AND created_on >= new.on_date 
        AND new.on_date BETWEEN from_time AND to_time ;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.delay, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;    
    END IF;
  END IF;
--
-- Check that the school's teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.delay, new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Student in delay cannot be absent
--
  PERFORM 1 
     FROM absences
    WHERE on_date = new.on_date 
      AND classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.delay, new.classroom_student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), new.classroom_student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- Check that the teacher is in rule 'teacher'
--
  IF NOT in_any_roles(new.teacher,'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.delay, new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_delays_iu() OWNER TO postgres;

--
-- Name: tr_explanations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_explanations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
  born			date;
-- variables for system tools
  context		text;
  full_function_name	text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil is not in the ''pupils'' role')::utility.system_message,
    ('en', 2, 'In justification: %L who is updating the pupil: %L (one person in the people table) does not have a linked user entered in the pupils role')::utility.system_message,
    ('en', 3, 'Check that the student user is included in the pupil role and retry the operation')::utility.system_message,
    ('en', 4, 'In justification you are entering the pupil: %L (a person in the person table) does not have a linked user inserted in the pupils role')::utility.system_message,
    ('en', 5, 'The student institution is not the same as the person indicated by the field: ''created_by ''')::utility.system_message,
    ('en', 6, 'In justification: %L that is being updated, pupil %L does not belong to the same institution: %L of the person: %L indicated in the ''created_from''field')::utility.system_message,
    ('en', 7, 'Controller ''pupil''and the person indicated in ''created_by'' and retry the operation')::utility.system_message,
    ('en', 8, 'In justification that you are entering, the pupil%L does not belong to the same institute: %L of the person: %L indicated in the ''created_by'' field')::utility.system_message ,
    ('en', 9, 'The pupil is not of age and therefore can not include justifications')::utility.system_message,
    ('en', 10, 'In justification: %L being updated,''pupil'': %L is no age and therefore can not enter justifications')::utility.system_message,
    ('en', 11, 'Check the value of ''created_by'' and retry the operation')::utility.system_message,
    ('en', 12, 'In justification that is being inserted, ''pupil:'' %L is no age and therefore can not include justifications')::utility.system_message,
    ('en', 13, 'The person indicated in ''created_by'' is not authorized')::utility.system_message,
    ('en', 14, 'In justification: %L being updated, the person: %L indicated in the ''created_from'' field is not a family member enabled and majority and is not even in the roles of:''leaders'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 15, 'Check the person indicated in the column ''created_by ''and retry the operation')::utility.system_message,
    ('en', 16, 'In the justification that is being entered, the person: %L indicated in the field ''created_by ''is not a qualified family and is not even in the roles of ''managers'', ''leaders'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 17, 'The person who filed the justification is not the same institution as the pupil')::utility.system_message,
    ('it', 18, 'In justification: %L that is being updated, pupil: %L does not belong to the same institution: %L of the person: %L indicated in the ''registered_from'' field')::utility.system_message,
    ('en', 19, 'Check the person indicated in the column: ''registered_from'' and repeat the operation')::utility.system_message,
    ('en', 20, 'In justification that is being entered, the pupil: %L does not belong to the same institute: %L of the person: %L indicated in the field ''registered_by ''')::utility.system_message ,
    ('en', 21, 'The person indicated in the ''registered'' column is not a member of any of the following roles: ''managers'', ''executives '', ''employees'' ')::utility.system_message,
    ('en', 22, 'In justification: %L being updated, the person indicated in the column: ''registered_from'' does not belong to any of the following roles: ''managers'', ''executives'', ''employees'', ''teachers'' ')::utility.system_message,
    ('en', 23, 'Check the value of the column: ''registered_by ''and re-propose the operation')::utility.system_message,
    ('en', 24, 'In the justification that is being entered, the person indicated in the column: ''registered_from'' does not belong to any of the following roles: ''managers'', '' executives'', ''teachers'' ')::utility.system_message,
    ('it', 1, 'L''alunno non è inserito nel ruolo ''alunni''')::utility.system_message,
    ('it', 2, 'Nella giustificazione: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non ha un utente collegato inserito nel ruolo alunni')::utility.system_message,
    ('it', 3, 'Controllare che l''utente dell''alunno sia inserito nel ruolo alunni e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella giustificazione si sta inserendo l''alunno: %L (una persona della tabella persone) non ha un utente collegato inserito nel ruolo alunni')::utility.system_message,
    ('it', 5, 'L''istituto dell''alunno no è lo stesso della persona indicata dal campo: ''creato_da''')::utility.system_message,
    ('it', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''')::utility.system_message,
    ('it', 7, 'Controllare l'' ''alunno'' e la persona indicata in ''creata_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''')::utility.system_message,
    ('it', 9, 'L''alunno non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 10, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 11, 'Controllare il valore di ''creato_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella giustificazione che si sta inserendo, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni')::utility.system_message,
    ('it', 13, 'La persona indicata in ''creata_da'' non è autorizzata')::utility.system_message,
    ('it', 14, 'Nella giustificazione: %L che si sta aggiornando, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 15, 'Controllare la persona indicata nella colonna ''creata_da'' e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nella giustificazione che si sta inserendo, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 17, 'La persona che ha registrato la giustificazione non è dello stesso istituto dell''alunno')::utility.system_message,
    ('it', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registrato_da''')::utility.system_message,
    ('it', 19, 'Controllare la persona indicata nella colonna ''registrata:_da'' e riproporre l''operazione')::utility.system_message,
    ('it', 20, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registrato_da''')::utility.system_message,
    ('it', 21, 'La persona indicata nella colonna ''registrato_da'' non è membro di nessuno dei seguenti ruoli: ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 22, 'Nella giustificazione: %L che si sta aggiornando, la persona indicata nella colonna: ''registrato_da'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message,
    ('it', 23, 'Controllare il valore della colonna: ''registrato_da'' e riproporre l''operazione')::utility.system_message,
    ('it', 24, 'Nella giustificazione che si sta inserendo, la persona indicata nella colonna: ''registrato_da'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the funcion
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  --
  -- Checking that the student role is student
  --
  IF NOT in_any_roles(new.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),   
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.explanation, new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.student),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;       
  END IF;
  --
  -- Recovery the school and the on_dates of birth of the student
  --
  SELECT p.school, p.born 
    INTO me.school, me.born
    FROM persons p
   WHERE p.person = new.student;
  --
  -- Checking that the school of student is equal to that of the person who created the explanation
  --
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.created_by 
      AND p.school = me.school;
  
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.explanation, new.student, me.school, new.created_by),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.student, me.school, new.created_by),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  --
  -- Check that if the explanation has been made from a student and this is an adult
  --
  IF new.created_by = new.student THEN
    IF (SELECT extract('year' from age(new.created_on, me.born)) < 18) THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.explanation, new.student),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;
    END IF;
  END IF;
  
    --
    -- Otherwise control if the person who created the explanation is in rule of
    -- managers, executives, employees or teachers
    --
  IF in_any_roles(new.created_by,'Supervisor','Executive','Employee','Teacher') THEN
  ELSE
    PERFORM 1 
       FROM persons_relations pr
       JOIN persons p ON pr.person_related_to = p.person
      WHERE pr.person = new.student
        AND pr.person_related_to = new.created_by
        AND pr.can_do_explanation = true
        AND extract('year' from age(new.registered_on, p.born)) >= 18;
  --
  -- control that if the explanation has been made from_time a family
  -- explicitly permitted to justify and adult
  --
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.explanation, new.created_by),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,16), new.created_by),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;   
    END IF;         
  END IF;
--  
-- Check that the school of student is equal to that of the person who has registered the explanation
--
  IF new.registered_by IS NOT NULL THEN

    PERFORM 1 
       FROM persons p
      WHERE p.person = new.registered_by 
        AND p.school = me.school;
        
      IF NOT FOUND THEN
        IF (TG_OP = 'UPDATE') THEN
          RAISE EXCEPTION USING
            ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
            MESSAGE = utility.system_messages_locale(system_messages,17),
            DETAIL = format(utility.system_messages_locale(system_messages,18), new.explanation, new.student, me.school, new.registered_by),
            HINT = utility.system_messages_locale(system_messages,19);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,20), new.student, me.school, new.registered_by),
          HINT = utility.system_messages_locale(system_messages,19);
      END IF;    
    END IF;
--
-- Checking that the person who registered the explanation is a teacher, a clerk, a manager or a manager
--
    IF NOT in_any_roles(new.registered_by, 'Supervisor','Executive','Employee','Teacher')  THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
          MESSAGE = utility.system_messages_locale(system_messages,21),
          DETAIL = format(utility.system_messages_locale(system_messages,22), new.explanation, new.registered_by),
          HINT = utility.system_messages_locale(system_messages,23);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
          MESSAGE = utility.system_messages_locale(system_messages,21),
          DETAIL = format(utility.system_messages_locale(system_messages,24), new.registered_by),
          HINT = utility.system_messages_locale(system_messages,23);
      END IF;      
    END IF;         
  END IF;
    
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_explanations_iu() OWNER TO postgres;

--
-- Name: tr_faults_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_faults_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
-- variables for system tool
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'the pupil is not part of the class indicated in lesson')::utility.system_message,
    ('en', 2, 'In the absence of: ''%s'' the pupil: ''%s'' is not part of the class of the lesson: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the pupil and lesson and repeat the operation')::utility.system_message,
    ('en', 4, 'In lack that you are inserting the pupil: ''%s'' is not part of the class of the lesson: ''%s''')::utility.system_message,
    ('en', 5, 'The note indicated is not related to the pupil and the class indicated by the lesson')::utility.system_message,
    ('en', 6, 'In the absence of: ''%s'' Note: ''%s'' is not related to the pupil: ''%s'' or to the class indicated by the lesson: ''%s''')::utility.system_message,
    ('en', 7, 'Check the values of the pupil and lesson and repeat the operation')::utility.system_message,
    ('en', 8, 'In lack that you are inserting the note: ''%s'' is not related to the pupil: ''%s'' or The class indicated by the lesson: ''%s''')::utility.system_message,
    ('en', 9, 'the pupil indicated is not in the role the ''alunni''')::utility.system_message,
    ('en', 10, 'In the absence of: ''%s'' that you are updating, the pupil indicated: ''%s'' is not present in the role pupils (the user connected to the person is not authorised for the role the ''alunni''')::utility.system_message,
    ('en', 11, 'Check the value of the pupil and repeat the operation')::utility.system_message,
    ('en', 12, 'In lack that you are inserting the pupil indicated: ''%s'' is not present in the role pupils (the user connected to the person is not authorised for the role the ''alunni''')::utility.system_message,
    ('it', 1, 'L''alunno non fa'' parte della classe indicata nella lezione')::utility.system_message,
    ('it', 2, 'Nella mancanza: ''%s'' l''alunno: ''%s'' non fa'' parte della classe della lezione: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori di alunno e lezione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella mancanza che si sta'' inserendo l''alunno: ''%s'' non fa'' parte della classe della lezione: ''%s''')::utility.system_message,
    ('it', 5, 'La nota indicata non è relativa all''alunno ed alla classe indicata dalla lezione')::utility.system_message,
    ('it', 6, 'Nella mancanza: ''%s'' la nota: ''%s'' non è relativa all''alunno: ''%s'' oppure alla classe indicata dalla lezione: ''%s''')::utility.system_message,
    ('it', 7, 'Controllare i valori di alunno e lezione e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nella mancanza che si sta inserendo la nota: ''%s'' non è relativa all''alunno: ''%s'' oppure alla classe indicata dalla lezione: ''%s''')::utility.system_message,
    ('it', 9, 'L''alunno indicato non è nel ruolo ''alunni''')::utility.system_message,
    ('it', 10, 'Nella mancanza: ''%s'' che si sta aggiornando, l''alunno indicato: ''%s'' non è presente nel ruolo alunni (l''utente collegato alla persona non è autorizzato al ruolo ''alunni'')')::utility.system_message,
    ('it', 11, 'Controllare il valore dell''alunno e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'Nella mancanza che si sta inserendo, l''alunno indicato: ''%s'' non è presente nel ruolo alunni (l''utente collegato alla persona non è autorizzato al ruolo ''alunni'')')::utility.system_message];
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the student is part of the classroom of the lesson
--
  PERFORM 1 
     FROM lessons l
     JOIN classrooms_students ca ON  ca.classroom = l.classroom
    WHERE l.lesson = new.lesson
      AND ca.student = new.student;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.fault, new.student,  new.lesson),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4),  new.student,  new.lesson),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Check that the the studen on the note is the same that in fault
-- and the classroom of the note is the same that in the lesson 
--
  IF new.note IS NOT NULL THEN
    PERFORM 1 
       FROM notes n
       JOIN faults f ON f.note = n.note
       JOIN lessons l ON l.lesson = f.lesson
      WHERE n.note = new.note
        AND n.student = new.student
        AND l.lesson = new.lesson
        AND n.classroom = l.classroom;

    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.fault, new.note, new.student, new.lesson),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.note, new.student, new.lesson),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;      
    END IF;
  END IF;
--
-- check that the student is in the rule students
--
  IF NOT in_any_roles(new.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.fault, new.student),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.student),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;
  END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_faults_iu() OWNER TO postgres;

--
-- Name: tr_grading_meetings_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context text;
  full_function_name text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The grading meeting has a date not covered by the beginning and end of the school year')::utility.system_message,
    ('en', 2, 'Date of the grading meeting: %L is not included in the school year: %L')::utility.system_message,
    ('en', 3, 'To correct the ''date'' of the grading meeting or the '' school_year '' to which he does reference and resubmit the operation')::utility.system_message,
    ('en', 4, 'Date: %L of the grading meeting: %L is not included in the school year: %L')::utility.system_message,
    ('it', 1, 'Lo scrutinio ha una data non compresa fra l''inizio e fine dell''anno scolastico')::utility.system_message,
    ('it', 2, 'La data dello scrutinio: %L non è compresa nella durata dell''anno scolastico: %L')::utility.system_message,
    ('it', 3, 'Correggere la ''data'' dello scrutinio oppure l'' ''anno_scolastico'' a cui si fa'' riferimento e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La data: %L dello scrutinio: %L non è compresa nella durata dell''anno scolastico: %L')::utility.system_message];
BEGIN
  --
  -- Retrieve the name of the funcion
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  --
  -- the meeting of evaluation "on_date" you must be inclusive in the days of lesson of the school
  --
  PERFORM 1 FROM grading_meetings s
     JOIN school_years a ON a.school_year = s.school_year
    WHERE s.school_year = new.school_year
      AND new.on_date <@ a.duration;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.school_year),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, new.grading_meeting, new.school_year),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;
  END IF;
  RETURN new;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_iu() OWNER TO postgres;

--
-- Name: tr_grading_meetings_valutations_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'The poll is closed')::utility.system_message,
    ('en', 2, 'The ''grading_meeting_valutation'': ''%s'' refer to the ''grading_meeting'': ''%s''  that it is closed ')::utility.system_message,
    ('en', 3, 'To correct the value of ''grading_meeting '' and to propose the operation')::utility.system_message,
    ('it', 1, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione'': ''%s'' fa riferimento allo ''scrutinio'': ''%s'' che è chiuso')::utility.system_message,
    ('it', 3, 'Correggere il valore di ''scrutinio '' e riproporre l''operazione')::utility.system_message];	
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the grading_meeting is open
--
  PERFORM 1 FROM grading_meetings 
    WHERE grading_meeting = old.grading_meeting
      AND closed = false;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), new.grading_meeting_valutation, new.grading_meeting),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_d() OWNER TO postgres;

--
-- Name: tr_grading_meetings_valutations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The ''grading_meeting'' is not of the same ''school_years'' of the ''class''')::utility.system_message,
    ('en', 2, 'The ''grading_meeting_valutation'': ''%s'' refer to the ''grading_meeting'': ''%s'' and a ''class'': ''%s'' that does not belong to ''school_years''')::utility.system_message,
    ('en', 3, 'To correct the values of: ''grading_meeting'' and ''school_years'' and repeat the operation')::utility.system_message,
    ('en', 4, 'In the ''grading_meeting_valutation'' that you are inserting they are suitable the ''grading_meeting'': ''%s'' and a ''class'': ''%s'' that does not belong to ''school_years''')::utility.system_message,
    ('en', 5, 'The student does not bolong to the ''class''')::utility.system_message,
    ('en', 6, 'The ''grading_meeting_valutation'': ''%s'' indicates a ''student'': ''%s'' that does not belong to''class'': ''%s''')::utility.system_message,
    ('en', 7, 'To correct the values of: ''student'' and ''class'' and repeat the operation')::utility.system_message,
    ('en', 8, 'In the ''grading_meeting_valutation'' that are inserting ''student'': ''%s'' that does not belong to ''class'': ''%s''')::utility.system_message,
    ('en', 9, 'The ''materia'' does not belong to the same institute of the ''school_years'' of the ''grading_meeting''')::utility.system_message,
    ('en', 10, 'The ''grading_meeting_valutation'': ''%s''indicates a ''materia'': ''%s'' that does not belong to the same istitute of the ''school_years'' of the ''grading_meeting'': ''%s''')::utility.system_message,
    ('en', 11, 'To correct the values of: ''materia'' and ''grading_meeting'' and repeat the operation')::utility.system_message,
    ('en', 12, 'The ''grading_meeting_valutation'' that are inserting indica una ''materia'': ''%s'' that does not belong to the same istitute of the ''school_years'' of the ''grading_meeting'': ''%s''')::utility.system_message,
    ('en', 17, 'The istitute of the ''metrica'' of the ''voto'' are not the same of ''school_years'' of the ''grading_meeting''')::utility.system_message,
    ('en', 18, 'The ''grading_meeting_valutation'': ''%s'' indicates a ''voto'': ''%s'' with a different subject from that of the ''school_years'' of the grading_meeting: ''%s''')::utility.system_message,
    ('en', 19, 'To correct the values of: ''voto'' and ''grading_meeting'' and repeat the operation')::utility.system_message,
    ('en', 20, 'The ''grading_meeting_valutation'' that are inserting indicates a ''voto'': ''%s''  with a metric that have the different istitute from that of the ''school_years'' of the grading_meeting: ''%s''')::utility.system_message,
    ('en', 21, 'The grading_meeting is closed')::utility.system_message,
    ('en', 22, 'The ''grading_meeting_valutation'': ''%s refer to the ''grading_meeting'': ''%s'' that is closed')::utility.system_message,
    ('en', 23, 'To correct the values of: ''grading_meeting '' and repeat the operation')::utility.system_message,
    ('en', 24, 'The ''grading_meeting_valutation'' that are inserting indicates a ''grading_meeting'': ''%s''  that is closed')::utility.system_message,
    ('it', 1, 'Lo ''scrutinio'' non è dello stesso ''anno_scolastico'' della ''classe''')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione'': ''%s'' indica uno ''scrutinio'': ''%s'' e una ''classe'': ''%s'' che non appartengono allo stesso ''anno_scolastico''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''scrutinio'' e ''anno_scolastico'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nella ''scrutinio_valutazione'' che si sta inserendo sono indicati uno ''scrutinio'': ''%s'' e una ''classe'': ''%s'' che non appartengono allo stesso ''anno_scolastico''')::utility.system_message,
    ('it', 5, 'L''alunno non fa'' parte della ''classe''')::utility.system_message,
    ('it', 6, 'La ''scrutinio_valutazione'': ''%s'' indica un ''alunno'': ''%s'' che non appartiene all ''classe'': ''%s''')::utility.system_message,
    ('it', 7, 'Correggere i valori di: ''alunno'' e ''classe'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nella ''scrutinio_valutazione'' che si sta inserendo l''alunno'': ''%s'' non appartiene alla ''classe'': ''%s''')::utility.system_message,
    ('it', 9, 'La ''materia'' non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio''')::utility.system_message,
    ('it', 10, 'La ''scrutinio_valutazione'': ''%s'' indica una ''materia'': ''%s'' che non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio'': ''%s''')::utility.system_message,
    ('it', 11, 'Correggere i valori di: ''materia'' e ''scrutinio'' e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'La ''scrutinio_valutazione'' che si sta inserendo indica una ''materia'': ''%s'' che non appartiene allo stesso istituto dell'' ''anno_scolastico'' dello ''scrutinio'': ''%s''')::utility.system_message,
    ('it', 17, 'L''istituto della ''metrica'' del ''voto'' non è lo stesso dell'' ''anno_scolastico'' dello ''scrutinio''')::utility.system_message,
    ('it', 18, 'La ''scrutinio_valutazione'': ''%s'' indica un ''voto'': ''%s'' con una metrica che ha un istituto diverso da quello dell'' ''anno_scolastico'' dello scrutinio: ''%s''')::utility.system_message,
    ('it', 19, 'Correggere i valori di: ''voto'' e ''scrutinio'' e riproporre l''operazione')::utility.system_message,
    ('it', 20, 'La ''scrutinio_valutazione'' che si sta'' inserendo indica un ''voto'': ''%s'' con una metrica che ha un istituto diverso da quello dell'' ''anno_scolastico'' dello scrutinio: ''%s''')::utility.system_message,
    ('it', 21, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 22, 'La ''scrutinio_valutazione'': ''%s fa'' riferimento allo ''scrutinio'': ''%s'' che è chiuso')::utility.system_message,
    ('it', 23, 'Correggere il valore di ''scrutinio '' e riproporre l''operazione')::utility.system_message,
    ('it', 24, 'La ''scrutinio_valutazione'' che si sta'' inserendo indica uno ''scrutinio'': ''%s''  che è chiuso')::utility.system_message];  
BEGIN 
  --
  -- recover the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the classroom is of the same school_year of the grading_meeting
--
  PERFORM 1 FROM grading_meetings s
     JOIN classrooms c ON s.school_year = c.school_year
    WHERE s.grading_meeting = new.grading_meeting
      AND c.classroom = new.classroom;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.grading_meeting_valutation, new.grading_meeting,  new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.grading_meeting,  new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the student belongs to the classroom
--
  PERFORM 1 FROM classrooms_students ca
    WHERE ca.classroom = new.classroom
      AND ca.student = new.student;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.grading_meeting_valutation, new.classroom,  new.student),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.classroom, new.student),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
--
-- check that the subject belongs to the same school of the school_year of the grading_meeting
--
  PERFORM 1 FROM grading_meetings s
    JOIN school_years a ON s.school_year = a.school_year
    JOIN subjects m ON a.school = m.school
   WHERE s.grading_meeting = new.grading_meeting
     AND m.subject = new.subject;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.grading_meeting_valutation, new.subject,  new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.subject, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;    
  END IF;
--
-- check the school of the metric of the grade both the same of the school_year of the grading_meeting
--
  PERFORM 1 FROM grades v
     JOIN metrics m ON v.metric = m.metric
     JOIN school_years a ON m.school = a.school
     JOIN grading_meetings s ON a.school_year = s.school_year
    WHERE v.grade =  new.grade
      AND s.grading_meeting = new.grading_meeting;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.grading_meeting_valutation, new.grade, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), new.grade, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- check that the grading_meeting is open
--
  PERFORM 1 
     FROM grading_meetings gm
    WHERE gm.grading_meeting = new.grading_meeting
      AND gm.closed = false;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,22), new.grading_meeting_valutation, new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,23);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,21),
        DETAIL = format(utility.system_messages_locale(system_messages,24), new.grading_meeting),
        HINT = utility.system_messages_locale(system_messages,23);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_iu() OWNER TO postgres;

--
-- Name: tr_grading_meetings_valutations_qua_d(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_qua_d() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages    utility.system_message[] = ARRAY [
    ('en', 1, 'The ''grading_meeting_valutation_qua'': ''%s'' refer to the ''grading_meeting_valutation'': ''%s'' that makes reference to a closed poll')::utility.system_message,
    ('en', 2, 'The poll is closed')::utility.system_message,
    ('en', 3, 'Check the value of the: ''grading_meeting'' of the ''grading_meeting_valutation'' and repeat the operation')::utility.system_message,
    ('it', 1, 'La ''scrutinio_valutazione_qualifica'': ''%s fa'' riferimento allo ''scrutinio_valutazione'': ''%s'' che fà riferimento ad uno scrutinio chiuso')::utility.system_message,
    ('it', 2, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 3, 'Correggere il valore di ''scrutinio'' dello ''scrutinio_valutazione'' e riproporre l''operazione')::utility.system_message];
BEGIN 
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the grading_meeting is open
--
  PERFORM 1 FROM grading_meetings_valutations sv
     JOIN grading_meetings s ON s.grading_meeting = sv.grading_meeting
    WHERE sv.grading_meeting_valutation = old.grading_meeting_valutation
      AND s.closed = false;
  IF NOT FOUND THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
      MESSAGE = utility.system_messages_locale(system_messages,1),
      DETAIL = format(utility.system_messages_locale(system_messages,2), old.grading_meeting_valutation_qua, old.grading_meeting_valutation),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  RETURN OLD;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_qua_d() OWNER TO postgres;

--
-- Name: tr_grading_meetings_valutations_qua_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_grading_meetings_valutations_qua_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The istitute of the ''qualifica'' it is not the same of that of the ''alunno'' of the''valutazione''')::utility.system_message,
    ('en', 2, 'The ''scrutinio_valutazione_qualifica'': ''%s'' specific a ''qualifica'': ''%s'' with a different istitute from that the ''alunno'' of the ''valutazione'': ''%s''')::utility.system_message,
    ('en', 3, 'To correct the values of: ''qualifica'' and ''valutazione'' and repeat the operation')::utility.system_message,
    ('en', 4, 'The ''scrutinio_valutazione_qualifica''that he is inserting specification a ''qualifica'': ''%s'' with a different institute from that of the ''alunno'' of the ''valutazione'': ''%s''')::utility.system_message,
    ('en', 9, 'The istitute of the ''qualifica'' it is not the same of that of the ''metrica'' of the ''voto''')::utility.system_message,
    ('en', 10, 'The ''scrutinio_valutazione_qualifica'': ''%s'' specific a ''qualifica'': ''%s'' with a different institute from that of the ''metrica'' of the ''voto'': ''%s''')::utility.system_message,
    ('en', 11, 'To correct the values of: ''qualifica'' and ''voto'' and repeat the operation')::utility.system_message,
    ('en', 12, 'The ''scrutinio_valutazione_qualifica'' that he is inserting specification a ''qualifica'': ''%s''with a different institute from that of the ''metrica'' of the ''voto'': ''%s''')::utility.system_message,
    ('en', 13, 'The ''scrutinio_valutazione_qualifica'': ''%s'' make reference to the ''scrutinio_valutazione'': ''%s'' that indicating a closed poll')::utility.system_message,
    ('en', 14, 'The poll is closed')::utility.system_message,
    ('en', 15, 'To correct the values of: ''scrutinio_valutazione'' and repeat the operation')::utility.system_message,
    ('en', 16, 'The ''scrutinio_valutazione_qualifica'' that he is inserting make reference to the ''scrutinio_valutazione'': ''%s''  that indicating a closed poll')::utility.system_message,
    ('it', 1, 'L''istituto della ''qualifica'' non è lo stesso di quello dell'' ''alunno'' della ''valutazione''')::utility.system_message,
    ('it', 2, 'La ''scrutinio_valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''qualifica'' e ''valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La ''scrutinio_valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 9, 'L''istituto della ''qualifica'' non è lo stesso di quello della ''metrica'' del ''voto''')::utility.system_message,
    ('it', 10, 'La ''scrutinio_valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 11, 'Correggere i valori di: ''qualifica'' e ''voto'' e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'La ''scrutinio_valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 13, 'La ''scrutinio_valutazione_qualifica'': ''%s fa'' riferimento allo ''scrutinio_valutazione'': ''%s'' che indica uno scrutinio chiuso')::utility.system_message,
    ('it', 14, 'Lo scrutinio è chiuso')::utility.system_message,
    ('it', 15, 'Correggere il valore di ''scrutinio_valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 16, 'La ''scrutinio_valutazione_qualifica'' che si sta'' inserendo fa'' riferimento ad uno ''scrutinio_valutazione'': ''%s''  che indica uno scrutinio chiuso')::utility.system_message];
BEGIN 
--
-- Recover the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check that the school of the qualification both the same of that of the student of the grading_meeting_valutation
--
  PERFORM 1 
     FROM grading_meetings_valutations v
     JOIN persons p ON v.student = p.person
     JOIN qualifications q ON p.school = q.school
    WHERE v.grading_meeting_valutation = new.grading_meeting_valutation
      AND q.qualification = new.qualification;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.grading_meeting_valutation_qua, new.qualification,  new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.qualification, new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the school of the qualification both the same of that of the metric of the subject of the grade
--
  IF new.grade IS NOT NULL THEN
    PERFORM 1 FROM grades g
       JOIN metrics m ON g.metric = m.metric
       JOIN qualifications q ON m.school = q.school
      WHERE g.grade = new.grade
        AND q.qualification = new.qualification;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.grading_meeting_valutation_qua, new.qualification,  new.grade),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.qualification,  new.grade),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
  END IF;
--
-- check the grading_meeting is open
--
  PERFORM 1 
     FROM grading_meetings_valutations v
     JOIN grading_meetings m ON m.grading_meeting = v.grading_meeting
    WHERE v.grading_meeting_valutation = new.grading_meeting_valutation
      AND m.closed = false;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.grading_meeting_valutation_qua, new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.grading_meeting_valutation),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    

  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_grading_meetings_valutations_qua_iu() OWNER TO postgres;

--
-- Name: tr_leavings_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_leavings_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school      		bigint;
  classroom		bigint;
  student		bigint;
-- variables for system tool
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is not any lesson in the day of the exit')::utility.system_message,
    ('en', 2, 'In the day : ''%s'' of the exit: ''%s'' the class: ''%s'' has not had lesson')::utility.system_message,
    ('en', 3, 'Before inserting an exit it is necessary to insert the lessons to provide therefore to the insertion of the in demand data or to check the proposed values and eventually to correct them')::utility.system_message,
    ('en', 4, 'In the day: ''%s'' of the exit than is wanted to insert the class: ''%s'' has not had lesson')::utility.system_message,
    ('en', 5, 'The justification is not valid')::utility.system_message,
    ('en', 6, 'The exit: ''%s'' has justification: ''%s'' then is not valid because: is not refer to the student: ''%s'' or the day of the exit: ''%s'' it is not great or equal to that of creation of the justification or still the day of the exit is not inclusive in the data ''from'' and ''to'' of the justification')::utility.system_message,
    ('en', 7, 'To check that justification has the correct values for the fields: ''created_on'', ''from'' e ''to''')::utility.system_message,
    ('en', 8, 'The exit that he is inserting has the justification: ''%s'' than is not valid because: is not refer to the student: ''%s'' or the day of exit: ''%s'' it is not great or equal to that of creation of the justification or still the day of the exit is not inclusive in the data ''from'' and ''to'' of the justification')::utility.system_message,
    ('en', 9, 'The pupil does not belong to the same institute of the class')::utility.system_message,
    ('en', 10, 'To the exit: ''%s'' that is update the student: ''%s'' (a person of the people table) it does not belong to the same istitute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 11, 'Check the student or class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In the exit that you are inserting the pupil: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same institute of the class')::utility.system_message,
    ('en', 14, 'In the exit: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 15, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 16, 'In the exit that you are entering the teacher: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of the class: ''%s''')::utility.system_message,
    ('en', 17, 'The pupil can not be reported as missing in the same day')::utility.system_message,
    ('en', 18, 'In the exit: ''%s'' than are updating the pupil: ''%s'' in the day: ''%s'' is also entered as absent')::utility.system_message,
    ('en', 19, 'Correct the pupil or the day and retry the operation')::utility.system_message,
    ('en', 20, 'In the exit that you are inserting the pupil: ''%s'' in the day: ''%s''  is also entered as absent')::utility.system_message,
    ('en', 33, 'The teacher indicated is not in the role of ''docenti''')::utility.system_message,
    ('en', 34, 'In the absence of: ''%s'' that you are upgrading the teacher stated: ''%s'' not has assigned your role ''teacher''')::utility.system_message,
    ('en', 35, 'Check the value of the teacher and repeat the operation')::utility.system_message,
    ('en', 36, 'In the absence which you are inserting the teacher stated: ''%s'' not has assigned your role ''teacher''')::utility.system_message, 
    ('it', 1, 'Non c''è nessuna lezione nel giorno dell''uscita')::utility.system_message,
    ('it', 2, 'Nel giorno: ''%s'' dell''uscita: ''%s'' la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire un''uscita è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: ''%s'' dell''uscita che si vuole inserire la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 5, 'La giustificazione indicata non è valida')::utility.system_message,
    ('it', 6, 'L''uscita: ''%s'' ha la giustificazione: ''%s'' che non è valida perchè: non è relativa all''alunno: ''%s'' oppure il gorno dell''uscita: ''%s'' non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''uscita non è compreso nei dati ''dal'' e ''al'' della giustificazione')::utility.system_message,
    ('it', 7, 'Controllare che la giustificazione abbia i corretti valori per i campi: ''creata_il'', ''dal'' e ''al''')::utility.system_message,
    ('it', 8, 'L''uscita che si sta inserendo ha la giustificazione: ''%s'' che non è valida perchè: non è relativa all''alunno: ''%s'' oppure il gorno dell''uscita: ''%s'' non è maggiore od uguale a quello di creazione della giustificazione oppure ancora il giorno dell''uscita non è compreso nei dati ''dal'' e ''al'' della giustificazione')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nell'' uscita: ''%s'' che si sta aggiornando l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nell'' uscita che si sta inserendo l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 14, 'Nell'' uscita: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nell'' uscita che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 17, 'L''alunno non può essere segnalato come assente nello stesso giorno')::utility.system_message,
    ('it', 18, 'Nell''uscita: ''%s'' che si sta aggiornando l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione')::utility.system_message,
    ('it', 20, 'Nell''uscita che si sta inserendo l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 33, 'Il docente indicato non è nel ruolo ''docenti''')::utility.system_message,
    ('it', 34, 'Nell''assenza: ''%s'' che si sta aggiornando, il docente indicato: ''%s'' non ha assegnato il ruolo ''Teacher''')::utility.system_message,
    ('it', 35, 'Controllare il valore del docente e riproporre l''operazione')::utility.system_message,
    ('it', 36, 'Nell''assenza che si sta inserendo, il docente indicato: ''%s'' non ha assegnato il ruolo ''Teacher''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of the classroom
--
  SELECT sy.school, cs.classroom, cs.student
    INTO me.school, me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom 
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that in the on_date of leaving there is least one lesson
--
  PERFORM 1 
     FROM lessons l
     JOIN classrooms c ON c.classroom = l.classroom
     JOIN classrooms_students cs ON cs.classroom = c.classroom
    WHERE classroom_student = new.classroom_student
      AND on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.leaving,  me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the explanation, if indicated, both related to that student, at that on_date of leaving amd created after or to_time maximun on_date same of leaving
--   
  IF new.explanation IS NOT NULL THEN
  
    PERFORM 1 
       FROM explanations e
       JOIN classrooms_students cs ON cs.student = e.student
      WHERE e.explanation=new.explanation 
        AND cs.classroom_student = new.classroom_student 
        AND e.created_on >= new.on_date 
        AND new.on_date BETWEEN e.from_time AND e.to_time ;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,6), new.leaving, new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,5),
          DETAIL = format(utility.system_messages_locale(system_messages,8), new.explanation, me.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,7);
      END IF;    
    END IF;
    
  END IF;
--
-- Checking that the student's school equals that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = me.student 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.leaving, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;       
  END IF;
--
-- Check that the school of the teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.leaving, new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;       
  END IF;   
--
-- The student that leaving_at cannot be absent
--  
  PERFORM 1 
     FROM absences a
     JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student
    WHERE a.on_date = new.on_date 
      AND cs.classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,18), new.leaving, me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
        MESSAGE = utility.system_messages_locale(system_messages,17),
        DETAIL = format(utility.system_messages_locale(system_messages,20), me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,19);
    END IF;    
  END IF;   
--
-- Check that the teacher is in rule 'teacher'
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.leaving, new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.teacher),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;    
  END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_leavings_iu() OWNER TO postgres;

--
-- Name: tr_lessons_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_lessons_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school      bigint;
-- variables manged by tools
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The material does not belong to the same institute of class')::utility.system_message,
    ('en', 2, 'In lesson: ''%s'' that you are upgrading the matter: ''%s'' does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 3, 'Control matter the class indicated and retry the operation')::utility.system_message,
    ('en', 4, 'In the lesson that you are by inserting the matter: ''%s'' does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 5, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 6, 'In lesson: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 7, 'Checking the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 8, 'In the lesson that you are inserting The teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 9, 'The Teacher indicated is not in the role of ''docenti''')::utility.system_message,
    ('en', 10, 'In lesson: ''%s'' that you are updating, the person indicated as teacher indicated: ''%s'' is not enabled the role teachers')::utility.system_message,
    ('en', 11, 'Check the value of the teacher and repeat the operation')::utility.system_message,
    ('en', 12, 'In the lesson that you are inserting, the suitable person as teacher indicated: ''%s'' is not enabled the role teachers')::utility.system_message,
    ('it', 1, 'La materia non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 2, 'Nella lezione: ''%s'' che si sta aggiornando la materia: ''%s'' non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare la materia la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella lezione che si sta'' inserendo la materia: ''%s'' non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 5, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 6, 'Nella lezione: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 7, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella lezione che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 9, 'Il docente indicato non è nel ruolo ''docenti''')::utility.system_message,
    ('it', 10, 'Nella lezione: ''%s'' che si sta aggiornando, la persona indicata come docente indicato: ''%s'' non è abilitato al ruolo docenti')::utility.system_message,
    ('it', 11, 'Controllare il valore del docente e riproporre l''operazione')::utility.system_message,
    ('it', 12, 'Nella lezione che si sta inserendo, la persona indicata come docente indicato: ''%s'' non è abilitato al ruolo docenti')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read the school of classroom
--
  SELECT s.school 
    INTO me.school 
    FROM classrooms c
    JOIN school_years s ON s.school_year = c.school_year
   WHERE c.classroom = new.classroom;
--
-- control that the school of subject is equal to that of classroom
--
  PERFORM 1 
     FROM subjects s 
    WHERE s.subject = new.subject 
      AND s.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.lesson, new.subject, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.subject, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;       
  END IF;
--
-- control that the school of teacher is equal to that of classroom
--
  PERFORM 1 
     FROM persons p 
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.lesson, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;   
--
-- control that the teacher is in rule teachers
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.lesson, new.teacher),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.teacher),
        HINT = utility.system_messages_locale(system_messages,11);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_lessons_iu() OWNER TO postgres;

--
-- Name: tr_messages_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messages_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school      		bigint;
-- variables for system tools
  context      		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the person ''da'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message that you are inserting is not the same as the pupil holder of the personal report card to which fa'' chapter the conversation: ''%s''')::utility.system_message,
    ('it', 1, 'L''istituto di chi ha scritto il messaggio (da) non è lo stesso dell''alunno del libretto della conversazione')::utility.system_message,
    ('it', 2, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio: ''%s'' non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- read person's school who wrote the message
--
  SELECT p.school INTO me.school 
    FROM persons p
   WHERE p.person = new.person;
--
-- Check that the person who wrote the message (from_time) is of the same school of student to which make zip codeo_the school_record of the conversation
--
  PERFORM 1 
     FROM classrooms_students cs
     JOIN conversations c ON c.classroom_student = cs.classroom_student
     JOIN persons p ON p.person = cs.student
    WHERE c.conversation = new.conversation
      AND p.school = me.school;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), me.school, new.person, new.message, new.conversation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), me.school, new.person, new.conversation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    

  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messages_iu() OWNER TO postgres;

--
-- Name: tr_messages_read_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_messages_read_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
-- variables for system tools
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute: ''%s'' of the person (from): ''%s'' that read the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation')::utility.system_message,
    ('en', 3, 'Check the values of the person ''from'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute of the person (from): ''%s'' that read the message that you are inserting is not the same as the pupil holder of the personal report card to which leads the conversation')::utility.system_message,
    ('it', 1, 'L''istituto di chi ha scritto il messaggio (da) non è lo stesso dell''alunno del libretto della conversazione')::utility.system_message,
    ('it', 2, 'L''istituo della persona (da): %L che ha letto il messaggio: %L non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: della persona (da): %L che ha letto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione')::utility.system_message];
BEGIN 
--
-- Retrieve the name of function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- control that the person who read the messages (message_read.person)
-- is of the same school of the student of the conversation
--
  PERFORM 1 
     FROM persons p
     JOIN messages_read mr ON mr.person = p.person 
     JOIN messages m on m.message = mr.message 
     JOIN conversations c ON c.conversation = m.conversation
     JOIN classrooms_students cs ON cs.classroom_student = c.classroom_student
     JOIN classrooms cl ON cl.classroom = cs.classroom 
     JOIN school_years sy ON sy.school_year = cl.school_year 
    WHERE mr.message_read = new.message_read 
      AND p.school = sy.school;
       
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.person, new.message),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_messages_read_iu() OWNER TO postgres;

--
-- Name: tr_notes_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_notes_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
  delete_signed		boolean := FALSE;
  insert_signed		boolean := FALSE;
-- variables for system tools
  context       	text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is no lesson on the day of the note')::utility.system_message,
    ('en', 2, 'In the day: ''%s'' of note: ''%s'' the class: ''%s'' had no lesson')::utility.system_message,
    ('en', 3, 'Before inserting a note you must enter the lessons provide therefore for the insertion of the requested data or check the values proposed and possibly correct')::utility.system_message,
    ('en', 4, 'In the day: ''%s'' of the note that you want to insert the class: ''%s'' had no lesson')::utility.system_message,
    ('en', 9, 'The pupil does not belong to the same institute of class')::utility.system_message,
    ('en', 10, 'In Note: ''%s'' that you are upgrading the pupil: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 11, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In Note that you are inserting the pupil: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 13, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 14, 'In note: ''%s'' that you are upgrading the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 15, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 16, 'In the note that you are entering the teacher: ''%s'' (a person of the People table) does not belong to the same institute: ''%s'' of class: ''%s''')::utility.system_message,
    ('en', 17, 'The pupil may not be reported as missing in the same day')::utility.system_message,
    ('en', 18, 'In "Notae: ''%s'' that you are upgrading the pupil: ''%s'' in the day: ''%s'' is Also inserted as absent')::utility.system_message,
    ('en', 19, 'Correct the pupil or the day and retry the operation')::utility.system_message,
    ('en', 20, 'In the note that you are inserting the pupil: ''%s'' in the day: ''%s'' is also entered as absent')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno della nota')::utility.system_message,
    ('it', 2, 'Nel giorno: ''%s'' della nota: ''%s'' la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire una nota è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: ''%s'' della nota che si vuole inserire la classe: ''%s'' non ha avuto lezione')::utility.system_message,
    ('it', 9, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nella nota: ''%s'' che si sta aggiornando l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 11, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella nota che si sta inserendo l''alunno: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 13, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 14, 'Nella nota: ''%s'' che si sta aggiornando il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 15, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 16, 'Nella nota che si sta inserendo il docente: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe: ''%s''')::utility.system_message,
    ('it', 17, 'L''alunno non può essere segnalato come assente nello stesso giorno')::utility.system_message,
    ('it', 18, 'Nella notae: ''%s'' che si sta aggiornando l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message,
    ('it', 19, 'Correggere l''alunno o il giorno e ritentare l''operazione')::utility.system_message,
    ('it', 20, 'Nella nota che si sta inserendo l''alunno: ''%s'' nel giorno: ''%s'' è anche inserito come assente')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- recovery the school of classroom
--
  SELECT sy.school 
    INTO me.school 
    FROM classrooms c
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE c.classroom = new.classroom;
--
-- control that in the on_dates of the notes there is at least one lesson
--
  PERFORM 1 FROM lessons l
     WHERE classroom = new.classroom
       AND on_date = new.on_date;

  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.note,  new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- If the student has been specified
--
  IF new.student IS NOT NULL THEN
    --
    -- control that the school of the student is equal to that of the classroom
    --
    PERFORM 1 
       FROM persons p 
      WHERE p.person = new.student 
        AND p.school = me.school;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.note, new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
    --
    -- Student in note cannot be absent
    --
    PERFORM 1 
       FROM absences a
       JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student 
      WHERE a.on_date = new.on_date 
        AND cs.student = new.student;
        
    IF FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,18), new.note, new.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,19);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,17),
          DETAIL = format(utility.system_messages_locale(system_messages,20), new.student, new.on_date),
          HINT = utility.system_messages_locale(system_messages,19);
      END IF;       
    END IF; 
    
  END IF;
--
-- Check that the school of the teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.note, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Handling of visas 
--
  IF TG_OP = 'INSERT' THEN
    IF new.to_approve = TRUE THEN
      me.insert_signed := TRUE;
    END IF;
  END IF;
  
  IF TG_OP = 'UPDATE' THEN
    --
    -- if are required visas control that they were even before
    --
    IF new.to_approve = TRUE THEN
      --
      -- if were required visas checking if changed the classroom, student or description
      -- in quto_time if you need to delete the old visas and insert the new
      -- paying attention that the'student may be null
      --
      IF old.to_approve = TRUE THEN
        IF new.description != old.description THEN
          me.delete_signed := TRUE;
          me.insert_signed := TRUE;
        END IF;
        IF new.classroom != old.classroom THEN
          me.delete_signed := TRUE;
          me.insert_signed := TRUE;
        END IF;
        IF new.student IS NULL THEN
          IF old.student IS NULL THEN
          ELSE
            me.delete_signed := TRUE;
          END IF;
          ELSE
            IF old.student IS NULL THEN
              me.insert_signed := TRUE;
            ELSE
              IF new.student != old.student THEN
                me.delete_signed := TRUE;
                me.insert_signed := TRUE;
              END IF;
            END IF;
          END IF ;
        END IF;
        --
        -- If you were not required visas allat_time I put them
        --
        IF old.to_approve = FALSE THEN
            me.insert_signed := TRUE;
        END IF;
    END IF;
    --
    -- if they are not required visas control if it were
    --
    IF new.to_approve = FALSE THEN
      --
      -- If they were required visas allat_time i have to delete the old
      --
      IF old.to_approve = TRUE THEN
        me.delete_signed := TRUE;
      END IF;
    END IF;
  END IF;
--
-- gate physically the old visas if was determiborn erasing
--
  IF me.delete_signed THEN 
    DELETE FROM notes_signed WHERE note = old.note;
  END IF;
--
-- insert the new visas if was determiborn them
--
  IF me.insert_signed THEN
    IF new.student IS NULL THEN
      INSERT INTO notes_signed (note, person) 
        SELECT new.note, person_related_to
          FROM persons_relations 
         WHERE sign_request = TRUE 
           AND person IN (SELECT student
                            FROM classrooms_students
                           WHERE classroom = new.classroom 
                             AND student NOT IN (SELECT student
                                                   FROM absences 
                                                   WHERE on_date = new.on_date));
    ELSE
      INSERT INTO notes_signed (note, person) 
        SELECT new.note, person_related_to
          FROM persons_relations 
         WHERE sign_request = TRUE 
           AND person = new.student;
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_notes_iu() OWNER TO postgres;

--
-- Name: tr_notes_signed_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_notes_signed_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
-- variables for system tools
  context		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The person who has seen the note has not the same institute of class of note')::utility.system_message,
    ('en', 2, 'In nota_visto: ''%s'' that you are upgrading the person: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of class of note: ''%s''')::utility.system_message,
    ('en', 3, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 4, 'In nota_visto that you are inserting the person: ''%s'' (a person of the people table) does not belong to the same institute: ''%s'' of class of note: ''%s''')::utility.system_message,
    ('it', 1, 'La persona che ha visto la nota non ha lo stesso istituto della classe della nota')::utility.system_message,
    ('it', 2, 'Nella nota_visto: ''%s'' che si sta aggiornando la persona: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe della nota: ''%s''')::utility.system_message,
    ('it', 3, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 4, 'Nella nota_visto che si sta inserendo la persona: ''%s'' (una persona della tabella persone) non appartiene allo stesso istituto: ''%s'' della classe della nota: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- I from_time a part of the school of classroom
--
  SELECT sy.school INTO me.school 
    FROM notes n
    JOIN classrooms c ON c.classroom = n.classroom
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE n.note = new.note;
--
-- control that person's school is the same as that of the classroom of notes
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.person
      AND p.school = me.school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.note_signed, new.person, me.school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, me.school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_notes_signed_iu() OWNER TO postgres;

--
-- Name: tr_out_of_classrooms_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_out_of_classrooms_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school     	bigint;
  student	bigint;
  classroom	bigint;
-- variables for system tools
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil is not in the ''pupils'' role.')::utility.system_message,
    ('en', 2, 'On ''on_date'': %L of ''out_of_classroom'': %L there isn''t any lessons.')::utility.system_message,
    ('en', 3, 'Check that the student user is included in the pupil role and retry the operation.')::utility.system_message,
    ('en', 4, 'On ''on_date'': %L there isn''t any lessons.')::utility.system_message,
    ('en', 5, 'The student institution is not the same as the person indicated by the field: ''created_by'' .')::utility.system_message,
    ('en', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('en', 7, 'Control  ''pupil'' and the person indicated in ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 8, 'In justification that you are entering, the pupil %L does not belong to the same institute: %L of the person: %L indicated in the ''created_by'' field .')::utility.system_message ,
    ('en', 9, 'The pupil is not of age and therefore can not include justifications.')::utility.system_message,
    ('en', 10, 'In justification: %L being updated, ''pupil'': %L is no age and therefore can not enter justifications.')::utility.system_message,
    ('en', 11, 'Check the value of ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 12, 'In justification that is being inserted, ''pupil'': %L is no age and therefore can not include justifications.')::utility.system_message,
    ('en', 13, 'The person indicated in ''created_by'' is not authorized.')::utility.system_message,
    ('en', 14, 'In justification: %L being updated, the person: %L indicated in the ''created_by'' field is not a family member enabled and majority and is not even in the roles of: ''leaders'', ''employees'', ''teachers'' .')::utility.system_message,
    ('en', 15, 'Check the person indicated in the column ''created_by'' and retry the operation.')::utility.system_message,
    ('en', 16, 'In the justification that is being entered, the person: %L indicated in the field ''created_by'' is not a qualified family and is not even in the roles of ''managers'', ''leaders'', ''employees'', ''teachers'' .')::utility.system_message,
    ('en', 17, 'The person who filed the justification is not the same institution as the pupil.')::utility.system_message,
    ('en', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('en', 19, 'Check the person indicated in the column ''registered_by'' and repeat the operation.')::utility.system_message,
    ('en', 20, 'In justification that is being entered, the pupil: %L does not belong to the same institute: %L of the person: %L indicated in the field ''registered_by'' .')::utility.system_message ,
    ('en', 21, 'The person indicated in the ''registered_by'' column is not a member of any of the following roles: ''managers'', ''executives'',  ''employees'' .')::utility.system_message,
    ('en', 22, 'In justification: %L being updated, the person indicated in the column: '' registered_by'' does not belong to any of the following roles: ''managers'', ''executives'', ''employees'', ''teachers''.')::utility.system_message,
    ('en', 23, 'Check the value of the column: ''registered_by'' and re-propose the operation.')::utility.system_message,
    ('en', 24, 'In the justification that is being entered, the person indicated in the column: ''registered_by'' does not belong to any of the following roles: ''managers'', ''executives'', ''teachers'' .')::utility.system_message,
    ('it', 1, 'L''alunno non è inserito nel ruolo ''alunni''.')::utility.system_message,
    ('it', 2, 'Nella ''on_date'': %L della ''out_of_classroom'': %L non esiste alcuna lezione.')::utility.system_message,
    ('it', 3, 'Controllare che l''utente dell''alunno sia inserito nel ruolo alunni e ritentare l''operazione.')::utility.system_message,
    ('it', 4, 'Nella ''on_date'': %L non esiste alcuna lezione.')::utility.system_message,
    ('it', 5, 'L''istituto dell''alunno no è lo stesso della persona indicata dal campo: ''creato_da''.')::utility.system_message,
    ('it', 6, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('it', 7, 'Controllare l'' ''alunno'' e la persona indicata in ''creata_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 8, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''creata_da''.')::utility.system_message,
    ('it', 9, 'L''alunno non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 10, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 11, 'Controllare il valore di ''creato_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 12, 'Nella giustificazione che si sta inserendo, l''alunno: %L non è maggiorenne e quindi non può inserire giustificazioni.')::utility.system_message,
    ('it', 13, 'La persona indicata in ''creata_da'' non è autorizzata.')::utility.system_message,
    ('it', 14, 'Nella giustificazione: %L che si sta aggiornando, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 15, 'Controllare la persona indicata nella colonna ''creata_da'' e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'Nella giustificazione che si sta inserendo, la persona: %L indicata nel campo ''creata_da'' non è un famigliare abilitato e maggiorenne e non è nemmeno nei ruoli di: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 17, 'La persona che ha registrato la giustificazione non è dello stesso istituto dell''alunno.')::utility.system_message,
    ('it', 18, 'Nella giustificazione: %L che si sta aggiornando, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('it', 19, 'Controllare la persona indicata nella colonna ''registrata:_da'' e riproporre l''operazione.')::utility.system_message,
    ('it', 20, 'Nella giustificazione che si sta inserendo, l''alunno: %L non appartiene allo stesso istituto: %L della persona: %L indicata nel campo ''registered_by''.')::utility.system_message,
    ('it', 21, 'La persona indicata nella colonna ''registered_by'' non è membro di nessuno dei seguenti ruoli: ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 22, 'Nella giustificazione: %L che si sta aggiornando, la persona indicata nella colonna: ''registered_by'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message,
    ('it', 23, 'Controllare il valore della colonna: ''registered_by'' e riproporre l''operazione.')::utility.system_message,
    ('it', 24, 'Nella giustificazione che si sta inserendo, la persona indicata nella colonna: ''registered_by'' non appartiene a nessuno dei seguenti ruoli:  ''gestori'',''dirigenti'',''impiegati'',''docenti''.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the on_dates of out_of_classroom there is at least one lesson
--
  PERFORM 1 FROM lessons l
            JOIN classrooms_students cs ON cs.classroom=l.classroom
           WHERE cs.classroom_student = new.classroom_student
             AND on_date = new.on_date;
             
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.out_of_classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Recovery the school of classroom
--
  SELECT a.school, cs.student, cs.classroom
    INTO me.school, me.student, me.classroom
    FROM school_years a
    JOIN classrooms c ON c.school_year = a.school_year
    JOIN classrooms_students cs ON cs.classroom = c.classroom 
   WHERE cs.classroom_student = new.classroom_student;
--
-- Check that the school of the student is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
     JOIN classrooms_students cs ON cs.student = p.person
    WHERE cs.classroom_student = new.classroom_student
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.out_of_classroom, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;     
  END IF;
--
-- Check that the school of the school staff is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p 
    WHERE p.person = new.school_operator 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,10), new.out_of_classroom, new.school_operator, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,11);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,9),
        DETAIL = format(utility.system_messages_locale(system_messages,12), new.school_operator, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,10);
    END IF;     
  END IF;
--
-- The student that leaving_at cannot be absent
--
  PERFORM 1 
     FROM absences a
     JOIN classrooms_students cs ON cs.classroom_student = a.classroom_student
    WHERE a.on_date = new.on_date 
      AND a.classroom_student = new.classroom_student;
      
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.out_of_classroom, me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), me.student, new.on_date),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;    
  END IF;   
--
-- Checking that the school_operator has one of the required roles
--
  IF NOT in_any_roles(new.school_operator,'Supervisor','Executive','Teacher','Employee') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,34), new.out_of_classroom, new.school_operator),
        HINT = utility.system_messages_locale(system_messages,35);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'I'),
        MESSAGE = utility.system_messages_locale(system_messages,33),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.school_operator),
        HINT = utility.system_messages_locale(system_messages,35);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_out_of_classrooms_iu() OWNER TO postgres;

--
-- Name: tr_parents_meetings_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_parents_meetings_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The teacher and the person with whom was fixed the interview are not of the same institute')::utility.system_message,
    ('en', 2, 'In the interview: ''%s'' the teacher: ''%s'' and the person (column ''with''): ''%s'' are not of the same institute')::utility.system_message,
    ('en', 3, 'Correct values: ''teacher'' and ''with'' and repeat the operation')::utility.system_message,
    ('en', 4, 'In the interview that you are entering the teacher: ''%s'' and the person (column ''with''): ''%s'' are not of the same institute')::utility.system_message,
    ('it', 1, 'Il docente e la persona con cui è stato fissato il colloquio non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nel colloquio: ''%s'' il docente: ''%s'' e al persona (colonna ''con''): ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''docente'' e ''con'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nel colloquio che si sta inserendo il docente: ''%s'' e la persona (colonna ''con''): ''%s'' non sono dello stesso istituto')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- control that the teacher and the person who has fixed the parents_meetings are of the same school
--
  IF new.person IS NOT NULL THEN
  
    PERFORM 1 
       FROM persons doc
       JOIN persons con ON doc.school = con.school
      WHERE doc.person = new.teacher
        AND con.person = new.person;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.parents_meeting, new.teacher, new.person),
          HINT = utility.system_messages_locale(system_messages,3);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,4), new.teacher, new.person),
          HINT = utility.system_messages_locale(system_messages,3);
      END IF;    
    END IF;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_parents_meetings_iu() OWNER TO postgres;

--
-- Name: tr_schools_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_schools_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context text;
  full_function_name text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The conduct indicated does not belong to the same institute of class')::utility.system_message,
    ('en', 2, 'In the school indicated: %L the behavior: %L related to another school')::utility.system_message,
    ('en', 3, 'Correct values of school and conduct and repeat the operation')::utility.system_message,
    ('en', 4, 'It is not possible to enter the school and at the same time the conduct')::utility.system_message,
    ('en', 5, 'Since conduct depends on the school cannot be inserted simultaneously')::utility.system_message,
    ('en', 6, 'Before you enter the school without the conduct, then enters the conduct taking note of the code number assigned to the first occasion you update the table schools with the code detected before')::utility.system_message,
    ('it', 1, 'La condotta indicata non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 2, 'Nella scuola indicata: %L la condotta: %L appartiena ad un''altra scuola')::utility.system_message,
    ('it', 3, 'Correggere i valori di scuola e condotta e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Non è possibile inserire la scuola e contemporaneamente la condotta')::utility.system_message,
    ('it', 5, 'Siccome la condatta dipende dalla scuola non è possibile inserirla contemporanemente')::utility.system_message,
    ('it', 6, 'Prima si inserisce la scuola senza la condotta, poi si inserisce la condotta prendendo nota del codice assegnato, alla prima occasione si aggionra la tabella scuole con il codice rilevato prima')::utility.system_message]; 
BEGIN
--
-- recover the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check behavior
--  
  IF new.behavior IS NOT NULL THEN
    IF (TG_OP = 'UPDATE') THEN
      --
      -- check that subject's school as equal as school
      --
      PERFORM 1 
         FROM subjects 
        WHERE subject = new.behavior 
          AND school = new.school;
          
      IF NOT FOUND THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
          MESSAGE = utility.system_messages_locale(system_messages,1),
          DETAIL = format(utility.system_messages_locale(system_messages,2), new.school, new.behavior),
          HINT = utility.system_messages_locale(system_messages,3);      
      END IF;
    ELSE
      --
      -- cannot set the behavior because it needs school. You must:
      -- 1) insert school
      -- 2) insert subject 
      -- 3) update school with the subject
      --
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,5)),
        HINT = utility.system_messages_locale(system_messages,6);
    END IF;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_schools_iu() OWNER TO postgres;

--
-- Name: tr_signatures_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_signatures_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The teacher can''t sign for a classroom of another school..')::utility.system_message,
    ('en', 2, 'The ''signature'': %L made by the ''teacher'': %L indicates a ''class'': %L of another institute .')::utility.system_message,
    ('en', 3, 'Correct the values of: teacher and class, then retry..')::utility.system_message,
    ('en', 4, 'In signature that the ''teacher'' is inserting.')::utility.system_message,
    ('en', 5, 'The person named as a teacher has not been authorized to serve as a teacher.')::utility.system_message,
    ('en', 6, 'The ''signature'': %L can not be updated by the ''teacher'': %L because the same is not allowed for the ''teacher'' role.')::utility.system_message,
    ('en', 7, 'Authorize the person referred to as ''teachers'' or indicate as an instructor an authorized person and repeat the operation.')::utility.system_message,
    ('en', 8, 'The person named as ''teacher'': %L can not enter the signature because he is not authorized to the ''faculty'' role.')::utility.system_message,
    ('it', 1, 'Il docente non può firmare per una classe di un altro istituto.')::utility.system_message,
    ('it', 2, 'La ''firma'': %L fatta dal ''docente'': %L indica una ''classe'': %L di un altro istituto.')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''docente'' e ''classe'' e riproporre l''operazione.')::utility.system_message,
    ('it', 4, 'Nella firma che si sta inserendo il ''docente'': %L indica una ''classe'': %L di un altro istituto.')::utility.system_message,
    ('it', 5, 'La persona indicata come docente non è stata autorizzata al ruolo di docente.')::utility.system_message,
    ('it', 6, 'La ''firma'': %L non può essere aggiornata dal ''docente'': %L perchè lo stesso non è autorizzato al ruolo ''docenti'' .')::utility.system_message,
    ('it', 7, 'Autorizare la persona indicato al ruolo ''docenti'' oppure indicare come docente una persona autorizzata e riproporre l''operazione.')::utility.system_message,
    ('it', 8, 'La persona indicata come ''docente'': %L non può inserire la firma perchè non è autorizzato al ruolo ''docenti''.')::utility.system_message];
  context       text;
  full_function_name    text;
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- Checking that the teacher is of the same institute of classroom
--
  PERFORM 1 FROM classrooms c
     JOIN school_years a ON c.school_year = a.school_year
     JOIN persons doc ON a.school = doc.school
    WHERE doc.person = new.teacher
      AND c.classroom = new.classroom;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.signature, new.teacher, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.teacher, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- Checking that the person designated as teacher has the rule of teacher or director
--
  IF NOT in_any_roles(new.teacher,'Executive','Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.signature, new.teacher),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,6),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.teacher),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_signatures_iu() OWNER TO postgres;

--
-- Name: tr_teachears_notes_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_teachears_notes_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school			bigint;
-- variables for system tool 
  context			text;
  full_function_name		text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'There is no lesson on the day of the note')::utility.system_message,
    ('en', 2, 'In the day: %L of note: %L the classroom: %L had no lesson')::utility.system_message,
    ('en', 3, 'Before inserting a note you must enter the lessons provide therefore for the insertion of the requested data or check the values proposed and possibly correct')::utility.system_message,
    ('en', 4, 'In the day: %L of the note that you want to insert, the class: %L had no lesson')::utility.system_message,
    ('en', 5, 'The pupil does not belong to the same institute of class')::utility.system_message,
    ('en', 6, 'In the note: %L that you are upgrading the pupil: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 7, 'Check the pupil or the class indicated and retry the operation')::utility.system_message,
    ('en', 8, 'In the note that you are inserting the pupil: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 9, 'The teacher does not belong to the same institute of class')::utility.system_message,
    ('en', 10, 'In the note: %L that you are upgrading the teacher: %L (a person of the people table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('en', 11, 'Check the teacher or the class indicated and retry the operation')::utility.system_message,
    ('en', 12, 'In the note that you are entering the teacher: %L (a person of the People table) does not belong to the same institute: %L of class: %L')::utility.system_message,
    ('it', 1, 'Non c''è nessuna lezione nel giorno della nota')::utility.system_message,
    ('it', 2, 'Nel giorno: %L della nota: %L la classe: %L non ha avuto lezione')::utility.system_message,
    ('it', 3, 'Prima di inserire una nota è necessario inserire le lezioni provvedere quindi all''inserimento dei dati richiesti oppure controllare i valori proposti ed eventualmente correggerli')::utility.system_message,
    ('it', 4, 'Nel giorno: %L della nota che si vuole inserire la classe: %L non ha avuto lezione')::utility.system_message,
    ('it', 5, 'L''alunno non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 6, 'Nella nota: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 7, 'Controllare l''alunno o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 8, 'Nella nota che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 9, 'Il docente non appartiene allo stesso istituto della classe')::utility.system_message,
    ('it', 10, 'Nella nota: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message,
    ('it', 11, 'Controllare il docente o la classe indicata e ritentare l''operazione')::utility.system_message,
    ('it', 12, 'Nella nota che si sta inserendo il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- I from_time a part of the school of classroom
--
  SELECT sy.school 
    INTO me.school 
    FROM classrooms c 
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE classroom = new.classroom;
--
-- control that in the on_dates of teacher_notes there is at least one lesson
--
  PERFORM 1 
     FROM lessons l
    WHERE l.classroom = new.classroom
      AND l.on_date = new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.on_date, new.teacher_notes,  new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.on_date, new.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- control that the school of the student is equal to that of classroom
--
  IF new.student IS NOT NULL THEN

    PERFORM 1 
       FROM persons p
      WHERE p.person = new.student 
        AND p.school = me.school;
        
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,10), new.teacher_notes, new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
          MESSAGE = utility.system_messages_locale(system_messages,9),
          DETAIL = format(utility.system_messages_locale(system_messages,12), new.student, me.school, new.classroom),
          HINT = utility.system_messages_locale(system_messages,11);
      END IF;    
    END IF;
  END IF;
--
-- control that the school of the teacher is equal to that of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,14), new.teacher_notes, new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,13),
        DETAIL = format(utility.system_messages_locale(system_messages,16), new.teacher, me.school, new.classroom),
        HINT = utility.system_messages_locale(system_messages,15);
    END IF;       
  END IF;   
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_teachears_notes_iu() OWNER TO postgres;

--
-- Name: tr_topics_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_topics_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  v_course_years    course_year;
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The matter and the school address are not of the same institute')::utility.system_message,
    ('en', 2, 'In the topic: ''%s'' matter: ''%s'' and the course_year: ''%s'' are not of the same institute')::utility.system_message,
    ('en', 3, 'Correct values of subject and course_year and repeat the operation')::utility.system_message,
    ('en', 4, 'In the topic that you are entering the field: ''%s'' and the course_year: ''%s'' are not of the same institute')::utility.system_message,
    ('en', 5, 'The year is greater than the years envisaged for the school address in the subject')::utility.system_message,
    ('en', 6, 'In the topic: ''%s'' the year: ''%s'' is greater than the years of course: ''%s'' provided by the address: ''%s'' in the subject')::utility.system_message,
    ('en', 7, 'Correct the value of the year or of the subject and to repeat the operation')::utility.system_message,
    ('en', 8, 'In the topic that you are inserting the year: ''%s'' Is greater than the years of course: ''%s'' provided by the address: ''%s'' in the subject')::utility.system_message,
    ('it', 1, 'La materia e l''indirizzo scolastico non sono dello stesso istituto')::utility.system_message,
    ('it', 2, 'Nell''argomento: ''%s'' la materia: ''%s'' e l''anno_scolastico: ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 3, 'Correggere i valori di materia e anno_scolastico e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'Nell''argomento che si sta inserendo la materia: ''%s'' e l''anno_scolastico: ''%s'' non sono dello stesso istituto')::utility.system_message,
    ('it', 5, 'L''anno di corso è superiore agli anni di corso previsti per l''indirizzo scolastico in oggetto')::utility.system_message,
    ('it', 6, 'Nell''argomento: ''%s'' l''anno di corso: ''%s'' è maggiore agli anni di corso: ''%s'' previsti dall''indirizzo: ''%s'' in oggetto')::utility.system_message,
    ('it', 7, 'Correggere il valore dell'' anno di corso o della materia e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'Nell''argomento che si sta inserendo l''anno di corso: ''%s'' è maggiore agli anni di corso: ''%s'' previsti dall''indirizzo: ''%s'' in oggetto')::utility.system_message]; 
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- Check that the subject and the address at school are of the same school
--
  SELECT i.course_years INTO v_course_years
    FROM subjects m
    JOIN degrees i ON i.school = m.school
   WHERE m.subject = new.subject
     AND i.degree = new.degree;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.topic, new.subject,  new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.subject,  new.degree),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  IF new.course_year > v_course_years THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.topic, new.course_year, v_course_years, new.degree),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.course_year, v_course_years, new.degree),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_topics_iu() OWNER TO postgres;

--
-- Name: tr_usename_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_usename_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages 	utility.system_message[] = ARRAY[
    ('en', 1, 'Attempts have been made to update a username that it isn''t exist in the system''s table_ pg_shadow')::utility.system_message,
    ('en', 2, 'Attempts have been made to insert a username that it isn''t exist in the system''s table_ pg_shadow')::utility.system_message,
    ('en', 3, 'To verify that the username indicated exists in the the system''s table pg_shadow and retry the operation')::utility.system_message,
    ('en', 4, 'Attempts have been made to enter a user with a non-existent system username (username)')::utility.system_message,
    ('en', 5, 'Attempts have been made to insert a user pointing out as ''usename'' (name consumer of system) the value: ''%s'' that it doesn''t exist in the sight of system pg_user')::utility.system_message,
    ('it', 1, 'Si è cercato di aggiornare un nome utente che non esiste nella vista di sistema pg_shadow')::utility.system_message,
    ('it', 2, 'Si è cercato di inserire un nome utente che non esiste nella vista di sistema pg_shadow')::utility.system_message,
    ('it', 3, 'Verificare che il nome utente indicato esista nella vista di sistema pg_shadow e riprovare l''operazione')::utility.system_message,
    ('it', 4, 'Si è cercato di inserire un utente con un nome utente di sistema (usename) inesistente')::utility.system_message,
    ('it', 5, 'Si è cercato di inserire un utente indicando come ''usename'' (nome utente di sistema) il valore: ''%s'' che non esiste nella vista di sistema pg_shadow')::utility.system_message];	
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
--
-- check user name
--
  PERFORM 1 FROM pg_shadow WHERE usename = new.usename;
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
      MESSAGE = utility.system_messages_locale(system_messages,4),
      DETAIL = format(utility.system_messages_locale(system_messages,5) ,new.usename),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END IF;
RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_usename_iu() OWNER TO postgres;

--
-- Name: tr_valutations_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutations_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  school		bigint;
  classroom		BIGINT;
  student		BIGINT;
  metric		bigint;
-- variables for system tools  
  context		text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY [
    ('en', 1, 'The pupil does not belong to the same institute of the class.')::utility.system_message,
    ('en', 2, 'In the evaluation: ''%L'' who is updating the pupil: ''%L ''(a person in the person table) does not belong to the same institute: ''%L'' of the class: ''%L''')::utility.system_message,
    ('en', 3, 'Check the student or subject matter and retry the operation.')::utility.system_message,
    ('en', 4, 'Material does not belong to the same institute of the class.')::utility.system_message,
    ('en', 5, 'In the evaluation: %L that is being updated, the matter: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 6, 'Check the matter or class indicated and retry the operation.')::utility.system_message,
    ('en', 7, 'Voting type is not the same as evaluation.')::utility.system_message,
    ('en', 8, 'In the evaluation: %L being updated, the vote type: %L is not the same: %L.')::utility.system_message,
    ('en', 9, 'Check the voting type or matter and retry the operation.')::utility.system_message,
    ('en', 10, 'The argument is not of the same subject as the evaluation.')::utility.system_message,
    ('en', 11, 'In the evaluation: %L that is being updated, the argument  L is not the same subject: %L.')::utility.system_message,
    ('en', 12, 'Check the topic or matter and retry the operation.')::utility.system_message,
    ('en', 13, 'The year of course and the school address of the subject are not the same as the class..')::utility.system_message,
    ('en', 14, 'In the evaluation: %L being updated, the course year and school address of the argument% L are not the same as the class: %L.')::utility.system_message,
    ('en', 15, 'Check the course year and the school address of the subject or subject matter and retry the operation.')::utility.system_message,
    ('en', 16, 'The voting metric does not belong to the same institute of the class.')::utility.system_message,
    ('en', 17, 'In the evaluation: %L that is being updated, the voting metric: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 18, 'Check the vote or matter and retry the operation.')::utility.system_message,
    ('en', 19, 'The person indicated as a pupil is not.')::utility.system_message,
    ('en', 20, 'In evaluation: %L who is updating the person: %L indicated as pupil does not have the role = ''Student''.')::utility.system_message,
    ('en', 21, 'Check the person listed as a pupil or rule the role in the people table.')::utility.system_message,
    ('en', 22, 'The note is not about this pupil and this teacher.')::utility.system_message,
    ('en', 23, 'In the evaluation: %L who is updating the note: %L is not pupil: %L and not even the teacher: %L.')::utility.system_message,
    ('en', 24, 'Check the note indicated or the person indicated as pupil and teacher and retry the operation.')::utility.system_message,
    ('en', 25, 'The teacher does not belong to the same class institute.')::utility.system_message,
    ('en', 26, 'In the evaluation: %L who is updating the teacher: %L (one person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 27, 'Check the instructor or subject matter and retry the operation.')::utility.system_message,
    ('en', 28, 'The person indicated as a teacher is not.')::utility.system_message,
    ('en', 29, 'Nella valutazione: %L che si sta aggiornando, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('en', 30, 'Check the person named as a teacher or correct the role in the people table.')::utility.system_message,
    ('en', 31, 'Evaluation date is not valid.')::utility.system_message,
    ('en', 32, 'In evaluation: %L being updated, evaluation date: %L is not between the beginning and end of classroom lessons: %L.')::utility.system_message,
    ('en', 33, 'check the evaluation date and retry the operation.')::utility.system_message,
    ('en', 34, 'In the evaluation you are entering the pupil: %L (a person in the person table) does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 35, 'In the evaluation you are entering, the matter: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 36, 'In the rating you are entering, the rating type: %L is not the same: %L.')::utility.system_message,
    ('en', 37, 'In the evaluation you are entering, the argument% L is not the same: %L.')::utility.system_message,
    ('en', 38, 'In the evaluation you are entering, the course year and the school address of the argument% L are not the same as the class: %L.')::utility.system_message ,
    ('en', 39, 'In the evaluation you are entering, the voting metric: %L does not belong to the same institute: %L of the class: %L.')::utility.system_message,
    ('en', 40, 'In the evaluation you are entering, the person: %L indicated as pupil does not have the role = '' Student ''.')::utility.system_message,
    ('en', 41, 'In the evaluation you are entering, note: %L is not pupil: %L and teacher: %L.')::utility.system_message,
    ('en', 42, 'In the evaluation you are entering, the teacher: %L (a person in the person table) does not belong to the same institution: %L of the class: %L.')::utility.system_message,
    ('en', 43, 'In the evaluation you are entering, the person: %L indicated as a teacher does not have the role = ''teacher'' .')::utility.system_message,
    ('en', 44, 'In the evaluation you are entering, the date of evaluation: %L is not between the beginning and end of class class lessons: %L.')::utility .system_message,
    ('en', 45, 'The evaluation duplicates the following data: class, subject, teacher, pupil, day, type_quote, argument, metric.')::utility.system_message,
    ('en', 46, 'The mark: %L has the metric: %L that is already present in the class database: %L, subject: %L, teacher: %L, pupil: %L, day: %L, % L and topic: %L.')::utility.system_message,
    ('en', 47, 'Check the values ​​of: class, subject, teacher, day, type_type, topic, vote and replay the operation.')::utility.system_message,
    ('en', 48, 'The% L of the evaluation you are entering has the metric: %L already in the class database: %L, subject: %L, teacher: %L, pupil: %L, day: %L, : %L and argument: %L.')::utility.system_message,
    ('en', 49, 'If evaluation is indicated as private can not have an associated note.')::utility.system_message,
    ('en', 50, 'Evaluation: %L was shown as private but has been associated with the note: %L.')::utility.system_message,
    ('en', 51, 'Check the ''private'' and ''note'' and repeat the operation.')::utility.system_message,
    ('en', 52, 'The rating you are entering has been shown as private but has been associated with the note: %L.')::utility.system_message,
    ('it', 1, 'L''alunno non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 2, 'Nella valutazione: %L che si sta aggiornando l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 3, 'Controllare l''alunno o la materia indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 4, 'La materia non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 5, 'Nella valutazione: %L che si sta aggiornando, la materia: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 6, 'Controllare la materia o la classe indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 7, 'Il tipo voto non è della stessa materia della valutazione.')::utility.system_message,
    ('it', 8, 'Nella valutazione: %L che si sta aggiornando, il tipo voto: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 9, 'Controllare il tipo voto oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 10, 'L''argomento non è della stessa materia della valutazione.')::utility.system_message,
    ('it', 11, 'Nella valutazione: %L  che si sta aggiornando, l''argomento: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 12, 'Controllare l''argomento oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 13, 'L''anno di corso e l''indirizzo scolastico dell''argomento non sono gli stessi della classe..')::utility.system_message,
    ('it', 14, 'Nella valutazione: %L che si sta aggiornando,  l''anno di corso e l''indirizzo scolastico dell'' argomento: %L non sono gli stessi della classe: %L.')::utility.system_message,
    ('it', 15, 'Controllare l''anno di corso e l''indirizzo scolastico dell''argomento indicato oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 16, 'La metrica del voto non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 17, 'Nella valutazione: %L che si sta aggiornado, la metrica del voto: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 18, 'Controllare il voto oppure la materia e ritentare l''operazione.')::utility.system_message,
    ('it', 19, 'La persona indicata come alunno non lo è.')::utility.system_message,
    ('it', 20, 'Nella valutazione: %L che si sta aggiornando la persona: %L indicata come alunno non ha il ruolo=''Student''.')::utility.system_message,
    ('it', 21, 'Controllare la persona indicata come alunno oppure coreggere il ruolo nella tabella persone.')::utility.system_message,
    ('it', 22, 'La nota non è di questo alunno e di questo docente.')::utility.system_message,
    ('it', 23, 'Nella valutazione: %L che si sta aggiornando la nota: %L non è dell''alunno: %L e nemmeno del docente: %L.')::utility.system_message,
    ('it', 24, 'Controlla la nota indicata oppure le persona indicata come alunno e docente e ritenta l''operazione.')::utility.system_message,
    ('it', 25, 'Il docente non appartiene allo stesso istituto della classe.')::utility.system_message,
    ('it', 26, 'Nella valutazione: %L che si sta aggiornando il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 27, 'Controllare il docente o la materia indicata e ritentare l''operazione.')::utility.system_message,
    ('it', 28, 'La persona indicata come docente non lo è.')::utility.system_message,
    ('it', 29, 'Nella valutazione: %L che si sta aggiornando, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('it', 30, 'Controllare la persona indicata come docente oppure correggere il ruolo nella tabella persone.')::utility.system_message,
    ('it', 31, 'La data della valutazione non è valida.')::utility.system_message,
    ('it', 32, 'Nella valutazione: %L che si sta aggiornando, la data della valutazione: %L non è compresa fra l''inizio e la fine delle lezioni dell''anno scolastico della classe: %L.')::utility.system_message,
    ('it', 33, 'controllare la data della valutazione e ritentare l''operazione.')::utility.system_message,
    ('it', 34, 'Nella valutazione che si sta inserendo l''alunno: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 35, 'Nella valutazione che si sta inserendo, la materia: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 36, 'Nella valutazione che si sta inserendo, il tipo voto: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 37, 'Nella valutazione che si sta inserendo, l''argomento: %L non è della stessa materia: %L.')::utility.system_message,
    ('it', 38, 'Nella valutazione che si sta inserendo, l''anno di corso e l''indirizzo scolastico dell'' argomento: %L non sono gli stessi della classe: %L.')::utility.system_message,
    ('it', 39, 'Nella valutazione che si sta inserendo, la metrica del voto: %L non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 40, 'Nella valutazione che si sta inserendo, la persona: %L indicata come alunno non ha il ruolo=''Student''.')::utility.system_message,
    ('it', 41, 'Nella valutazione che si sta inserendo, la nota: %L non è dell''alunno: %L e del docente: %L.')::utility.system_message,
    ('it', 42, 'Nella valutazione che si sta inserendo, il docente: %L (una persona della tabella persone) non appartiene allo stesso istituto: %L della classe: %L.')::utility.system_message,
    ('it', 43, 'Nella valutazione che si sta inserendo, la persona: %L indicata come docente non ha il ruolo=''Teacher''.')::utility.system_message,
    ('it', 44, 'Nella valutazione che si sta inserendo, la data della valutazione: %L non è compresa fra l''inizio e la fine delle lezioni dell''anno scolastico della classe: %L.')::utility.system_message,
    ('it', 45, 'La valutazione duplica i seguenti dati: classe,materia,docente,alunno,giorno,tipo_voto,argomento,metrica.')::utility.system_message,
    ('it', 46, 'Il voto: %L della valutazione: %L ha la metrica: %L che è già presente nel database con classe: %L, materia: %L, docente: %L, alunno: %L, giorno: %L, tipo_voto: %L e argomento: %L.')::utility.system_message,
    ('it', 47, 'Controllare i valori di: classe,materia,docente,giorno,tipo_voto,argomento,voto e riproporre l''operazione.')::utility.system_message,
    ('it', 48, 'Il voto: %L della valutazione che si sta inserendo ha la metrica: %L che è già presente nel database con classe: %L, materia: %L, docente: %L, alunno: %L, giorno: %L, tipo_voto: %L e argomento: %L.')::utility.system_message,
    ('it', 49, 'Se la valutazione viene indicata come privata non può avere una nota associata.')::utility.system_message,
    ('it', 50, 'La valutazione: %L è stata indicata come privata ma gli è stata associata la nota: %L.')::utility.system_message,
    ('it', 51, 'Controllare i valori di ''privata'' e ''nota'' e riproporre l''operazione.')::utility.system_message,
    ('it', 52, 'La valutazione che si sta inserendo è stata indicata come privata ma gli è stata associata la nota: %L.')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the funcion
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- Retrieve the school and the classroom
--
  SELECT sy.school, c.classroom, cs.student INTO me.school, me.classroom, me.student
    FROM classrooms_students cs
    JOIN classrooms c ON c.classroom = cs.classroom
    JOIN school_years sy ON sy.school_year = c.school_year
   WHERE cs.classroom_student = new.classroom_student;
--
-- check that the school of student is equal to school of the classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = me.student 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.valutation, me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,34), me.student, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the school of subject is equal to school of the classroom
--
  PERFORM 1 
     FROM subjects s
    WHERE subject = new.subject 
      AND s.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,5), new.valutation, new.subject, me.school,me.classroom),
        HINT = utility.system_messages_locale(system_messages,6);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,4),
        DETAIL = format(utility.system_messages_locale(system_messages,35), new.valutation, new.subject, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,6);
    END IF;       
  END IF;
--
-- check that the type grade is equals to subject of the valutation
--
  PERFORM 1 FROM grade_types WHERE grade_type = new.grade_type AND subject = new.subject;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'5'),
        MESSAGE = utility.system_messages_locale(system_messages,7),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.valutation, new.grade_type, new.subject),
        HINT = utility.system_messages_locale(system_messages,9);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'6'),
        MESSAGE = utility.system_messages_locale(system_messages,7),
        DETAIL = format(utility.system_messages_locale(system_messages,36), new.grade_type, new.subject),
        HINT = utility.system_messages_locale(system_messages,9);
    END IF;       
  END IF;
--
-- check that the topic is the same subject of the valutation
--
  IF new.topic IS NOT NULL THEN
    PERFORM 1 FROM topics WHERE topic = new.topic AND subject = new.subject;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'7'),
          MESSAGE = utility.system_messages_locale(system_messages,10),
          DETAIL = format(utility.system_messages_locale(system_messages,11), new.valutation, new.topic, new.subject),
          HINT = utility.system_messages_locale(system_messages,12);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'8'),
          MESSAGE = utility.system_messages_locale(system_messages,10),
          DETAIL = format(utility.system_messages_locale(system_messages,37), new.topic, new.subject),
          HINT = utility.system_messages_locale(system_messages,12);
      END IF;     
    END IF;
  END IF;
--
-- check that the course_year and degree of topic are the same of the classroom
--
  IF new.topic IS NOT NULL THEN
    PERFORM 1 FROM classrooms c
              JOIN topics a ON (     a.degree = c.degree 
                                AND  a.course_year = c.course_year)
             WHERE c.classroom = me.classroom 
               AND a.topic = new.topic;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'9'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,14), new.valutation, new.topic, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'A'),
          MESSAGE = utility.system_messages_locale(system_messages,13),
          DETAIL = format(utility.system_messages_locale(system_messages,38), new.topic, me.classroom),
          HINT = utility.system_messages_locale(system_messages,15);
      END IF;     
    END IF;
  END IF;
--
-- check that the school of metric of grade is the same of the classroom
--
  PERFORM 1 
     FROM metrics m
     JOIN grades v ON (m.metric = v.metric)
    WHERE v.grade = new.grade 
      AND m.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'B'),
        MESSAGE = utility.system_messages_locale(system_messages,16),
        DETAIL = format(utility.system_messages_locale(system_messages,17), new.valutation, new.grade, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,18);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'C'),
        MESSAGE = utility.system_messages_locale(system_messages,16),
        DETAIL = format(utility.system_messages_locale(system_messages,39), new.grade, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,18);
    END IF;       
  END IF;
--
-- check that the student is a person in rule 'Student'
--
  IF NOT in_any_roles(me.student, 'Student') THEN
    IF (TG_OP = 'UPDATE') THEN
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'D'),
      MESSAGE = utility.system_messages_locale(system_messages,19),
      DETAIL = format(utility.system_messages_locale(system_messages,20), new.valutation, me.student),
      HINT = utility.system_messages_locale(system_messages,21);
    ELSE
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'E'),
      MESSAGE = utility.system_messages_locale(system_messages,19),
      DETAIL = format(utility.system_messages_locale(system_messages,40), me.student),
      HINT = utility.system_messages_locale(system_messages,21);
    END IF;    
  END IF;
--
-- check that the note refer to the same student and at the same teacher
--
  IF new.note IS NOT NULL THEN
    PERFORM 1 FROM notes n
      WHERE n.note = new.note
        AND n.student = me.student
        AND n.teacher = new.teacher;
    IF NOT FOUND THEN
      IF (TG_OP = 'UPDATE') THEN
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'F'),
          MESSAGE = utility.system_messages_locale(system_messages,22),
          DETAIL = format(utility.system_messages_locale(system_messages,23), new.valutation, new.note, me.student, new.teacher),
          HINT = utility.system_messages_locale(system_messages,24);
      ELSE
        RAISE EXCEPTION USING
          ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'G'),
          MESSAGE = utility.system_messages_locale(system_messages,22),
          DETAIL = format(utility.system_messages_locale(system_messages,41), new.note, me.student, new.teacher),
          HINT = utility.system_messages_locale(system_messages,24);
      END IF;     
    END IF;
  END IF;
--
-- check that teacher's school is equals to teacher's classroom
--
  PERFORM 1 
     FROM persons p
    WHERE p.person = new.teacher 
      AND p.school = me.school;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'H'),
        MESSAGE = utility.system_messages_locale(system_messages,25),
        DETAIL = format(utility.system_messages_locale(system_messages,26), new.valutation, new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,27);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'I'),
        MESSAGE = utility.system_messages_locale(system_messages,25),
        DETAIL = format(utility.system_messages_locale(system_messages,42), new.teacher, me.school, me.classroom),
        HINT = utility.system_messages_locale(system_messages,27);
    END IF;    
  END IF;
--
-- check that the teacher is a person in rule 'Teacher'
--
  IF NOT in_any_roles(new.teacher, 'Teacher') THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'L'),
        MESSAGE = utility.system_messages_locale(system_messages,28),
        DETAIL = format(utility.system_messages_locale(system_messages,29), new.valutation, new.teacher),
        HINT = utility.system_messages_locale(system_messages,30);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'M'),
        MESSAGE = utility.system_messages_locale(system_messages,28),
        DETAIL = format(utility.system_messages_locale(system_messages,43), new.teacher),
        HINT = utility.system_messages_locale(system_messages,30);
    END IF;    
  END IF;
--
-- Check that the on_dates of valutation is between the begin_on and end_on the school year
--
  PERFORM 1 
     FROM school_years a
     JOIN classrooms c ON a.school_year = c.school_year
    WHERE c.classroom = me.classroom 
      AND a.lessons_duration @> new.on_date;
      
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'N'),
        MESSAGE = utility.system_messages_locale(system_messages,31),
        DETAIL = format(utility.system_messages_locale(system_messages,32), new.valutation, new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,33);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'O'),
        MESSAGE = utility.system_messages_locale(system_messages,31),
        DETAIL = format(utility.system_messages_locale(system_messages,44), new.on_date, me.classroom),
        HINT = utility.system_messages_locale(system_messages,33);
    END IF;    
  END IF;
--
-- Check that the classroom, subject, teacher, on_dates, grade_type, topic there is a single metric
--
  SELECT g.metric 
    INTO me.metric 
    FROM grades g 
   WHERE g.grade = new.grade;
    
  PERFORM 1 
     FROM valutations va
     JOIN grades vo ON va.grade = vo.grade
    WHERE va.classroom_student = new.classroom_student
      AND va.subject = new.subject
      AND va.teacher = new.teacher
      AND va.on_date = new.on_date
      AND va.grade_type = new.grade_type
      AND va.topic = new.topic
      AND vo.metric = me.metric
      AND va.valutation <> new.valutation;
  IF FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'P'),
        MESSAGE = diagnostic.my_sqlcode(me.full_function_name,'P') || ' ' || utility.system_messages_locale(system_messages,45),
        DETAIL = format(utility.system_messages_locale(system_messages,46), new.grade, new.valutation, me.metric, me.classroom, new.subject, new.teacher, me.student, new.on_date, new.grade_type, new.topic),
        HINT = utility.system_messages_locale(system_messages,47);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'Q'),
        MESSAGE = diagnostic.my_sqlcode(me.full_function_name,'Q') || ' ' || utility.system_messages_locale(system_messages,45),
        DETAIL = format(utility.system_messages_locale(system_messages,48), new.grade, me.metric, me.classroom, new.subject, new.teacher, me.student, new.on_date, new.grade_type, new.topic),
        HINT = utility.system_messages_locale(system_messages,47);
    END IF;    
  END IF;        
--
-- If the valutation is private cannot be assigned a notes
--
  IF  new.private = true AND new.note IS NOT NULL THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'R'),
        MESSAGE = utility.system_messages_locale(system_messages,49),
        DETAIL = format(utility.system_messages_locale(system_messages,50), new.valutation, new.private, new.note),
        HINT = utility.system_messages_locale(system_messages,51);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'S'),
        MESSAGE = utility.system_messages_locale(system_messages,49),
        DETAIL = format(utility.system_messages_locale(system_messages,52), new.private, new.note),
        HINT = utility.system_messages_locale(system_messages,51);
    END IF;    
  END IF;
    
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutations_iu() OWNER TO postgres;

--
-- Name: tr_valutations_qualifications_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_valutations_qualifications_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute of the ''qualification'' is not the same as that of the ''student'' of ''valutation''')::utility.system_message,
    ('en', 2, 'The ''valutation_qualification'': ''%s'' specifies a ''qualification'': ''%s'' with an institution different from that of the ''student'' of ''valutation'': ''%s''')::utility.system_message,
    ('en', 3, 'Correct values of: the ''qualification'' and ''valutation'' and repeat the operation')::utility.system_message,
    ('en', 4, 'The ''valutation_qualification'' that you are inserting specifies a ''qualification'': ''%s'' with an institution different from that of the ''student'' of ''valutation'': ''%s''')::utility.system_message,
    ('en', 5, 'The Institute of the ''qualification'' is not the same as that of the ''metric'' of ''grade''')::utility.system_message,
    ('en', 6, 'The ''valutation_qualification'': ''%s'' specifies a ''qualification'': ''%s'' with an institute which is different from that of the ''metric'' of ''grade'': ''%s''')::utility.system_message,
    ('en', 7, 'Correct values of: the ''qualification'' and ''grade'' and repeat the operation')::utility.system_message,
    ('en', 8, 'The ''valutation_qualification'' that you are inserting specifies a ''qualification'': ''%s'' with an institute which is different from that of the ''metric'' of ''grade'': ''%s''')::utility.system_message,    
    ('it', 1, 'L''istituto della ''qualifica'' non è lo stesso di quello dell'' ''alunno'' della ''valutazione''')::utility.system_message,
    ('it', 2, 'La ''valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 3, 'Correggere i valori di: ''qualifica'' e ''valutazione'' e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'La ''valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello dell'' ''alunno'' della ''valutazione'': ''%s''')::utility.system_message,
    ('it', 5, 'L''istituto della ''qualifica'' non è lo stesso di quello della ''metrica'' del ''voto''')::utility.system_message,
    ('it', 6, 'La ''valutazione_qualifica'': ''%s'' specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message,
    ('it', 7, 'Correggere i valori di: ''qualifica'' e ''voto'' e riproporre l''operazione')::utility.system_message,
    ('it', 8, 'La ''valutazione_qualifica'' che si sta inserendo specifica una ''qualifica'': ''%s'' con un istituto diverso da quello della ''metrica'' del ''voto'': ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- check that the school of the qualification both the same of that of the student of the valutation
--
  PERFORM 1 
     FROM valutations v
     JOIN classrooms_students cs ON cs.classroom_student = v.classroom_student
     JOIN persons p ON p.person = cs.student  
     JOIN qualifications q ON p.school = q.school
    WHERE v.valutation = new.valutation
      AND q.qualification = new.qualification;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.valutation_qualificationtion, new.qualification,  new.valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.qualification,  new.valutation),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
--
-- check that the school of the qualification both the same of that of the metric of the grade
--
PERFORM 1 FROM grades v
   JOIN metrics m ON v.metric = v.metric
   JOIN qualifications q ON m.school = q.school
  WHERE v.grade = new.grade
    AND q.qualification = new.qualification;
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'3'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,6), new.valutation_qualificationtion, new.qualification,  new.grade),
        HINT = utility.system_messages_locale(system_messages,7);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'4'),
        MESSAGE = utility.system_messages_locale(system_messages,5),
        DETAIL = format(utility.system_messages_locale(system_messages,8), new.qualification,  new.grade),
        HINT = utility.system_messages_locale(system_messages,7);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_valutations_qualifications_iu() OWNER TO postgres;

--
-- Name: tr_weekly_timetables_days_iu(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION tr_weekly_timetables_days_iu() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  v_school      bigint;
  context       text;
  full_function_name    text;
  system_messages   utility.system_message[] = ARRAY[
    ('en', 1, 'The institute who wrote the message (from) is not the same as the pupil of the personal report card')::utility.system_message,
    ('en', 2, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message: ''%s'' is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('en', 3, 'Check the values of the person ''da'' and the conversation and repeat the operation')::utility.system_message,
    ('en', 4, 'The Institute: ''%s'' of the person (from): ''%s'' that wrote the message that you are inserting is not the same as the pupil holder of the personal report card to which leads the conversation: ''%s''')::utility.system_message,
    ('it', 1, 'la scuola della persona no è la stessa di quella della classroom della note')::utility.system_message,
    ('it', 2, 'in data:''%s''')::utility.system_message,
    ('it', 3, 'Controllare i valori della persona ''da'' e della conversazione e riproporre l''operazione')::utility.system_message,
    ('it', 4, 'L''istituo: ''%s'' della persona (da): ''%s'' che ha scritto il messaggio che si sta inserendo non è lo stesso dell''alunno intestatario del libretto a cui fa'' capo la conversazione: ''%s''')::utility.system_message];
BEGIN 
--
-- Retrieve the name of the function
--
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
--
-- metto da una parte l'school della classroom
--
  SELECT s.school INTO v_school 
    FROM schools s
    JOIN school_years sy ON sy.school = s.school
    JOIN classrooms c ON c.school_year = sy.school_year
    JOIN weekly_timetables wt ON wt.classroom = c.classroom
    JOIN weekly_timetables_days wtd ON wtd.weekly_timetable = wt.weekly_timetable
   WHERE wt.weekly_timetable_day = new.weekly_timetable_day;
--
-- controllo che l'school della person sia lo stesso di quello della classroom del calendario settimanale
--
  PERFORM 1 FROM persons
    WHERE person = new.person
      AND school = v_school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.at_timerio_weekli_on_date, new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  
--
-- controllo che l'school della subject sia lo stesso di quello della classroom del calendario settimanale
--
  PERFORM 1 FROM subjects
    WHERE subject = new.subject
      AND school = v_school;
           
  IF NOT FOUND THEN
    IF (TG_OP = 'UPDATE') THEN
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'1'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,2), new.at_timerio_weekli_on_date, new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    ELSE
      RAISE EXCEPTION USING
        ERRCODE = diagnostic.my_sqlcode(me.full_function_name,'2'),
        MESSAGE = utility.system_messages_locale(system_messages,1),
        DETAIL = format(utility.system_messages_locale(system_messages,4), new.person, v_school, new.note),
        HINT = utility.system_messages_locale(system_messages,3);
    END IF;    
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.tr_weekly_timetables_days_iu() OWNER TO postgres;

--
-- Name: valutations_del(bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_del(_rv bigint, _valutation bigint) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
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
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages  	utility.system_message[] = ARRAY[
   ('en', 1, 'was not found no row in table the ''valutazioni'' with: ''revision'' = ''%s'', ''valutazione'' = ''%s''')::utility.system_message,
   ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
   ('en', 3, 'Check the value of: ''revision'', ''valutazione'' and retry the operation')::utility.system_message,
   ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s''')::utility.system_message,
   ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
   ('it', 3, 'Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  DELETE FROM valutations t WHERE t.valutation = _valutation AND xmin = _rv::text::xid;
  
  IF NOT FOUND THEN 
    RAISE EXCEPTION USING
      ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
      MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _valutation),
      DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
      HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END;
$$;


ALTER FUNCTION public.valutations_del(_rv bigint, _valutation bigint) OWNER TO postgres;

--
-- Name: FUNCTION valutations_del(_rv bigint, _valutation bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION valutations_del(_rv bigint, _valutation bigint) IS 'Delete a valutation';


--
-- Name: valutations_ex_by_classroom_teacher_subject(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) RETURNS refcursor
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  cur 			refcursor;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
   OPEN cur FOR SELECT rv,
		       classroom,
		       teacher,
		       subject,
		       valutation,
		       student,
		       surname,
		       name,
		       on_date,
		       grade_type,
		       grade_type_description,
		       topic,
		       topic_description,
		       metric,
		       metric_description,
		       grade,
		       grade_description,
		       evaluation,
		       privato
		  FROM valutations_ex
		 WHERE classroom = p_classroom
		   AND teacher = p_teacher
		   AND subject = p_subject   
	      ORDER BY on_date, surname, name, student, grade_type, topic;
 RETURN cur;	        
END;
$$;


ALTER FUNCTION public.valutations_ex_by_classroom_teacher_subject(p_classroom bigint, p_teacher bigint, p_subject bigint) OWNER TO postgres;

--
-- Name: valutations_ins(bigint, bigint, bigint, bigint, bigint, character varying, boolean, bigint, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ins(OUT _rv bigint, OUT _valutation bigint, _classroom_student bigint, _subject bigint, _grade_type bigint, _topic bigint, _grade bigint, _evaluation character varying, _private boolean, _teacher bigint, _on_date date) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  IF _topic = 0 THEN 
    _topic := nULL ;
  END IF;
  
  INSERT INTO valutations 
             (classroom_student, subject, grade_type, topic, grade, evaluation, private, teacher, on_date)
      VALUES (_classroom_student, _subject, _grade_type, _topic, _grade, _evaluation, _private, _teacher, _on_date);
      
  SELECT currval('pk_seq') INTO _valutation;
  SELECT xmin::text::bigint 
    INTO _rv 
    FROM public.valutations 
   WHERE valutation = _valutation;
END;
$$;


ALTER FUNCTION public.valutations_ins(OUT _rv bigint, OUT _valutation bigint, _classroom_student bigint, _subject bigint, _grade_type bigint, _topic bigint, _grade bigint, _evaluation character varying, _private boolean, _teacher bigint, _on_date date) OWNER TO postgres;

--
-- Name: valutations_ins_note(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
<<me>>
DECLARE
  context 			text;
  full_function_name		text;
  
  subject_description 		varchar;
  grade_type_description 	varchar;
  topic_description 		varchar;
  grade_description 		varchar;
  teacher_surname_name 		varchar;
  student_name 			varchar;
  description 			varchar;
  student			bigint;
  teacher			bigint;
  on_date			date;
  
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT va.on_date, cs.student, va.teacher, alu.name , doc.surname || ' ' || doc.name , m.description, tv.description, a.description, vo.description
    INTO me.on_date, me.student, me.teacher, me.student_name, me.teacher_surname_name, me.subject_description, me.grade_type_description, me.topic_description, me.grade_description
    FROM valutations va
    JOIN classrooms_students cs ON cs.classroom_student = va.classroom_student
    JOIN persons alu ON cs.student = alu.person
    JOIN persons doc ON va.teacher = doc.person
    JOIN subjects m ON va.subject = m.subject
    JOIN grade_types tv ON va.grade_type = tv.grade_type
    JOIN topics a ON va.topic = a.topic
    JOIN grades vo ON va.grade = vo.grade
   WHERE valutation = _valutation;
   
  me.description := format('In on_date: %s ad: %s il teacher: %s (%s) ha dato sull''topic: %s nel type di valutation: %s il grade: %s e ha richiesto il vostro visto',
                           to_char('2014-01-31'::date,'Dy DD Mon yyyy'), me.student_name, me.teacher_surname_name, me.subject_description, me.topic_description, me.grade_type_description, me.grade_description);
                           
  SELECT nextval('pk_seq') INTO _note;

  INSERT INTO notes (note, student, description, teacher, disciplinary, on_date, at_time, to_approve, classroom)
             VALUES (_note, me.student, me.description, me.teacher, false, me.on_date, now()::time, true, NULL);
             
  SELECT xmin::text::bigint INTO _rv FROM notes WHERE note = _note;
END;
$$;


ALTER FUNCTION public.valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint) OWNER TO postgres;

--
-- Name: FUNCTION valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint) IS 'Insert a note in the valutation';


--
-- Name: valutations_sel(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) RETURNS record
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   	utility.system_message[] = ARRAY[
   ('en', 1, 'was not found no row in table the ''valutazioni'' with: ''valutazione'' = ''%s''')::utility.system_message,
   ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
   ('en', 3, 'Check the value of: ''valutazione'' and retry the operation')::utility.system_message,
   ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''valutazioni'' con:  ''valutazione'' = ''%s''')::utility.system_message,
   ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
   ('it', 3, 'Controllare il valore di: ''valutazione'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  SELECT xmin::text::bigint, valutation, evaluation, private, note IS NOT NULL AS note
  INTO p_rv, p_valutation, p_evaluation, p_private, p_note 
  FROM valutations
  WHERE valutation = p_valutation;
  
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),p_valutation),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
END;
$$;


ALTER FUNCTION public.valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) OWNER TO postgres;

--
-- Name: FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) IS 'Select a valutation';


--
-- Name: valutations_upd(bigint, bigint, character varying, boolean, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean) RETURNS bigint
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
 * This copyrighted subjectl is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions
 * of the GNU Affero Generto_time Public License, v. 3.
 * This program is distributed in the hope that it will be useful, but WITHOUT A
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
 * PARTICULAR PURPOSE.
 * 
 * See http://www.gnu.org/licenses/agpl-3.0.html for more details.
 */
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages   	utility.system_message[] = ARRAY[
   ('en', 1, 'was not found no row in table the ''valutazioni'' with: ''revision'' = ''%s'', ''valutazione'' = ''%s''')::utility.system_message,
   ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
   ('en', 3, 'Check the value of: ''revision'', ''valutazione'' and retry the operation')::utility.system_message,
   ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s''')::utility.system_message,
   ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
   ('it', 3, 'Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  UPDATE valutations 
     SET valutation = _valutation, 
         evaluation = _evaluation, 
         private = _private
    WHERE valutation = _valutation
      AND xmin = _rv::text::xid;
      
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,2),_rv, _valutation),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  
  IF _note THEN
  
    --Check if the missing notes and possibly then the iput
    PERFORM 1 
       FROM valutations 
      WHERE valutation = _valutation 
        AND note IS NOT NULL;
        
    IF NOT FOUND THEN
    -- insert the note 
  END IF;	
  ELSE
    DELETE FROM notes WHERE note IN (SELECT note FROM valutations WHERE valutation = _valutation);
  END IF;
  RETURN xmin::text::bigint  FROM valutations WHERE valutation = _valutation;
END;
$$;


ALTER FUNCTION public.valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean) OWNER TO postgres;

--
-- Name: FUNCTION valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean) IS 'Update a valutation';


--
-- Name: valutations_upd_grade(bigint, bigint, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
  system_messages  	utility.system_message[] = ARRAY[
   ('en', 1, 'was not found no row in table the ''valutazioni'' with: ''revision'' = ''%s'', ''valutazione'' = ''%s''')::utility.system_message,
   ('en', 2, 'The function in error is: ''%s''')::utility.system_message,
   ('en', 3, 'Check the value of: ''revision'', ''valutazione'' and retry the operation')::utility.system_message,
   ('it', 1, 'Non è stata trovata nessuna riga nella tabella ''valutazioni'' con: ''revisione'' = ''%s'',  ''valutazione'' = ''%s''')::utility.system_message,
   ('it', 2, 'La funzione in errore è: ''%s''')::utility.system_message,
   ('it', 3, 'Controllare il valore di: ''revisione'', ''valutazione'' e riprovare l''operazione')::utility.system_message];
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  UPDATE valutations
     SET grade = p_grade
   WHERE valutation = p_valutation
     AND xmin = p_rv::text::xid;
     
  IF NOT FOUND THEN RAISE USING
    ERRCODE = diagnostic.my_sqlcode(full_function_name,'1'),
    MESSAGE = format(utility.system_messages_locale(system_messages,1),p_rv, p_valutation),
    DETAIL = format(utility.system_messages_locale(system_messages,2),current_query()),
    HINT = utility.system_messages_locale(system_messages,3);
  END IF;
  
  RETURN xmin::text::bigint  FROM valutations WHERE valutation = p_valutation;
END;
$$;


ALTER FUNCTION public.valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) OWNER TO postgres;

--
-- Name: FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION valutations_upd_grade(p_rv bigint, p_valutation bigint, p_grade bigint) IS 'Update the grade of a valutation';


--
-- Name: w_classrooms_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_ex() RETURNS SETOF classrooms_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN QUERY SELECT * FROM classrooms_ex;
 END;
$$;


ALTER FUNCTION public.w_classrooms_ex() OWNER TO postgres;

--
-- Name: FUNCTION w_classrooms_ex(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION w_classrooms_ex() IS 'Returns classrooms with other info';


--
-- Name: w_classrooms_students_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_students_ex() RETURNS SETOF classrooms_students_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN QUERY SELECT * FROM classrooms_students_ex;
 END;
$$;


ALTER FUNCTION public.w_classrooms_students_ex() OWNER TO postgres;

--
-- Name: FUNCTION w_classrooms_students_ex(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION w_classrooms_students_ex() IS 'Returns students of all classroom with other info';


--
-- Name: w_classrooms_teachers_subjects_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_classrooms_teachers_subjects_ex() RETURNS SETOF classrooms_teachers_subjects_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
 
  RETURN QUERY SELECT * 
    FROM classrooms_teachers_subjects_ex
   WHERE school = ANY (schools_enabled());
 END;
$$;


ALTER FUNCTION public.w_classrooms_teachers_subjects_ex() OWNER TO postgres;

--
-- Name: FUNCTION w_classrooms_teachers_subjects_ex(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION w_classrooms_teachers_subjects_ex() IS 'Returns all teachers with their subjects and other infos';


--
-- Name: w_weekly_timetable_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_weekly_timetable_ex() RETURNS SETOF weekly_timetable_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  
  RETURN QUERY SELECT * FROM weekly_timetable_ex;
 END;
$$;


ALTER FUNCTION public.w_weekly_timetable_ex() OWNER TO postgres;

--
-- Name: FUNCTION w_weekly_timetable_ex(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION w_weekly_timetable_ex() IS 'Returns weekly timetable with other info';


--
-- Name: w_weekly_timetables_days_ex(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION w_weekly_timetables_days_ex() RETURNS SETOF weekly_timetables_days_ex
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/* 
questa funzione serve from_time wrapper per la query person il corrispondente name senza il prefisso w_
*/
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
   
  RETURN QUERY SELECT * FROM weekly_timetables_days_ex;
 END;
$$;


ALTER FUNCTION public.w_weekly_timetables_days_ex() OWNER TO postgres;

--
-- Name: FUNCTION w_weekly_timetables_days_ex(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION w_weekly_timetables_days_ex() IS 'Return weekly timetable with all days and other info';


--
-- Name: weekly_timetable_xt_subject(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) RETURNS TABLE(period text, "lunedì" text, "martedì" text, "mercoledì" text, "giovedì" text, "venerdì" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  RETURN QUERY SELECT *
    FROM crosstab('SELECT period, weekday, subject::text 
                     FROM weekly_timetables_days_ex 
                    WHERE weekly_timetable='  || p_weekly_timetable || ' ORDER BY 1',
                    $$VALUES (1),(2),(3),(4),(5),(6)$$
                  )
      AS ct (period text, lunedì text, martedì text, mercoledì text, giovedì text, venerdì text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.weekly_timetable_xt_subject(p_weekly_timetable bigint) OWNER TO postgres;

--
-- Name: weekly_timetable_xt_teacher(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION weekly_timetable_xt_teacher(p_weekly_timetable bigint) RETURNS TABLE(period text, "lunedì" text, "martedì" text, "mercoledì" text, "giovedì" text, "venerdì" text, sabato text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $_$
<<me>>
DECLARE
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  RETURN QUERY SELECT *
    FROM crosstab('SELECT period, weekday, teacher_name_surname 
                     FROM weekly_timetables_days_ex 
                    WHERE weekly_timetable='  || p_weekly_timetable || ' ORDER BY 1',
                    $$VALUES (1),(2),(3),(4),(5),(6)$$
                  )
      AS ct (period text, lunedì text, martedì text, mercoledì text, giovedì text, venerdì text, sabato text);                   
 END;
$_$;


ALTER FUNCTION public.weekly_timetable_xt_teacher(p_weekly_timetable bigint) OWNER TO postgres;

--
-- Name: where_sequence(text, bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION where_sequence(name text, search_value bigint) RETURNS TABLE(table_catalog information_schema.sql_identifier, table_schema information_schema.sql_identifier, table_name information_schema.sql_identifier, column_name information_schema.sql_identifier, num_time_found bigint)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO public, pg_temp
    AS $$
/*
   Cerca in tutte le columns del on_datebase che hanno per default 
   la sequenza indicata nel parametro name il valore indicato nel
   parametro value
*/
<<me>>
declare
  results 		record;
  default_column 	character varying;
  context 		text;
  full_function_name	text;
begin
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  
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
-- Name: FUNCTION where_sequence(name text, search_value bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION where_sequence(name text, search_value bigint) IS 'Returns where the sequence is';


--
-- Name: wikimedia_0_reset(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_0_reset() RETURNS TABLE(_message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  row_count_wikimedia_files_persons	int = 0;
  row_count_wikimedia_files		int = 0;
  row_count_persons         		int = 0;
  my_command                		text;
  error		            		diagnostic.error;
  my_data_path              		text = '/var/lib/scuola247/';
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
-- table wikimedia_files
  BEGIN
    UPDATE wikimedia_files SET info = NULL, thumbnail = NULL, photo = NULL;
    GET DIAGNOSTICS row_count_wikimedia_files = ROW_COUNT;
    RAISE NOTICE 'table wikimedia_files: set null to info, photo e thumbnail...: % rows updated', row_count_wikimedia_files::text;
    _message =   'table wikimedia_files: set null to info, photo e thumbnail...: ' || row_count_wikimedia_files::text || ' rows updated'; RETURN NEXT; 
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'table wikimedia_files: set null to info, photo e thumbnail...: *** KO ***';
    _message  =  'table wikimedia_files: set null to info, photo e thumbnail...: *** KO ***'; RETURN NEXT; 
    PERFORM diagnostic.show(error);
  END;
-- table persons
  BEGIN
    UPDATE persons SET thumbnail = NULL, photo = NULL;
    GET DIAGNOSTICS row_count_persons = ROW_COUNT;
    RAISE NOTICE 'table persons: set null to photo e thumbnail.................: % rows updated', row_count_persons::text;
    _message =   'table persons: set null to photo e thumbnail.................: ' || row_count_persons::text || ' rows updated'; RETURN NEXT; 
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'table persons: set null to photo e thumbnail.................: *** KO ***';
    _message =   'table persons: set null to photo e thumbnail.................: *** KO ***'; RETURN NEXT; 
    PERFORM diagnostic.show(error);
  END;  
-- table wikimedia_files_persons
  DELETE FROM wikimedia_files_persons;
    GET DIAGNOSTICS row_count_wikimedia_files_persons = ROW_COUNT;
    RAISE NOTICE 'table wikmedia_files_persons.................................: % rows deleted', row_count_wikimedia_files_persons::text;
    _message =   'table wikmedia_files_persons.................................: ' || row_count_wikimedia_files_persons::text || ' rows deleted'; RETURN NEXT; 
  
-- files wikimedia_files/infos
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/infos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove info...........................: !!! OK !!!';
    _message =   'files wikimedia_files: remove info...........................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove info...........................: *** KO ***';
    _message =   'files wikimedia_files: remove info...........................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
  
-- files wikimedia_files/thumbnail
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/thumbnails/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove thumbnail......................: !!! OK !!!';
    _message =   'files wikimedia_files: remove thumbnail......................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove thumbnail......................: *** KO ***';
    _message =   'files wikimedia_files: remove thumbnail......................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
-- files wikimedia_files/photos
    
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/wikimedia_files/photos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files wikimedia_files: remove photo..........................: !!! OK !!!';
    _message =   'files wikimedia_files: remove photo..........................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files wikimedia_files: remove photo..........................: *** KO ***';
    _message =   'files wikimedia_files: remove photo..........................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
  
-- files persons/thumbnails
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/persons/thumbnails/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files persons: remove thumbnails.............................: !!! OK !!!';
    _message =   'files persons: remove thumbnails.............................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files persons: remove thumbnails.............................: *** KO ***';
    _message =   'files persons: remove thumbnails.............................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
-- files persons/photos
  
  BEGIN   
    my_command = 'COPY (SELECT 1) TO PROGRAM ''rm ' || my_data_path || '/persons/photos/*''';
    EXECUTE my_command;
    RAISE NOTICE 'files persons: remove photos.................................: !!! OK !!!';
    _message =   'files persons: remove photo..................................: !!! OK !!!'; RETURN NEXT;         
  EXCEPTION WHEN OTHERS THEN
    GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
    RAISE NOTICE 'files persons: remove photo..................................: *** KO ***';
    _message =   'files persons: remove photo..................................: *** KO ***'; RETURN NEXT;     
    PERFORM diagnostic.show(error);
  END;
         
END
$$;


ALTER FUNCTION public.wikimedia_0_reset() OWNER TO postgres;

--
-- Name: wikimedia_1_recreate_wikimedia_files_persons(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_1_recreate_wikimedia_files_persons() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  row_count integer;
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  DELETE FROM wikimedia_files_persons;
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'wikimedia_files_persons deleted .................: ' || row_count::text;
  RETURN NEXT; 
  
  WITH p AS (SELECT person, ((row_number() OVER() -1 )% (select count (*) from wikimedia_files where type = 'Male portrait')) + 1 AS row_number FROM persons WHERE sex = 'M' ORDER BY person),
       w AS (SELECT wikimedia_file, row_number() OVER() AS row_number from wikimedia_files  WHERE type = 'Male portrait' ORDER BY wikimedia_file)
  INSERT INTO wikimedia_files_persons (person, wikimedia_file) 
  SELECT  p.person, w.wikimedia_file
  FROM p
  JOIN w on p.row_number = w.row_number;
  
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'wikimedia_files_persons (Male) inserted .........: ' || row_count::text;
  RETURN NEXT; 
  WITH p AS (SELECT person, ((row_number() OVER() -1 )% (select count (*) from wikimedia_files where type = 'Female portrait')) + 1 AS row_number FROM persons WHERE sex = 'F' ORDER BY person),
       w AS (SELECT wikimedia_file, row_number() OVER() AS row_number from wikimedia_files  WHERE type = 'Female portrait' ORDER BY wikimedia_file)
  INSERT INTO wikimedia_files_persons (person, wikimedia_file) 
  SELECT  p.person, w.wikimedia_file
  FROM p
  JOIN w on p.row_number = w.row_number;
 
  GET DIAGNOSTICS row_count = ROW_COUNT;
  message := 'wikimedia_files_persons (Female) inserted .......: ' || row_count::text;
  RETURN NEXT; 
  RETURN;
  END
$$;


ALTER FUNCTION public.wikimedia_1_recreate_wikimedia_files_persons() OWNER TO postgres;

--
-- Name: wikimedia_2_wikimedia_files_hydration(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_2_wikimedia_files_hydration(_count integer DEFAULT 1) RETURNS TABLE(_message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  ctr_info_ok                	int = 0;
  ctr_info_ko                	int = 0;
  ctr_photo_ok               	int = 0;
  ctr_photo_ko               	int = 0;
  ctr_thumbnail_ok           	int = 0;
  ctr_thumbnail_ko          	int = 0;
  
  my_record                  	record;
  url_wikimedia_api_prefix   	text := 'https://tools.wmflabs.org/magnus-toolserver/commonsapi.php?image=';
  error                      	diagnostic.error;
  my_thumbnail_info          	xml;
  my_url                     	text;
  context 			text;
  full_function_name		text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  SET http.keepalive = 'on';
  SET http.timeout_msec = 30000;
  -- hydration column info
  FOR my_record IN SELECT wikimedia_file, name
                     FROM wikimedia_files 
                    WHERE info IS NULL 
                 ORDER BY wikimedia_file
                    LIMIT _count
  LOOP
    BEGIN
      UPDATE wikimedia_files SET info = (http(('GET', url_wikimedia_api_prefix || my_record.name , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_info_ok := ctr_info_ok + 1;
      _message := 'wikimedia_files: set info..................: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;  
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_info_ko := ctr_info_ko + 1;
      RAISE NOTICE 'wikimedia_files: set info..................: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set info..................: '|| my_record.name || ' *** KO ***'; RETURN NEXT;       
    END;
  END LOOP;
-- hydration column thumbnail
  FOR my_record IN SELECT wikimedia_file, info, name
                     FROM wikimedia_files 
                    WHERE thumbnail IS NULL 
                 ORDER BY wikimedia_file
                    LIMIT _count
  LOOP
    BEGIN
      my_thumbnail_info := (http(('GET', url_wikimedia_api_prefix || my_record.name::text || '&thumbwidth=100', ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml;
      my_url := (xpath('/response/file/urls/thumbnail/text()',my_thumbnail_info))[1];
      UPDATE wikimedia_files SET thumbnail = textsend((http(('GET', my_url , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content)
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      _message := 'wikimedia_files: set thumbnail.............: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'wikimedia_files: set thumbnail.............: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set thumbnail.............: '|| my_record.name || ' *** KO ***'; RETURN NEXT;      
    END;
  END LOOP;
-- hydration column photo
  FOR my_record IN SELECT wikimedia_file, info, name
                     FROM wikimedia_files 
                    WHERE photo IS NULL 
                 ORDER BY wikimedia_file                    
                    LIMIT _count
  LOOP
    BEGIN
      my_thumbnail_info := (http(('GET', url_wikimedia_api_prefix || my_record.name::text || '&thumbwidth=400', ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content::xml;
      my_url := (xpath('/response/file/urls/thumbnail/text()',my_thumbnail_info))[1];
      UPDATE wikimedia_files SET photo = textsend((http(('GET', my_url , ARRAY[('user-agent','scuola247')::http_header], NULL, NULL)::http_request)).content)
        WHERE wikimedia_file = my_record.wikimedia_file;
      ctr_photo_ok := ctr_photo_ok + 1;
      _message := 'wikimedia_files: set photo.................: '|| my_record.name || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'wikimedia_files: set photo.................: % *** KO ***', my_record.name;
      PERFORM diagnostic.show(error);
      _message := 'wikimedia_files: set photo.................: '|| my_record.name || ' *** KO ***'; RETURN NEXT;      
    END;
  END LOOP;

  RAISE NOTICE 'wikimedia_files: set info !!!OK!!! ........: % ', ctr_info_ok;
  RAISE NOTICE 'wikimedia_files: set info ***KO*** ........: % ', ctr_info_ko;
  RAISE NOTICE 'wikimedia_files: set thumbnail !!!OK!!! ...: % ', ctr_thumbnail_ok;
  RAISE NOTICE 'wikimedia_files: set thumbnail ***KO*** ...: % ', ctr_thumbnail_ko;
  RAISE NOTICE 'wikimedia_files: set photo !!!OK!!! .......: % ', ctr_photo_ok;
  RAISE NOTICE 'wikimedia_files: set photo ***KO*** .......: % ', ctr_photo_ko;
  _message := 'wikimedia_files: set info !!!OK!!! ........: ' || ctr_info_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set info ***KO*** ........: ' || ctr_info_ko::text; RETURN NEXT;
  _message := 'wikimedia_files: set thumbnail !!!OK!!! ...: ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set thumbnail ***KO*** ...: ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  _message := 'wikimedia_files: set photo !!!OK!!! .......: ' || ctr_photo_ok::text; RETURN NEXT; 
  _message := 'wikimedia_files: set photo ***KO*** .......: ' || ctr_photo_ko::text; RETURN NEXT; 
      
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE 'Normally errors are due to timeouts or slow connections.';
  RAISE NOTICE 'Please retry the operation until you clear the error.';
  RAISE NOTICE 'It is recommended to investigate the errors only if them are not decreasing.';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  RAISE NOTICE '****************************** READ CAREFULLY ******************************';
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := 'Normally errors are due to timeouts or slow connections.'; RETURN NEXT; 
  _message := 'Please retry the operation until you clear the error.'; RETURN NEXT; 
  _message := 'It is recommended to investigate the errors only if them are not decreasing.'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
  _message := '****************************** READ CAREFULLY ******************************'; RETURN NEXT; 
END
$$;


ALTER FUNCTION public.wikimedia_2_wikimedia_files_hydration(_count integer) OWNER TO postgres;

--
-- Name: wikimedia_3_wikimedia_files_popolate_files(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_3_wikimedia_files_popolate_files() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  my_record		record;
  my_command		text;
  error			diagnostic.error;
  my_data_path		text = '/var/lib/scuola247/wikimedia_files/';
  ctr_info_ok		int = 0;
  ctr_info_ko		int = 0;
  ctr_photo_ok		int = 0;
  ctr_photo_ko		int = 0;
  ctr_thumbnail_ok	int = 0;
  ctr_thumbnail_ko	int = 0;
  
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  -- info
  FOR my_record IN SELECT wikimedia_file, info
                     FROM wikimedia_files 
                    WHERE info IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(info::text::bytea, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'infos/' || my_record.wikimedia_file::text || '.xml''';
      EXECUTE my_command;
      ctr_info_ok := ctr_info_ok + 1;
      message := 'wikimedia_files: write info file.....................: '|| my_record.wikimedia_file::text || ' !!! OK !!!'; RETURN NEXT;         
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_info_ko := ctr_info_ko + 1;
      RAISE NOTICE 'wikimedia_files: write info file.....................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write info file.....................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT;
      PERFORM diagnostic.show(error); 
    END;
  END LOOP;
-- thumbnail
  FOR my_record IN SELECT wikimedia_file, name, thumbnail
                     FROM wikimedia_files 
                    WHERE thumbnail IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(thumbnail, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'thumbnails/' || my_record.wikimedia_file::text ||  right(my_record.name,4) || '''';
      EXECUTE my_command;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      message := 'wikimedia_files: write thumbnail file................: '|| my_record.wikimedia_file::text || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'wikimedia_files: write thumbnail file................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write thumbnail file................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
    END;
  END LOOP;
  
-- photo
  FOR my_record IN SELECT wikimedia_file, name, photo
                     FROM wikimedia_files 
                    WHERE photo IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode(photo, ''hex'') FROM wikimedia_files WHERE wikimedia_file = ' || my_record.wikimedia_file::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'photos/' || my_record.wikimedia_file::text || right(my_record.name,4) || '''';
      EXECUTE my_command;
      ctr_photo_ok := ctr_photo_ok + 1;
      message := 'wikimedia_files: write photo file....................: '|| my_record.wikimedia_file::text || ' !!! OK !!!';  RETURN NEXT; 
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'wikimedia_files: write photo file....................: % *** KO ***', my_record.wikimedia_file::text;
      message := 'wikimedia_files: write photo file....................: '|| my_record.wikimedia_file::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
     END;
  END LOOP;
  RAISE NOTICE 'wikimedia_files: write info file .........!!! OK !!! : % ', ctr_info_ok;
  RAISE NOTICE 'wikimedia_files: write info file .........*** KO *** : % ', ctr_info_ko;
  RAISE NOTICE 'wikimedia_files: write thumbnail file ... !!! OK !!! : % ', ctr_thumbnail_ok;
  RAISE NOTICE 'wikimedia_files: write thumbnail file ....*** KO *** : % ', ctr_thumbnail_ko;
  RAISE NOTICE 'wikimedia_files: write photo file ........!!! OK !!! : % ', ctr_photo_ok;
  RAISE NOTICE 'wikimedia_files: write photo file ........*** KO *** : % ', ctr_photo_ko;
  message := 'wikimedia_files: write info file .........!!! OK !!! : ' || ctr_info_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write info file .........*** KO *** : ' || ctr_info_ko::text; RETURN NEXT;
  message := 'wikimedia_files: write thumbnail file ... !!! OK !!! : ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write thumbnail file ....*** KO *** : ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  message := 'wikimedia_files: write photo file ........!!! OK !!! : ' || ctr_photo_ok::text; RETURN NEXT; 
  message := 'wikimedia_files: write photo file ........*** KO *** : ' || ctr_photo_ko::text; RETURN NEXT; 
      
END
$$;


ALTER FUNCTION public.wikimedia_3_wikimedia_files_popolate_files() OWNER TO postgres;

--
-- Name: wikimedia_4_persons_hydration(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_4_persons_hydration() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  ctr_photo_ok int = 0;
  ctr_thumbnail_ok int = 0;
  
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  UPDATE persons p SET thumbnail.content = wf.thumbnail, thumbnail.mime_type = lower(right(wf.name,4))::file_extension
    FROM wikimedia_files wf, wikimedia_files_persons wfp
   WHERE wfp.wikimedia_file = wf.wikimedia_file
     AND wfp.person = p.person
     AND p.thumbnail IS NULL 
     AND wf.thumbnail IS NOT NULL;
  GET DIAGNOSTICS ctr_thumbnail_ok = ROW_COUNT;
  
  UPDATE persons p SET photo.content = wf.photo, photo.mime_type = lower(right(wf.name,4))::file_extension
    FROM wikimedia_files wf, wikimedia_files_persons wfp
   WHERE wfp.wikimedia_file = wf.wikimedia_file
     AND wfp.person = p.person
     AND p.photo IS NULL 
     AND wf.photo IS NOT NULL;
  GET DIAGNOSTICS ctr_photo_ok = ROW_COUNT;
  RAISE NOTICE 'persons: update thumbnail....: % ', ctr_thumbnail_ok;
  RAISE NOTICE 'persons: update photo........: % ', ctr_photo_ok;
  
  message := 'persons: update thumbnail....: ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'persons: update photo........: ' || ctr_photo_ok::text; RETURN NEXT;
  
END
$$;


ALTER FUNCTION public.wikimedia_4_persons_hydration() OWNER TO postgres;

--
-- Name: wikimedia_5_persons_popolate_files(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION wikimedia_5_persons_popolate_files() RETURNS TABLE(message text)
    LANGUAGE plpgsql
    AS $$
<<me>>
DECLARE
  my_record		record;
  my_command		text;
  error			diagnostic.error;
  my_data_path		text = '/var/lib/scuola247/persons/';
  ctr_photo_ok		int = 0;
  ctr_photo_ko		int = 0;
  ctr_thumbnail_ok	int = 0;
  ctr_thumbnail_ko	int = 0;
     
  context 		text;
  full_function_name	text;
BEGIN 
  --
  -- Retrieve the name of the function
  --
  GET DIAGNOSTICS me.context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context); 
  -- thumbnail
  
   FOR my_record IN SELECT person, thumbnail
                     FROM persons
                    WHERE thumbnail IS NOT NULL
  LOOP
    BEGIN   
      my_command := 'COPY (SELECT encode((thumbnail).content, ''hex'') FROM persons WHERE person = ' || my_record.person::text || ') ' || 
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'thumbnails/' || my_record.person::text || (my_record.thumbnail).mime_type::file_extension::text  || '''';
      EXECUTE my_command;
      ctr_thumbnail_ok := ctr_thumbnail_ok + 1;
      message := 'persons: write thumbnail file.................: '|| my_record.person::text || ' !!! OK !!!'; RETURN NEXT;         
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_thumbnail_ko := ctr_thumbnail_ko + 1;
      RAISE NOTICE 'persons: write thumbnail file.................: % *** KO ***', my_record.person::text;
      message := 'persons: write thumbnail file.................: '|| my_record.person::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
    END;
  END LOOP;
  
-- photo
   FOR my_record IN SELECT person, photo
                     FROM persons
                    WHERE photo IS NOT NULL
  LOOP
    BEGIN
      my_command := 'COPY (SELECT encode((photo).content, ''hex'') FROM persons WHERE person = ' || my_record.person::text || ') ' ||
                    'TO PROGRAM ''xxd -p -r >' || my_data_path || 'photos/' || my_record.person::text || (my_record.photo).mime_type::file_extension::text  || '''';
      EXECUTE my_command;
      ctr_photo_ok := ctr_photo_ok + 1;
      message := 'persons: write photo file.....................: '|| my_record.person::text || ' !!! OK !!!'; RETURN NEXT;
    EXCEPTION WHEN OTHERS THEN
      GET STACKED DIAGNOSTICS error.returned_sqlstate = RETURNED_SQLSTATE, error.message_text = MESSAGE_TEXT, error.schema_name = SCHEMA_NAME, error.table_name = TABLE_NAME, error.column_name = COLUMN_NAME, error.constraint_name = CONSTRAINT_NAME, error.pg_exception_context = PG_EXCEPTION_CONTEXT, error.pg_exception_detail = PG_EXCEPTION_DETAIL, error.pg_exception_hint = PG_EXCEPTION_HINT, error.pg_datatype_name = PG_DATATYPE_NAME;
      ctr_photo_ko := ctr_photo_ko + 1;
      RAISE NOTICE 'persons: write photo file.....................: % *** KO ***', my_record.person::text;
      message := 'persons: write photo file.....................: '|| my_record.person::text || ' *** KO ***'; RETURN NEXT; 
      PERFORM diagnostic.show(error);
    END;
    
  END LOOP;
  
  RAISE NOTICE 'persons: write thumbnail file ... !!! OK !!!! : % ', ctr_thumbnail_ok;
  RAISE NOTICE 'persons: write thumbnail file ... *** KO **** : % ', ctr_thumbnail_ko;
  RAISE NOTICE 'persons: write photo file ....... !!! OK !!!! : % ', ctr_photo_ok;
  RAISE NOTICE 'persons: write photo file ....... *** KO **** : % ', ctr_photo_ko;
  message := 'persons: write thumbnail file ... !!! OK !!!! : % ' || ctr_thumbnail_ok::text; RETURN NEXT; 
  message := 'persons: write thumbnail file ... *** KO **** : % ' || ctr_thumbnail_ko::text; RETURN NEXT; 
  message := 'persons: write photo file ....... !!! OK !!!! : % ' || ctr_photo_ok::text; RETURN NEXT; 
  message := 'persons: write photo file ....... *** KO **** : % ' || ctr_photo_ko::text; RETURN NEXT; 
      
END
$$;


ALTER FUNCTION public.wikimedia_5_persons_popolate_files() OWNER TO postgres;

--
-- Name: topics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE topics (
    topic bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    subject bigint NOT NULL,
    description character varying(160) NOT NULL,
    course_year course_year,
    degree bigint NOT NULL
);


ALTER TABLE topics OWNER TO postgres;

--
-- Name: TABLE topics; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE topics IS 'Contains the object topics of a valutation';


--
-- Name: COLUMN topics.topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN topics.topic IS 'Unique identification code for the row';


--
-- Name: COLUMN topics.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN topics.subject IS 'Subject for the topic';


--
-- Name: COLUMN topics.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN topics.description IS 'The description of the topic';


--
-- Name: COLUMN topics.course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN topics.course_year IS 'The course year with these topics';


--
-- Name: COLUMN topics.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN topics.degree IS 'The degree for the topic';


--
-- Name: absences_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_certified_grp AS
 SELECT cs.classroom,
    a.teacher,
    count(1) AS absences_certified
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, a.teacher;


ALTER TABLE absences_certified_grp OWNER TO postgres;

--
-- Name: VIEW absences_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_certified_grp IS 'groups the absences certified by date, teacher, class';


--
-- Name: COLUMN absences_certified_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_certified_grp.classroom IS 'Classroom for the certified absences';


--
-- Name: COLUMN absences_certified_grp.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_certified_grp.teacher IS 'Teacher that certified the absence';


--
-- Name: COLUMN absences_certified_grp.absences_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_certified_grp.absences_certified IS 'Unique identification code for the row';


--
-- Name: explanations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE explanations (
    explanation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint NOT NULL,
    description character varying(2048) NOT NULL,
    created_on timestamp without time zone NOT NULL,
    created_by bigint NOT NULL,
    registered_on timestamp without time zone,
    registered_by bigint,
    from_time date,
    to_time date,
    coming_at time without time zone,
    leaving_at time without time zone,
    type explanation_type,
    CONSTRAINT explanations_ck_leaving_at CHECK ((leaving_at > coming_at)),
    CONSTRAINT explanations_ck_registered_on CHECK ((registered_on >= created_on)),
    CONSTRAINT explanations_ck_to_time CHECK ((to_time >= from_time))
);


ALTER TABLE explanations OWNER TO postgres;

--
-- Name: TABLE explanations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE explanations IS 'Contains the explanations for absences, delay annd leavings.
It can be done by a schoolteacher that will compile the description or by a parents';


--
-- Name: COLUMN explanations.explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.explanation IS 'Unique identification code for the row';


--
-- Name: COLUMN explanations.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.student IS 'The student with this explanation';


--
-- Name: COLUMN explanations.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.description IS 'Description for the explanation';


--
-- Name: COLUMN explanations.created_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.created_on IS 'Date when the explanation has been created';


--
-- Name: COLUMN explanations.created_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.created_by IS 'The person, school teacher, family or student also, if adult, that has insert the explanation';


--
-- Name: COLUMN explanations.registered_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.registered_on IS 'Date for register when the explanation has been insert';


--
-- Name: COLUMN explanations.registered_by; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.registered_by IS 'Whom have insert the explanation';


--
-- Name: COLUMN explanations.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.from_time IS 'The starting absence time of an explanation';


--
-- Name: COLUMN explanations.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.to_time IS 'The return at school time of an explanation';


--
-- Name: COLUMN explanations.coming_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.coming_at IS 'When the student came at school (delay)';


--
-- Name: COLUMN explanations.leaving_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.leaving_at IS 'When the student had leave the school';


--
-- Name: COLUMN explanations.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN explanations.type IS 'The type for the explanation';


--
-- Name: absences_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_ex AS
 SELECT cs.classroom,
    a.on_date,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM (((((((absences a
     JOIN classrooms_students cs ON ((cs.classroom_student = a.classroom_student)))
     JOIN classrooms c ON ((c.classroom = cs.classroom)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((a.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = a.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE absences_ex OWNER TO postgres;

--
-- Name: VIEW absences_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_ex IS 'Extract every absence for student and other infos';


--
-- Name: COLUMN absences_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.classroom IS 'The classroom with these absences';


--
-- Name: COLUMN absences_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.on_date IS 'Date when the absence was insert';


--
-- Name: COLUMN absences_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.teacher_thumbnail IS 'Thumbnail of the teacher';


--
-- Name: COLUMN absences_ex.teacher_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.teacher_surname IS 'The surname of the teacher';


--
-- Name: COLUMN absences_ex.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.teacher_name IS 'The name of the teacher';


--
-- Name: COLUMN absences_ex.teacher_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.teacher_tax_code IS 'The teacher tax code';


--
-- Name: COLUMN absences_ex.student_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.student_thumbnail IS 'The thumbnail of the student';


--
-- Name: COLUMN absences_ex.student_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.student_surname IS 'Surname of the student';


--
-- Name: COLUMN absences_ex.student_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.student_name IS 'The student name';


--
-- Name: COLUMN absences_ex.student_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.student_tax_code IS 'Tax code for the student';


--
-- Name: COLUMN absences_ex.explanation_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.explanation_description IS 'description for the explanation';


--
-- Name: COLUMN absences_ex.explanation_created_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.explanation_created_on IS 'Date when the explanation was insert';


--
-- Name: COLUMN absences_ex.created_by_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.created_by_surname IS 'The surname of whom created this absence';


--
-- Name: COLUMN absences_ex.created_by_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.created_by_name IS 'The name of whom create with absence';


--
-- Name: COLUMN absences_ex.created_by_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.created_by_thumbnail IS 'The thumbnail of whom created this absence';


--
-- Name: COLUMN absences_ex.explanation_registered_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.explanation_registered_on IS 'Date when the explanation was registered';


--
-- Name: COLUMN absences_ex.registered_on_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.registered_on_surname IS 'Surname of whom create that absence';


--
-- Name: COLUMN absences_ex.registered_on_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.registered_on_name IS 'Name for register absence';


--
-- Name: COLUMN absences_ex.registered_on_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_ex.registered_on_thumbnail IS 'Thumbnail saved when registered';


--
-- Name: absences_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW absences_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, a.on_date) AS month,
            count(1) AS absences
           FROM (absences a
             JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, a.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.absences, (0)::bigint) AS absences
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE absences_month_grp OWNER TO postgres;

--
-- Name: VIEW absences_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW absences_month_grp IS 'Regroup the absences for classroom (also for school year) and month
it''s used a crossjoin to create a list of all classrooms person for every month at zero for join them to persons the absences of the table for having all absences for every month of the year. also those at zero. otherwise, looking only table of absences, there will not';


--
-- Name: COLUMN absences_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_month_grp.classroom IS 'Classroom for the absence in this month';


--
-- Name: COLUMN absences_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_month_grp.month IS 'The month when the student did the absence';


--
-- Name: COLUMN absences_month_grp.absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN absences_month_grp.absences IS 'The absences of the month';


--
-- Name: persons_addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_addresses (
    person_address bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    address_type address_type NOT NULL,
    street character varying(160) NOT NULL,
    zip_code character varying(15) NOT NULL,
    city character(4) NOT NULL
);


ALTER TABLE persons_addresses OWNER TO postgres;

--
-- Name: TABLE persons_addresses; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persons_addresses IS 'Contains the address for every person registered in a school';


--
-- Name: COLUMN persons_addresses.person_address; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.person_address IS 'Unique identification code for the row';


--
-- Name: COLUMN persons_addresses.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.person IS 'Person that have that address';


--
-- Name: COLUMN persons_addresses.address_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.address_type IS 'The address type of the person';


--
-- Name: COLUMN persons_addresses.street; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.street IS 'The street';


--
-- Name: COLUMN persons_addresses.zip_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.zip_code IS 'The zip code';


--
-- Name: COLUMN persons_addresses.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_addresses.city IS 'City of the person';


--
-- Name: classrooms_students_addresses_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_students_addresses_ex AS
 SELECT ca.classroom,
    ca.student,
    p.name,
    p.surname,
    p.tax_code,
    p.sex,
    p.born,
    cn.description AS city_of_birth,
    pi.street,
    pi.zip_code,
    ci.description AS city,
    ci.district AS province,
    COALESCE(agrp.absences, (0)::bigint) AS absences
   FROM (((((classrooms_students ca
     JOIN persons p ON ((p.person = ca.student)))
     JOIN persons_addresses pi ON ((pi.person = p.person)))
     LEFT JOIN cities cn ON ((cn.city = p.city_of_birth)))
     LEFT JOIN cities ci ON ((ci.city = pi.city)))
     LEFT JOIN absences_grp agrp ON ((agrp.student = ca.student)))
  WHERE (p.school = ANY (schools_enabled()));


ALTER TABLE classrooms_students_addresses_ex OWNER TO postgres;

--
-- Name: VIEW classrooms_students_addresses_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_students_addresses_ex IS 'Extract all students addresses';


--
-- Name: COLUMN classrooms_students_addresses_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.classroom IS 'The classroom of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.student IS 'Student with these address';


--
-- Name: COLUMN classrooms_students_addresses_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.name IS 'The name of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.surname IS 'The surname of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.tax_code IS 'The tax code of these students';


--
-- Name: COLUMN classrooms_students_addresses_ex.sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.sex IS 'sex of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.born; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.born IS 'The address where the student born';


--
-- Name: COLUMN classrooms_students_addresses_ex.city_of_birth; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.city_of_birth IS 'city of birth for the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.street; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.street IS 'The street of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.zip_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.zip_code IS 'Zip code of student';


--
-- Name: COLUMN classrooms_students_addresses_ex.city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.city IS 'The city of the student';


--
-- Name: COLUMN classrooms_students_addresses_ex.province; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.province IS 'Province of student';


--
-- Name: COLUMN classrooms_students_addresses_ex.absences; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_students_addresses_ex.absences IS 'The absences of the student';


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lessons (
    lesson bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    on_date date NOT NULL,
    subject bigint NOT NULL,
    teacher bigint NOT NULL,
    description character varying(2048) NOT NULL,
    substitute boolean DEFAULT false NOT NULL,
    from_time time without time zone NOT NULL,
    to_time time without time zone NOT NULL,
    assignment character varying(2048),
    period tsrange,
    CONSTRAINT lessons_ck_to_time CHECK ((to_time > from_time))
);


ALTER TABLE lessons OWNER TO postgres;

--
-- Name: COLUMN lessons.lesson; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.lesson IS 'Unique identification code for the row';


--
-- Name: COLUMN lessons.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.classroom IS 'Classroom that have these lessons';


--
-- Name: COLUMN lessons.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.on_date IS 'Date when the lessons start';


--
-- Name: COLUMN lessons.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.subject IS 'The subject at lesson';


--
-- Name: COLUMN lessons.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.teacher IS 'The teacher for these lessons';


--
-- Name: COLUMN lessons.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.description IS 'The description for the lessons';


--
-- Name: COLUMN lessons.substitute; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.substitute IS 'Indicates if the lesson is a taken by a sobstitute teacher not owning the teacher post';


--
-- Name: COLUMN lessons.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.from_time IS 'Time to begin the lessons';


--
-- Name: COLUMN lessons.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.to_time IS 'Time to end the lessons';


--
-- Name: COLUMN lessons.assignment; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.assignment IS 'assignments gaven during the lesson';


--
-- Name: COLUMN lessons.period; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons.period IS 'Period for the lessons';


--
-- Name: classrooms_teachers; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers AS
 SELECT DISTINCT l.classroom,
    l.teacher
   FROM lessons l
UNION
 SELECT DISTINCT cs.classroom,
    v.teacher
   FROM (valutations v
     JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)));


ALTER TABLE classrooms_teachers OWNER TO postgres;

--
-- Name: VIEW classrooms_teachers; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_teachers IS 'Shows all teachers with their assigned classroom';


--
-- Name: COLUMN classrooms_teachers.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers.classroom IS 'The classroom of the teacher';


--
-- Name: COLUMN classrooms_teachers.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers.teacher IS 'Unique identification code for the row';


--
-- Name: delays_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_certified_grp AS
 SELECT cs.classroom,
    d.teacher,
    count(1) AS delays_certified
   FROM (delays d
     JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, d.teacher;


ALTER TABLE delays_certified_grp OWNER TO postgres;

--
-- Name: VIEW delays_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_certified_grp IS 'Regroup the certified delays for every teacher for all classrooms';


--
-- Name: COLUMN delays_certified_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_certified_grp.classroom IS 'The classroom of these certified delays';


--
-- Name: COLUMN delays_certified_grp.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_certified_grp.teacher IS 'Teacher with these delays certified';


--
-- Name: COLUMN delays_certified_grp.delays_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_certified_grp.delays_certified IS 'Regroup all certified delays';


--
-- Name: leavings_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_certified_grp AS
 SELECT cs.classroom,
    l.teacher,
    count(1) AS leavings_certified
   FROM (leavings l
     JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, l.teacher;


ALTER TABLE leavings_certified_grp OWNER TO postgres;

--
-- Name: VIEW leavings_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_certified_grp IS 'Regrouè the certified leavings for every teacher for all classrooms';


--
-- Name: COLUMN leavings_certified_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_certified_grp.classroom IS 'The classroom of the certified leavings';


--
-- Name: COLUMN leavings_certified_grp.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_certified_grp.teacher IS 'The teacher that certified these leavings';


--
-- Name: COLUMN leavings_certified_grp.leavings_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_certified_grp.leavings_certified IS 'Unique identification code for the row';


--
-- Name: lessons_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_grp AS
 SELECT l.classroom,
    l.teacher,
    count(1) AS lessons
   FROM lessons l
  GROUP BY l.classroom, l.teacher;


ALTER TABLE lessons_grp OWNER TO postgres;

--
-- Name: VIEW lessons_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lessons_grp IS 'Regroup the learned lessons for every teacher for all classrooms';


--
-- Name: COLUMN lessons_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_grp.classroom IS 'The classroom with these lessons';


--
-- Name: COLUMN lessons_grp.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_grp.teacher IS 'Teacher with these lessons';


--
-- Name: COLUMN lessons_grp.lessons; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_grp.lessons IS 'All the lessons';


--
-- Name: notes_iussed_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_iussed_grp AS
 SELECT notes.classroom,
    notes.teacher,
    count(1) AS notes_iussed
   FROM notes
  GROUP BY notes.classroom, notes.teacher;


ALTER TABLE notes_iussed_grp OWNER TO postgres;

--
-- Name: VIEW notes_iussed_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_iussed_grp IS 'Regroup all used notes for every teacher and classroom';


--
-- Name: COLUMN notes_iussed_grp.notes_iussed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_iussed_grp.notes_iussed IS 'Unique identification code for the row';


--
-- Name: out_of_classrooms_certified_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_certified_grp AS
 SELECT cs.classroom,
    ooc.school_operator,
    count(1) AS out_of_classrooms_certified
   FROM (out_of_classrooms ooc
     JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, ooc.school_operator;


ALTER TABLE out_of_classrooms_certified_grp OWNER TO postgres;

--
-- Name: VIEW out_of_classrooms_certified_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_certified_grp IS 'Regroup the certified out of the classrooms for every schoolteacher for all classrooms';


--
-- Name: COLUMN out_of_classrooms_certified_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_certified_grp.classroom IS 'Classroom of whom are certified out of classroom';


--
-- Name: COLUMN out_of_classrooms_certified_grp.school_operator; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_certified_grp.school_operator IS 'Regroup all school teacher with students out of their classroom';


--
-- Name: COLUMN out_of_classrooms_certified_grp.out_of_classrooms_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_certified_grp.out_of_classrooms_certified IS 'Unique identification code for the row';


--
-- Name: signatures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatures (
    signature bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom bigint NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone
);


ALTER TABLE signatures OWNER TO postgres;

--
-- Name: TABLE signatures; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE signatures IS 'Contains info of the signature for every teacher';


--
-- Name: COLUMN signatures.signature; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures.signature IS 'Unique identification code for the row';


--
-- Name: COLUMN signatures.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures.classroom IS 'The classroom of the student';


--
-- Name: COLUMN signatures.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures.teacher IS 'The teacher that did that signature';


--
-- Name: COLUMN signatures.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures.on_date IS 'Date of the signature';


--
-- Name: COLUMN signatures.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures.at_time IS 'When the signature was insert';


--
-- Name: signatures_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW signatures_grp AS
 SELECT f.classroom,
    f.teacher,
    count(1) AS signatures
   FROM signatures f
  GROUP BY f.classroom, f.teacher;


ALTER TABLE signatures_grp OWNER TO postgres;

--
-- Name: VIEW signatures_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW signatures_grp IS 'raggruppa le signatures fatte from_time ogni teachers per ogni classroom';


--
-- Name: COLUMN signatures_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_grp.classroom IS 'The classroom of these signatures';


--
-- Name: COLUMN signatures_grp.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_grp.teacher IS 'The teacher with these signatures';


--
-- Name: COLUMN signatures_grp.signatures; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_grp.signatures IS 'Regroup all signatures';


--
-- Name: classrooms_teachers_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_ex AS
 SELECT cd.classroom,
    cd.teacher,
    p.thumbnail,
    p.tax_code,
    p.surname,
    p.name,
    p.sex,
    p.born,
    co.description AS city_of_birth_description,
    COALESCE(lgrp.lessons, (0)::bigint) AS lessons,
    COALESCE(fgrp.signatures, (0)::bigint) AS signatures,
    COALESCE(acgrp.absences_certified, (0)::bigint) AS absences_certified,
    COALESCE(rcgrp.delays_certified, (0)::bigint) AS delays_certified,
    COALESCE(ucgrp.leavings_certified, (0)::bigint) AS leavings_certified,
    COALESCE(fccgrp.out_of_classrooms_certified, (0)::bigint) AS out_of_classroom_certified,
    COALESCE(negrp.notes_iussed, (0)::bigint) AS notes_iussed
   FROM (((((((((classrooms_teachers cd
     JOIN persons p ON ((p.person = cd.teacher)))
     LEFT JOIN lessons_grp lgrp ON (((lgrp.classroom = cd.classroom) AND (lgrp.teacher = cd.teacher))))
     LEFT JOIN cities co ON ((co.city = p.city_of_birth)))
     LEFT JOIN signatures_grp fgrp ON (((fgrp.classroom = cd.classroom) AND (fgrp.teacher = cd.teacher))))
     LEFT JOIN absences_certified_grp acgrp ON (((acgrp.classroom = cd.classroom) AND (acgrp.teacher = cd.teacher))))
     LEFT JOIN delays_certified_grp rcgrp ON (((rcgrp.classroom = cd.classroom) AND (rcgrp.teacher = cd.teacher))))
     LEFT JOIN leavings_certified_grp ucgrp ON (((ucgrp.classroom = cd.classroom) AND (ucgrp.teacher = cd.teacher))))
     LEFT JOIN out_of_classrooms_certified_grp fccgrp ON (((fccgrp.classroom = cd.classroom) AND (fccgrp.school_operator = cd.teacher))))
     LEFT JOIN notes_iussed_grp negrp ON (((negrp.classroom = cd.classroom) AND (negrp.teacher = cd.teacher))));


ALTER TABLE classrooms_teachers_ex OWNER TO postgres;

--
-- Name: VIEW classrooms_teachers_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_teachers_ex IS 'Exctract all teachers for classroom';


--
-- Name: COLUMN classrooms_teachers_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.classroom IS 'Classroom of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.teacher IS 'The teacher for the classroom';


--
-- Name: COLUMN classrooms_teachers_ex.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.thumbnail IS 'The thumbnail of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.tax_code IS 'The tax code of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.surname IS 'Surname of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.name IS 'Name of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.sex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.sex IS 'The sec of the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.born; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.born IS 'Date of born for the teacher';


--
-- Name: COLUMN classrooms_teachers_ex.city_of_birth_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.city_of_birth_description IS 'The description of the city of birth';


--
-- Name: COLUMN classrooms_teachers_ex.lessons; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.lessons IS 'Lessons for the classroom';


--
-- Name: COLUMN classrooms_teachers_ex.signatures; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.signatures IS 'Signatures for the teachers';


--
-- Name: COLUMN classrooms_teachers_ex.absences_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.absences_certified IS 'Absences certified for the classroom';


--
-- Name: COLUMN classrooms_teachers_ex.delays_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.delays_certified IS 'The delays certified';


--
-- Name: COLUMN classrooms_teachers_ex.leavings_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.leavings_certified IS 'The leavings certified of the classroom';


--
-- Name: COLUMN classrooms_teachers_ex.out_of_classroom_certified; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_ex.out_of_classroom_certified IS 'Check if teacher is out of classroom';


--
-- Name: classrooms_teachers_subject; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classrooms_teachers_subject AS
 SELECT DISTINCT lessons.classroom,
    lessons.teacher,
    lessons.subject
   FROM lessons;


ALTER TABLE classrooms_teachers_subject OWNER TO postgres;

--
-- Name: VIEW classrooms_teachers_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classrooms_teachers_subject IS 'Shows the subject of teacher for every class';


--
-- Name: COLUMN classrooms_teachers_subject.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subject.classroom IS 'The classroom for the classroom';


--
-- Name: COLUMN classrooms_teachers_subject.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subject.teacher IS 'The teacher with this subject';


--
-- Name: COLUMN classrooms_teachers_subject.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classrooms_teachers_subject.subject IS 'Subject for the teacher';


SET default_with_oids = false;

--
-- Name: parents_meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE parents_meetings (
    parents_meeting bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    teacher bigint NOT NULL,
    person bigint,
    on_date timestamp without time zone
);


ALTER TABLE parents_meetings OWNER TO postgres;

--
-- Name: TABLE parents_meetings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE parents_meetings IS 'In this table will be memorized all periods of avaibility for the parents meetings';


--
-- Name: COLUMN parents_meetings.parents_meeting; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.parents_meeting IS 'Unique identification code for the row';


--
-- Name: COLUMN parents_meetings.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.teacher IS 'Teacher that meets the person on this date';


--
-- Name: COLUMN parents_meetings.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.person IS 'Person that meets the teacher on this date';


--
-- Name: COLUMN parents_meetings.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN parents_meetings.on_date IS 'The date that the teacher is avaible for the meet';


--
-- Name: conversations_invites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversations_invites (
    conversation_invite bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversation bigint NOT NULL,
    invited bigint NOT NULL
);


ALTER TABLE conversations_invites OWNER TO postgres;

--
-- Name: TABLE conversations_invites; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE conversations_invites IS 'Defines the guests at the conversation, the persons able to view and participate to a certain conversation.';


--
-- Name: COLUMN conversations_invites.conversation_invite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations_invites.conversation_invite IS 'Unique identification code for the row';


--
-- Name: COLUMN conversations_invites.conversation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations_invites.conversation IS 'The conversation that has these invites';


--
-- Name: COLUMN conversations_invites.invited; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations_invites.invited IS 'Check if is invited';


--
-- Name: signatures_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW signatures_ex AS
 SELECT f.classroom,
    f.on_date,
    f.at_time,
    p.thumbnail,
    p.person AS teacher,
    p.surname,
    p.name,
    p.tax_code
   FROM (signatures f
     JOIN persons p ON ((f.teacher = p.person)));


ALTER TABLE signatures_ex OWNER TO postgres;

--
-- Name: VIEW signatures_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW signatures_ex IS 'Extract all signatures';


--
-- Name: COLUMN signatures_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.classroom IS 'The classroom with these signatures';


--
-- Name: COLUMN signatures_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.on_date IS 'When the signature was insert';


--
-- Name: COLUMN signatures_ex.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.at_time IS 'Date when the signature has been done';


--
-- Name: COLUMN signatures_ex.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.thumbnail IS 'Thumbnail of whom create this signature';


--
-- Name: COLUMN signatures_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.teacher IS 'Teacher that add the signature';


--
-- Name: COLUMN signatures_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.surname IS 'The surname of whom did the signature';


--
-- Name: COLUMN signatures_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.name IS 'Name of this signature';


--
-- Name: COLUMN signatures_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN signatures_ex.tax_code IS 'The tax code';


--
-- Name: out_of_classrooms_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_ex AS
 SELECT cs.classroom,
    ooc.on_date,
    ooc.from_time,
    ooc.to_time,
    ooc.description,
    adsco.thumbnail AS school_operator_thumbnail,
    adsco.surname AS school_operator_surname,
    adsco.name AS school_operator_name,
    adsco.tax_code AS school_operator_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code
   FROM (((out_of_classrooms ooc
     JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons adsco ON ((ooc.school_operator = adsco.person)));


ALTER TABLE out_of_classrooms_ex OWNER TO postgres;

--
-- Name: VIEW out_of_classrooms_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_ex IS 'Extract every out of classroom';


--
-- Name: COLUMN out_of_classrooms_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.classroom IS 'The classroom of the student out of classrooms';


--
-- Name: COLUMN out_of_classrooms_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.on_date IS 'When the class is certified to be out of room';


--
-- Name: COLUMN out_of_classrooms_ex.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.from_time IS 'Date when out of classroom starts';


--
-- Name: COLUMN out_of_classrooms_ex.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.to_time IS 'Date when out of classrooms returns';


--
-- Name: COLUMN out_of_classrooms_ex.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.description IS 'The description for the out of the classroom';


--
-- Name: COLUMN out_of_classrooms_ex.school_operator_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.school_operator_thumbnail IS 'The school operator thumbnail';


--
-- Name: COLUMN out_of_classrooms_ex.school_operator_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.school_operator_surname IS 'The surname of the school operator';


--
-- Name: COLUMN out_of_classrooms_ex.school_operator_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.school_operator_name IS 'The school operator name with these out of classrooms';


--
-- Name: COLUMN out_of_classrooms_ex.school_operator_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.school_operator_tax_code IS 'Tax code of the school operator';


--
-- Name: COLUMN out_of_classrooms_ex.student_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.student_thumbnail IS 'The thumbnail of the student';


--
-- Name: COLUMN out_of_classrooms_ex.student_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.student_surname IS 'The surname of the student';


--
-- Name: COLUMN out_of_classrooms_ex.student_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.student_name IS 'The name of the student out of classroom';


--
-- Name: COLUMN out_of_classrooms_ex.student_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_ex.student_tax_code IS 'Tax code of the student';


--
-- Name: out_of_classrooms_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW out_of_classrooms_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, ooc.on_date) AS month,
            count(1) AS out_of_classrooms
           FROM (out_of_classrooms ooc
             JOIN classrooms_students cs ON ((ooc.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, ooc.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.out_of_classrooms, (0)::bigint) AS out_of_classrooms
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE out_of_classrooms_month_grp OWNER TO postgres;

--
-- Name: VIEW out_of_classrooms_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW out_of_classrooms_month_grp IS 'Regroup the out of classrooms of the month';


--
-- Name: COLUMN out_of_classrooms_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_month_grp.classroom IS 'The classroom of whom out of classroom';


--
-- Name: COLUMN out_of_classrooms_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_month_grp.month IS 'Month of the year';


--
-- Name: COLUMN out_of_classrooms_month_grp.out_of_classrooms; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN out_of_classrooms_month_grp.out_of_classrooms IS 'Out of classroom in this month';


--
-- Name: schools_school_years_classrooms_weekly_timetable; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW schools_school_years_classrooms_weekly_timetable AS
 SELECT i.school,
    i.description AS school_description,
    i.logo,
    a.school_year,
    a.description AS school_year_description,
    c.classroom,
    c.description AS classrom_description,
    o.weekly_timetable,
    o.description AS weekly_timetable_description
   FROM (((schools i
     JOIN school_years a ON ((i.school = a.school)))
     JOIN classrooms c ON ((a.school_year = c.school_year)))
     JOIN weekly_timetables o ON ((c.classroom = o.classroom)))
  WHERE (i.school = ANY (schools_enabled()));


ALTER TABLE schools_school_years_classrooms_weekly_timetable OWNER TO postgres;

--
-- Name: VIEW schools_school_years_classrooms_weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW schools_school_years_classrooms_weekly_timetable IS 'Extract all weekly timetable for every school year';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.school IS 'The school that has this timetable';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.school_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.school_description IS 'The school description';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.logo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.logo IS 'The logo of the school';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.school_year IS 'The school year';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.school_year_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.school_year_description IS 'The school year description';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.classroom IS 'Classroom for the weekly timetable';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.classrom_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.classrom_description IS 'description for the classroom';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.weekly_timetable IS 'The weekly timetable for the school year';


--
-- Name: COLUMN schools_school_years_classrooms_weekly_timetable.weekly_timetable_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN schools_school_years_classrooms_weekly_timetable.weekly_timetable_description IS 'Weekly table used for the classroom in this school year';


--
-- Name: lessons_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_ex AS
 SELECT l.classroom,
    l.on_date,
    l.from_time,
    l.to_time,
    p.surname,
    p.name,
    p.tax_code,
    p.thumbnail,
    l.description AS lesson_description,
    m.description AS subject_description
   FROM ((lessons l
     JOIN persons p ON ((l.teacher = p.person)))
     LEFT JOIN subjects m ON ((l.subject = m.subject)));


ALTER TABLE lessons_ex OWNER TO postgres;

--
-- Name: VIEW lessons_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lessons_ex IS 'Extract all lesson with teacher/date ecc.';


--
-- Name: COLUMN lessons_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.classroom IS 'Classroom that did the lesson';


--
-- Name: COLUMN lessons_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.on_date IS 'When the lessons start';


--
-- Name: COLUMN lessons_ex.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.from_time IS 'When the lessons start';


--
-- Name: COLUMN lessons_ex.to_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.to_time IS 'The date when the lessons end';


--
-- Name: COLUMN lessons_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.surname IS 'Surname for the person with these lessons';


--
-- Name: COLUMN lessons_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.name IS 'Name for the lesson';


--
-- Name: COLUMN lessons_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.tax_code IS 'The tax code of every person at lesson';


--
-- Name: COLUMN lessons_ex.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.thumbnail IS 'Thumbnail for the lesson';


--
-- Name: COLUMN lessons_ex.lesson_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.lesson_description IS 'The description for the lesson';


--
-- Name: COLUMN lessons_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_ex.subject_description IS 'Description for the subject';


--
-- Name: lessons_days; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW lessons_days AS
 SELECT DISTINCT l.classroom,
    l.on_date
   FROM lessons l;


ALTER TABLE lessons_days OWNER TO postgres;

--
-- Name: VIEW lessons_days; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW lessons_days IS 'Shows lesson days';


--
-- Name: COLUMN lessons_days.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_days.classroom IS 'Classroom with these lessons days';


--
-- Name: COLUMN lessons_days.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN lessons_days.on_date IS 'When the lessons start';


SET default_with_oids = true;

--
-- Name: faults; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE faults (
    fault bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint NOT NULL,
    description character varying(2048) NOT NULL,
    lesson bigint NOT NULL,
    note bigint
);


ALTER TABLE faults OWNER TO postgres;

--
-- Name: TABLE faults; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE faults IS 'Reveals the faults of a student';


--
-- Name: COLUMN faults.fault; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults.fault IS 'Unique identification code for the row';


--
-- Name: COLUMN faults.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults.student IS 'The student with these faults';


--
-- Name: COLUMN faults.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults.description IS 'Description for the faults';


--
-- Name: COLUMN faults.lesson; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults.lesson IS 'The lesson with these faults';


--
-- Name: COLUMN faults.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults.note IS 'Note for the fault';


--
-- Name: faults_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW faults_grp AS
 SELECT l.classroom,
    m.student,
    count(1) AS faults
   FROM (faults m
     JOIN lessons l ON ((l.lesson = m.lesson)))
  GROUP BY l.classroom, m.student;


ALTER TABLE faults_grp OWNER TO postgres;

--
-- Name: VIEW faults_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW faults_grp IS 'Regroup the faults for classrooms (also for school year) and student';


--
-- Name: COLUMN faults_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults_grp.classroom IS 'Classroom with these faults';


--
-- Name: COLUMN faults_grp.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults_grp.student IS 'Regroup all faults of a student';


--
-- Name: COLUMN faults_grp.faults; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN faults_grp.faults IS 'Unique identification code for the row';


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE countries (
    country smallint NOT NULL,
    description character varying(160) NOT NULL,
    existing boolean DEFAULT true NOT NULL
);


ALTER TABLE countries OWNER TO postgres;

--
-- Name: TABLE countries; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE countries IS 'Contains all avaible countries';


--
-- Name: COLUMN countries.country; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.country IS 'Unique identification code for the row';


--
-- Name: COLUMN countries.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.description IS 'A description for the countries';


--
-- Name: COLUMN countries.existing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN countries.existing IS 'Checked if the country exist';


--
-- Name: teachears_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE teachears_notes (
    teacher_notes bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    student bigint,
    description character varying(2048) NOT NULL,
    teacher bigint NOT NULL,
    on_date date NOT NULL,
    at_time time without time zone,
    classroom bigint NOT NULL
);


ALTER TABLE teachears_notes OWNER TO postgres;

--
-- Name: TABLE teachears_notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE teachears_notes IS 'It does the same fuunctions of notes table but for teacher register.
The only difference is that isn''t necessary to replicate the coloumn ''disciplinary'' too because the disciplinary notes have to be done only on classroom register unless these notes are mainly for private use of the teacher.';


--
-- Name: COLUMN teachears_notes.teacher_notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.teacher_notes IS 'The teacher notes';


--
-- Name: COLUMN teachears_notes.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.student IS 'The student with this note';


--
-- Name: COLUMN teachears_notes.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.description IS 'Description for the note';


--
-- Name: COLUMN teachears_notes.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.teacher IS 'Teacher that insert the note';


--
-- Name: COLUMN teachears_notes.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.on_date IS 'When the note has been added';


--
-- Name: COLUMN teachears_notes.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.at_time IS 'When the teacher insert the note';


--
-- Name: COLUMN teachears_notes.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachears_notes.classroom IS 'Classroom for the teacher notes';


--
-- Name: notes_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_ex AS
 SELECT n.classroom,
    n.on_date,
    n.at_time,
    n.note,
    n.description,
    n.disciplinary,
    n.to_approve,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code
   FROM ((notes n
     JOIN persons doc ON ((n.teacher = doc.person)))
     LEFT JOIN persons alu ON ((n.student = alu.person)));


ALTER TABLE notes_ex OWNER TO postgres;

--
-- Name: VIEW notes_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_ex IS 'Extract every note';


--
-- Name: COLUMN notes_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.classroom IS 'The classroom with these notes';


--
-- Name: COLUMN notes_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.on_date IS 'When the note was insert';


--
-- Name: COLUMN notes_ex.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.at_time IS 'Date of the note';


--
-- Name: COLUMN notes_ex.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.note IS 'Unique identification code for the row';


--
-- Name: COLUMN notes_ex.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.description IS 'Description for the notes';


--
-- Name: COLUMN notes_ex.disciplinary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.disciplinary IS 'Check if the note is disciplinary';


--
-- Name: COLUMN notes_ex.to_approve; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.to_approve IS 'Check if the note is still to approve';


--
-- Name: COLUMN notes_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.teacher_thumbnail IS 'The teacher thumbnail';


--
-- Name: COLUMN notes_ex.teacher_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.teacher_surname IS 'Surname of the teacher';


--
-- Name: COLUMN notes_ex.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.teacher_name IS 'The teacher name';


--
-- Name: COLUMN notes_ex.teacher_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.teacher_tax_code IS 'Tax code of the teacher';


--
-- Name: COLUMN notes_ex.student_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.student_thumbnail IS 'The thumbnail of the student';


--
-- Name: COLUMN notes_ex.student_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.student_surname IS 'Surname of the student';


--
-- Name: COLUMN notes_ex.student_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.student_name IS 'Student name';


--
-- Name: COLUMN notes_ex.student_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_ex.student_tax_code IS 'The student tax code';


--
-- Name: notes_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_month_grp AS
 WITH cmg AS (
         SELECT notes.classroom,
            date_part('month'::text, notes.on_date) AS month,
            count(1) AS notes
           FROM notes
          GROUP BY notes.classroom, (date_part('month'::text, notes.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.notes, (0)::bigint) AS notes
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE notes_month_grp OWNER TO postgres;

--
-- Name: VIEW notes_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_month_grp IS 'Regroup the notes of the month';


--
-- Name: COLUMN notes_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_month_grp.classroom IS 'Classroom with these notes';


--
-- Name: COLUMN notes_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_month_grp.month IS 'The month with these notes';


--
-- Name: COLUMN notes_month_grp.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_month_grp.notes IS 'Notes of the month';


SET default_with_oids = false;

--
-- Name: notes_signed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notes_signed (
    note_signed bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    on_date timestamp without time zone,
    note bigint NOT NULL
);


ALTER TABLE notes_signed OWNER TO postgres;

--
-- Name: COLUMN notes_signed.note_signed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.note_signed IS 'Unique identification code for the row';


--
-- Name: COLUMN notes_signed.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.person IS 'Persons that have to check the notes';


--
-- Name: COLUMN notes_signed.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.on_date IS 'Date that indicates when the note has been checked';


--
-- Name: COLUMN notes_signed.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed.note IS 'identification column for the table notes';


--
-- Name: notes_signed_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW notes_signed_ex AS
 SELECT n.note,
    v.on_date AS visto_il,
    per.surname AS visto_surname,
    per.name AS visto_name,
    per.thumbnail AS visto_thumbnail,
    per.tax_code AS visto_tax_code
   FROM ((notes n
     LEFT JOIN notes_signed v ON ((v.note = n.note)))
     LEFT JOIN persons per ON ((v.person = per.person)));


ALTER TABLE notes_signed_ex OWNER TO postgres;

--
-- Name: VIEW notes_signed_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW notes_signed_ex IS 'Extract every signed note';


--
-- Name: COLUMN notes_signed_ex.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.note IS 'The note';


--
-- Name: COLUMN notes_signed_ex.visto_il; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.visto_il IS 'Date when the note has been checked';


--
-- Name: COLUMN notes_signed_ex.visto_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.visto_surname IS 'Surname of whom visto the note';


--
-- Name: COLUMN notes_signed_ex.visto_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.visto_name IS 'Name of whom visto the signed note';


--
-- Name: COLUMN notes_signed_ex.visto_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.visto_thumbnail IS 'Thumbnail of whom has visto the signed note';


--
-- Name: COLUMN notes_signed_ex.visto_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notes_signed_ex.visto_tax_code IS 'Tax code of whom visto the signed note';


SET default_with_oids = true;

--
-- Name: persons_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_relations (
    person_relation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    person_related_to bigint NOT NULL,
    sign_request boolean DEFAULT true NOT NULL,
    relationship relationships NOT NULL,
    can_do_explanation boolean DEFAULT false
);


ALTER TABLE persons_relations OWNER TO postgres;

--
-- Name: TABLE persons_relations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persons_relations IS 'Indicates the relations abount persons: tipically student(coloumn person) will have for relationship ''Parent''  the father (person_related_to) for indicates the mother will add a row with same values as said before but looking that this time to insert in coloumn person_related_to the code of person that identifies the mother';


--
-- Name: COLUMN persons_relations.person_relation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.person_relation IS 'The relation of this person with the student';


--
-- Name: COLUMN persons_relations.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.person IS 'Person that has this relation';


--
-- Name: COLUMN persons_relations.person_related_to; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.person_related_to IS 'Indicates the person related to the student';


--
-- Name: COLUMN persons_relations.sign_request; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.sign_request IS 'Indicates that, in case of classroom notes (example: museum visit) or disciplinary notes, the teacher has to check if the parent checked the note';


--
-- Name: COLUMN persons_relations.relationship; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.relationship IS 'The relationship about the parent and the student';


--
-- Name: COLUMN persons_relations.can_do_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_relations.can_do_explanation IS 'Indicates if can do explanations for the student';


SET default_with_oids = false;

--
-- Name: persons_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE persons_roles (
    person_role bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    role role NOT NULL
);


ALTER TABLE persons_roles OWNER TO postgres;

--
-- Name: TABLE persons_roles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE persons_roles IS 'Contains the list of person with their role';


--
-- Name: COLUMN persons_roles.person_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_roles.person_role IS 'Unique identification code for the row';


--
-- Name: COLUMN persons_roles.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_roles.person IS 'The person with these roles';


--
-- Name: COLUMN persons_roles.role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN persons_roles.role IS 'The role of a person';


--
-- Name: qualifications_plan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE qualifications_plan (
    qualificationtion_plan bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    qualification bigint NOT NULL,
    degree bigint,
    course_year course_year,
    subject bigint
);


ALTER TABLE qualifications_plan OWNER TO postgres;

--
-- Name: TABLE qualifications_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifications_plan IS 'Contains the connections about the information plan (degree, course_year e subject) and qualificationtions.
It is necessary in valutation fase for presenting the qualifications to the parents about valutations';


--
-- Name: COLUMN qualifications_plan.qualificationtion_plan; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications_plan.qualificationtion_plan IS 'Unique identification code for the row';


--
-- Name: COLUMN qualifications_plan.qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications_plan.qualification IS 'The qualification';


--
-- Name: COLUMN qualifications_plan.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications_plan.degree IS 'Degree of the qualifications';


--
-- Name: COLUMN qualifications_plan.course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications_plan.course_year IS 'Course year with these qualifications';


--
-- Name: COLUMN qualifications_plan.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications_plan.subject IS 'Subject in the qulification plan';


SET default_with_oids = true;

--
-- Name: qualifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE qualifications (
    qualification bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    name character varying(160) NOT NULL,
    description character varying(4000) NOT NULL,
    metric bigint NOT NULL,
    type qualificationtion_types NOT NULL,
    qualification_parent bigint
);


ALTER TABLE qualifications OWNER TO postgres;

--
-- Name: TABLE qualifications; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE qualifications IS 'Describes for single school the knowledges, competences and skills.
Adding all in only a table it''s duplicated the term qualification to be generic compared to declicountry that can have: Expertise, knowledge, skills';


--
-- Name: COLUMN qualifications.qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.qualification IS 'Unique identification code for the row';


--
-- Name: COLUMN qualifications.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.school IS 'The school for the qualifications';


--
-- Name: COLUMN qualifications.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.name IS 'The name of the qualification';


--
-- Name: COLUMN qualifications.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.description IS 'Description of the qualification';


--
-- Name: COLUMN qualifications.metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.metric IS 'The metric used for the qualifications';


--
-- Name: COLUMN qualifications.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.type IS 'The type for these qualifications';


--
-- Name: COLUMN qualifications.qualification_parent; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN qualifications.qualification_parent IS 'It''s needed for create the qualification tree, in this coloumn will be indicated the family dependency';


--
-- Name: delays_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, d.on_date) AS month,
            count(1) AS delays
           FROM (delays d
             JOIN classrooms_students cs ON ((d.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, d.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.delays, (0)::bigint) AS delays
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE delays_month_grp OWNER TO postgres;

--
-- Name: VIEW delays_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_month_grp IS 'Regroup the delays for classroom (also for school year) and month
it''s used a crossjoin to create a list of all classrooms person for every month at zero for join them to persons the delays of the table for having all delays for every month of the year. also those at zero. otherwise, looking only table of delays, there will not';


--
-- Name: COLUMN delays_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_month_grp.classroom IS 'Classroom with these delays in this month';


--
-- Name: COLUMN delays_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_month_grp.month IS 'Month for the delay';


--
-- Name: COLUMN delays_month_grp.delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_month_grp.delays IS 'The delays of the month';


--
-- Name: leavings_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_month_grp AS
 WITH cmg AS (
         SELECT cs.classroom,
            date_part('month'::text, l.on_date) AS month,
            count(1) AS leavings
           FROM (leavings l
             JOIN classrooms_students cs ON ((l.classroom_student = cs.classroom_student)))
          GROUP BY cs.classroom, (date_part('month'::text, l.on_date))
        )
 SELECT c.classroom,
    month.month,
    COALESCE(cmg.leavings, (0)::bigint) AS leavings
   FROM ((classrooms c
     CROSS JOIN generate_series(1, 12) month(month))
     LEFT JOIN cmg ON (((cmg.classroom = c.classroom) AND ((month.month)::double precision = cmg.month))));


ALTER TABLE leavings_month_grp OWNER TO postgres;

--
-- Name: VIEW leavings_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_month_grp IS 'Regroup the leavings of the month';


--
-- Name: COLUMN leavings_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_month_grp.classroom IS 'The classroom of student who did the leaving';


--
-- Name: COLUMN leavings_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_month_grp.month IS 'Month for the leaving';


--
-- Name: COLUMN leavings_month_grp.leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_month_grp.leavings IS 'The leavings of the month';


--
-- Name: classbooks_month_grp; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW classbooks_month_grp AS
 SELECT 'absences'::text AS evento,
    absences_month_grp.classroom,
    absences_month_grp.month,
    absences_month_grp.absences AS numero
   FROM absences_month_grp
UNION ALL
 SELECT 'delays'::text AS evento,
    delays_month_grp.classroom,
    delays_month_grp.month,
    delays_month_grp.delays AS numero
   FROM delays_month_grp
UNION ALL
 SELECT 'leavings'::text AS evento,
    leavings_month_grp.classroom,
    leavings_month_grp.month,
    leavings_month_grp.leavings AS numero
   FROM leavings_month_grp
UNION ALL
 SELECT 'fuori classrooms'::text AS evento,
    out_of_classrooms_month_grp.classroom,
    out_of_classrooms_month_grp.month,
    out_of_classrooms_month_grp.out_of_classrooms AS numero
   FROM out_of_classrooms_month_grp
UNION ALL
 SELECT 'notes'::text AS evento,
    notes_month_grp.classroom,
    notes_month_grp.month,
    notes_month_grp.notes AS numero
   FROM notes_month_grp;


ALTER TABLE classbooks_month_grp OWNER TO postgres;

--
-- Name: VIEW classbooks_month_grp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW classbooks_month_grp IS 'Regroup the classbooks of the month';


--
-- Name: COLUMN classbooks_month_grp.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classbooks_month_grp.classroom IS 'The cclassroom for that classbook';


--
-- Name: COLUMN classbooks_month_grp.month; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classbooks_month_grp.month IS 'The month';


--
-- Name: COLUMN classbooks_month_grp.numero; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN classbooks_month_grp.numero IS 'Number of the month';


SET default_with_oids = false;

--
-- Name: residence_grp_city; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE residence_grp_city (
    school bigint,
    description character varying(160),
    count bigint
);

ALTER TABLE ONLY residence_grp_city REPLICA IDENTITY NOTHING;


ALTER TABLE residence_grp_city OWNER TO postgres;

--
-- Name: TABLE residence_grp_city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE residence_grp_city IS 'Regroup all cities';


--
-- Name: COLUMN residence_grp_city.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN residence_grp_city.school IS 'School in this city';


--
-- Name: COLUMN residence_grp_city.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN residence_grp_city.description IS 'Description of the residence';


--
-- Name: delays_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW delays_ex AS
 SELECT cs.classroom,
    r.on_date,
    r.at_time,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM ((((((delays r
     JOIN classrooms_students cs ON ((r.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((r.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = r.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE delays_ex OWNER TO postgres;

--
-- Name: VIEW delays_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW delays_ex IS 'Extract every delay';


--
-- Name: COLUMN delays_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.classroom IS 'Classroom for the delays';


--
-- Name: COLUMN delays_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.on_date IS 'When the delays has been done';


--
-- Name: COLUMN delays_ex.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.at_time IS 'Date of the delay, enter in school';


--
-- Name: COLUMN delays_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.teacher_thumbnail IS 'The teacher thumbnail';


--
-- Name: COLUMN delays_ex.teacher_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.teacher_surname IS 'The teacher surname';


--
-- Name: COLUMN delays_ex.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.teacher_name IS 'The name of the teacher';


--
-- Name: COLUMN delays_ex.teacher_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.teacher_tax_code IS 'The teacher tax code';


--
-- Name: COLUMN delays_ex.student_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.student_thumbnail IS 'The thumbnail of a student';


--
-- Name: COLUMN delays_ex.student_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.student_surname IS 'Student surname with these delays';


--
-- Name: COLUMN delays_ex.student_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.student_name IS 'The student name';


--
-- Name: COLUMN delays_ex.student_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.student_tax_code IS 'The student tax code';


--
-- Name: COLUMN delays_ex.explanation_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.explanation_description IS 'The description of these delays';


--
-- Name: COLUMN delays_ex.explanation_created_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.explanation_created_on IS 'When the explanation has been created';


--
-- Name: COLUMN delays_ex.created_by_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.created_by_surname IS 'Surname of who insert that delay';


--
-- Name: COLUMN delays_ex.created_by_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.created_by_name IS 'name of whom create this delay';


--
-- Name: COLUMN delays_ex.created_by_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.created_by_thumbnail IS 'Thumbnail of whom create this delay';


--
-- Name: COLUMN delays_ex.explanation_registered_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.explanation_registered_on IS 'The date when the explanation has been registered';


--
-- Name: COLUMN delays_ex.registered_on_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.registered_on_surname IS 'Surname on register for student with this delay';


--
-- Name: COLUMN delays_ex.registered_on_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.registered_on_name IS 'Name on register for the student with this delay';


--
-- Name: COLUMN delays_ex.registered_on_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN delays_ex.registered_on_thumbnail IS 'Thumbnail on register for the student with this delay';


SET default_with_oids = true;

--
-- Name: grading_meetings_valutations_qua; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings_valutations_qua (
    grading_meeting_valutation_qua bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    grading_meeting_valutation bigint NOT NULL,
    qualification bigint NOT NULL,
    grade bigint NOT NULL,
    notes character varying(2048)
);


ALTER TABLE grading_meetings_valutations_qua OWNER TO postgres;

--
-- Name: TABLE grading_meetings_valutations_qua; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE grading_meetings_valutations_qua IS 'Shows all grading meetings, close or still open';


--
-- Name: COLUMN grading_meetings_valutations_qua.grading_meeting_valutation_qua; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations_qua.grading_meeting_valutation_qua IS 'The valutation from the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations_qua.grading_meeting_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations_qua.grading_meeting_valutation IS 'The grading meeting valutation';


--
-- Name: COLUMN grading_meetings_valutations_qua.qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations_qua.qualification IS 'The qualification for the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations_qua.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations_qua.grade IS 'The final grade from the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations_qua.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations_qua.notes IS 'The notes at the grading meetings';


--
-- Name: communication_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE communication_types (
    communication_type bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(160) NOT NULL,
    notification_management boolean DEFAULT false NOT NULL,
    school bigint
);


ALTER TABLE communication_types OWNER TO postgres;

--
-- Name: TABLE communication_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE communication_types IS 'It refers to the kind of communication handled from the school and any notifies management that will be distincted by school, because it could have addictive costs that not every school wants.';


--
-- Name: COLUMN communication_types.communication_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communication_types.communication_type IS 'Unique identification code for the row';


--
-- Name: COLUMN communication_types.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communication_types.description IS 'All types of communication avaible';


--
-- Name: COLUMN communication_types.notification_management; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communication_types.notification_management IS 'It''s indicates if this kind of communication manage the notifications';


--
-- Name: COLUMN communication_types.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communication_types.school IS 'School with these communication type';


--
-- Name: grade_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grade_types (
    grade_type bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    description character varying(60) NOT NULL,
    subject bigint NOT NULL,
    mnemonic character varying(3)
);


ALTER TABLE grade_types OWNER TO postgres;

--
-- Name: TABLE grade_types; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE grade_types IS 'The marks has to been grouped by mark type.
Example: `Oral` or `Written` ';


--
-- Name: COLUMN grade_types.grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grade_types.grade_type IS 'Unique identification code for the row';


--
-- Name: COLUMN grade_types.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grade_types.description IS 'The description';


--
-- Name: COLUMN grade_types.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grade_types.subject IS 'The subject with these grade types';


--
-- Name: COLUMN grade_types.mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grade_types.mnemonic IS 'The mnemonic of the grade type';


--
-- Name: leavings_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW leavings_ex AS
 SELECT cs.classroom,
    u.on_date,
    u.at_time,
    doc.thumbnail AS teacher_thumbnail,
    doc.surname AS teacher_surname,
    doc.name AS teacher_name,
    doc.tax_code AS teacher_tax_code,
    alu.thumbnail AS student_thumbnail,
    alu.surname AS student_surname,
    alu.name AS student_name,
    alu.tax_code AS student_tax_code,
    g.description AS explanation_description,
    g.created_on AS explanation_created_on,
    pcre.surname AS created_by_surname,
    pcre.name AS created_by_name,
    pcre.thumbnail AS created_by_thumbnail,
    g.registered_on AS explanation_registered_on,
    preg.surname AS registered_on_surname,
    preg.name AS registered_on_name,
    preg.thumbnail AS registered_on_thumbnail
   FROM ((((((leavings u
     JOIN classrooms_students cs ON ((u.classroom_student = cs.classroom_student)))
     JOIN persons alu ON ((cs.student = alu.person)))
     JOIN persons doc ON ((u.teacher = doc.person)))
     LEFT JOIN explanations g ON ((g.explanation = u.explanation)))
     LEFT JOIN persons pcre ON ((pcre.person = g.created_by)))
     LEFT JOIN persons preg ON ((preg.person = g.registered_by)));


ALTER TABLE leavings_ex OWNER TO postgres;

--
-- Name: VIEW leavings_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW leavings_ex IS 'Extract every leaving';


--
-- Name: COLUMN leavings_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.classroom IS 'The classroom for the leavings';


--
-- Name: COLUMN leavings_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.on_date IS 'Date of the leaving';


--
-- Name: COLUMN leavings_ex.at_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.at_time IS 'Date when student leaves';


--
-- Name: COLUMN leavings_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.teacher_thumbnail IS 'The teacher thumbnail';


--
-- Name: COLUMN leavings_ex.teacher_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.teacher_surname IS 'The surname of the teacher';


--
-- Name: COLUMN leavings_ex.teacher_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.teacher_name IS 'Teacher name for the signature';


--
-- Name: COLUMN leavings_ex.teacher_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.teacher_tax_code IS 'The tax code of the teacher';


--
-- Name: COLUMN leavings_ex.student_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.student_thumbnail IS 'Tumbnail for the student';


--
-- Name: COLUMN leavings_ex.student_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.student_surname IS 'The surname of the student';


--
-- Name: COLUMN leavings_ex.student_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.student_name IS 'Name of the student with this leaving';


--
-- Name: COLUMN leavings_ex.student_tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.student_tax_code IS 'Tax code of the student with this leaving';


--
-- Name: COLUMN leavings_ex.explanation_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.explanation_description IS 'Description of the explanation';


--
-- Name: COLUMN leavings_ex.explanation_created_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.explanation_created_on IS 'The date when the explanation has been created';


--
-- Name: COLUMN leavings_ex.created_by_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.created_by_surname IS 'The surname of whom created this leaving';


--
-- Name: COLUMN leavings_ex.created_by_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.created_by_name IS 'The name of whom create this leaving';


--
-- Name: COLUMN leavings_ex.created_by_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.created_by_thumbnail IS 'thumbnail of person of the leaving';


--
-- Name: COLUMN leavings_ex.explanation_registered_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.explanation_registered_on IS 'Date when the explanation has been registered';


--
-- Name: COLUMN leavings_ex.registered_on_surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.registered_on_surname IS 'Surname on register of the student with this leaving';


--
-- Name: COLUMN leavings_ex.registered_on_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.registered_on_name IS 'The name of whom registered that leaving';


--
-- Name: COLUMN leavings_ex.registered_on_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN leavings_ex.registered_on_thumbnail IS 'Thumbnail on register for the student with this leaving';


SET default_with_oids = false;

--
-- Name: usenames_ex; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usenames_ex (
    usename name NOT NULL,
    token character varying(1024),
    language utility.language
);


ALTER TABLE usenames_ex OWNER TO postgres;

--
-- Name: TABLE usenames_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE usenames_ex IS 'Add informations to usename''s system table usefull only to scuola247';


--
-- Name: COLUMN usenames_ex.usename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_ex.usename IS 'The usename for the person';


--
-- Name: COLUMN usenames_ex.token; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_ex.token IS 'Used for the password reset';


--
-- Name: COLUMN usenames_ex.language; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_ex.language IS 'Preferred language for the user';


--
-- Name: usenames_schools; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usenames_schools (
    usename_school bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    usename name NOT NULL,
    school bigint NOT NULL
);


ALTER TABLE usenames_schools OWNER TO postgres;

--
-- Name: TABLE usenames_schools; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE usenames_schools IS 'record schools accessible to the user';


--
-- Name: COLUMN usenames_schools.usename_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_schools.usename_school IS 'Unique identification code for the row';


--
-- Name: COLUMN usenames_schools.usename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_schools.usename IS 'The session''s usename';


--
-- Name: COLUMN usenames_schools.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_schools.school IS 'School enabled for the the usename';


SET default_with_oids = true;

--
-- Name: holidays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE holidays (
    holiday bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    on_date date NOT NULL,
    description character varying(160)
);


ALTER TABLE holidays OWNER TO postgres;

--
-- Name: TABLE holidays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE holidays IS 'Contains all holidays for every school';


--
-- Name: COLUMN holidays.holiday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN holidays.holiday IS 'Unique identification code for the row';


--
-- Name: COLUMN holidays.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN holidays.school IS 'School with these holidays';


--
-- Name: COLUMN holidays.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN holidays.on_date IS 'Start for holidays';


--
-- Name: COLUMN holidays.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN holidays.description IS 'Description for the holidays';


--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grades (
    grade bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    metric bigint NOT NULL,
    description character varying(160) NOT NULL,
    thousandths smallint NOT NULL,
    mnemonic character varying(3) NOT NULL
);


ALTER TABLE grades OWNER TO postgres;

--
-- Name: TABLE grades; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE grades IS 'For each metric here we have the possible grades';


--
-- Name: COLUMN grades.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grades.grade IS 'Unique identification code for the row';


--
-- Name: COLUMN grades.metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grades.metric IS 'Metric for the grades';


--
-- Name: COLUMN grades.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grades.description IS 'The description for the grade';


--
-- Name: COLUMN grades.thousandths; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grades.thousandths IS 'Indicates the weight in thousandths for that grade. Its value allows to compare different metrics';


--
-- Name: COLUMN grades.mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grades.mnemonic IS 'A mnemonic for the grade';


--
-- Name: metrics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metrics (
    metric bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL,
    sufficiency smallint DEFAULT 600 NOT NULL
);


ALTER TABLE metrics OWNER TO postgres;

--
-- Name: COLUMN metrics.metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metrics.metric IS 'Unique identification code for the row';


--
-- Name: COLUMN metrics.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metrics.school IS 'School with these metrics';


--
-- Name: COLUMN metrics.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metrics.description IS 'The description for the metrics';


--
-- Name: COLUMN metrics.sufficiency; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metrics.sufficiency IS 'Indicates the value to reach the sufficiency';


--
-- Name: valutations_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_ex AS
 SELECT ((v.xmin)::text)::bigint AS rv,
    cs.classroom,
    v.teacher,
    v.subject,
    v.valutation,
    cs.student,
    alu.surname,
    alu.name,
    v.on_date,
    v.grade_type,
    tv.description AS grade_type_description,
    v.topic,
    a.description AS topic_description,
    m.metric,
    m.description AS metric_description,
    v.grade,
    vo.description AS grade_description,
    v.evaluation,
    v.private AS privato
   FROM ((((((valutations v
     JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))
     JOIN persons alu ON ((alu.person = cs.student)))
     JOIN grade_types tv ON ((tv.grade_type = v.grade_type)))
     JOIN topics a ON ((a.topic = v.topic)))
     JOIN grades vo ON ((vo.grade = v.grade)))
     JOIN metrics m ON ((m.metric = vo.metric)));


ALTER TABLE valutations_ex OWNER TO postgres;

--
-- Name: VIEW valutations_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_ex IS 'Extract every valutation';


--
-- Name: COLUMN valutations_ex.rv; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.rv IS 'All the valutations with extra infos';


--
-- Name: COLUMN valutations_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.classroom IS 'The classroom with these valutations';


--
-- Name: COLUMN valutations_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.teacher IS 'The teacher taht gave that valutation';


--
-- Name: COLUMN valutations_ex.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.subject IS 'Subject for the valutations';


--
-- Name: COLUMN valutations_ex.valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.valutation IS 'Unique identification code for the row';


--
-- Name: COLUMN valutations_ex.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.student IS 'Student with the valutation';


--
-- Name: COLUMN valutations_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.surname IS 'Surname of the student';


--
-- Name: COLUMN valutations_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.name IS 'The name of the student with this valutation';


--
-- Name: COLUMN valutations_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.on_date IS 'Date when the valutations has been insert';


--
-- Name: COLUMN valutations_ex.grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.grade_type IS 'The grade type for the valutations';


--
-- Name: COLUMN valutations_ex.grade_type_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.grade_type_description IS 'The description for the grade type';


--
-- Name: COLUMN valutations_ex.topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.topic IS 'The topic for the valutations';


--
-- Name: COLUMN valutations_ex.topic_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.topic_description IS 'Description of the topic';


--
-- Name: COLUMN valutations_ex.metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.metric IS 'Metric for the valutations';


--
-- Name: COLUMN valutations_ex.metric_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.metric_description IS 'Description of the metric';


--
-- Name: COLUMN valutations_ex.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.grade IS 'Grade for the valutations';


--
-- Name: COLUMN valutations_ex.grade_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.grade_description IS 'The grade description with these valutations';


--
-- Name: COLUMN valutations_ex.evaluation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.evaluation IS 'The evaluation';


--
-- Name: COLUMN valutations_ex.privato; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex.privato IS 'Check if the valutation is private for the teacher';


--
-- Name: valutations_references; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_references AS
 SELECT t.classroom,
    t.teacher,
    t.subject,
    t.on_date,
    t.grade_type,
    t.grade_type_description,
    t.grade_type_mnemonic,
    t.topic,
    t.topic_description,
    t.metric,
    t.metric_description,
    row_number() OVER (PARTITION BY t.classroom, t.teacher, t.subject, t.on_date ORDER BY t.grade_type_description, t.topic_description, t.metric_description) AS row_number
   FROM ( SELECT DISTINCT cs.classroom,
            va.teacher,
            va.subject,
            va.on_date,
            va.grade_type,
            tv.description AS grade_type_description,
            tv.mnemonic AS grade_type_mnemonic,
            va.topic,
            COALESCE(a.description, ''::character varying) AS topic_description,
            m.metric,
            m.description AS metric_description
           FROM (((((valutations va
             JOIN classrooms_students cs ON ((cs.classroom_student = va.classroom_student)))
             LEFT JOIN topics a ON ((a.topic = va.topic)))
             JOIN grade_types tv ON ((tv.grade_type = va.grade_type)))
             JOIN grades vo ON ((vo.grade = va.grade)))
             JOIN metrics m ON ((m.metric = vo.metric)))
          ORDER BY va.on_date, tv.description, COALESCE(a.description, ''::character varying), m.description) t;


ALTER TABLE valutations_references OWNER TO postgres;

--
-- Name: COLUMN valutations_references.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.classroom IS 'The classroom with these valutations';


--
-- Name: COLUMN valutations_references.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.teacher IS 'teacher that isnert these valutations';


--
-- Name: COLUMN valutations_references.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.subject IS 'The subject with these references';


--
-- Name: COLUMN valutations_references.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.on_date IS 'When the reference has been registered';


--
-- Name: COLUMN valutations_references.grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.grade_type IS 'The type of grade used in this valutation';


--
-- Name: COLUMN valutations_references.grade_type_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.grade_type_description IS 'The description for the grade type';


--
-- Name: COLUMN valutations_references.grade_type_mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.grade_type_mnemonic IS 'The grade type mnemonic for these valutations';


--
-- Name: COLUMN valutations_references.topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.topic IS 'Topic for the valutations reference';


--
-- Name: COLUMN valutations_references.topic_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.topic_description IS 'The description of the topic';


--
-- Name: COLUMN valutations_references.metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.metric IS 'The metric';


--
-- Name: COLUMN valutations_references.metric_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.metric_description IS 'Description for the metric';


--
-- Name: COLUMN valutations_references.row_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_references.row_number IS 'The row number';


--
-- Name: valutations_ex_references; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_ex_references AS
 SELECT cs.classroom,
    va.teacher,
    va.subject,
    alu.surname,
    alu.name,
    alu.tax_code,
    va.on_date,
    vr.row_number,
    (((to_char((va.on_date)::timestamp with time zone, 'YYYY-MM-DD'::text) || ' ['::text) || "right"(('000'::text || vr.row_number), 3)) || ']'::text) AS riferimento,
    vo.mnemonic
   FROM (((((valutations va
     JOIN classrooms_students cs ON ((cs.classroom_student = va.classroom_student)))
     JOIN persons alu ON ((alu.person = cs.student)))
     JOIN grades vo ON ((vo.grade = va.grade)))
     JOIN metrics m ON ((m.metric = vo.metric)))
     JOIN valutations_references vr ON (((vr.classroom = cs.classroom) AND (vr.teacher = va.teacher) AND (vr.subject = va.subject) AND (vr.on_date = va.on_date) AND (vr.grade_type = va.grade_type) AND (COALESCE(vr.topic, (0)::bigint) = COALESCE(va.topic, (0)::bigint)) AND (vr.metric = m.metric))));


ALTER TABLE valutations_ex_references OWNER TO postgres;

--
-- Name: VIEW valutations_ex_references; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_ex_references IS 'Extract every reference for valutation';


--
-- Name: COLUMN valutations_ex_references.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.classroom IS 'Classroom with these valutations references';


--
-- Name: COLUMN valutations_ex_references.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.teacher IS 'The teacher that insert the valutation';


--
-- Name: COLUMN valutations_ex_references.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.subject IS 'Subject in the reference for the valutation';


--
-- Name: COLUMN valutations_ex_references.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.surname IS 'Surname of the reference for valutations';


--
-- Name: COLUMN valutations_ex_references.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.name IS 'Name for the valutations';


--
-- Name: COLUMN valutations_ex_references.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.tax_code IS 'The tax code';


--
-- Name: COLUMN valutations_ex_references.row_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.row_number IS 'The row number';


--
-- Name: COLUMN valutations_ex_references.riferimento; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.riferimento IS 'Unique identification code for the row';


--
-- Name: COLUMN valutations_ex_references.mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_ex_references.mnemonic IS 'The mnemonic for the reference of the valutations';


--
-- Name: valutations_qualifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE valutations_qualifications (
    valutation_qualificationtion bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    valutation bigint NOT NULL,
    qualification bigint NOT NULL,
    grade bigint NOT NULL,
    note character varying(2048)
);


ALTER TABLE valutations_qualifications OWNER TO postgres;

--
-- Name: TABLE valutations_qualifications; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE valutations_qualifications IS 'For every valution inserted in valutations table is possible to connect valutation too of qualifications connected that are saved here';


--
-- Name: COLUMN valutations_qualifications.valutation_qualificationtion; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_qualifications.valutation_qualificationtion IS 'Unique identification code for the row';


--
-- Name: COLUMN valutations_qualifications.valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_qualifications.valutation IS 'The valutation of a qualification';


--
-- Name: COLUMN valutations_qualifications.qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_qualifications.qualification IS 'Unique identification code for the row';


--
-- Name: COLUMN valutations_qualifications.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_qualifications.grade IS 'Grade of the qualification';


--
-- Name: COLUMN valutations_qualifications.note; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_qualifications.note IS 'The note for the qualification';


--
-- Name: valutations_stats_classrooms_students_subjects; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects AS
 SELECT cs.classroom,
    cs.student,
    va.subject,
    min(vo.thousandths) AS min,
    max(vo.thousandths) AS max,
    round(avg(vo.thousandths)) AS media,
    round(stddev_pop(vo.thousandths)) AS dev_std
   FROM ((valutations va
     JOIN classrooms_students cs ON ((cs.classroom_student = va.classroom_student)))
     JOIN grades vo ON ((vo.grade = va.grade)))
  GROUP BY cs.classroom, cs.student, va.subject;


ALTER TABLE valutations_stats_classrooms_students_subjects OWNER TO postgres;

--
-- Name: VIEW valutations_stats_classrooms_students_subjects; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_stats_classrooms_students_subjects IS 'statistics for classroom / student / subject';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.classroom IS 'Classroom for these valutations';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.student IS 'The student with these valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.subject IS 'Subject for the valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.min; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.min IS 'Minimum grade for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.max; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.max IS 'Maximum in the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects.media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects.media IS 'The valutations media';


--
-- Name: valutations_stats_classrooms_subjects; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_subjects AS
 SELECT cs.classroom,
    va.subject,
    min(vo.thousandths) AS min,
    max(vo.thousandths) AS max,
    round(avg(vo.thousandths)) AS media,
    round(stddev_pop(vo.thousandths)) AS dev_std
   FROM ((valutations va
     JOIN classrooms_students cs ON ((cs.classroom_student = va.classroom_student)))
     JOIN grades vo ON ((vo.grade = va.grade)))
  GROUP BY cs.classroom, va.subject;


ALTER TABLE valutations_stats_classrooms_subjects OWNER TO postgres;

--
-- Name: COLUMN valutations_stats_classrooms_subjects.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects.classroom IS 'Classroom with this valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects.subject IS 'Indicates the subject for the valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects.min; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects.min IS 'Minimum for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects.media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects.media IS 'Media for the valutations stats';


--
-- Name: valutations_stats_classrooms_subjects_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_subjects_ex AS
 SELECT v.classroom,
    v.subject,
    c.school_year,
    c.degree,
    c.section,
    c.course_year,
    c.description,
    c.branch AS building,
    p.description AS building_description,
    v.min,
    v.max,
    v.media,
    v.dev_std
   FROM ((valutations_stats_classrooms_subjects v
     JOIN classrooms c ON ((v.classroom = c.classroom)))
     JOIN branches p ON ((p.branch = c.branch)));


ALTER TABLE valutations_stats_classrooms_subjects_ex OWNER TO postgres;

--
-- Name: VIEW valutations_stats_classrooms_subjects_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW valutations_stats_classrooms_subjects_ex IS 'statistics for classroom';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.classroom IS 'Classroom for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.subject IS 'The subject stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.school_year IS 'School year with these valutations';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.degree IS 'Degree for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.section; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.section IS 'Section of student with these valutations';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.course_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.course_year IS 'The course year for these valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.description IS 'Description of the valutation stats for the subjects';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.building_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.building_description IS 'The description of the building';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.min; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.min IS 'Minimum for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.max; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.max IS 'Indicates the statistics of the subjects for a classroom';


--
-- Name: COLUMN valutations_stats_classrooms_subjects_ex.media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_subjects_ex.media IS 'The valutations media';


SET default_with_oids = false;

--
-- Name: wikimedia_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wikimedia_files (
    name text NOT NULL,
    type wikimedia_type NOT NULL,
    wikimedia_file bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    info xml,
    photo bytea,
    thumbnail bytea
);


ALTER TABLE wikimedia_files OWNER TO postgres;

--
-- Name: TABLE wikimedia_files; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE wikimedia_files IS 'files from wikimedia commons';


--
-- Name: COLUMN wikimedia_files.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.name IS 'The name of wikimedia file';


--
-- Name: COLUMN wikimedia_files.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.type IS 'The type of the file';


--
-- Name: COLUMN wikimedia_files.wikimedia_file; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.wikimedia_file IS 'Unique identification code for the row';


--
-- Name: COLUMN wikimedia_files.info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.info IS 'Contains all the meta data in xml format like the api of wikimedia';


--
-- Name: COLUMN wikimedia_files.photo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.photo IS 'Photo from wikimedia';


--
-- Name: COLUMN wikimedia_files.thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files.thumbnail IS 'The thumbnail from wikimedia';


--
-- Name: wikimedia_files_persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE wikimedia_files_persons (
    wikimedia_file_person bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    wikimedia_file bigint NOT NULL,
    person bigint NOT NULL
);


ALTER TABLE wikimedia_files_persons OWNER TO postgres;

--
-- Name: TABLE wikimedia_files_persons; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE wikimedia_files_persons IS 'files from wikimedia commons for person';


--
-- Name: COLUMN wikimedia_files_persons.wikimedia_file_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files_persons.wikimedia_file_person IS 'The file of the person';


--
-- Name: COLUMN wikimedia_files_persons.wikimedia_file; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files_persons.wikimedia_file IS 'File from wikimedia';


--
-- Name: COLUMN wikimedia_files_persons.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_files_persons.person IS 'The person of the wikimedia file';


--
-- Name: wikimedia_license_infos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW wikimedia_license_infos AS
 SELECT wikimedia_files.name,
    array_length((xpath('/response/licenses/license/name/text()'::text, wikimedia_files.info))::text[], 1) AS license_number,
    (xpath('/response/licenses/license/name/text()'::text, wikimedia_files.info))::text[] AS license,
    utility.strip_tags(datasets.entity2char(((xpath('/response/file/author/text()'::text, wikimedia_files.info))[1])::text)) AS author,
    utility.strip_tags(datasets.entity2char(((xpath('/response/file/source/text()'::text, wikimedia_files.info))[1])::text)) AS source,
    utility.strip_tags(datasets.entity2char(((xpath('/response/file/permission/text()'::text, wikimedia_files.info))[1])::text)) AS permission
   FROM wikimedia_files;


ALTER TABLE wikimedia_license_infos OWNER TO postgres;

--
-- Name: VIEW wikimedia_license_infos; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW wikimedia_license_infos IS 'Exctract information from coloumn in wikimedia table the data relative to file-using-license';


--
-- Name: COLUMN wikimedia_license_infos.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.name IS 'The license name from wikimedia';


--
-- Name: COLUMN wikimedia_license_infos.license_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.license_number IS 'License number from wikimedia';


--
-- Name: COLUMN wikimedia_license_infos.license; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.license IS 'The license from wikimedia';


--
-- Name: COLUMN wikimedia_license_infos.author; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.author IS 'The author from wikimedia';


--
-- Name: COLUMN wikimedia_license_infos.source; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.source IS 'The source for the wikimedia files';


--
-- Name: COLUMN wikimedia_license_infos.permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN wikimedia_license_infos.permission IS 'Permission about license from wikimedia';


--
-- Name: absences_certified_grp_mat; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW absences_certified_grp_mat AS
 SELECT cs.classroom,
    a.teacher,
    count(1) AS absences_certified
   FROM (absences a
     JOIN classrooms_students cs ON ((a.classroom_student = cs.classroom_student)))
  GROUP BY cs.classroom, a.teacher
  WITH NO DATA;


ALTER TABLE absences_certified_grp_mat OWNER TO postgres;

SET default_with_oids = true;

--
-- Name: communications_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE communications_media (
    communication_media bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    person bigint NOT NULL,
    communication_type bigint NOT NULL,
    description character varying(160),
    uri character varying(255) NOT NULL,
    notification boolean DEFAULT false NOT NULL
);


ALTER TABLE communications_media OWNER TO postgres;

--
-- Name: COLUMN communications_media.communication_media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.communication_media IS 'Unique identification code for the row';


--
-- Name: COLUMN communications_media.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.person IS 'Person for the communication media';


--
-- Name: COLUMN communications_media.communication_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.communication_type IS 'Communication type for the communications';


--
-- Name: COLUMN communications_media.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.description IS 'The description for the communication media';


--
-- Name: COLUMN communications_media.uri; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.uri IS 'The uri for the media';


--
-- Name: COLUMN communications_media.notification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN communications_media.notification IS 'It states whether to use the notifications, only if the communication allows it.';


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conversations (
    conversation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    classroom_student bigint NOT NULL,
    subject character varying(160) NOT NULL,
    confidential boolean DEFAULT false NOT NULL,
    begin_on timestamp without time zone DEFAULT now(),
    end_on timestamp without time zone,
    CONSTRAINT conversations_ck_end_on CHECK ((end_on >= begin_on))
);


ALTER TABLE conversations OWNER TO postgres;

--
-- Name: COLUMN conversations.conversation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.conversation IS 'Unique identification code for the row';


--
-- Name: COLUMN conversations.classroom_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.classroom_student IS 'Reference to the classroom_students table.';


--
-- Name: COLUMN conversations.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.subject IS 'subject for the conversation';


--
-- Name: COLUMN conversations.confidential; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.confidential IS 'States that the conversation has to be viewed by the participants and from the school insiders. Furthermore it''s not included in the personal school_record.';


--
-- Name: COLUMN conversations.begin_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.begin_on IS 'When the conversation start';


--
-- Name: COLUMN conversations.end_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN conversations.end_on IS 'When a conversation ends, it''s not longer possible to add or edit messages.';


--
-- Name: degrees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE degrees (
    degree bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school bigint NOT NULL,
    description character varying(160) NOT NULL,
    course_years course_year NOT NULL
);


ALTER TABLE degrees OWNER TO postgres;

--
-- Name: COLUMN degrees.degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN degrees.degree IS 'Unique identification code for the row';


--
-- Name: COLUMN degrees.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN degrees.school IS 'The school with these degrees';


--
-- Name: COLUMN degrees.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN degrees.description IS 'The description of the degree';


--
-- Name: COLUMN degrees.course_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN degrees.course_years IS 'Years of the course, e.g 5 for the elementary schools, 3 for the middle schools, 5 for the high schools';


SET default_with_oids = false;

--
-- Name: grading_meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings (
    grading_meeting bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    school_year bigint,
    on_date date,
    description character varying(60) NOT NULL,
    closed boolean DEFAULT false NOT NULL
);


ALTER TABLE grading_meetings OWNER TO postgres;

--
-- Name: COLUMN grading_meetings.grading_meeting; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.grading_meeting IS 'Unique identification code for the row';


--
-- Name: COLUMN grading_meetings.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.school_year IS 'The school year for the grading meeting';


--
-- Name: COLUMN grading_meetings.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.on_date IS 'Date of the grading meeting';


--
-- Name: COLUMN grading_meetings.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.description IS 'The description for the grading meeting';


--
-- Name: COLUMN grading_meetings.closed; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings.closed IS 'Indicates if the grading meeting is closed and the changes are locked';


--
-- Name: grading_meetings_valutations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE grading_meetings_valutations (
    grading_meeting_valutation bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    grading_meeting bigint NOT NULL,
    classroom bigint NOT NULL,
    student bigint NOT NULL,
    subject bigint NOT NULL,
    grade bigint NOT NULL,
    notes character varying(2048),
    lack_of_training boolean DEFAULT false NOT NULL,
    council_vote boolean DEFAULT false,
    teacher bigint,
    CONSTRAINT grading_meetings_valutations_ck_grade_consiglio CHECK ((((teacher IS NOT NULL) AND (council_vote IS NULL)) OR ((teacher IS NULL) AND (council_vote IS NOT NULL))))
);


ALTER TABLE grading_meetings_valutations OWNER TO postgres;

--
-- Name: COLUMN grading_meetings_valutations.grading_meeting_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.grading_meeting_valutation IS 'The valutation from the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations.grading_meeting; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.grading_meeting IS 'Unique identification code for the row';


--
-- Name: COLUMN grading_meetings_valutations.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.classroom IS 'The classroom of these valutations from grading meeting';


--
-- Name: COLUMN grading_meetings_valutations.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.student IS 'Indicates all the valutations of the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.subject IS 'The subject of the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations.grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.grade IS 'If the teacher is '' this indicates the grade of the grading meeting otherwise the grade of the teacher';


--
-- Name: COLUMN grading_meetings_valutations.notes; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.notes IS 'The notes in the valutations from the grading meeting';


--
-- Name: COLUMN grading_meetings_valutations.lack_of_training; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.lack_of_training IS 'Indicates if the student shows formative lacks';


--
-- Name: COLUMN grading_meetings_valutations.council_vote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.council_vote IS 'Indicates if the grade was chose by the grading metting or it''s from the teacher if showed(so the row in the db shows the proposal grade and it can''t be '')';


--
-- Name: COLUMN grading_meetings_valutations.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN grading_meetings_valutations.teacher IS 'If '' indicates the grade of the grading meeting othwerwise it shows the grade of the teacher';


--
-- Name: CONSTRAINT grading_meetings_valutations_ck_grade_consiglio ON grading_meetings_valutations; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT grading_meetings_valutations_ck_grade_consiglio ON grading_meetings_valutations IS 'Se è indicato il teacher (proposta di grade) allat_time il flag ''council_vote'' non deve essere indicato perchè è valido solo per il grade di grading_meeting e viceversa';


SET default_with_oids = true;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages (
    message bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    conversation bigint NOT NULL,
    written_on timestamp without time zone DEFAULT now() NOT NULL,
    message_text character varying(2048) NOT NULL,
    person bigint NOT NULL
);


ALTER TABLE messages OWNER TO postgres;

--
-- Name: COLUMN messages.message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.message IS 'Unique identification code for the row';


--
-- Name: COLUMN messages.conversation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.conversation IS 'Conversation';


--
-- Name: COLUMN messages.written_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.written_on IS 'Date when the message was written';


--
-- Name: COLUMN messages.message_text; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.message_text IS 'The text of the message';


--
-- Name: COLUMN messages.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages.person IS 'La person fisica che ha scritto il message';


--
-- Name: messages_read; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE messages_read (
    message_read bigint DEFAULT nextval('pk_seq'::regclass) NOT NULL,
    message bigint NOT NULL,
    person bigint NOT NULL,
    read_on timestamp without time zone
);


ALTER TABLE messages_read OWNER TO postgres;

--
-- Name: COLUMN messages_read.message_read; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages_read.message_read IS 'Unique identification code for the row';


--
-- Name: COLUMN messages_read.message; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages_read.message IS 'Message to read';


--
-- Name: COLUMN messages_read.person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages_read.person IS 'The person that rode the message';


--
-- Name: COLUMN messages_read.read_on; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN messages_read.read_on IS 'Date when the message has been red';


--
-- Name: teachers_classbooks_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW teachers_classbooks_ex AS
 SELECT DISTINCT s.school,
    sy.school_year,
    cs.classroom,
    v.teacher,
    v.subject,
    s.description AS school_description,
    s.mnemonic AS school_mnemonic,
    sy.description AS school_year_description,
    c.description AS classrom_description,
    p.surname,
    p.name,
    p.tax_code,
    sub.description AS subject_description
   FROM ((((((valutations v
     JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))
     JOIN classrooms c ON ((c.classroom = cs.classroom)))
     JOIN school_years sy ON ((sy.school_year = c.school_year)))
     JOIN schools s ON ((s.school = sy.school)))
     JOIN persons p ON ((p.person = v.teacher)))
     JOIN subjects sub ON ((sub.subject = v.subject)));


ALTER TABLE teachers_classbooks_ex OWNER TO postgres;

--
-- Name: COLUMN teachers_classbooks_ex.school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.school IS 'School of the teachers';


--
-- Name: COLUMN teachers_classbooks_ex.school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.school_year IS 'The school year with these classbooks';


--
-- Name: COLUMN teachers_classbooks_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.classroom IS 'Classroom in the classbook teacher';


--
-- Name: COLUMN teachers_classbooks_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.teacher IS 'Teacher';


--
-- Name: COLUMN teachers_classbooks_ex.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.subject IS 'The subject for the teacher';


--
-- Name: COLUMN teachers_classbooks_ex.school_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.school_description IS 'The description of the school';


--
-- Name: COLUMN teachers_classbooks_ex.school_mnemonic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.school_mnemonic IS 'The school mnemonic';


--
-- Name: COLUMN teachers_classbooks_ex.school_year_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.school_year_description IS 'A note for the school year';


--
-- Name: COLUMN teachers_classbooks_ex.classrom_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.classrom_description IS 'Description for the classroom';


--
-- Name: COLUMN teachers_classbooks_ex.surname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.surname IS 'Surname on the classbook';


--
-- Name: COLUMN teachers_classbooks_ex.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.name IS 'The name of the teacher';


--
-- Name: COLUMN teachers_classbooks_ex.tax_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.tax_code IS 'Tax code on the classbook';


--
-- Name: COLUMN teachers_classbooks_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_classbooks_ex.subject_description IS 'The description of the subject';


--
-- Name: teachers_lessons_signatures_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW teachers_lessons_signatures_ex AS
 SELECT 'lesson'::text AS type_riga,
    l.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    p.thumbnail AS teacher_thumbnail,
    l.on_date,
    l.from_time,
    l.to_time,
    COALESCE(m.description, '* nessuna subject specificata *'::character varying(160)) AS subject_description,
    l.description,
    l.substitute
   FROM ((lessons l
     JOIN persons p ON ((l.teacher = p.person)))
     LEFT JOIN subjects m ON ((l.subject = m.subject)))
UNION ALL
 SELECT 'signature'::text AS type_riga,
    f.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    p.thumbnail AS teacher_thumbnail,
    f.on_date,
    f.at_time AS from_time,
    NULL::time without time zone AS to_time,
    NULL::character varying AS subject_description,
    NULL::character varying AS description,
    NULL::boolean AS substitute
   FROM (signatures f
     JOIN persons p ON ((f.teacher = p.person)));


ALTER TABLE teachers_lessons_signatures_ex OWNER TO postgres;

--
-- Name: COLUMN teachers_lessons_signatures_ex.type_riga; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.type_riga IS 'Type for the row';


--
-- Name: COLUMN teachers_lessons_signatures_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.classroom IS 'Classrooms with these lessosn signatures';


--
-- Name: COLUMN teachers_lessons_signatures_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.teacher IS 'The teacher that requested the signatures';


--
-- Name: COLUMN teachers_lessons_signatures_ex.teacher_surname_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.teacher_surname_name IS 'The teacher surname and name';


--
-- Name: COLUMN teachers_lessons_signatures_ex.teacher_thumbnail; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.teacher_thumbnail IS 'The teacher thumbnail';


--
-- Name: COLUMN teachers_lessons_signatures_ex.on_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.on_date IS 'When the signature was insert';


--
-- Name: COLUMN teachers_lessons_signatures_ex.from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.from_time IS 'The time when lessons start';


--
-- Name: COLUMN teachers_lessons_signatures_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.subject_description IS 'The description for the subject';


--
-- Name: COLUMN teachers_lessons_signatures_ex.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.description IS 'The description for these lessons signatures';


--
-- Name: COLUMN teachers_lessons_signatures_ex.substitute; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN teachers_lessons_signatures_ex.substitute IS 'Check if is a substitute';


--
-- Name: usenames_rolnames; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW usenames_rolnames AS
 SELECT (members.rolname)::character varying AS usename,
    (roles.rolname)::character varying AS rolname
   FROM ((pg_authid roles
     JOIN pg_auth_members links ON ((links.roleid = roles.oid)))
     JOIN pg_authid members ON ((links.member = members.oid)));


ALTER TABLE usenames_rolnames OWNER TO postgres;

--
-- Name: COLUMN usenames_rolnames.usename; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_rolnames.usename IS 'The usename';


--
-- Name: COLUMN usenames_rolnames.rolname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN usenames_rolnames.rolname IS 'The rolname for the usename';


--
-- Name: valutations_stats_classrooms_students_subjects_on_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects_on_date AS
 SELECT cs.classroom,
    cs.student,
    v.subject,
    min(v.on_date) AS min,
    max(v.on_date) AS max
   FROM (valutations v
     JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))
  GROUP BY cs.classroom, cs.student, v.subject;


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date OWNER TO postgres;

--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date.classroom IS 'The classroom for the valutations';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date.student IS 'Student with these valutations';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date.subject IS 'The subject of these valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date.max; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date.max IS 'Maximum for the valutation stats';


--
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW valutations_stats_classrooms_students_subjects_on_date_ex AS
 SELECT vas.classroom,
    c.description AS classrom_description,
    vas.student,
    ((((((alu.surname)::text || ' '::text) || (alu.name)::text) || ' ('::text) || (alu.tax_code)::text) || ')'::text) AS student_description,
    vas.subject,
    m.description AS subject_description,
    vas.min,
    vas.max,
    vas.media,
    vas.dev_std,
    vo_f.thousandths AS primo,
    vo_l.thousandths AS ultimo
   FROM ((((((((valutations_stats_classrooms_students_subjects vas
     JOIN valutations_stats_classrooms_students_subjects_on_date vas_g ON (((vas.classroom = vas_g.classroom) AND (vas.student = vas_g.student) AND (vas_g.subject = vas.subject))))
     JOIN ( SELECT cs.classroom,
            cs.student,
            v.subject,
            v.on_date,
            v.grade
           FROM (valutations v
             JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))) va_f ON (((va_f.classroom = vas.classroom) AND (va_f.student = vas.student) AND (va_f.subject = vas.subject) AND (va_f.on_date = vas_g.min))))
     JOIN grades vo_f ON ((vo_f.grade = va_f.grade)))
     JOIN ( SELECT cs.classroom,
            cs.student,
            v.subject,
            v.on_date,
            v.grade
           FROM (valutations v
             JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))) va_l ON (((va_l.classroom = vas.classroom) AND (va_l.student = vas.student) AND (va_l.subject = vas.subject) AND (va_l.on_date = vas_g.max))))
     JOIN grades vo_l ON ((vo_l.grade = va_l.grade)))
     JOIN classrooms c ON ((c.classroom = vas.classroom)))
     JOIN persons alu ON ((alu.person = vas.student)))
     JOIN subjects m ON ((m.subject = vas.subject)));


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date_ex OWNER TO postgres;

--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.classroom IS 'The classroom with these valutations stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.classrom_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.classrom_description IS 'The description of the classroom';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.student IS 'Student with that subject valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.student_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.student_description IS 'Student description';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.subject IS 'Subject for the valutations';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.subject_description IS 'The subject description';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.min; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.min IS 'Minimum for the valutation stats';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.max; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.max IS 'Max stats for the valutation';


--
-- Name: COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.media; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN valutations_stats_classrooms_students_subjects_on_date_ex.media IS 'Media of the valutation stats';


--
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex_mat; Type: MATERIALIZED VIEW; Schema: public; Owner: postgres
--

CREATE MATERIALIZED VIEW valutations_stats_classrooms_students_subjects_on_date_ex_mat AS
 SELECT vas.classroom,
    c.description AS classrom_description,
    vas.student,
    ((((((alu.surname)::text || ' '::text) || (alu.name)::text) || ' ('::text) || (alu.tax_code)::text) || ')'::text) AS student_description,
    vas.subject,
    m.description AS subject_description,
    vas.min,
    vas.max,
    vas.media,
    vas.dev_std,
    vo_f.thousandths AS primo,
    vo_l.thousandths AS ultimo
   FROM ((((((((valutations_stats_classrooms_students_subjects vas
     JOIN valutations_stats_classrooms_students_subjects_on_date vas_g ON (((vas.classroom = vas_g.classroom) AND (vas.student = vas_g.student) AND (vas_g.subject = vas.subject))))
     JOIN ( SELECT cs.classroom,
            cs.student,
            v.subject,
            v.on_date,
            v.grade
           FROM (valutations v
             JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))) va_f ON (((va_f.classroom = vas.classroom) AND (va_f.student = vas.student) AND (va_f.subject = vas.subject) AND (va_f.on_date = vas_g.min))))
     JOIN grades vo_f ON ((vo_f.grade = va_f.grade)))
     JOIN ( SELECT cs.classroom,
            cs.student,
            v.subject,
            v.on_date,
            v.grade
           FROM (valutations v
             JOIN classrooms_students cs ON ((cs.classroom_student = v.classroom_student)))) va_l ON (((va_l.classroom = vas.classroom) AND (va_l.student = vas.student) AND (va_l.subject = vas.subject) AND (va_l.on_date = vas_g.max))))
     JOIN grades vo_l ON ((vo_l.grade = va_l.grade)))
     JOIN classrooms c ON ((c.classroom = vas.classroom)))
     JOIN persons alu ON ((alu.person = vas.student)))
     JOIN subjects m ON ((m.subject = vas.subject)))
  WITH NO DATA;


ALTER TABLE valutations_stats_classrooms_students_subjects_on_date_ex_mat OWNER TO postgres;

--
-- Name: weekly_timetable_teachers_ex; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW weekly_timetable_teachers_ex AS
 SELECT c.classroom,
    p.person AS teacher,
    (((p.surname)::text || ' '::text) || (p.name)::text) AS teacher_surname_name,
    os.description AS weekly_timetable_description,
    COALESCE(m.description, 'Materia non specificata'::character varying) AS subject_description,
    osg.weekday,
    ((to_char((('now'::text)::date + osg.from_time), 'HH24:MI'::text) || ' - '::text) || to_char((('now'::text)::date + osg.to_time), ((('HH24:MI'::text || ' ('::text) || (osg.team_teaching)::text) || ')'::text))) AS period
   FROM (((((school_years a
     JOIN classrooms c ON ((c.school_year = a.school_year)))
     JOIN weekly_timetables os ON ((os.classroom = c.classroom)))
     JOIN weekly_timetables_days osg ON ((osg.weekly_timetable = os.weekly_timetable)))
     JOIN persons p ON ((p.person = osg.teacher)))
     LEFT JOIN subjects m ON ((m.subject = osg.subject)))
  WHERE (a.school = ANY (schools_enabled()));


ALTER TABLE weekly_timetable_teachers_ex OWNER TO postgres;

--
-- Name: COLUMN weekly_timetable_teachers_ex.classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.classroom IS 'The classroomfor of the teacher with these weekly timetables';


--
-- Name: COLUMN weekly_timetable_teachers_ex.teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.teacher IS 'Teacher of the weekl timetable';


--
-- Name: COLUMN weekly_timetable_teachers_ex.teacher_surname_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.teacher_surname_name IS 'The teacher surname and name for the weekly timetable';


--
-- Name: COLUMN weekly_timetable_teachers_ex.weekly_timetable_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.weekly_timetable_description IS 'The description for the weekly timetable';


--
-- Name: COLUMN weekly_timetable_teachers_ex.subject_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.subject_description IS 'The description of the subject';


--
-- Name: COLUMN weekly_timetable_teachers_ex.weekday; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.weekday IS 'The weekday';


--
-- Name: COLUMN weekly_timetable_teachers_ex.period; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weekly_timetable_teachers_ex.period IS 'The period for the weekly timetable';


--
-- Name: absences absences_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_pk PRIMARY KEY (absence);


--
-- Name: absences absences_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- Name: branches branches_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_pk PRIMARY KEY (branch);


--
-- Name: branches branches_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_uq_description UNIQUE (school, description);


--
-- Name: cities cities_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_pk PRIMARY KEY (city);


--
-- Name: cities cities_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_uq_description UNIQUE (description, district);


--
-- Name: CONSTRAINT cities_uq_description ON cities; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT cities_uq_description ON cities IS 'There must not exist two differents cities for district!';


--
-- Name: classrooms classrooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_pk PRIMARY KEY (classroom);


--
-- Name: classrooms_students classrooms_students_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_pk PRIMARY KEY (classroom_student);


--
-- Name: classrooms_students classrooms_students_uq_classroom_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_uq_classroom_student UNIQUE (classroom, student);


--
-- Name: classrooms classrooms_uq_classroom; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_uq_classroom UNIQUE (school_year, branch, degree, section, course_year);


--
-- Name: classrooms classrooms_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_uq_description UNIQUE (school_year, description);


--
-- Name: communication_types communication_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_pk PRIMARY KEY (communication_type);


--
-- Name: communication_types communication_types_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_uq_description UNIQUE (school, description);


--
-- Name: communications_media communications_media_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_pk PRIMARY KEY (communication_media);


--
-- Name: communications_media communications_media_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_uq_description UNIQUE (person, communication_type, description);


--
-- Name: communications_media communications_media_uq_uri; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_uq_uri UNIQUE (person, communication_type, uri);


--
-- Name: conversations_invites conversations_invites_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_pk PRIMARY KEY (conversation_invite);


--
-- Name: conversations_invites conversations_invites_uq_invited; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_uq_invited UNIQUE (conversation, invited);


--
-- Name: CONSTRAINT conversations_invites_uq_invited ON conversations_invites; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT conversations_invites_uq_invited ON conversations_invites IS 'It''s not possible in a given conversation to invite the same person many times.';


--
-- Name: conversations conversations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_pk PRIMARY KEY (conversation);


--
-- Name: countries countries_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_pk PRIMARY KEY (country);


--
-- Name: countries countries_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY countries
    ADD CONSTRAINT countries_uq_description UNIQUE (description);


--
-- Name: degrees degrees_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_pk PRIMARY KEY (degree);


--
-- Name: degrees degrees_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_uq_description UNIQUE (school, description);


--
-- Name: delays delays_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_pk PRIMARY KEY (delay);


--
-- Name: delays delays_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- Name: CONSTRAINT delays_uq_classroom_student_on_date ON delays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT delays_uq_classroom_student_on_date ON delays IS 'A student in a classrom can have just one delay for day.';


--
-- Name: districts districts_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_pk PRIMARY KEY (district);


--
-- Name: districts districts_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_uq_description UNIQUE (description);


--
-- Name: explanations explanations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_pk PRIMARY KEY (explanation);


--
-- Name: faults faults_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_pk PRIMARY KEY (fault);


--
-- Name: grade_types grade_types_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_pk PRIMARY KEY (grade_type);


--
-- Name: grade_types grade_types_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_uq_mnemonic UNIQUE (subject, mnemonic);


--
-- Name: grades grades_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pk PRIMARY KEY (grade);


--
-- Name: grades grades_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_uq_description UNIQUE (metric, description);


--
-- Name: grades grades_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_uq_mnemonic UNIQUE (metric, mnemonic);


--
-- Name: grading_meetings grading_meetings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_pk PRIMARY KEY (grading_meeting);


--
-- Name: grading_meetings grading_meetings_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_uq_description UNIQUE (school_year, description);


--
-- Name: grading_meetings grading_meetings_uq_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_uq_on_date UNIQUE (school_year, on_date);


--
-- Name: grading_meetings_valutations grading_meetings_valutations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_pk PRIMARY KEY (grading_meeting_valutation);


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_pk PRIMARY KEY (grading_meeting_valutation_qua);


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_uq_qualification UNIQUE (grading_meeting_valutation, qualification);


--
-- Name: grading_meetings_valutations grading_meetings_valutations_uq_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_uq_student UNIQUE (grading_meeting, classroom, student, subject, teacher);


--
-- Name: holidays holidays_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holidays
    ADD CONSTRAINT holidays_pk PRIMARY KEY (holiday);


--
-- Name: holidays holidays_uq_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holidays
    ADD CONSTRAINT holidays_uq_on_date UNIQUE (school, on_date);


--
-- Name: CONSTRAINT holidays_uq_on_date ON holidays; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT holidays_uq_on_date ON holidays IS 'Nello stesso school ogni on_date deve essere indicato to_time massimo una volta';


--
-- Name: leavings leavings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_pk PRIMARY KEY (leaving);


--
-- Name: leavings leavings_uq_classroom_student; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_uq_classroom_student UNIQUE (classroom_student, on_date);


--
-- Name: CONSTRAINT leavings_uq_classroom_student ON leavings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT leavings_uq_classroom_student ON leavings IS 'Per ub student di una classroom in un on_date è possibile una sola leaving';


--
-- Name: lessons lessons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_pk PRIMARY KEY (lesson);


--
-- Name: messages messages_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pk PRIMARY KEY (message);


--
-- Name: messages_read messages_read_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_pk PRIMARY KEY (message_read);


--
-- Name: messages_read messages_read_uq_read_on; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_uq_read_on UNIQUE (message, person);


--
-- Name: CONSTRAINT messages_read_uq_read_on ON messages_read; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT messages_read_uq_read_on ON messages_read IS 'L''indicazione di quando è stato letto un message è univoco per ogni messagio e person (from_time) che lo ha letto';


--
-- Name: messages messages_uq_from_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_uq_from_time UNIQUE (conversation, person, written_on);


--
-- Name: metrics metrics_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_pk PRIMARY KEY (metric);


--
-- Name: metrics metrics_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_uq_description UNIQUE (school, description);


--
-- Name: mime_type_image mime_type_image_is_not_null; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER DOMAIN mime_type_image
    ADD CONSTRAINT mime_type_image_is_not_null CHECK ((VALUE IS NOT NULL)) NOT VALID;


--
-- Name: notes notes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_pk PRIMARY KEY (note);


--
-- Name: notes_signed notes_signed_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_pk PRIMARY KEY (note_signed);


--
-- Name: notes_signed notes_signed_uq_note_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_uq_note_person UNIQUE (note, person);


--
-- Name: notes notes_uq_on_date_at_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time);


--
-- Name: out_of_classrooms out_of_classrooms_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_pk PRIMARY KEY (out_of_classroom);


--
-- Name: out_of_classrooms out_of_classrooms_uq_classroom_student_on_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_uq_classroom_student_on_date UNIQUE (classroom_student, on_date);


--
-- Name: parents_meetings parents_meetings_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_pk PRIMARY KEY (parents_meeting);


--
-- Name: parents_meetings parents_meetings_uq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_uq UNIQUE (teacher, on_date);


--
-- Name: CONSTRAINT parents_meetings_uq ON parents_meetings; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT parents_meetings_uq ON parents_meetings IS 'Un teacher non può avere più di un interview in un determiborn momento';


--
-- Name: persons_addresses persons_addresses_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_pk PRIMARY KEY (person_address);


--
-- Name: persons_addresses persons_addresses_uq_indirizzo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_uq_indirizzo UNIQUE (person, street, zip_code, city);


--
-- Name: persons persons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_pk PRIMARY KEY (person);


--
-- Name: persons_relations persons_relations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_pk PRIMARY KEY (person_relation);


--
-- Name: persons_relations persons_relations_uq_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_uq_person UNIQUE (person, relationship, person_related_to);


--
-- Name: persons_roles persons_roles_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_pk PRIMARY KEY (person_role);


--
-- Name: persons_roles persons_roles_uq_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_uq_person UNIQUE (person, role);


--
-- Name: persons persons_uq_school_tax_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_uq_school_tax_code UNIQUE (school, tax_code);


--
-- Name: persons persons_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_uq_usename UNIQUE (school, usename);


--
-- Name: CONSTRAINT persons_uq_usename ON persons; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT persons_uq_usename ON persons IS 'for every school we cannot have more than one person with the same usename (we can have hovewer the same person with more roles in the same school) ';


--
-- Name: qualifications qualifications_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications
    ADD CONSTRAINT qualifications_pk PRIMARY KEY (qualification);


--
-- Name: qualifications qualifications_uq_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications
    ADD CONSTRAINT qualifications_uq_name UNIQUE (school, name);


--
-- Name: qualifications_plan qualificationtions_plan_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications_plan
    ADD CONSTRAINT qualificationtions_plan_pk PRIMARY KEY (qualificationtion_plan);


--
-- Name: qualifications_plan qualificationtions_plan_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications_plan
    ADD CONSTRAINT qualificationtions_plan_uq_qualification UNIQUE (degree, course_year, subject, qualification);


--
-- Name: regions regions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pk PRIMARY KEY (region);


--
-- Name: regions regions_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_uq_description UNIQUE (description);


--
-- Name: school_years school_years_ex_duration; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_ex_duration EXCLUDE USING gist (school WITH =, duration WITH &&);


--
-- Name: CONSTRAINT school_years_ex_duration ON school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT school_years_ex_duration ON school_years IS 'in the same school we cannot have duration overlap';


--
-- Name: school_years school_years_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_pk PRIMARY KEY (school_year);


--
-- Name: school_years school_years_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_uq_description UNIQUE (school, description);


--
-- Name: CONSTRAINT school_years_uq_description ON school_years; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT school_years_uq_description ON school_years IS 'La description deve essere univoca all''interno di un school';


--
-- Name: schools schools_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_pk PRIMARY KEY (school);


--
-- Name: schools schools_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_description UNIQUE (description);


--
-- Name: schools schools_uq_mnemonic; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_mnemonic UNIQUE (mnemonic);


--
-- Name: schools schools_uq_processing_code; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_uq_processing_code UNIQUE (processing_code, example);


--
-- Name: signatures signatures_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_pk PRIMARY KEY (signature);


--
-- Name: signatures signatures_uq_classroom; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_uq_classroom UNIQUE (classroom, teacher, on_date, at_time);


--
-- Name: CONSTRAINT signatures_uq_classroom ON signatures; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT signatures_uq_classroom ON signatures IS 'Un teacher non può signaturere più di una volta nello stesso on_date e  nella stessa at_time (indipendentemente from_timela classroom)';


--
-- Name: subjects subjects_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_pk PRIMARY KEY (subject);


--
-- Name: subjects subjects_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_uq_description UNIQUE (school, description);


--
-- Name: teachears_notes teachears_notes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_pk PRIMARY KEY (teacher_notes);


--
-- Name: teachears_notes teachears_notes_uq_on_date_at_time; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time);


--
-- Name: grade_types tipi_grades_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT tipi_grades_uq_description UNIQUE (subject, description);


--
-- Name: topics topics_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_pk PRIMARY KEY (topic);


--
-- Name: topics topics_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_uq_description UNIQUE (degree, course_year, subject, description);


--
-- Name: CONSTRAINT topics_uq_description ON topics; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT topics_uq_description ON topics IS 'test';


--
-- Name: usenames_ex usenames_ex_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_ex
    ADD CONSTRAINT usenames_ex_pk PRIMARY KEY (usename);


--
-- Name: usenames_ex usenames_ex_uq_usename; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_ex
    ADD CONSTRAINT usenames_ex_uq_usename UNIQUE (usename);


--
-- Name: CONSTRAINT usenames_ex_uq_usename ON usenames_ex; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT usenames_ex_uq_usename ON usenames_ex IS 'ad ogni db_user di sistema deve corrispondere un solo db_user ';


--
-- Name: usenames_schools usenames_schools_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_schools
    ADD CONSTRAINT usenames_schools_pk PRIMARY KEY (usename_school);


--
-- Name: usenames_schools usenames_schools_uq_usename_school; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_schools
    ADD CONSTRAINT usenames_schools_uq_usename_school UNIQUE (usename, school);


--
-- Name: CONSTRAINT usenames_schools_uq_usename_school ON usenames_schools; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT usenames_schools_uq_usename_school ON usenames_schools IS 'Foe every usename one school can be enabled only one time';


--
-- Name: valutations valutations_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_pk PRIMARY KEY (valutation);


--
-- Name: valutations_qualifications valutations_qualificationtions_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualifications
    ADD CONSTRAINT valutations_qualificationtions_pk PRIMARY KEY (valutation_qualificationtion);


--
-- Name: valutations_qualifications valutations_qualificationtions_uq_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualifications
    ADD CONSTRAINT valutations_qualificationtions_uq_qualification UNIQUE (valutation, qualification);


--
-- Name: weekly_timetables weekly_timetable_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables
    ADD CONSTRAINT weekly_timetable_pk PRIMARY KEY (weekly_timetable);


--
-- Name: weekly_timetables weekly_timetable_uq_description; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables
    ADD CONSTRAINT weekly_timetable_uq_description UNIQUE (classroom, description);


--
-- Name: weekly_timetables_days weekly_timetables_days_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_pk PRIMARY KEY (weekly_timetable_day);


--
-- Name: weekly_timetables_days weekly_timetables_days_uq_weekly_timetable; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_uq_weekly_timetable UNIQUE (weekly_timetable, weekday, teacher, subject, from_time);


--
-- Name: wikimedia_files_persons wikimedia_files_persons_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_pk PRIMARY KEY (wikimedia_file_person);


--
-- Name: wikimedia_files_persons wikimedia_files_persons_uq_wikimedia_file_person; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_uq_wikimedia_file_person UNIQUE (wikimedia_file, person);


--
-- Name: wikimedia_files wikimedia_files_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files
    ADD CONSTRAINT wikimedia_files_pk PRIMARY KEY (wikimedia_file);


--
-- Name: absences_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_classroom_student ON absences USING btree (classroom_student);


--
-- Name: absences_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_explanation ON absences USING btree (explanation);


--
-- Name: INDEX absences_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX absences_fx_explanation IS 'Index to access the relative foreign key.';


--
-- Name: absences_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX absences_fx_teacher ON absences USING btree (teacher);


--
-- Name: INDEX absences_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX absences_fx_teacher IS 'Index to access the relative foreign key.';


--
-- Name: branches_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX branches_fx_school ON branches USING btree (school);


--
-- Name: cities_fx_district; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cities_fx_district ON cities USING btree (district);


--
-- Name: classrooms_fx_branch; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_branch ON classrooms USING btree (branch);


--
-- Name: classrooms_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_degree ON classrooms USING btree (degree);


--
-- Name: INDEX classrooms_fx_degree; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_fx_degree IS 'Index to access the relative foreign key.';


--
-- Name: classrooms_fx_school_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_fx_school_year ON classrooms USING btree (school_year);


--
-- Name: INDEX classrooms_fx_school_year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_fx_school_year IS 'Index to access the relative foreign key.';


--
-- Name: classrooms_students_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX classrooms_students_fx_classroom ON classrooms_students USING btree (classroom);


--
-- Name: INDEX classrooms_students_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX classrooms_students_fx_classroom IS 'Index to access the relative foreign key.';


--
-- Name: communication_types_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communication_types_fx_school ON communication_types USING btree (school);


--
-- Name: communications_media_ix_communication_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communications_media_ix_communication_type ON communications_media USING btree (communication_type);


--
-- Name: INDEX communications_media_ix_communication_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX communications_media_ix_communication_type IS 'Index to access the relative foreign key.';


--
-- Name: communications_media_ix_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX communications_media_ix_person ON communications_media USING btree (person);


--
-- Name: INDEX communications_media_ix_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX communications_media_ix_person IS 'Index to access the relative foreign key.';


--
-- Name: conversations_fx_school_record; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_fx_school_record ON conversations USING btree (classroom_student);


--
-- Name: INDEX conversations_fx_school_record; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX conversations_fx_school_record IS 'Index to access the relative foreign key.';


--
-- Name: conversations_partecipanti_fx_conversation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_partecipanti_fx_conversation ON conversations_invites USING btree (conversation);


--
-- Name: conversations_partecipanti_fx_partecipante; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversations_partecipanti_fx_partecipante ON conversations_invites USING btree (invited);


--
-- Name: degrees_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX degrees_fx_school ON degrees USING btree (school);


--
-- Name: INDEX degrees_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX degrees_fx_school IS 'Index to access the relative foreign key.';


--
-- Name: delays_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_classroom_student ON delays USING btree (classroom_student);


--
-- Name: delays_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_explanation ON delays USING btree (explanation);


--
-- Name: INDEX delays_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX delays_fx_explanation IS 'Index to access the relative foreign key.';


--
-- Name: delays_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX delays_fx_teacher ON delays USING btree (teacher);


--
-- Name: INDEX delays_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX delays_fx_teacher IS 'Index to access the relative foreign key.';


--
-- Name: explanations_fx_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_created_by ON explanations USING btree (created_by);


--
-- Name: explanations_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_student ON explanations USING btree (student);


--
-- Name: INDEX explanations_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX explanations_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: explanations_fx_usata_from_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX explanations_fx_usata_from_time ON explanations USING btree (registered_by);


--
-- Name: faults_fx_lesson; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faults_fx_lesson ON faults USING btree (lesson);


--
-- Name: faults_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX faults_fx_student ON faults USING btree (student);


--
-- Name: INDEX faults_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX faults_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: grade_types_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grade_types_fx_subject ON grade_types USING btree (subject);


--
-- Name: grades_fx_metric; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grades_fx_metric ON grades USING btree (metric);


--
-- Name: INDEX grades_fx_metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grades_fx_metric IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: grading_meetings_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_fx_school ON grading_meetings USING btree (school_year);


--
-- Name: grading_meetings_valutations_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_classroom ON grading_meetings_valutations USING btree (classroom);


--
-- Name: grading_meetings_valutations_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_grade ON grading_meetings_valutations USING btree (grade);


--
-- Name: grading_meetings_valutations_fx_grading_meeting; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_grading_meeting ON grading_meetings_valutations USING btree (grading_meeting);


--
-- Name: grading_meetings_valutations_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_student ON grading_meetings_valutations USING btree (student);


--
-- Name: grading_meetings_valutations_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_fx_subject ON grading_meetings_valutations USING btree (subject);


--
-- Name: grading_meetings_valutations_qua_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_grade ON grading_meetings_valutations_qua USING btree (grade);


--
-- Name: INDEX grading_meetings_valutations_qua_fx_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_grade IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: grading_meetings_valutations_qua_fx_grading_meeting_valutation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation ON grading_meetings_valutations_qua USING btree (grading_meeting_valutation);


--
-- Name: INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: grading_meetings_valutations_qua_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX grading_meetings_valutations_qua_fx_qualification ON grading_meetings_valutations_qua USING btree (qualification);


--
-- Name: INDEX grading_meetings_valutations_qua_fx_qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX grading_meetings_valutations_qua_fx_qualification IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: holidays_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX holidays_fx_school ON holidays USING btree (school);


--
-- Name: INDEX holidays_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX holidays_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: idx_grading_meetings_valutations; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_grading_meetings_valutations ON grading_meetings_valutations USING btree (teacher);


--
-- Name: idx_persons_roles; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_persons_roles ON persons_roles USING btree (person);


--
-- Name: leavings_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_classroom_student ON leavings USING btree (classroom_student);


--
-- Name: leavings_fx_explanation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_explanation ON leavings USING btree (explanation);


--
-- Name: INDEX leavings_fx_explanation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX leavings_fx_explanation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: leavings_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX leavings_fx_teacher ON leavings USING btree (teacher);


--
-- Name: INDEX leavings_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX leavings_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: lessons_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_classroom ON lessons USING btree (classroom);


--
-- Name: INDEX lessons_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: lessons_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_subject ON lessons USING btree (subject);


--
-- Name: INDEX lessons_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: lessons_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX lessons_fx_teacher ON lessons USING btree (teacher);


--
-- Name: INDEX lessons_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX lessons_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: libretti_messages_read_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libretti_messages_read_fx_person ON messages_read USING btree (person);


--
-- Name: INDEX libretti_messages_read_fx_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messages_read_fx_person IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: libretti_messages_read_fx_school_record_mess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX libretti_messages_read_fx_school_record_mess ON messages_read USING btree (message);


--
-- Name: INDEX libretti_messages_read_fx_school_record_mess; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX libretti_messages_read_fx_school_record_mess IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: messages_fx_conversation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_fx_conversation ON messages USING btree (conversation);


--
-- Name: INDEX messages_fx_conversation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messages_fx_conversation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: messages_fx_from_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_fx_from_time ON messages USING btree (person);


--
-- Name: INDEX messages_fx_from_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX messages_fx_from_time IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: metrics_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX metrics_fx_school ON metrics USING btree (school);


--
-- Name: INDEX metrics_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX metrics_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: notes_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_classroom ON notes USING btree (classroom);


--
-- Name: notes_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_classroom_student ON notes USING btree (classroom, student);


--
-- Name: notes_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_fx_teacher ON notes USING btree (teacher);


--
-- Name: INDEX notes_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX notes_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: notes_signed_fx_note; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_signed_fx_note ON notes_signed USING btree (note);


--
-- Name: notes_signed_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX notes_signed_fx_person ON notes_signed USING btree (person);


--
-- Name: out_of_classrooms_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX out_of_classrooms_fx_classroom_student ON out_of_classrooms USING btree (classroom_student);


--
-- Name: out_of_classrooms_fx_school_operator; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX out_of_classrooms_fx_school_operator ON out_of_classrooms USING btree (school_operator);


--
-- Name: INDEX out_of_classrooms_fx_school_operator; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX out_of_classrooms_fx_school_operator IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: parents_meetings_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parents_meetings_fx_person ON parents_meetings USING btree (person);


--
-- Name: parents_meetings_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX parents_meetings_fx_teacher ON parents_meetings USING btree (teacher);


--
-- Name: persons_addresses_fx_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_addresses_fx_city ON persons_addresses USING btree (city);


--
-- Name: persons_addresses_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_addresses_fx_person ON persons_addresses USING btree (person);


--
-- Name: persons_fx_city_of_birth; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_city_of_birth ON persons USING btree (city_of_birth);


--
-- Name: persons_fx_country_of_birth; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_country_of_birth ON persons USING btree (country_of_birth);


--
-- Name: persons_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_school ON persons USING btree (school);


--
-- Name: persons_fx_usename; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_fx_usename ON persons USING btree (usename);


--
-- Name: persons_ix_usename_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_ix_usename_school ON persons USING btree (usename, school);


--
-- Name: INDEX persons_ix_usename_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persons_ix_usename_school IS 'for the policy roles about horizontal security';


--
-- Name: persons_relations_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_relations_fx_person ON persons_relations USING btree (person);


--
-- Name: INDEX persons_relations_fx_person; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persons_relations_fx_person IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: persons_relations_fx_person_related_to; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX persons_relations_fx_person_related_to ON persons_relations USING btree (person_related_to);


--
-- Name: INDEX persons_relations_fx_person_related_to; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX persons_relations_fx_person_related_to IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: qualificationtions_fx_metric; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_metric ON qualifications USING btree (metric);


--
-- Name: INDEX qualificationtions_fx_metric; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualificationtions_fx_metric IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: qualificationtions_fx_riferimento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_riferimento ON qualifications USING btree (qualification_parent);


--
-- Name: qualificationtions_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_fx_school ON qualifications USING btree (school);


--
-- Name: INDEX qualificationtions_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX qualificationtions_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: qualificationtions_plan_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_degree ON qualifications_plan USING btree (degree);


--
-- Name: qualificationtions_plan_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_qualification ON qualifications_plan USING btree (qualification);


--
-- Name: qualificationtions_plan_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX qualificationtions_plan_fx_subject ON qualifications_plan USING btree (subject);


--
-- Name: school_years_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX school_years_fx_school ON school_years USING btree (school);


--
-- Name: schools_fk_behavior; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX schools_fk_behavior ON schools USING btree (behavior);


--
-- Name: signatures_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX signatures_fx_classroom ON signatures USING btree (classroom);


--
-- Name: INDEX signatures_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX signatures_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: signatures_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX signatures_fx_teacher ON signatures USING btree (teacher);


--
-- Name: INDEX signatures_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX signatures_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: subjects_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX subjects_fx_school ON subjects USING btree (school);


--
-- Name: INDEX subjects_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX subjects_fx_school IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: teachears_notes_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_classroom ON teachears_notes USING btree (classroom);


--
-- Name: teachears_notes_fx_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_student ON teachears_notes USING btree (student);


--
-- Name: INDEX teachears_notes_fx_student; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX teachears_notes_fx_student IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: teachears_notes_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX teachears_notes_fx_teacher ON teachears_notes USING btree (teacher);


--
-- Name: INDEX teachears_notes_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX teachears_notes_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: topics_fx_degree; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topics_fx_degree ON topics USING btree (degree);


--
-- Name: topics_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX topics_fx_subject ON topics USING btree (subject);


--
-- Name: INDEX topics_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX topics_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: usenames_schools_fx_school; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX usenames_schools_fx_school ON usenames_schools USING btree (school);


--
-- Name: INDEX usenames_schools_fx_school; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX usenames_schools_fx_school IS 'for using by usenames_ex_schools_fk_school';


--
-- Name: valutations_fx_classroom_student; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_classroom_student ON valutations USING btree (classroom_student);


--
-- Name: valutations_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_grade ON valutations USING btree (grade);


--
-- Name: valutations_fx_grade_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_grade_type ON valutations USING btree (grade_type);


--
-- Name: INDEX valutations_fx_grade_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_grade_type IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: valutations_fx_note; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_note ON valutations USING btree (note);


--
-- Name: valutations_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_teacher ON valutations USING btree (teacher);


--
-- Name: INDEX valutations_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: valutations_fx_topic; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_fx_topic ON valutations USING btree (topic);


--
-- Name: INDEX valutations_fx_topic; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_fx_topic IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: valutations_qualificationtions_fx_grade; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_grade ON valutations_qualifications USING btree (grade);


--
-- Name: INDEX valutations_qualificationtions_fx_grade; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_grade IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: valutations_qualificationtions_fx_qualification; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_qualification ON valutations_qualifications USING btree (qualification);


--
-- Name: INDEX valutations_qualificationtions_fx_qualification; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_qualification IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: valutations_qualificationtions_fx_valutation; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX valutations_qualificationtions_fx_valutation ON valutations_qualifications USING btree (valutation);


--
-- Name: INDEX valutations_qualificationtions_fx_valutation; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX valutations_qualificationtions_fx_valutation IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: weekly_timetable_fx_classroom; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetable_fx_classroom ON weekly_timetables USING btree (classroom);


--
-- Name: INDEX weekly_timetable_fx_classroom; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetable_fx_classroom IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: weekly_timetables_days_fx_subject; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_subject ON weekly_timetables_days USING btree (subject);


--
-- Name: INDEX weekly_timetables_days_fx_subject; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_subject IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: weekly_timetables_days_fx_teacher; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_teacher ON weekly_timetables_days USING btree (teacher);


--
-- Name: INDEX weekly_timetables_days_fx_teacher; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_teacher IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: weekly_timetables_days_fx_weekly_timetable; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX weekly_timetables_days_fx_weekly_timetable ON weekly_timetables_days USING btree (weekly_timetable);


--
-- Name: INDEX weekly_timetables_days_fx_weekly_timetable; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX weekly_timetables_days_fx_weekly_timetable IS 'Indice per l''acceso from_timela relativa chiave esterna';


--
-- Name: wikimedia_files_persons_fx_person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wikimedia_files_persons_fx_person ON wikimedia_files_persons USING btree (person);


--
-- Name: wikimedia_files_persons_fx_wikimedia_file; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX wikimedia_files_persons_fx_wikimedia_file ON wikimedia_files_persons USING btree (wikimedia_file);


--
-- Name: residence_grp_city _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE RULE "_RETURN" AS
    ON SELECT TO residence_grp_city DO INSTEAD  SELECT p.school,
    c.description,
    count(p.person) AS count
   FROM ((persons p
     JOIN persons_addresses pi ON ((pi.person = p.person)))
     JOIN cities c ON ((pi.city = c.city)))
  WHERE (pi.address_type = 'Residence'::address_type)
  GROUP BY p.school, c.city;


--
-- Name: absences absences_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER absences_iu AFTER INSERT OR UPDATE ON absences FOR EACH ROW EXECUTE PROCEDURE tr_absences_iu();


--
-- Name: classrooms classrooms_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classrooms_iu AFTER INSERT OR UPDATE ON classrooms FOR EACH ROW EXECUTE PROCEDURE tr_classrooms_iu();


--
-- Name: classrooms_students classrooms_students_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER classrooms_students_iu AFTER INSERT OR UPDATE ON classrooms_students FOR EACH ROW EXECUTE PROCEDURE tr_classrooms_students_iu();


--
-- Name: communications_media communications_media_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER communications_media_iu AFTER INSERT OR UPDATE ON communications_media FOR EACH ROW EXECUTE PROCEDURE tr_communications_media_iu();


--
-- Name: conversations_invites conversations_invites_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER conversations_invites_iu AFTER INSERT OR UPDATE ON conversations_invites FOR EACH ROW EXECUTE PROCEDURE tr_conversations_invites_iu();


--
-- Name: delays delays_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delays_iu AFTER INSERT OR UPDATE ON delays FOR EACH ROW EXECUTE PROCEDURE tr_delays_iu();


--
-- Name: explanations explanations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER explanations_iu AFTER INSERT OR UPDATE ON explanations FOR EACH ROW EXECUTE PROCEDURE tr_explanations_iu();


--
-- Name: faults faults_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER faults_iu AFTER INSERT OR UPDATE ON faults FOR EACH ROW EXECUTE PROCEDURE tr_faults_iu();


--
-- Name: grading_meetings grading_meetings_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_iu AFTER INSERT OR UPDATE ON grading_meetings FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_iu();


--
-- Name: grading_meetings_valutations grading_meetings_valutations_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_d AFTER DELETE ON grading_meetings_valutations FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_d();


--
-- Name: grading_meetings_valutations grading_meetings_valutations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_iu AFTER INSERT OR UPDATE ON grading_meetings_valutations FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_iu();


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_d; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_qua_d AFTER DELETE ON grading_meetings_valutations_qua FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_qua_d();


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER grading_meetings_valutations_qua_iu AFTER INSERT OR UPDATE ON grading_meetings_valutations_qua FOR EACH ROW EXECUTE PROCEDURE tr_grading_meetings_valutations_qua_iu();


--
-- Name: leavings leavings_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER leavings_iu AFTER INSERT OR UPDATE ON leavings FOR EACH ROW EXECUTE PROCEDURE tr_leavings_iu();


--
-- Name: lessons lessons_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER lessons_iu AFTER INSERT OR UPDATE ON lessons FOR EACH ROW EXECUTE PROCEDURE tr_lessons_iu();


--
-- Name: messages messages_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messages_iu AFTER INSERT OR UPDATE ON messages FOR EACH ROW EXECUTE PROCEDURE tr_messages_iu();


--
-- Name: messages_read messages_read_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER messages_read_iu AFTER INSERT OR UPDATE ON messages_read FOR EACH ROW EXECUTE PROCEDURE tr_messages_read_iu();


--
-- Name: notes notes_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notes_iu AFTER INSERT OR UPDATE ON notes FOR EACH ROW EXECUTE PROCEDURE tr_notes_iu();


--
-- Name: notes_signed notes_signed_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER notes_signed_iu AFTER INSERT OR UPDATE ON notes_signed FOR EACH ROW EXECUTE PROCEDURE tr_notes_signed_iu();


--
-- Name: out_of_classrooms out_of_classrooms_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER out_of_classrooms_iu AFTER INSERT OR UPDATE ON out_of_classrooms FOR EACH ROW EXECUTE PROCEDURE tr_out_of_classrooms_iu();


--
-- Name: parents_meetings parents_meetings_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER parents_meetings_iu AFTER INSERT OR UPDATE ON parents_meetings FOR EACH ROW EXECUTE PROCEDURE tr_parents_meetings_iu();


--
-- Name: schools schools_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER schools_iu AFTER INSERT OR UPDATE ON schools FOR EACH ROW EXECUTE PROCEDURE tr_schools_iu();


--
-- Name: signatures signatures_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER signatures_iu AFTER INSERT OR UPDATE ON signatures FOR EACH ROW EXECUTE PROCEDURE tr_signatures_iu();


--
-- Name: teachears_notes teachears_notes_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER teachears_notes_iu AFTER INSERT OR UPDATE ON teachears_notes FOR EACH ROW EXECUTE PROCEDURE tr_teachears_notes_iu();


--
-- Name: topics topics_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER topics_iu AFTER INSERT OR UPDATE ON topics FOR EACH ROW EXECUTE PROCEDURE tr_topics_iu();


--
-- Name: usenames_ex usenames_ex_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER usenames_ex_iu AFTER INSERT OR UPDATE ON usenames_ex FOR EACH ROW EXECUTE PROCEDURE tr_usename_iu();


--
-- Name: usenames_schools usenames_schools_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER usenames_schools_iu AFTER INSERT OR UPDATE ON usenames_schools FOR EACH ROW EXECUTE PROCEDURE tr_usename_iu();


--
-- Name: valutations valutations_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutations_iu AFTER INSERT OR UPDATE ON valutations FOR EACH ROW EXECUTE PROCEDURE tr_valutations_iu();


--
-- Name: valutations_qualifications valutations_qualifications_iu; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER valutations_qualifications_iu AFTER INSERT OR UPDATE ON valutations_qualifications FOR EACH ROW EXECUTE PROCEDURE tr_valutations_qualifications_iu();


--
-- Name: absences absences_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: absences absences_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: absences absences_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY absences
    ADD CONSTRAINT absences_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: branches branches_fk_schools; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY branches
    ADD CONSTRAINT branches_fk_schools FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: cities cities_fk_district; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cities
    ADD CONSTRAINT cities_fk_district FOREIGN KEY (district) REFERENCES districts(district);


--
-- Name: classrooms classrooms_fk_branch; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_branch FOREIGN KEY (branch) REFERENCES branches(branch) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: classrooms classrooms_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: classrooms classrooms_fk_school_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms
    ADD CONSTRAINT classrooms_fk_school_year FOREIGN KEY (school_year) REFERENCES school_years(school_year) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: classrooms_students classrooms_students_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: classrooms_students classrooms_students_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY classrooms_students
    ADD CONSTRAINT classrooms_students_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: communication_types communication_types_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communication_types
    ADD CONSTRAINT communication_types_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: communications_media communications_media_fk_communication_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_fk_communication_type FOREIGN KEY (communication_type) REFERENCES communication_types(communication_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: communications_media communications_media_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY communications_media
    ADD CONSTRAINT communications_media_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: conversations conversations_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations
    ADD CONSTRAINT conversations_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student);


--
-- Name: conversations_invites conversations_invites_fk_conversation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_fk_conversation FOREIGN KEY (conversation) REFERENCES conversations(conversation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: conversations_invites conversations_invites_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conversations_invites
    ADD CONSTRAINT conversations_invites_fk_person FOREIGN KEY (invited) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: degrees degrees_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY degrees
    ADD CONSTRAINT degrees_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: delays delays_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: delays delays_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: delays delays_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY delays
    ADD CONSTRAINT delays_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: districts districts_fk_region; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY districts
    ADD CONSTRAINT districts_fk_region FOREIGN KEY (region) REFERENCES regions(region) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: explanations explanations_fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_created_by FOREIGN KEY (created_by) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: explanations explanations_fk_registered_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_registered_by FOREIGN KEY (registered_by) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: explanations explanations_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY explanations
    ADD CONSTRAINT explanations_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: faults faults_fk_lesson; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_fk_lesson FOREIGN KEY (lesson) REFERENCES lessons(lesson) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: faults faults_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY faults
    ADD CONSTRAINT faults_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grade_types grade_types_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grade_types
    ADD CONSTRAINT grade_types_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grades grades_fk_metric; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_fk_metric FOREIGN KEY (metric) REFERENCES metrics(metric) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings grading_meetings_fk_school_year; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings
    ADD CONSTRAINT grading_meetings_fk_school_year FOREIGN KEY (school_year) REFERENCES school_years(school_year) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_grading_meeting; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_grading_meeting FOREIGN KEY (grading_meeting) REFERENCES grading_meetings(grading_meeting) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations grading_meetings_valutations_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations
    ADD CONSTRAINT grading_meetings_valutations_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_grading_meeting_valutation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_grading_meeting_valutation FOREIGN KEY (grading_meeting_valutation) REFERENCES grading_meetings_valutations(grading_meeting_valutation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY grading_meetings_valutations_qua
    ADD CONSTRAINT grading_meetings_valutations_qua_fk_qualification FOREIGN KEY (qualification) REFERENCES qualifications(qualification) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: holidays holidays_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY holidays
    ADD CONSTRAINT holidays_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: leavings leavings_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: leavings leavings_fk_explanation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_explanation FOREIGN KEY (explanation) REFERENCES explanations(explanation) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: leavings leavings_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY leavings
    ADD CONSTRAINT leavings_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lessons lessons_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lessons lessons_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: lessons lessons_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lessons
    ADD CONSTRAINT lessons_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: messages messages_fk_conversation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_fk_conversation FOREIGN KEY (conversation) REFERENCES conversations(conversation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages messages_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: messages_read messages_read_fk_message; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_fk_message FOREIGN KEY (message) REFERENCES messages(message) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages_read messages_read_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY messages_read
    ADD CONSTRAINT messages_read_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: metrics metrics_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metrics
    ADD CONSTRAINT metrics_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notes notes_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notes notes_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_classroom_student FOREIGN KEY (classroom, student) REFERENCES classrooms_students(classroom, student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notes notes_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes
    ADD CONSTRAINT notes_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: notes_signed notes_signed_fk_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_fk_note FOREIGN KEY (note) REFERENCES notes(note) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: notes_signed notes_signed_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notes_signed
    ADD CONSTRAINT notes_signed_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: out_of_classrooms out_of_classrooms_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: out_of_classrooms out_of_classrooms_fk_school_operator; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY out_of_classrooms
    ADD CONSTRAINT out_of_classrooms_fk_school_operator FOREIGN KEY (school_operator) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: parents_meetings parents_meetings_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: parents_meetings parents_meetings_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parents_meetings
    ADD CONSTRAINT parents_meetings_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: persons_addresses persons_addresses_fk_city; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_fk_city FOREIGN KEY (city) REFERENCES cities(city) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: persons_addresses persons_addresses_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_addresses
    ADD CONSTRAINT persons_addresses_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: persons persons_fk_city_of_birth; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_city_of_birth FOREIGN KEY (city_of_birth) REFERENCES cities(city);


--
-- Name: persons persons_fk_country_of_birth; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_country_of_birth FOREIGN KEY (country_of_birth) REFERENCES countries(country);


--
-- Name: persons persons_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: persons persons_fk_usename; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons
    ADD CONSTRAINT persons_fk_usename FOREIGN KEY (usename) REFERENCES usenames_ex(usename) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: persons_relations persons_relations_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: persons_relations persons_relations_fk_person_related_to; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_relations
    ADD CONSTRAINT persons_relations_fk_person_related_to FOREIGN KEY (person_related_to) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: persons_roles persons_roles_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY persons_roles
    ADD CONSTRAINT persons_roles_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: qualifications qualifications_fk_metric; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications
    ADD CONSTRAINT qualifications_fk_metric FOREIGN KEY (metric) REFERENCES metrics(metric) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: qualifications qualifications_fk_qualification_parent; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications
    ADD CONSTRAINT qualifications_fk_qualification_parent FOREIGN KEY (qualification_parent) REFERENCES qualifications(qualification) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: qualifications qualifications_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications
    ADD CONSTRAINT qualifications_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: qualifications_plan qualificationtions_plan_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications_plan
    ADD CONSTRAINT qualificationtions_plan_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: qualifications_plan qualificationtions_plan_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications_plan
    ADD CONSTRAINT qualificationtions_plan_fk_qualification FOREIGN KEY (qualification) REFERENCES qualifications(qualification) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: qualifications_plan qualificationtions_plan_fk_subjects; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY qualifications_plan
    ADD CONSTRAINT qualificationtions_plan_fk_subjects FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: school_years school_years_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY school_years
    ADD CONSTRAINT school_years_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: schools schools_fk_behavior; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schools
    ADD CONSTRAINT schools_fk_behavior FOREIGN KEY (behavior) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: signatures signatures_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: signatures signatures_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatures
    ADD CONSTRAINT signatures_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: subjects subjects_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subjects
    ADD CONSTRAINT subjects_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: teachears_notes teachears_notes_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: teachears_notes teachears_notes_fk_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_student FOREIGN KEY (student) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: teachears_notes teachears_notes_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY teachears_notes
    ADD CONSTRAINT teachears_notes_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: topics topics_fk_degree; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_fk_degree FOREIGN KEY (degree) REFERENCES degrees(degree) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: topics topics_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY topics
    ADD CONSTRAINT topics_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: usenames_schools usenames_schools_fk_school; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usenames_schools
    ADD CONSTRAINT usenames_schools_fk_school FOREIGN KEY (school) REFERENCES schools(school) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: valutations valutations_fk_classroom_student; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_classroom_student FOREIGN KEY (classroom_student) REFERENCES classrooms_students(classroom_student) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: valutations valutations_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: valutations valutations_fk_grade_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_grade_type FOREIGN KEY (grade_type) REFERENCES grade_types(grade_type) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: valutations valutations_fk_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_note FOREIGN KEY (note) REFERENCES notes(note) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: valutations valutations_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person);


--
-- Name: valutations valutations_fk_topic; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations
    ADD CONSTRAINT valutations_fk_topic FOREIGN KEY (topic) REFERENCES topics(topic) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: valutations_qualifications valutations_qualificationtions_fk_grade; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualifications
    ADD CONSTRAINT valutations_qualificationtions_fk_grade FOREIGN KEY (grade) REFERENCES grades(grade) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: valutations_qualifications valutations_qualificationtions_fk_qualification; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualifications
    ADD CONSTRAINT valutations_qualificationtions_fk_qualification FOREIGN KEY (qualification) REFERENCES qualifications(qualification) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: valutations_qualifications valutations_qualificationtions_fk_valutation; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY valutations_qualifications
    ADD CONSTRAINT valutations_qualificationtions_fk_valutation FOREIGN KEY (valutation) REFERENCES valutations(valutation) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: weekly_timetables weekly_timetable_fk_classroom; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables
    ADD CONSTRAINT weekly_timetable_fk_classroom FOREIGN KEY (classroom) REFERENCES classrooms(classroom) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: weekly_timetables_days weekly_timetables_days_fk_subject; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_subject FOREIGN KEY (subject) REFERENCES subjects(subject) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: weekly_timetables_days weekly_timetables_days_fk_teacher; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_teacher FOREIGN KEY (teacher) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: weekly_timetables_days weekly_timetables_days_fk_weekly_timetable; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weekly_timetables_days
    ADD CONSTRAINT weekly_timetables_days_fk_weekly_timetable FOREIGN KEY (weekly_timetable) REFERENCES weekly_timetables(weekly_timetable) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wikimedia_files_persons wikimedia_files_persons_fk_person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_fk_person FOREIGN KEY (person) REFERENCES persons(person) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wikimedia_files_persons wikimedia_files_persons_fk_wikimedia_file; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY wikimedia_files_persons
    ADD CONSTRAINT wikimedia_files_persons_fk_wikimedia_file FOREIGN KEY (wikimedia_file) REFERENCES wikimedia_files(wikimedia_file) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: absences; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE absences ENABLE ROW LEVEL SECURITY;

--
-- Name: absences absences_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY absences_pl_classroom_student ON absences FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: branches; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE branches ENABLE ROW LEVEL SECURITY;

--
-- Name: branches branches_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY branches_pl_school ON branches FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: classrooms; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE classrooms ENABLE ROW LEVEL SECURITY;

--
-- Name: classrooms classrooms_pl_school_year; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY classrooms_pl_school_year ON classrooms FOR ALL TO PUBLIC USING ((school_year IN ( SELECT school_years.school_year
   FROM school_years))) WITH CHECK ((school_year IN ( SELECT school_years.school_year
   FROM school_years)));


--
-- Name: classrooms_students; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE classrooms_students ENABLE ROW LEVEL SECURITY;

--
-- Name: classrooms_students classrooms_students_pl_classroom; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY classrooms_students_pl_classroom ON classrooms_students FOR ALL TO PUBLIC USING ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms))) WITH CHECK ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms)));


--
-- Name: communication_types; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE communication_types ENABLE ROW LEVEL SECURITY;

--
-- Name: communication_types communication_types_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY communication_types_pl_school ON communication_types FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: communications_media; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE communications_media ENABLE ROW LEVEL SECURITY;

--
-- Name: communications_media communications_media_pl_communication_type; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY communications_media_pl_communication_type ON communications_media FOR ALL TO PUBLIC USING ((communication_type IN ( SELECT communication_types.communication_type
   FROM communication_types))) WITH CHECK ((communication_type IN ( SELECT communication_types.communication_type
   FROM communication_types)));


--
-- Name: conversations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE conversations ENABLE ROW LEVEL SECURITY;

--
-- Name: conversations_invites conversations_invites_pl_conversationt; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY conversations_invites_pl_conversationt ON conversations_invites FOR ALL TO PUBLIC USING ((conversation IN ( SELECT conversations.conversation
   FROM conversations))) WITH CHECK ((conversation IN ( SELECT conversations.conversation
   FROM conversations)));


--
-- Name: conversations conversations_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY conversations_pl_classroom_student ON conversations FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: degrees; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE degrees ENABLE ROW LEVEL SECURITY;

--
-- Name: degrees degrees_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY degrees_pl_school ON degrees FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: delays; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE delays ENABLE ROW LEVEL SECURITY;

--
-- Name: delays delays_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY delays_pl_classroom_student ON delays FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: explanations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE explanations ENABLE ROW LEVEL SECURITY;

--
-- Name: explanations explanations_pl_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY explanations_pl_student ON explanations FOR ALL TO PUBLIC USING ((student IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((student IN ( SELECT persons.person
   FROM persons)));


--
-- Name: faults; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE faults ENABLE ROW LEVEL SECURITY;

--
-- Name: faults faults_pl_lessons; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY faults_pl_lessons ON faults FOR ALL TO PUBLIC USING ((lesson IN ( SELECT lessons.lesson
   FROM lessons))) WITH CHECK ((lesson IN ( SELECT lessons.lesson
   FROM lessons)));


--
-- Name: grade_types; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE grade_types ENABLE ROW LEVEL SECURITY;

--
-- Name: grade_types grade_types_pl_subject; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY grade_types_pl_subject ON grade_types FOR ALL TO PUBLIC USING ((subject IN ( SELECT subjects.subject
   FROM subjects))) WITH CHECK ((subject IN ( SELECT subjects.subject
   FROM subjects)));


--
-- Name: grades; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE grades ENABLE ROW LEVEL SECURITY;

--
-- Name: grades grades_pl_metric; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY grades_pl_metric ON grades FOR ALL TO PUBLIC USING ((metric IN ( SELECT metrics.metric
   FROM metrics))) WITH CHECK ((metric IN ( SELECT metrics.metric
   FROM metrics)));


--
-- Name: grading_meetings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE grading_meetings ENABLE ROW LEVEL SECURITY;

--
-- Name: grading_meetings grading_meetings_pl_school_year; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY grading_meetings_pl_school_year ON grading_meetings FOR ALL TO PUBLIC USING ((school_year IN ( SELECT school_years.school_year
   FROM school_years))) WITH CHECK ((school_year IN ( SELECT school_years.school_year
   FROM school_years)));


--
-- Name: grading_meetings_valutations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE grading_meetings_valutations ENABLE ROW LEVEL SECURITY;

--
-- Name: grading_meetings_valutations grading_meetings_valutations_pl_grading_meeting; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY grading_meetings_valutations_pl_grading_meeting ON grading_meetings_valutations FOR ALL TO PUBLIC USING ((grading_meeting IN ( SELECT grading_meetings.grading_meeting
   FROM grading_meetings))) WITH CHECK ((grading_meeting IN ( SELECT grading_meetings.grading_meeting
   FROM grading_meetings)));


--
-- Name: grading_meetings_valutations_qua; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE grading_meetings_valutations_qua ENABLE ROW LEVEL SECURITY;

--
-- Name: grading_meetings_valutations_qua grading_meetings_valutations_qua_pl_grading_meeting_valutation; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY grading_meetings_valutations_qua_pl_grading_meeting_valutation ON grading_meetings_valutations_qua FOR ALL TO PUBLIC USING ((grading_meeting_valutation IN ( SELECT grading_meetings_valutations.grading_meeting_valutation
   FROM grading_meetings_valutations))) WITH CHECK ((grading_meeting_valutation IN ( SELECT grading_meetings_valutations.grading_meeting_valutation
   FROM grading_meetings_valutations)));


--
-- Name: holidays; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE holidays ENABLE ROW LEVEL SECURITY;

--
-- Name: holidays holidays_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY holidays_pl_school ON holidays FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: leavings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE leavings ENABLE ROW LEVEL SECURITY;

--
-- Name: leavings leavings_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY leavings_pl_classroom_student ON leavings FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: lessons; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;

--
-- Name: lessons lessons_pl_classroom; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY lessons_pl_classroom ON lessons FOR ALL TO PUBLIC USING ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms))) WITH CHECK ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms)));


--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

--
-- Name: messages messages_pl_conversation; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY messages_pl_conversation ON messages FOR ALL TO PUBLIC USING ((conversation IN ( SELECT conversations.conversation
   FROM conversations))) WITH CHECK ((conversation IN ( SELECT conversations.conversation
   FROM conversations)));


--
-- Name: messages_read; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE messages_read ENABLE ROW LEVEL SECURITY;

--
-- Name: messages_read messages_read_pl_conversation; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY messages_read_pl_conversation ON messages_read FOR ALL TO PUBLIC USING ((message IN ( SELECT messages.message
   FROM messages))) WITH CHECK ((message IN ( SELECT messages.message
   FROM messages)));


--
-- Name: metrics; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE metrics ENABLE ROW LEVEL SECURITY;

--
-- Name: metrics metrics_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY metrics_pl_school ON metrics FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: notes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE notes ENABLE ROW LEVEL SECURITY;

--
-- Name: notes notes_pl_teacher; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notes_pl_teacher ON notes FOR ALL TO PUBLIC USING ((teacher IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((teacher IN ( SELECT persons.person
   FROM persons)));


--
-- Name: notes_signed; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE notes_signed ENABLE ROW LEVEL SECURITY;

--
-- Name: notes_signed notes_signed_pl_note; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY notes_signed_pl_note ON notes_signed FOR ALL TO PUBLIC USING ((note IN ( SELECT notes.note
   FROM notes))) WITH CHECK ((note IN ( SELECT notes.note
   FROM notes)));


--
-- Name: out_of_classrooms; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE out_of_classrooms ENABLE ROW LEVEL SECURITY;

--
-- Name: out_of_classrooms out_of_classrooms_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY out_of_classrooms_pl_classroom_student ON out_of_classrooms FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: parents_meetings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE parents_meetings ENABLE ROW LEVEL SECURITY;

--
-- Name: parents_meetings parents_meetings_pl_teacher; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY parents_meetings_pl_teacher ON parents_meetings FOR ALL TO PUBLIC USING ((teacher IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((teacher IN ( SELECT persons.person
   FROM persons)));


--
-- Name: persons; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE persons ENABLE ROW LEVEL SECURITY;

--
-- Name: persons_addresses; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE persons_addresses ENABLE ROW LEVEL SECURITY;

--
-- Name: persons_addresses persons_addresses_pl_person; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY persons_addresses_pl_person ON persons_addresses FOR ALL TO PUBLIC USING ((person IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((person IN ( SELECT persons.person
   FROM persons)));


--
-- Name: persons persons_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY persons_pl_school ON persons FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: persons_relations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE persons_relations ENABLE ROW LEVEL SECURITY;

--
-- Name: persons_relations persons_relations_pl_person; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY persons_relations_pl_person ON persons_relations FOR ALL TO PUBLIC USING ((person IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((person IN ( SELECT persons.person
   FROM persons)));


--
-- Name: persons_roles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE persons_roles ENABLE ROW LEVEL SECURITY;

--
-- Name: persons_roles persons_roles_pl_person; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY persons_roles_pl_person ON persons_roles FOR ALL TO PUBLIC USING ((person IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((person IN ( SELECT persons.person
   FROM persons)));


--
-- Name: qualifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE qualifications ENABLE ROW LEVEL SECURITY;

--
-- Name: qualifications qualifications_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY qualifications_pl_school ON qualifications FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: qualifications_plan; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE qualifications_plan ENABLE ROW LEVEL SECURITY;

--
-- Name: qualifications_plan qualifications_plan_pl_qualification; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY qualifications_plan_pl_qualification ON qualifications_plan FOR ALL TO PUBLIC USING ((qualification IN ( SELECT qualifications_plan_1.qualification
   FROM qualifications_plan qualifications_plan_1))) WITH CHECK ((qualification IN ( SELECT qualifications_plan_1.qualification
   FROM qualifications_plan qualifications_plan_1)));


--
-- Name: school_years; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE school_years ENABLE ROW LEVEL SECURITY;

--
-- Name: school_years school_years_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY school_years_pl_school ON school_years FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: schools; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE schools ENABLE ROW LEVEL SECURITY;

--
-- Name: schools schools_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY schools_pl_school ON schools FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: signatures; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE signatures ENABLE ROW LEVEL SECURITY;

--
-- Name: signatures signatures_pl_classroom; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY signatures_pl_classroom ON signatures FOR ALL TO PUBLIC USING ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms))) WITH CHECK ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms)));


--
-- Name: subjects; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;

--
-- Name: subjects subjects_pl_school; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY subjects_pl_school ON subjects FOR ALL TO PUBLIC USING ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools))) WITH CHECK ((school IN ( SELECT usenames_schools.school
   FROM usenames_schools)));


--
-- Name: teachears_notes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE teachears_notes ENABLE ROW LEVEL SECURITY;

--
-- Name: teachears_notes teachears_notes_pl_teacher; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY teachears_notes_pl_teacher ON teachears_notes FOR ALL TO PUBLIC USING ((teacher IN ( SELECT persons.person
   FROM persons))) WITH CHECK ((teacher IN ( SELECT persons.person
   FROM persons)));


--
-- Name: topics; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE topics ENABLE ROW LEVEL SECURITY;

--
-- Name: topics topics_pl_subject; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY topics_pl_subject ON topics FOR ALL TO PUBLIC USING ((subject IN ( SELECT subjects.subject
   FROM subjects))) WITH CHECK ((subject IN ( SELECT subjects.subject
   FROM subjects)));


--
-- Name: usenames_ex; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE usenames_ex ENABLE ROW LEVEL SECURITY;

--
-- Name: usenames_ex usenames_ex_pl_usename; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY usenames_ex_pl_usename ON usenames_ex FOR ALL TO PUBLIC USING ((usename = "current_user"())) WITH CHECK ((usename = "current_user"()));


--
-- Name: usenames_schools; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE usenames_schools ENABLE ROW LEVEL SECURITY;

--
-- Name: usenames_schools usenames_schools_pl_usename; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY usenames_schools_pl_usename ON usenames_schools FOR ALL TO PUBLIC USING ((usename = "current_user"())) WITH CHECK ((usename = "current_user"()));


--
-- Name: valutations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE valutations ENABLE ROW LEVEL SECURITY;

--
-- Name: valutations valutations_pl_classroom_student; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY valutations_pl_classroom_student ON valutations FOR ALL TO PUBLIC USING ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students))) WITH CHECK ((classroom_student IN ( SELECT classrooms_students.classroom_student
   FROM classrooms_students)));


--
-- Name: valutations_qualifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE valutations_qualifications ENABLE ROW LEVEL SECURITY;

--
-- Name: valutations_qualifications valutations_qualifications_pl_valutation; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY valutations_qualifications_pl_valutation ON valutations_qualifications FOR ALL TO PUBLIC USING ((valutation IN ( SELECT valutations.valutation
   FROM valutations))) WITH CHECK ((valutation IN ( SELECT valutations.valutation
   FROM valutations)));


--
-- Name: weekly_timetables; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE weekly_timetables ENABLE ROW LEVEL SECURITY;

--
-- Name: weekly_timetables_days; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE weekly_timetables_days ENABLE ROW LEVEL SECURITY;

--
-- Name: weekly_timetables_days weekly_timetables_days_pl_weekly_timetable; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY weekly_timetables_days_pl_weekly_timetable ON weekly_timetables_days FOR ALL TO PUBLIC USING ((weekly_timetable IN ( SELECT weekly_timetables.weekly_timetable
   FROM weekly_timetables))) WITH CHECK ((weekly_timetable IN ( SELECT weekly_timetables.weekly_timetable
   FROM weekly_timetables)));


--
-- Name: weekly_timetables weekly_timetables_pl_classroom; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY weekly_timetables_pl_classroom ON weekly_timetables FOR ALL TO PUBLIC USING ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms))) WITH CHECK ((classroom IN ( SELECT classrooms.classroom
   FROM classrooms)));


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO scuola247_executive;
GRANT ALL ON SCHEMA public TO scuola247_relative;
GRANT USAGE ON SCHEMA public TO postgrest;


--
-- Name: address_type; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE address_type FROM PUBLIC;
GRANT ALL ON TYPE address_type TO scuola247_executive;


--
-- Name: course_year; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE course_year FROM PUBLIC;
GRANT ALL ON TYPE course_year TO scuola247_executive;


--
-- Name: explanation_type; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE explanation_type FROM PUBLIC;
GRANT ALL ON TYPE explanation_type TO scuola247_executive;


--
-- Name: geographical_area; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE geographical_area FROM PUBLIC;
GRANT ALL ON TYPE geographical_area TO scuola247_executive;


--
-- Name: language; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE language FROM PUBLIC;
GRANT ALL ON TYPE language TO scuola247_executive;


--
-- Name: marital_status; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE marital_status FROM PUBLIC;
GRANT ALL ON TYPE marital_status TO scuola247_executive;


--
-- Name: period_lesson; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE period_lesson FROM PUBLIC;
GRANT ALL ON TYPE period_lesson TO scuola247_executive;


--
-- Name: qualificationtion_types; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE qualificationtion_types FROM PUBLIC;
GRANT ALL ON TYPE qualificationtion_types TO scuola247_executive;


--
-- Name: relationships; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE relationships FROM PUBLIC;
GRANT ALL ON TYPE relationships TO scuola247_executive;


--
-- Name: role; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE role FROM PUBLIC;
GRANT ALL ON TYPE role TO scuola247_executive;


--
-- Name: sex; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE sex FROM PUBLIC;
GRANT ALL ON TYPE sex TO scuola247_executive;


--
-- Name: week; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TYPE week FROM PUBLIC;
GRANT ALL ON TYPE week TO scuola247_executive;


--
-- Name: pk_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE pk_seq TO scuola247_executive;


--
-- Name: schools; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE schools FROM postgres;
GRANT SELECT ON TABLE schools TO postgrest;
GRANT SELECT ON TABLE schools TO scuola247_relative;
GRANT SELECT,UPDATE ON TABLE schools TO scuola247_executive;


--
-- Name: schools_enabled(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION schools_enabled() TO scuola247_relative;


--
-- Name: absences; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences TO scuola247_executive;
GRANT SELECT ON TABLE absences TO postgrest;


--
-- Name: classrooms_students; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_students TO postgrest;


--
-- Name: absences_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_grp TO scuola247_executive;
GRANT SELECT ON TABLE absences_grp TO postgrest;


--
-- Name: absences_not_explanated_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_not_explanated_grp TO scuola247_executive;
GRANT SELECT ON TABLE absences_not_explanated_grp TO postgrest;


--
-- Name: cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE cities TO scuola247_executive;
GRANT SELECT ON TABLE cities TO postgrest;


--
-- Name: delays; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays TO scuola247_executive;
GRANT SELECT ON TABLE delays TO postgrest;


--
-- Name: delays_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_grp TO scuola247_executive;
GRANT SELECT ON TABLE delays_grp TO postgrest;


--
-- Name: delays_not_explained_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_not_explained_grp TO scuola247_executive;
GRANT SELECT ON TABLE delays_not_explained_grp TO postgrest;


--
-- Name: leavings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings TO scuola247_executive;
GRANT SELECT ON TABLE leavings TO postgrest;


--
-- Name: leavings_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_grp TO scuola247_executive;
GRANT SELECT ON TABLE leavings_grp TO postgrest;


--
-- Name: leavings_not_explained_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_not_explained_grp TO scuola247_executive;
GRANT SELECT ON TABLE leavings_not_explained_grp TO postgrest;


--
-- Name: notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes TO scuola247_executive;
GRANT SELECT ON TABLE notes TO postgrest;


--
-- Name: notes_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_grp TO scuola247_executive;
GRANT SELECT ON TABLE notes_grp TO postgrest;


--
-- Name: out_of_classrooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms TO scuola247_executive;
GRANT SELECT ON TABLE out_of_classrooms TO postgrest;


--
-- Name: out_of_classrooms_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_grp TO scuola247_executive;
GRANT SELECT ON TABLE out_of_classrooms_grp TO postgrest;


--
-- Name: persons; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE persons TO postgrest;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE persons TO scuola247_executive;
GRANT SELECT,UPDATE ON TABLE persons TO scuola247_relative;


--
-- Name: classrooms_students_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students_ex TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_students_ex TO postgrest;


--
-- Name: branches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE branches TO scuola247_executive;
GRANT SELECT ON TABLE branches TO postgrest;


--
-- Name: classrooms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms TO scuola247_executive;
GRANT SELECT ON TABLE classrooms TO postgrest;


--
-- Name: school_years; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE school_years TO scuola247_executive;
GRANT SELECT ON TABLE school_years TO postgrest;


--
-- Name: subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE subjects TO scuola247_executive;
GRANT SELECT ON TABLE subjects TO postgrest;


--
-- Name: valutations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations TO scuola247_executive;
GRANT SELECT ON TABLE valutations TO postgrest;


--
-- Name: classrooms_teachers_subjects_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_subjects_ex TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_teachers_subjects_ex TO postgrest;


--
-- Name: classrooms_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_ex TO scuola247_relative;
GRANT SELECT ON TABLE classrooms_ex TO postgrest;
GRANT ALL ON TABLE classrooms_ex TO scuola247_executive;


--
-- Name: weekly_timetables; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetables TO scuola247_executive;
GRANT SELECT ON TABLE weekly_timetables TO postgrest;


--
-- Name: weekly_timetables_days; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetables_days TO scuola247_executive;
GRANT SELECT ON TABLE weekly_timetables_days TO postgrest;


--
-- Name: weekly_timetables_days_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetables_days_ex TO scuola247_executive;
GRANT SELECT ON TABLE weekly_timetables_days_ex TO postgrest;


--
-- Name: weekly_timetable_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetable_ex TO scuola247_executive;
GRANT SELECT ON TABLE weekly_timetable_ex TO postgrest;


--
-- Name: districts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE districts TO scuola247_executive;
GRANT SELECT ON TABLE districts TO postgrest;


--
-- Name: grade_types_by_subject(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION grade_types_by_subject(p_subject bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION grade_types_by_subject(p_subject bigint) TO scuola247_relative;


--
-- Name: persons_sel_thumbnail(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION persons_sel_thumbnail(_person bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION persons_sel_thumbnail(_person bigint) TO scuola247_relative;


--
-- Name: regions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE regions TO scuola247_executive;
GRANT SELECT ON TABLE regions TO postgrest;


--
-- Name: schools_ins(character varying, character varying, character varying, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_ins(OUT _rv bigint, OUT _school bigint, _description character varying, _processing_code character varying, _mnemonic character varying, _example boolean) TO scuola247_relative;


--
-- Name: schools_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_sel(OUT _rv bigint, _school bigint, OUT _description character varying, OUT _processing_code character varying, OUT _mnemonic character varying, OUT _example boolean, OUT _behavior bigint, OUT _logo_mime_type mime_type_image, OUT _logo_content bytea) TO scuola247_relative;


--
-- Name: schools_sel_logo(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION schools_sel_logo(_school bigint, OUT _logo image) FROM PUBLIC;
GRANT ALL ON FUNCTION schools_sel_logo(_school bigint, OUT _logo image) TO scuola247_relative;


--
-- Name: subjects_list(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_list(p_school bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_list(p_school bigint) TO scuola247_relative;


--
-- Name: subjects_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION subjects_sel(OUT p_rv bigint, p_subject bigint, OUT p_school bigint, OUT p_description character varying) TO scuola247_relative;


--
-- Name: topics_ins_rid(bigint, character varying, bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_ins_rid(OUT _rv bigint, OUT _topic bigint, _subject bigint, _description character varying, _classroom bigint) TO scuola247_relative;


--
-- Name: topics_upd_rid(bigint, bigint, character varying); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION topics_upd_rid(_rv bigint, _topic bigint, _description character varying) FROM PUBLIC;
GRANT ALL ON FUNCTION topics_upd_rid(_rv bigint, _topic bigint, _description character varying) TO scuola247_relative;


--
-- Name: tr_absences_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_absences_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_absences_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_absences_iu() TO scuola247_relative;


--
-- Name: tr_classrooms_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classrooms_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_classrooms_iu() TO scuola247_relative;


--
-- Name: tr_classrooms_students_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_classrooms_students_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_classrooms_students_iu() TO scuola247_relative;


--
-- Name: tr_communications_media_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_communications_media_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_communications_media_iu() TO scuola247_relative;


--
-- Name: tr_conversations_invites_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_conversations_invites_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_conversations_invites_iu() TO scuola247_relative;


--
-- Name: tr_delays_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_delays_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_delays_iu() TO scuola247_relative;


--
-- Name: tr_explanations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_explanations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_explanations_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_explanations_iu() TO scuola247_relative;


--
-- Name: tr_faults_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_faults_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_faults_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_faults_iu() TO scuola247_relative;


--
-- Name: tr_grading_meetings_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_iu() TO scuola247_relative;


--
-- Name: tr_grading_meetings_valutations_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_d() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_d() TO scuola247_relative;


--
-- Name: tr_grading_meetings_valutations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_iu() TO scuola247_relative;


--
-- Name: tr_grading_meetings_valutations_qua_d(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_qua_d() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_qua_d() TO scuola247_relative;


--
-- Name: tr_grading_meetings_valutations_qua_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_grading_meetings_valutations_qua_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_grading_meetings_valutations_qua_iu() TO scuola247_relative;


--
-- Name: tr_leavings_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_leavings_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_leavings_iu() TO scuola247_relative;


--
-- Name: tr_lessons_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_lessons_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_lessons_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_lessons_iu() TO scuola247_relative;


--
-- Name: tr_messages_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messages_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_messages_iu() TO scuola247_relative;


--
-- Name: tr_messages_read_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_messages_read_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_messages_read_iu() TO scuola247_relative;


--
-- Name: tr_notes_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_notes_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_notes_iu() TO scuola247_relative;


--
-- Name: tr_notes_signed_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_notes_signed_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_notes_signed_iu() TO scuola247_relative;


--
-- Name: tr_out_of_classrooms_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_out_of_classrooms_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_out_of_classrooms_iu() TO scuola247_relative;


--
-- Name: tr_parents_meetings_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_parents_meetings_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_parents_meetings_iu() TO scuola247_relative;


--
-- Name: tr_schools_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_schools_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_schools_iu() TO scuola247_relative;


--
-- Name: tr_signatures_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_signatures_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_signatures_iu() TO scuola247_executive;
GRANT ALL ON FUNCTION tr_signatures_iu() TO scuola247_relative;


--
-- Name: tr_teachears_notes_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_teachears_notes_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_teachears_notes_iu() TO scuola247_relative;


--
-- Name: tr_topics_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_topics_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_topics_iu() TO scuola247_relative;


--
-- Name: tr_usename_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_usename_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_usename_iu() TO scuola247_relative;


--
-- Name: tr_valutations_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutations_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_valutations_iu() TO scuola247_relative;


--
-- Name: tr_valutations_qualifications_iu(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION tr_valutations_qualifications_iu() FROM PUBLIC;
GRANT ALL ON FUNCTION tr_valutations_qualifications_iu() TO scuola247_relative;


--
-- Name: valutations_ins_note(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_ins_note(OUT _rv bigint, OUT _note bigint, _valutation bigint) TO scuola247_relative;


--
-- Name: valutations_sel(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_sel(OUT p_rv bigint, p_valutation bigint, OUT p_evaluation character varying, OUT p_private boolean, OUT p_note boolean) TO scuola247_relative;


--
-- Name: valutations_upd(bigint, bigint, character varying, boolean, boolean); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean) FROM PUBLIC;
GRANT ALL ON FUNCTION valutations_upd(_rv bigint, _valutation bigint, _evaluation character varying, _private boolean, _note boolean) TO scuola247_relative;


--
-- Name: w_classrooms_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classrooms_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_classrooms_ex() TO scuola247_relative;


--
-- Name: w_classrooms_students_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_classrooms_students_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_classrooms_students_ex() TO scuola247_relative;


--
-- Name: w_weekly_timetable_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_weekly_timetable_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_weekly_timetable_ex() TO scuola247_relative;


--
-- Name: w_weekly_timetables_days_ex(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION w_weekly_timetables_days_ex() FROM PUBLIC;
GRANT ALL ON FUNCTION w_weekly_timetables_days_ex() TO scuola247_relative;


--
-- Name: weekly_timetable_xt_subject(bigint); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) FROM PUBLIC;
GRANT ALL ON FUNCTION weekly_timetable_xt_subject(p_weekly_timetable bigint) TO scuola247_relative;


--
-- Name: topics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE topics TO scuola247_executive;
GRANT SELECT ON TABLE topics TO postgrest;


--
-- Name: absences_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_certified_grp TO scuola247_executive;
GRANT SELECT ON TABLE absences_certified_grp TO postgrest;


--
-- Name: explanations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE explanations TO scuola247_executive;
GRANT SELECT ON TABLE explanations TO postgrest;


--
-- Name: absences_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_ex TO scuola247_executive;
GRANT SELECT ON TABLE absences_ex TO postgrest;


--
-- Name: absences_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE absences_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE absences_month_grp TO postgrest;


--
-- Name: persons_addresses; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE persons_addresses TO scuola247_executive;
GRANT SELECT ON TABLE persons_addresses TO postgrest;


--
-- Name: classrooms_students_addresses_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_students_addresses_ex TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_students_addresses_ex TO postgrest;


--
-- Name: lessons; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons TO scuola247_executive;
GRANT SELECT ON TABLE lessons TO postgrest;


--
-- Name: classrooms_teachers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_teachers TO postgrest;


--
-- Name: delays_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_certified_grp TO scuola247_executive;
GRANT SELECT ON TABLE delays_certified_grp TO postgrest;


--
-- Name: leavings_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_certified_grp TO scuola247_executive;
GRANT SELECT ON TABLE leavings_certified_grp TO postgrest;


--
-- Name: lessons_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_grp TO scuola247_executive;
GRANT SELECT ON TABLE lessons_grp TO postgrest;


--
-- Name: notes_iussed_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_iussed_grp TO scuola247_executive;
GRANT SELECT ON TABLE notes_iussed_grp TO postgrest;


--
-- Name: out_of_classrooms_certified_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_certified_grp TO scuola247_executive;
GRANT SELECT ON TABLE out_of_classrooms_certified_grp TO postgrest;


--
-- Name: signatures; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures TO scuola247_executive;
GRANT SELECT ON TABLE signatures TO postgrest;


--
-- Name: signatures_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures_grp TO scuola247_executive;
GRANT SELECT ON TABLE signatures_grp TO postgrest;


--
-- Name: classrooms_teachers_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_ex TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_teachers_ex TO postgrest;


--
-- Name: classrooms_teachers_subject; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classrooms_teachers_subject TO scuola247_executive;
GRANT SELECT ON TABLE classrooms_teachers_subject TO postgrest;


--
-- Name: parents_meetings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE parents_meetings TO scuola247_executive;
GRANT SELECT ON TABLE parents_meetings TO postgrest;


--
-- Name: conversations_invites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE conversations_invites TO scuola247_executive;
GRANT SELECT ON TABLE conversations_invites TO postgrest;


--
-- Name: signatures_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE signatures_ex TO scuola247_executive;
GRANT SELECT ON TABLE signatures_ex TO postgrest;


--
-- Name: out_of_classrooms_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_ex TO scuola247_executive;
GRANT SELECT ON TABLE out_of_classrooms_ex TO postgrest;


--
-- Name: out_of_classrooms_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE out_of_classrooms_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE out_of_classrooms_month_grp TO postgrest;


--
-- Name: schools_school_years_classrooms_weekly_timetable; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE schools_school_years_classrooms_weekly_timetable TO scuola247_executive;
GRANT SELECT ON TABLE schools_school_years_classrooms_weekly_timetable TO postgrest;


--
-- Name: lessons_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_ex TO scuola247_executive;
GRANT SELECT ON TABLE lessons_ex TO postgrest;


--
-- Name: lessons_days; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE lessons_days TO scuola247_executive;
GRANT SELECT ON TABLE lessons_days TO postgrest;


--
-- Name: faults; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE faults TO scuola247_executive;
GRANT SELECT ON TABLE faults TO postgrest;


--
-- Name: faults_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE faults_grp TO scuola247_executive;
GRANT SELECT ON TABLE faults_grp TO postgrest;


--
-- Name: countries; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE countries TO scuola247_executive;
GRANT SELECT ON TABLE countries TO postgrest;


--
-- Name: teachears_notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachears_notes TO scuola247_executive;
GRANT SELECT ON TABLE teachears_notes TO postgrest;


--
-- Name: notes_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_ex TO scuola247_executive;
GRANT SELECT ON TABLE notes_ex TO postgrest;


--
-- Name: notes_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE notes_month_grp TO postgrest;


--
-- Name: notes_signed; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_signed TO scuola247_executive;
GRANT SELECT ON TABLE notes_signed TO postgrest;


--
-- Name: notes_signed_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE notes_signed_ex TO scuola247_executive;
GRANT SELECT ON TABLE notes_signed_ex TO postgrest;


--
-- Name: persons_relations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE persons_relations TO scuola247_executive;
GRANT SELECT ON TABLE persons_relations TO postgrest;


--
-- Name: persons_roles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE persons_roles TO postgrest;


--
-- Name: qualifications_plan; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE qualifications_plan TO scuola247_executive;
GRANT SELECT ON TABLE qualifications_plan TO postgrest;


--
-- Name: qualifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE qualifications TO scuola247_executive;
GRANT SELECT ON TABLE qualifications TO postgrest;


--
-- Name: delays_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE delays_month_grp TO postgrest;


--
-- Name: leavings_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE leavings_month_grp TO postgrest;


--
-- Name: classbooks_month_grp; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE classbooks_month_grp TO scuola247_executive;
GRANT SELECT ON TABLE classbooks_month_grp TO postgrest;


--
-- Name: residence_grp_city; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE residence_grp_city TO scuola247_executive;
GRANT SELECT ON TABLE residence_grp_city TO postgrest;


--
-- Name: delays_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE delays_ex TO scuola247_executive;
GRANT SELECT ON TABLE delays_ex TO postgrest;


--
-- Name: grading_meetings_valutations_qua; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings_valutations_qua TO scuola247_executive;
GRANT SELECT ON TABLE grading_meetings_valutations_qua TO postgrest;


--
-- Name: communication_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE communication_types TO scuola247_executive;
GRANT SELECT ON TABLE communication_types TO postgrest;


--
-- Name: grade_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grade_types TO scuola247_executive;
GRANT SELECT ON TABLE grade_types TO postgrest;


--
-- Name: leavings_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE leavings_ex TO scuola247_executive;
GRANT SELECT ON TABLE leavings_ex TO postgrest;


--
-- Name: usenames_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE usenames_ex TO scuola247_executive;
GRANT SELECT ON TABLE usenames_ex TO postgrest;


--
-- Name: usenames_schools; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE usenames_schools TO scuola247_user;
GRANT ALL ON TABLE usenames_schools TO postgrest;


--
-- Name: holidays; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE holidays TO scuola247_executive;
GRANT SELECT ON TABLE holidays TO postgrest;


--
-- Name: grades; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grades TO scuola247_executive;
GRANT SELECT ON TABLE grades TO postgrest;


--
-- Name: metrics; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE metrics TO scuola247_executive;
GRANT SELECT ON TABLE metrics TO postgrest;


--
-- Name: valutations_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_ex TO scuola247_executive;
GRANT SELECT ON TABLE valutations_ex TO postgrest;


--
-- Name: valutations_references; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_references TO scuola247_executive;
GRANT SELECT ON TABLE valutations_references TO postgrest;


--
-- Name: valutations_ex_references; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_ex_references TO scuola247_executive;
GRANT SELECT ON TABLE valutations_ex_references TO postgrest;


--
-- Name: valutations_qualifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_qualifications TO scuola247_executive;
GRANT SELECT ON TABLE valutations_qualifications TO postgrest;


--
-- Name: valutations_stats_classrooms_students_subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects TO scuola247_executive;
GRANT SELECT ON TABLE valutations_stats_classrooms_students_subjects TO postgrest;


--
-- Name: valutations_stats_classrooms_subjects; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_subjects TO scuola247_executive;
GRANT SELECT ON TABLE valutations_stats_classrooms_subjects TO postgrest;


--
-- Name: valutations_stats_classrooms_subjects_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_subjects_ex TO scuola247_executive;
GRANT SELECT ON TABLE valutations_stats_classrooms_subjects_ex TO postgrest;


--
-- Name: wikimedia_files; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE wikimedia_files TO postgrest;


--
-- Name: wikimedia_files_persons; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE wikimedia_files_persons TO postgrest;


--
-- Name: wikimedia_license_infos; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE wikimedia_license_infos TO postgrest;


--
-- Name: absences_certified_grp_mat; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE absences_certified_grp_mat TO postgrest;


--
-- Name: communications_media; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE communications_media TO scuola247_executive;
GRANT SELECT ON TABLE communications_media TO postgrest;


--
-- Name: conversations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE conversations TO scuola247_executive;
GRANT SELECT ON TABLE conversations TO postgrest;


--
-- Name: degrees; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE degrees TO scuola247_executive;
GRANT SELECT ON TABLE degrees TO postgrest;


--
-- Name: grading_meetings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings TO scuola247_executive;
GRANT SELECT ON TABLE grading_meetings TO postgrest;


--
-- Name: grading_meetings_valutations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE grading_meetings_valutations TO scuola247_executive;
GRANT SELECT ON TABLE grading_meetings_valutations TO postgrest;


--
-- Name: messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE messages TO scuola247_executive;
GRANT SELECT ON TABLE messages TO postgrest;


--
-- Name: messages_read; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE messages_read TO scuola247_executive;
GRANT SELECT ON TABLE messages_read TO postgrest;


--
-- Name: teachers_classbooks_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachers_classbooks_ex TO scuola247_executive;
GRANT SELECT ON TABLE teachers_classbooks_ex TO postgrest;


--
-- Name: teachers_lessons_signatures_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE teachers_lessons_signatures_ex TO scuola247_executive;
GRANT SELECT ON TABLE teachers_lessons_signatures_ex TO postgrest;


--
-- Name: usenames_rolnames; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE usenames_rolnames TO scuola247_executive;
GRANT SELECT ON TABLE usenames_rolnames TO postgrest;


--
-- Name: valutations_stats_classrooms_students_subjects_on_date; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects_on_date TO scuola247_executive;
GRANT SELECT ON TABLE valutations_stats_classrooms_students_subjects_on_date TO postgrest;


--
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE valutations_stats_classrooms_students_subjects_on_date_ex TO scuola247_executive;
GRANT SELECT ON TABLE valutations_stats_classrooms_students_subjects_on_date_ex TO postgrest;


--
-- Name: valutations_stats_classrooms_students_subjects_on_date_ex_mat; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE valutations_stats_classrooms_students_subjects_on_date_ex_mat TO postgrest;


--
-- Name: weekly_timetable_teachers_ex; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE weekly_timetable_teachers_ex TO scuola247_executive;
GRANT SELECT ON TABLE weekly_timetable_teachers_ex TO postgrest;

