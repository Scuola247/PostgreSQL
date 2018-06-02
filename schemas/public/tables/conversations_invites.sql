-- Table: public.conversations_invites

-- DROP TABLE public.conversations_invites;

CREATE TABLE public.conversations_invites
(
  conversation_invite bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  conversation bigint NOT NULL, -- The conversation that has these invites
  invited bigint NOT NULL, -- Check if is invited
  CONSTRAINT conversations_invites_pk PRIMARY KEY (conversation_invite),
  CONSTRAINT conversations_invites_fk_conversation FOREIGN KEY (conversation)
      REFERENCES public.conversations (conversation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT conversations_invites_fk_person FOREIGN KEY (invited)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT conversations_invites_uq_invited UNIQUE (conversation, invited) -- It's not possible in a given conversation to invite the same person many times.
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.conversations_invites
  OWNER TO postgres;
GRANT ALL ON TABLE public.conversations_invites TO postgres;
GRANT ALL ON TABLE public.conversations_invites TO scuola247_executive;
GRANT SELECT ON TABLE public.conversations_invites TO postgrest;
COMMENT ON TABLE public.conversations_invites
  IS 'Defines the guests at the conversation, the persons able to view and participate to a certain conversation.';
COMMENT ON COLUMN public.conversations_invites.conversation_invite IS 'Unique identification code for the row';
COMMENT ON COLUMN public.conversations_invites.conversation IS 'The conversation that has these invites';
COMMENT ON COLUMN public.conversations_invites.invited IS 'Check if is invited';

COMMENT ON CONSTRAINT conversations_invites_uq_invited ON public.conversations_invites IS 'It''s not possible in a given conversation to invite the same person many times.';


-- Index: public.conversations_partecipanti_fx_conversation

-- DROP INDEX public.conversations_partecipanti_fx_conversation;

CREATE INDEX conversations_partecipanti_fx_conversation
  ON public.conversations_invites
  USING btree
  (conversation);

-- Index: public.conversations_partecipanti_fx_partecipante

-- DROP INDEX public.conversations_partecipanti_fx_partecipante;

CREATE INDEX conversations_partecipanti_fx_partecipante
  ON public.conversations_invites
  USING btree
  (invited);


-- Trigger: conversations_invites_iu on public.conversations_invites

-- DROP TRIGGER conversations_invites_iu ON public.conversations_invites;

CREATE TRIGGER conversations_invites_iu
  AFTER INSERT OR UPDATE
  ON public.conversations_invites
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_conversations_invites_iu();

