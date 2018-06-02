-- Table: public.communications_media

-- DROP TABLE public.communications_media;

CREATE TABLE public.communications_media
(
  communication_media bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  person bigint NOT NULL, -- Person for the communication media
  communication_type bigint NOT NULL, -- Communication type for the communications
  description character varying(160), -- The description for the communication media
  uri character varying(255) NOT NULL, -- The uri for the media
  notification boolean NOT NULL DEFAULT false, -- It states whether to use the notifications, only if the communication allows it.
  CONSTRAINT communications_media_pk PRIMARY KEY (communication_media),
  CONSTRAINT communications_media_fk_communication_type FOREIGN KEY (communication_type)
      REFERENCES public.communication_types (communication_type) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT communications_media_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT communications_media_uq_description UNIQUE (person, communication_type, description),
  CONSTRAINT communications_media_uq_uri UNIQUE (person, communication_type, uri),
  CONSTRAINT communications_media_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT communications_media_ck_uri CHECK (length(btrim(uri::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.communications_media
  OWNER TO postgres;
GRANT ALL ON TABLE public.communications_media TO postgres;
GRANT ALL ON TABLE public.communications_media TO scuola247_executive;
GRANT SELECT ON TABLE public.communications_media TO postgrest;
COMMENT ON COLUMN public.communications_media.communication_media IS 'Unique identification code for the row';
COMMENT ON COLUMN public.communications_media.person IS 'Person for the communication media';
COMMENT ON COLUMN public.communications_media.communication_type IS 'Communication type for the communications';
COMMENT ON COLUMN public.communications_media.description IS 'The description for the communication media';
COMMENT ON COLUMN public.communications_media.uri IS 'The uri for the media';
COMMENT ON COLUMN public.communications_media.notification IS 'It states whether to use the notifications, only if the communication allows it.';


-- Index: public.communications_media_ix_communication_type

-- DROP INDEX public.communications_media_ix_communication_type;

CREATE INDEX communications_media_ix_communication_type
  ON public.communications_media
  USING btree
  (communication_type);
COMMENT ON INDEX public.communications_media_ix_communication_type
  IS 'Index to access the relative foreign key.';

-- Index: public.communications_media_ix_person

-- DROP INDEX public.communications_media_ix_person;

CREATE INDEX communications_media_ix_person
  ON public.communications_media
  USING btree
  (person);
COMMENT ON INDEX public.communications_media_ix_person
  IS 'Index to access the relative foreign key.';


-- Trigger: communications_media_iu on public.communications_media

-- DROP TRIGGER communications_media_iu ON public.communications_media;

CREATE TRIGGER communications_media_iu
  AFTER INSERT OR UPDATE
  ON public.communications_media
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_communications_media_iu();

