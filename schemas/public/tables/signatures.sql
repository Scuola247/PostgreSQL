-- Table: public.signatures

-- DROP TABLE public.signatures;

CREATE TABLE public.signatures
(
  signature bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  classroom bigint NOT NULL, -- The classroom of the student
  teacher bigint NOT NULL, -- The teacher that did that signature
  on_date date NOT NULL, -- Date of the signature
  at_time time without time zone, -- When the signature was insert
  CONSTRAINT signatures_pk PRIMARY KEY (signature),
  CONSTRAINT signatures_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT signatures_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT signatures_uq_classroom UNIQUE (classroom, teacher, on_date, at_time) -- Un teacher non può signaturere più di una volta nello stesso on_date e  nella stessa at_time (indipendentemente from_timela classroom)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.signatures
  OWNER TO postgres;
GRANT ALL ON TABLE public.signatures TO postgres;
GRANT ALL ON TABLE public.signatures TO scuola247_executive;
GRANT SELECT ON TABLE public.signatures TO postgrest;
COMMENT ON TABLE public.signatures
  IS 'Contains info of the signature for every teacher';
COMMENT ON COLUMN public.signatures.signature IS 'Unique identification code for the row';
COMMENT ON COLUMN public.signatures.classroom IS 'The classroom of the student';
COMMENT ON COLUMN public.signatures.teacher IS 'The teacher that did that signature';
COMMENT ON COLUMN public.signatures.on_date IS 'Date of the signature';
COMMENT ON COLUMN public.signatures.at_time IS 'When the signature was insert';

COMMENT ON CONSTRAINT signatures_uq_classroom ON public.signatures IS 'Un teacher non può signaturere più di una volta nello stesso on_date e  nella stessa at_time (indipendentemente from_timela classroom)';


-- Index: public.signatures_fx_classroom

-- DROP INDEX public.signatures_fx_classroom;

CREATE INDEX signatures_fx_classroom
  ON public.signatures
  USING btree
  (classroom);
COMMENT ON INDEX public.signatures_fx_classroom
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.signatures_fx_teacher

-- DROP INDEX public.signatures_fx_teacher;

CREATE INDEX signatures_fx_teacher
  ON public.signatures
  USING btree
  (teacher);
COMMENT ON INDEX public.signatures_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: signatures_iu on public.signatures

-- DROP TRIGGER signatures_iu ON public.signatures;

CREATE TRIGGER signatures_iu
  AFTER INSERT OR UPDATE
  ON public.signatures
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_signatures_iu();

