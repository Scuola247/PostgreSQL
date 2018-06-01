-- Table: public.persons_roles

-- DROP TABLE public.persons_roles;

CREATE TABLE public.persons_roles
(
  person_role bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  person bigint NOT NULL, -- The person with these roles
  role role NOT NULL, -- The role of a person
  CONSTRAINT persons_roles_pk PRIMARY KEY (person_role),
  CONSTRAINT persons_roles_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT persons_roles_uq_person UNIQUE (person, role)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.persons_roles
  OWNER TO postgres;
GRANT ALL ON TABLE public.persons_roles TO postgres;
GRANT SELECT ON TABLE public.persons_roles TO postgrest;
COMMENT ON TABLE public.persons_roles
  IS 'Contains the list of person with their role';
COMMENT ON COLUMN public.persons_roles.person_role IS 'Unique identification code for the row';
COMMENT ON COLUMN public.persons_roles.person IS 'The person with these roles';
COMMENT ON COLUMN public.persons_roles.role IS 'The role of a person';


-- Index: public.idx_persons_roles

-- DROP INDEX public.idx_persons_roles;

CREATE INDEX idx_persons_roles
  ON public.persons_roles
  USING btree
  (person);

