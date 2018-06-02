-- Table: public.subjects

-- DROP TABLE public.subjects;

CREATE TABLE public.subjects
(
  subject bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- The school with these subjects
  description character varying(160) NOT NULL, -- The description of a subject
  CONSTRAINT subjects_pk PRIMARY KEY (subject),
  CONSTRAINT subjects_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT subjects_uq_description UNIQUE (school, description),
  CONSTRAINT subjects_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.subjects
  OWNER TO postgres;
GRANT ALL ON TABLE public.subjects TO postgres;
GRANT ALL ON TABLE public.subjects TO scuola247_executive;
GRANT SELECT ON TABLE public.subjects TO postgrest;
COMMENT ON TABLE public.subjects
  IS 'Contains subjects for every school';
COMMENT ON COLUMN public.subjects.subject IS 'Unique identification code for the row';
COMMENT ON COLUMN public.subjects.school IS 'The school with these subjects';
COMMENT ON COLUMN public.subjects.description IS 'The description of a subject';


-- Index: public.subjects_fx_school

-- DROP INDEX public.subjects_fx_school;

CREATE INDEX subjects_fx_school
  ON public.subjects
  USING btree
  (school);
COMMENT ON INDEX public.subjects_fx_school
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

