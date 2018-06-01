-- Table: public.degrees

-- DROP TABLE public.degrees;

CREATE TABLE public.degrees
(
  degree bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- The school with these degrees
  description character varying(160) NOT NULL, -- The description of the degree
  course_years course_year NOT NULL, -- Years of the course, e.g 5 for the elementary schools, 3 for the middle schools, 5 for the high schools
  CONSTRAINT degrees_pk PRIMARY KEY (degree),
  CONSTRAINT degrees_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT degrees_uq_description UNIQUE (school, description),
  CONSTRAINT degrees_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.degrees
  OWNER TO postgres;
GRANT ALL ON TABLE public.degrees TO postgres;
GRANT ALL ON TABLE public.degrees TO scuola247_executive;
GRANT SELECT ON TABLE public.degrees TO postgrest;
COMMENT ON COLUMN public.degrees.degree IS 'Unique identification code for the row';
COMMENT ON COLUMN public.degrees.school IS 'The school with these degrees';
COMMENT ON COLUMN public.degrees.description IS 'The description of the degree';
COMMENT ON COLUMN public.degrees.course_years IS 'Years of the course, e.g 5 for the elementary schools, 3 for the middle schools, 5 for the high schools';


-- Index: public.degrees_fx_school

-- DROP INDEX public.degrees_fx_school;

CREATE INDEX degrees_fx_school
  ON public.degrees
  USING btree
  (school);
COMMENT ON INDEX public.degrees_fx_school
  IS 'Index to access the relative foreign key.';

