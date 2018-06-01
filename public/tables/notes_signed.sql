-- Table: public.notes_signed

-- DROP TABLE public.notes_signed;

CREATE TABLE public.notes_signed
(
  note_signed bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  person bigint NOT NULL, -- Persons that have to check the notes
  on_date timestamp without time zone, -- Date that indicates when the note has been checked
  note bigint NOT NULL, -- identification column for the table notes
  CONSTRAINT notes_signed_pk PRIMARY KEY (note_signed),
  CONSTRAINT notes_signed_fk_note FOREIGN KEY (note)
      REFERENCES public.notes (note) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT notes_signed_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT notes_signed_uq_note_person UNIQUE (note, person)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.notes_signed
  OWNER TO postgres;
GRANT ALL ON TABLE public.notes_signed TO postgres;
GRANT ALL ON TABLE public.notes_signed TO scuola247_executive;
GRANT SELECT ON TABLE public.notes_signed TO postgrest;
COMMENT ON COLUMN public.notes_signed.note_signed IS 'Unique identification code for the row';
COMMENT ON COLUMN public.notes_signed.person IS 'Persons that have to check the notes';
COMMENT ON COLUMN public.notes_signed.on_date IS 'Date that indicates when the note has been checked';
COMMENT ON COLUMN public.notes_signed.note IS 'identification column for the table notes';


-- Index: public.notes_signed_fx_note

-- DROP INDEX public.notes_signed_fx_note;

CREATE INDEX notes_signed_fx_note
  ON public.notes_signed
  USING btree
  (note);

-- Index: public.notes_signed_fx_person

-- DROP INDEX public.notes_signed_fx_person;

CREATE INDEX notes_signed_fx_person
  ON public.notes_signed
  USING btree
  (person);


-- Trigger: notes_signed_iu on public.notes_signed

-- DROP TRIGGER notes_signed_iu ON public.notes_signed;

CREATE TRIGGER notes_signed_iu
  AFTER INSERT OR UPDATE
  ON public.notes_signed
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_notes_signed_iu();

