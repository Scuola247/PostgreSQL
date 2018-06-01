-- Table: public.school_years

-- DROP TABLE public.school_years;

CREATE TABLE public.school_years
(
  school_year bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- School
  description character varying(160) NOT NULL, -- The description for the school year
  duration daterange, -- The duration for the school year
  lessons_duration daterange, -- The duration of the lessons
  CONSTRAINT school_years_pk PRIMARY KEY (school_year),
  CONSTRAINT school_years_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT school_years_ex_duration EXCLUDE 
  USING gist (school WITH =, duration WITH &&), -- in the same school we cannot have duration overlap
  CONSTRAINT school_years_uq_description UNIQUE (school, description), -- La description deve essere univoca all'interno di un school
  CONSTRAINT school_years_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT school_years_ck_duration CHECK (duration @> lessons_duration)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.school_years
  OWNER TO postgres;
GRANT ALL ON TABLE public.school_years TO postgres;
GRANT ALL ON TABLE public.school_years TO scuola247_executive;
GRANT SELECT ON TABLE public.school_years TO postgrest;
COMMENT ON TABLE public.school_years
  IS 'Rapreseant the school year and it''s separated by schools';
COMMENT ON COLUMN public.school_years.school_year IS 'Unique identification code for the row';
COMMENT ON COLUMN public.school_years.school IS 'School';
COMMENT ON COLUMN public.school_years.description IS 'The description for the school year';
COMMENT ON COLUMN public.school_years.duration IS 'The duration for the school year';
COMMENT ON COLUMN public.school_years.lessons_duration IS 'The duration of the lessons';

COMMENT ON CONSTRAINT school_years_ex_duration ON public.school_years IS 'in the same school we cannot have duration overlap';
COMMENT ON CONSTRAINT school_years_uq_description ON public.school_years IS 'La description deve essere univoca all''interno di un school';


-- Index: public.school_years_fx_school

-- DROP INDEX public.school_years_fx_school;

CREATE INDEX school_years_fx_school
  ON public.school_years
  USING btree
  (school);

