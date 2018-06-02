-- Table: public.grades

-- DROP TABLE public.grades;

CREATE TABLE public.grades
(
  grade bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  metric bigint NOT NULL, -- Metric for the grades
  description character varying(160) NOT NULL, -- The description for the grade
  thousandths smallint NOT NULL, -- Indicates the weight in thousandths for that grade. Its value allows to compare different metrics
  mnemonic character varying(3) NOT NULL, -- A mnemonic for the grade
  CONSTRAINT grades_pk PRIMARY KEY (grade),
  CONSTRAINT grades_fk_metric FOREIGN KEY (metric)
      REFERENCES public.metrics (metric) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grades_uq_description UNIQUE (metric, description),
  CONSTRAINT grades_uq_mnemonic UNIQUE (metric, mnemonic),
  CONSTRAINT grades_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT grades_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.grades
  OWNER TO postgres;
GRANT ALL ON TABLE public.grades TO postgres;
GRANT ALL ON TABLE public.grades TO scuola247_executive;
GRANT SELECT ON TABLE public.grades TO postgrest;
COMMENT ON TABLE public.grades
  IS 'For each metric here we have the possible grades';
COMMENT ON COLUMN public.grades.grade IS 'Unique identification code for the row';
COMMENT ON COLUMN public.grades.metric IS 'Metric for the grades';
COMMENT ON COLUMN public.grades.description IS 'The description for the grade';
COMMENT ON COLUMN public.grades.thousandths IS 'Indicates the weight in thousandths for that grade. Its value allows to compare different metrics';
COMMENT ON COLUMN public.grades.mnemonic IS 'A mnemonic for the grade';


-- Index: public.grades_fx_metric

-- DROP INDEX public.grades_fx_metric;

CREATE INDEX grades_fx_metric
  ON public.grades
  USING btree
  (metric);
COMMENT ON INDEX public.grades_fx_metric
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

