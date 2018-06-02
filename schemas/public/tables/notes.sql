-- Table: public.notes

-- DROP TABLE public.notes;

CREATE TABLE public.notes
(
  note bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  student bigint, -- The student with these notes
  description character varying(2048) NOT NULL, -- The description of the note
  teacher bigint NOT NULL, -- The teacher that insert this note
  disciplinary boolean NOT NULL, -- Indicates that the annotation is of disciplinary type so it will be reported at school_record for the view signature of a parent....
  on_date date NOT NULL, -- Note insert on date
  at_time time without time zone NOT NULL, -- When the note was insert
  to_approve boolean NOT NULL DEFAULT false, -- Indicates that is requested the check from the student (if adult) or from someone that have the paternity authorition and have requested to be warned....
  classroom bigint NOT NULL, -- Indicates if the note is for all the classroom
  CONSTRAINT notes_pk PRIMARY KEY (note),
  CONSTRAINT notes_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT notes_fk_classroom_student FOREIGN KEY (classroom, student)
      REFERENCES public.classrooms_students (classroom, student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT notes_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time),
  CONSTRAINT notes_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT notes_ck_to_approve CHECK (disciplinary = false AND to_approve = false OR disciplinary = false AND to_approve = true OR disciplinary = true AND to_approve = true) -- Se è una note disciplinary allat_time deve essere richiesto il visto
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.notes
  OWNER TO postgres;
GRANT ALL ON TABLE public.notes TO postgres;
GRANT ALL ON TABLE public.notes TO scuola247_executive;
GRANT SELECT ON TABLE public.notes TO postgrest;
COMMENT ON COLUMN public.notes.note IS 'Unique identification code for the row';
COMMENT ON COLUMN public.notes.student IS 'The student with these notes';
COMMENT ON COLUMN public.notes.description IS 'The description of the note';
COMMENT ON COLUMN public.notes.teacher IS 'The teacher that insert this note';
COMMENT ON COLUMN public.notes.disciplinary IS 'Indicates that the annotation is of disciplinary type so it will be reported at school_record for the view signature of a parent.
The annotation is for all the classroom unless it isn''t indicated a single student.
If it''s needed to do a disciplinary note (also normal) to two or more students is necessary to insert the note for everyone.';
COMMENT ON COLUMN public.notes.on_date IS 'Note insert on date';
COMMENT ON COLUMN public.notes.at_time IS 'When the note was insert';
COMMENT ON COLUMN public.notes.to_approve IS 'Indicates that is requested the check from the student (if adult) or from someone that have the paternity authorition and have requested to be warned.
If it isn''t specified the check has to be requested for all the class, but if the note is disciplinary and is missing the student, the check will be requested only for present students';
COMMENT ON COLUMN public.notes.classroom IS 'Indicates if the note is for all the classroom';

COMMENT ON CONSTRAINT notes_ck_to_approve ON public.notes IS 'Se è una note disciplinary allat_time deve essere richiesto il visto';


-- Index: public.notes_fx_classroom

-- DROP INDEX public.notes_fx_classroom;

CREATE INDEX notes_fx_classroom
  ON public.notes
  USING btree
  (classroom);

-- Index: public.notes_fx_classroom_student

-- DROP INDEX public.notes_fx_classroom_student;

CREATE INDEX notes_fx_classroom_student
  ON public.notes
  USING btree
  (classroom, student);

-- Index: public.notes_fx_teacher

-- DROP INDEX public.notes_fx_teacher;

CREATE INDEX notes_fx_teacher
  ON public.notes
  USING btree
  (teacher);
COMMENT ON INDEX public.notes_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: notes_iu on public.notes

-- DROP TRIGGER notes_iu ON public.notes;

CREATE TRIGGER notes_iu
  AFTER INSERT OR UPDATE
  ON public.notes
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_notes_iu();

