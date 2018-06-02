-- Table: public.messages_read

-- DROP TABLE public.messages_read;

CREATE TABLE public.messages_read
(
  message_read bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  message bigint NOT NULL, -- Message to read
  person bigint NOT NULL, -- The person that rode the message
  read_on timestamp without time zone, -- Date when the message has been red
  CONSTRAINT messages_read_pk PRIMARY KEY (message_read),
  CONSTRAINT messages_read_fk_message FOREIGN KEY (message)
      REFERENCES public.messages (message) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT messages_read_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT messages_read_uq_read_on UNIQUE (message, person) -- L'indicazione di quando è stato letto un message è univoco per ogni messagio e person (from_time) che lo ha letto
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.messages_read
  OWNER TO postgres;
GRANT ALL ON TABLE public.messages_read TO postgres;
GRANT ALL ON TABLE public.messages_read TO scuola247_executive;
GRANT SELECT ON TABLE public.messages_read TO postgrest;
COMMENT ON COLUMN public.messages_read.message_read IS 'Unique identification code for the row';
COMMENT ON COLUMN public.messages_read.message IS 'Message to read';
COMMENT ON COLUMN public.messages_read.person IS 'The person that rode the message';
COMMENT ON COLUMN public.messages_read.read_on IS 'Date when the message has been red';

COMMENT ON CONSTRAINT messages_read_uq_read_on ON public.messages_read IS 'L''indicazione di quando è stato letto un message è univoco per ogni messagio e person (from_time) che lo ha letto';


-- Index: public.libretti_messages_read_fx_person

-- DROP INDEX public.libretti_messages_read_fx_person;

CREATE INDEX libretti_messages_read_fx_person
  ON public.messages_read
  USING btree
  (person);
COMMENT ON INDEX public.libretti_messages_read_fx_person
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.libretti_messages_read_fx_school_record_mess

-- DROP INDEX public.libretti_messages_read_fx_school_record_mess;

CREATE INDEX libretti_messages_read_fx_school_record_mess
  ON public.messages_read
  USING btree
  (message);
COMMENT ON INDEX public.libretti_messages_read_fx_school_record_mess
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: messages_read_iu on public.messages_read

-- DROP TRIGGER messages_read_iu ON public.messages_read;

CREATE TRIGGER messages_read_iu
  AFTER INSERT OR UPDATE
  ON public.messages_read
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_messages_read_iu();

