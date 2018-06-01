-- Table: public.teachears_notes

-- DROP TABLE public.teachears_notes;

CREATE TABLE public.teachears_notes
(
  teacher_notes bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- The teacher notes
  student bigint, -- The student with this note
  description character varying(2048) NOT NULL, -- Description for the note
  teacher bigint NOT NULL, -- Teacher that insert the note
  on_date date NOT NULL, -- When the note has been added
  at_time time without time zone, -- When the teacher insert the note
  classroom bigint NOT NULL, -- Classroom for the teacher notes
  CONSTRAINT teachears_notes_pk PRIMARY KEY (teacher_notes),
  CONSTRAINT teachears_notes_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT teachears_notes_fk_student FOREIGN KEY (student)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT teachears_notes_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT teachears_notes_uq_on_date_at_time UNIQUE (classroom, student, on_date, at_time),
  CONSTRAINT teachears_notes_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.teachears_notes
  OWNER TO postgres;
GRANT ALL ON TABLE public.teachears_notes TO postgres;
GRANT ALL ON TABLE public.teachears_notes TO scuola247_executive;
GRANT SELECT ON TABLE public.teachears_notes TO postgrest;
COMMENT ON TABLE public.teachears_notes
  IS 'It does the same fuunctions of notes table but for teacher register.
The only difference is that isn''t necessary to replicate the coloumn ''disciplinary'' too because the disciplinary notes have to be done only on classroom register unless these notes are mainly for private use of the teacher.';
COMMENT ON COLUMN public.teachears_notes.teacher_notes IS 'The teacher notes';
COMMENT ON COLUMN public.teachears_notes.student IS 'The student with this note';
COMMENT ON COLUMN public.teachears_notes.description IS 'Description for the note';
COMMENT ON COLUMN public.teachears_notes.teacher IS 'Teacher that insert the note';
COMMENT ON COLUMN public.teachears_notes.on_date IS 'When the note has been added';
COMMENT ON COLUMN public.teachears_notes.at_time IS 'When the teacher insert the note';
COMMENT ON COLUMN public.teachears_notes.classroom IS 'Classroom for the teacher notes';


-- Index: public.teachears_notes_fx_classroom

-- DROP INDEX public.teachears_notes_fx_classroom;

CREATE INDEX teachears_notes_fx_classroom
  ON public.teachears_notes
  USING btree
  (classroom);

-- Index: public.teachears_notes_fx_student

-- DROP INDEX public.teachears_notes_fx_student;

CREATE INDEX teachears_notes_fx_student
  ON public.teachears_notes
  USING btree
  (student);
COMMENT ON INDEX public.teachears_notes_fx_student
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.teachears_notes_fx_teacher

-- DROP INDEX public.teachears_notes_fx_teacher;

CREATE INDEX teachears_notes_fx_teacher
  ON public.teachears_notes
  USING btree
  (teacher);
COMMENT ON INDEX public.teachears_notes_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: teachears_notes_iu on public.teachears_notes

-- DROP TRIGGER teachears_notes_iu ON public.teachears_notes;

CREATE TRIGGER teachears_notes_iu
  AFTER INSERT OR UPDATE
  ON public.teachears_notes
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_teachears_notes_iu();

