-- Table: public.classrooms

-- DROP TABLE public.classrooms;

CREATE TABLE public.classrooms
(
  classroom bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school_year bigint NOT NULL, -- The school year for these classrooms
  degree bigint NOT NULL, -- Indicates the degree of a classroom
  section character varying(5), -- The section of the classroom
  course_year course_year NOT NULL, -- The course year of the classroom
  description character varying(160) NOT NULL, -- Description for the classroom
  branch bigint NOT NULL, -- The branch of the class
  CONSTRAINT classrooms_pk PRIMARY KEY (classroom),
  CONSTRAINT classrooms_fk_branch FOREIGN KEY (branch)
      REFERENCES public.branches (branch) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT classrooms_fk_degree FOREIGN KEY (degree)
      REFERENCES public.degrees (degree) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT classrooms_fk_school_year FOREIGN KEY (school_year)
      REFERENCES public.school_years (school_year) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT classrooms_uq_classroom UNIQUE (school_year, branch, degree, section, course_year),
  CONSTRAINT classrooms_uq_description UNIQUE (school_year, description),
  CONSTRAINT classrooms_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT classrooms_ck_section CHECK (length(btrim(section::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.classrooms
  OWNER TO postgres;
GRANT ALL ON TABLE public.classrooms TO postgres;
GRANT ALL ON TABLE public.classrooms TO scuola247_executive;
GRANT SELECT ON TABLE public.classrooms TO postgrest;
COMMENT ON TABLE public.classrooms
  IS 'Contains all classrooms for every school';
COMMENT ON COLUMN public.classrooms.classroom IS 'Unique identification code for the row';
COMMENT ON COLUMN public.classrooms.school_year IS 'The school year for these classrooms';
COMMENT ON COLUMN public.classrooms.degree IS 'Indicates the degree of a classroom';
COMMENT ON COLUMN public.classrooms.section IS 'The section of the classroom';
COMMENT ON COLUMN public.classrooms.course_year IS 'The course year of the classroom';
COMMENT ON COLUMN public.classrooms.description IS 'Description for the classroom';
COMMENT ON COLUMN public.classrooms.branch IS 'The branch of the class';


-- Index: public.classrooms_fx_branch

-- DROP INDEX public.classrooms_fx_branch;

CREATE INDEX classrooms_fx_branch
  ON public.classrooms
  USING btree
  (branch);

-- Index: public.classrooms_fx_degree

-- DROP INDEX public.classrooms_fx_degree;

CREATE INDEX classrooms_fx_degree
  ON public.classrooms
  USING btree
  (degree);
COMMENT ON INDEX public.classrooms_fx_degree
  IS 'Index to access the relative foreign key.';

-- Index: public.classrooms_fx_school_year

-- DROP INDEX public.classrooms_fx_school_year;

CREATE INDEX classrooms_fx_school_year
  ON public.classrooms
  USING btree
  (school_year);
COMMENT ON INDEX public.classrooms_fx_school_year
  IS 'Index to access the relative foreign key.';


-- Trigger: classrooms_iu on public.classrooms

-- DROP TRIGGER classrooms_iu ON public.classrooms;

CREATE TRIGGER classrooms_iu
  AFTER INSERT OR UPDATE
  ON public.classrooms
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_classrooms_iu();

