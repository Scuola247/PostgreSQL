-- Table: public.qualifications

-- DROP TABLE public.qualifications;

CREATE TABLE public.qualifications
(
  qualification bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- The school for the qualifications
  name character varying(160) NOT NULL, -- The name of the qualification
  description character varying(4000) NOT NULL, -- Description of the qualification
  metric bigint NOT NULL, -- The metric used for the qualifications
  type qualificationtion_types NOT NULL, -- The type for these qualifications
  qualification_parent bigint, -- It's needed for create the qualification tree, in this coloumn will be indicated the family dependency
  CONSTRAINT qualifications_pk PRIMARY KEY (qualification),
  CONSTRAINT qualifications_fk_metric FOREIGN KEY (metric)
      REFERENCES public.metrics (metric) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT qualifications_fk_qualification_parent FOREIGN KEY (qualification_parent)
      REFERENCES public.qualifications (qualification) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT qualifications_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT qualifications_uq_name UNIQUE (school, name),
  CONSTRAINT qualifications_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT qualifications_ck_name CHECK (length(btrim(name::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.qualifications
  OWNER TO postgres;
GRANT ALL ON TABLE public.qualifications TO postgres;
GRANT ALL ON TABLE public.qualifications TO scuola247_executive;
GRANT SELECT ON TABLE public.qualifications TO postgrest;
COMMENT ON TABLE public.qualifications
  IS 'Describes for single school the knowledges, competences and skills.
Adding all in only a table it''s duplicated the term qualification to be generic compared to declicountry that can have: Expertise, knowledge, skills';
COMMENT ON COLUMN public.qualifications.qualification IS 'Unique identification code for the row';
COMMENT ON COLUMN public.qualifications.school IS 'The school for the qualifications';
COMMENT ON COLUMN public.qualifications.name IS 'The name of the qualification';
COMMENT ON COLUMN public.qualifications.description IS 'Description of the qualification';
COMMENT ON COLUMN public.qualifications.metric IS 'The metric used for the qualifications';
COMMENT ON COLUMN public.qualifications.type IS 'The type for these qualifications';
COMMENT ON COLUMN public.qualifications.qualification_parent IS 'It''s needed for create the qualification tree, in this coloumn will be indicated the family dependency';


-- Index: public.qualificationtions_fx_metric

-- DROP INDEX public.qualificationtions_fx_metric;

CREATE INDEX qualificationtions_fx_metric
  ON public.qualifications
  USING btree
  (metric);
COMMENT ON INDEX public.qualificationtions_fx_metric
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.qualificationtions_fx_riferimento

-- DROP INDEX public.qualificationtions_fx_riferimento;

CREATE INDEX qualificationtions_fx_riferimento
  ON public.qualifications
  USING btree
  (qualification_parent);

-- Index: public.qualificationtions_fx_school

-- DROP INDEX public.qualificationtions_fx_school;

CREATE INDEX qualificationtions_fx_school
  ON public.qualifications
  USING btree
  (school);
COMMENT ON INDEX public.qualificationtions_fx_school
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

