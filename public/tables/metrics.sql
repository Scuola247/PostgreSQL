-- Table: public.metrics

-- DROP TABLE public.metrics;

CREATE TABLE public.metrics
(
  metric bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- School with these metrics
  description character varying(160) NOT NULL, -- The description for the metrics
  sufficiency smallint NOT NULL DEFAULT 600, -- Indicates the value to reach the sufficiency
  CONSTRAINT metrics_pk PRIMARY KEY (metric),
  CONSTRAINT metrics_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT metrics_uq_description UNIQUE (school, description),
  CONSTRAINT metrics_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.metrics
  OWNER TO postgres;
GRANT ALL ON TABLE public.metrics TO postgres;
GRANT ALL ON TABLE public.metrics TO scuola247_executive;
GRANT SELECT ON TABLE public.metrics TO postgrest;
COMMENT ON COLUMN public.metrics.metric IS 'Unique identification code for the row';
COMMENT ON COLUMN public.metrics.school IS 'School with these metrics';
COMMENT ON COLUMN public.metrics.description IS 'The description for the metrics';
COMMENT ON COLUMN public.metrics.sufficiency IS 'Indicates the value to reach the sufficiency';


-- Index: public.metrics_fx_school

-- DROP INDEX public.metrics_fx_school;

CREATE INDEX metrics_fx_school
  ON public.metrics
  USING btree
  (school);
COMMENT ON INDEX public.metrics_fx_school
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

