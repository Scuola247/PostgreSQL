-- Table: public.wikimedia_files

-- DROP TABLE public.wikimedia_files;

CREATE TABLE public.wikimedia_files
(
  name text NOT NULL, -- The name of wikimedia file
  type wikimedia_type NOT NULL, -- The type of the file
  wikimedia_file bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  info xml, -- Contains all the meta data in xml format like the api of wikimedia
  photo bytea, -- Photo from wikimedia
  thumbnail bytea, -- The thumbnail from wikimedia
  CONSTRAINT wikimedia_files_pk PRIMARY KEY (wikimedia_file),
  CONSTRAINT wikimedia_files_name CHECK (length(btrim(name)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.wikimedia_files
  OWNER TO postgres;
GRANT ALL ON TABLE public.wikimedia_files TO postgres;
GRANT SELECT ON TABLE public.wikimedia_files TO postgrest;
COMMENT ON TABLE public.wikimedia_files
  IS 'files from wikimedia commons';
COMMENT ON COLUMN public.wikimedia_files.name IS 'The name of wikimedia file';
COMMENT ON COLUMN public.wikimedia_files.type IS 'The type of the file';
COMMENT ON COLUMN public.wikimedia_files.wikimedia_file IS 'Unique identification code for the row';
COMMENT ON COLUMN public.wikimedia_files.info IS 'Contains all the meta data in xml format like the api of wikimedia';
COMMENT ON COLUMN public.wikimedia_files.photo IS 'Photo from wikimedia';
COMMENT ON COLUMN public.wikimedia_files.thumbnail IS 'The thumbnail from wikimedia';

