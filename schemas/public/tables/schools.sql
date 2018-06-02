-- Table: public.schools

-- DROP TABLE public.schools;

CREATE TABLE public.schools
(
  school bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Uniquely identifies the table row
  description character varying(160) NOT NULL, -- Description for the school
  processing_code character varying(160) NOT NULL, -- A code that identify the school on the government information system
  mnemonic character varying(30) NOT NULL, -- Short description to be use as code
  example boolean NOT NULL DEFAULT false, -- It indicates that the data have been inserted to be an example of the use of the data base
  behavior bigint, -- Indicates the subject used for the behavior
  logo image, -- Picture to be used as a logo
  CONSTRAINT schools_pk PRIMARY KEY (school),
  CONSTRAINT schools_fk_behavior FOREIGN KEY (behavior)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT schools_uq_description UNIQUE (description),
  CONSTRAINT schools_uq_mnemonic UNIQUE (mnemonic),
  CONSTRAINT schools_uq_processing_code UNIQUE (processing_code, example),
  CONSTRAINT schools_min_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT schools_min_mnemonic CHECK (length(btrim(mnemonic::text)) > 0),
  CONSTRAINT schools_min_processing_code CHECK (length(btrim(processing_code::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.schools
  OWNER TO postgres;
GRANT SELECT ON TABLE public.schools TO postgrest;
GRANT SELECT ON TABLE public.schools TO scuola247_relative;
GRANT SELECT, UPDATE ON TABLE public.schools TO scuola247_executive;
COMMENT ON TABLE public.schools
  IS 'An institution for the instruction of children or people under college age';
COMMENT ON COLUMN public.schools.school IS 'Uniquely identifies the table row';
COMMENT ON COLUMN public.schools.description IS 'Description for the school';
COMMENT ON COLUMN public.schools.processing_code IS 'A code that identify the school on the government information system';
COMMENT ON COLUMN public.schools.mnemonic IS 'Short description to be use as code';
COMMENT ON COLUMN public.schools.example IS 'It indicates that the data have been inserted to be an example of the use of the data base';
COMMENT ON COLUMN public.schools.behavior IS 'Indicates the subject used for the behavior';
COMMENT ON COLUMN public.schools.logo IS 'Picture to be used as a logo';


-- Index: public.schools_fk_behavior

-- DROP INDEX public.schools_fk_behavior;

CREATE INDEX schools_fk_behavior
  ON public.schools
  USING btree
  (behavior);


-- Trigger: schools_iu on public.schools

-- DROP TRIGGER schools_iu ON public.schools;

CREATE TRIGGER schools_iu
  AFTER INSERT OR UPDATE
  ON public.schools
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_schools_iu();

