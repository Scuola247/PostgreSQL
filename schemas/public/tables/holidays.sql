-- Table: public.holidays

-- DROP TABLE public.holidays;

CREATE TABLE public.holidays
(
  holiday bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- School with these holidays
  on_date date NOT NULL, -- Start for holidays
  description character varying(160), -- Description for the holidays
  CONSTRAINT holidays_pk PRIMARY KEY (holiday),
  CONSTRAINT holidays_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT holidays_uq_on_date UNIQUE (school, on_date), -- Nello stesso school ogni on_date deve essere indicato to_time massimo una volta
  CONSTRAINT holidays_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.holidays
  OWNER TO postgres;
GRANT ALL ON TABLE public.holidays TO postgres;
GRANT ALL ON TABLE public.holidays TO scuola247_executive;
GRANT SELECT ON TABLE public.holidays TO postgrest;
COMMENT ON TABLE public.holidays
  IS 'Contains all holidays for every school';
COMMENT ON COLUMN public.holidays.holiday IS 'Unique identification code for the row';
COMMENT ON COLUMN public.holidays.school IS 'School with these holidays';
COMMENT ON COLUMN public.holidays.on_date IS 'Start for holidays';
COMMENT ON COLUMN public.holidays.description IS 'Description for the holidays';

COMMENT ON CONSTRAINT holidays_uq_on_date ON public.holidays IS 'Nello stesso school ogni on_date deve essere indicato to_time massimo una volta';


-- Index: public.holidays_fx_school

-- DROP INDEX public.holidays_fx_school;

CREATE INDEX holidays_fx_school
  ON public.holidays
  USING btree
  (school);
COMMENT ON INDEX public.holidays_fx_school
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

