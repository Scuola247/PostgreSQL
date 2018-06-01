-- Table: public.branches

-- DROP TABLE public.branches;

CREATE TABLE public.branches
(
  branch bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school bigint NOT NULL, -- School for branches
  description character varying(160) NOT NULL, -- The description for the branch
  CONSTRAINT branches_pk PRIMARY KEY (branch),
  CONSTRAINT branches_fk_schools FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT branches_uq_description UNIQUE (school, description),
  CONSTRAINT branches_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.branches
  OWNER TO postgres;
GRANT ALL ON TABLE public.branches TO postgres;
GRANT ALL ON TABLE public.branches TO scuola247_executive;
GRANT SELECT ON TABLE public.branches TO postgrest;
COMMENT ON TABLE public.branches
  IS 'Contains branches for every school';
COMMENT ON COLUMN public.branches.branch IS 'Unique identification code for the row';
COMMENT ON COLUMN public.branches.school IS 'School for branches';
COMMENT ON COLUMN public.branches.description IS 'The description for the branch';


-- Index: public.branches_fx_school

-- DROP INDEX public.branches_fx_school;

CREATE INDEX branches_fx_school
  ON public.branches
  USING btree
  (school);

