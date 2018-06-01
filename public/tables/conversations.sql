-- Table: public.conversations

-- DROP TABLE public.conversations;

CREATE TABLE public.conversations
(
  conversation bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  classroom_student bigint NOT NULL, -- Reference to the classroom_students table.
  subject character varying(160) NOT NULL, -- subject for the conversation
  confidential boolean NOT NULL DEFAULT false, -- States that the conversation has to be viewed by the participants and from the school insiders. Furthermore it's not included in the personal school_record.
  begin_on timestamp without time zone DEFAULT now(), -- When the conversation start
  end_on timestamp without time zone, -- When a conversation ends, it's not longer possible to add or edit messages.
  CONSTRAINT conversations_pk PRIMARY KEY (conversation),
  CONSTRAINT conversations_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT conversations_ck_end_on CHECK (end_on >= begin_on),
  CONSTRAINT conversations_ck_subject CHECK (length(btrim(subject::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.conversations
  OWNER TO postgres;
GRANT ALL ON TABLE public.conversations TO postgres;
GRANT ALL ON TABLE public.conversations TO scuola247_executive;
GRANT SELECT ON TABLE public.conversations TO postgrest;
COMMENT ON COLUMN public.conversations.conversation IS 'Unique identification code for the row';
COMMENT ON COLUMN public.conversations.classroom_student IS 'Reference to the classroom_students table.';
COMMENT ON COLUMN public.conversations.subject IS 'subject for the conversation';
COMMENT ON COLUMN public.conversations.confidential IS 'States that the conversation has to be viewed by the participants and from the school insiders. Furthermore it''s not included in the personal school_record.';
COMMENT ON COLUMN public.conversations.begin_on IS 'When the conversation start';
COMMENT ON COLUMN public.conversations.end_on IS 'When a conversation ends, it''s not longer possible to add or edit messages.';


-- Index: public.conversations_fx_school_record

-- DROP INDEX public.conversations_fx_school_record;

CREATE INDEX conversations_fx_school_record
  ON public.conversations
  USING btree
  (classroom_student);
COMMENT ON INDEX public.conversations_fx_school_record
  IS 'Index to access the relative foreign key.';

