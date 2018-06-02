-- Table: public.usenames_schools

-- DROP TABLE public.usenames_schools;

CREATE TABLE public.usenames_schools
(
  usename_school bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  usename name NOT NULL, -- The session's usename
  school bigint NOT NULL, -- School enabled for the the usename
  CONSTRAINT usenames_schools_pk PRIMARY KEY (usename_school),
  CONSTRAINT usenames_schools_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT usenames_schools_uq_usename_school UNIQUE (usename, school), -- Foe every usename one school can be enabled only one time
  CONSTRAINT usenames_schools_ck_usename CHECK (length(btrim(usename::text)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.usenames_schools
  OWNER TO postgres;
GRANT ALL ON TABLE public.usenames_schools TO postgres;
GRANT SELECT ON TABLE public.usenames_schools TO scuola247_user;
GRANT ALL ON TABLE public.usenames_schools TO postgrest;
COMMENT ON TABLE public.usenames_schools
  IS 'record schools accessible to the user';
COMMENT ON COLUMN public.usenames_schools.usename_school IS 'Unique identification code for the row';
COMMENT ON COLUMN public.usenames_schools.usename IS 'The session''s usename';
COMMENT ON COLUMN public.usenames_schools.school IS 'School enabled for the the usename';

COMMENT ON CONSTRAINT usenames_schools_uq_usename_school ON public.usenames_schools IS 'Foe every usename one school can be enabled only one time';


-- Index: public.usenames_schools_fx_school

-- DROP INDEX public.usenames_schools_fx_school;

CREATE INDEX usenames_schools_fx_school
  ON public.usenames_schools
  USING btree
  (school);
COMMENT ON INDEX public.usenames_schools_fx_school
  IS 'for using by usenames_ex_schools_fk_school';


-- Trigger: usenames_schools_iu on public.usenames_schools

-- DROP TRIGGER usenames_schools_iu ON public.usenames_schools;

CREATE TRIGGER usenames_schools_iu
  AFTER INSERT OR UPDATE
  ON public.usenames_schools
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_usename_iu();

