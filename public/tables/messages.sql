-- Table: public.messages

-- DROP TABLE public.messages;

CREATE TABLE public.messages
(
  message bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  conversation bigint NOT NULL, -- Conversation
  written_on timestamp without time zone NOT NULL DEFAULT now(), -- Date when the message was written
  message_text character varying(2048) NOT NULL, -- The text of the message
  person bigint NOT NULL, -- La person fisica che ha scritto il message
  CONSTRAINT messages_pk PRIMARY KEY (message),
  CONSTRAINT messages_fk_conversation FOREIGN KEY (conversation)
      REFERENCES public.conversations (conversation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT messages_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT messages_uq_from_time UNIQUE (conversation, person, written_on),
  CONSTRAINT messages_ck_message_text CHECK (length(btrim(message_text::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.messages
  OWNER TO postgres;
GRANT ALL ON TABLE public.messages TO postgres;
GRANT ALL ON TABLE public.messages TO scuola247_executive;
GRANT SELECT ON TABLE public.messages TO postgrest;
COMMENT ON COLUMN public.messages.message IS 'Unique identification code for the row';
COMMENT ON COLUMN public.messages.conversation IS 'Conversation';
COMMENT ON COLUMN public.messages.written_on IS 'Date when the message was written';
COMMENT ON COLUMN public.messages.message_text IS 'The text of the message';
COMMENT ON COLUMN public.messages.person IS 'La person fisica che ha scritto il message';


-- Index: public.messages_fx_conversation

-- DROP INDEX public.messages_fx_conversation;

CREATE INDEX messages_fx_conversation
  ON public.messages
  USING btree
  (conversation);
COMMENT ON INDEX public.messages_fx_conversation
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.messages_fx_from_time

-- DROP INDEX public.messages_fx_from_time;

CREATE INDEX messages_fx_from_time
  ON public.messages
  USING btree
  (person);
COMMENT ON INDEX public.messages_fx_from_time
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: messages_iu on public.messages

-- DROP TRIGGER messages_iu ON public.messages;

CREATE TRIGGER messages_iu
  AFTER INSERT OR UPDATE
  ON public.messages
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_messages_iu();

