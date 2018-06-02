-- Table: public.wikimedia_files_persons

-- DROP TABLE public.wikimedia_files_persons;

CREATE TABLE public.wikimedia_files_persons
(
  wikimedia_file_person bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- The file of the person
  wikimedia_file bigint NOT NULL, -- File from wikimedia
  person bigint NOT NULL, -- The person of the wikimedia file
  CONSTRAINT wikimedia_files_persons_pk PRIMARY KEY (wikimedia_file_person),
  CONSTRAINT wikimedia_files_persons_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT wikimedia_files_persons_fk_wikimedia_file FOREIGN KEY (wikimedia_file)
      REFERENCES public.wikimedia_files (wikimedia_file) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT wikimedia_files_persons_uq_wikimedia_file_person UNIQUE (wikimedia_file, person)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.wikimedia_files_persons
  OWNER TO postgres;
GRANT ALL ON TABLE public.wikimedia_files_persons TO postgres;
GRANT SELECT ON TABLE public.wikimedia_files_persons TO postgrest;
COMMENT ON TABLE public.wikimedia_files_persons
  IS 'files from wikimedia commons for person';
COMMENT ON COLUMN public.wikimedia_files_persons.wikimedia_file_person IS 'The file of the person';
COMMENT ON COLUMN public.wikimedia_files_persons.wikimedia_file IS 'File from wikimedia';
COMMENT ON COLUMN public.wikimedia_files_persons.person IS 'The person of the wikimedia file';


-- Index: public.wikimedia_files_persons_fx_person

-- DROP INDEX public.wikimedia_files_persons_fx_person;

CREATE INDEX wikimedia_files_persons_fx_person
  ON public.wikimedia_files_persons
  USING btree
  (person);

-- Index: public.wikimedia_files_persons_fx_wikimedia_file

-- DROP INDEX public.wikimedia_files_persons_fx_wikimedia_file;

CREATE INDEX wikimedia_files_persons_fx_wikimedia_file
  ON public.wikimedia_files_persons
  USING btree
  (wikimedia_file);

