-- Table: public.grade_types

-- DROP TABLE public.grade_types;

CREATE TABLE public.grade_types
(
  grade_type bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  description character varying(60) NOT NULL, -- The description
  subject bigint NOT NULL, -- The subject with these grade types
  mnemonic character varying(3), -- The mnemonic of the grade type
  CONSTRAINT grade_types_pk PRIMARY KEY (grade_type),
  CONSTRAINT grade_types_fk_subject FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grade_types_uq_mnemonic UNIQUE (subject, mnemonic),
  CONSTRAINT tipi_grades_uq_description UNIQUE (subject, description),
  CONSTRAINT grade_types_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT grade_types_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.grade_types
  OWNER TO postgres;
GRANT ALL ON TABLE public.grade_types TO postgres;
GRANT ALL ON TABLE public.grade_types TO scuola247_executive;
GRANT SELECT ON TABLE public.grade_types TO postgrest;
COMMENT ON TABLE public.grade_types
  IS 'The marks has to been grouped by mark type.
Example: `Oral` or `Written` ';
COMMENT ON COLUMN public.grade_types.grade_type IS 'Unique identification code for the row';
COMMENT ON COLUMN public.grade_types.description IS 'The description';
COMMENT ON COLUMN public.grade_types.subject IS 'The subject with these grade types';
COMMENT ON COLUMN public.grade_types.mnemonic IS 'The mnemonic of the grade type';


-- Index: public.grade_types_fx_subject

-- DROP INDEX public.grade_types_fx_subject;

CREATE INDEX grade_types_fx_subject
  ON public.grade_types
  USING btree
  (subject);

