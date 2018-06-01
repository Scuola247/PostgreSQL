-- Table: public.absences

-- DROP TABLE public.absences;

CREATE TABLE public.absences
(
  absence bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  on_date date NOT NULL, -- The date when the absence has been done
  teacher bigint NOT NULL, -- The teacher that has validated the absence.
  explanation bigint, -- Explanation for the absences
  classroom_student bigint, -- Student of the Classroom with this absence
  CONSTRAINT absences_pk PRIMARY KEY (absence),
  CONSTRAINT absences_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT absences_fk_explanation FOREIGN KEY (explanation)
      REFERENCES public.explanations (explanation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT absences_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT absences_uq_classroom_student_on_date UNIQUE (classroom_student, on_date)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.absences
  OWNER TO postgres;
GRANT ALL ON TABLE public.absences TO postgres;
GRANT ALL ON TABLE public.absences TO scuola247_executive;
GRANT SELECT ON TABLE public.absences TO postgrest;
COMMENT ON TABLE public.absences
  IS 'Detect the absences of a student.';
COMMENT ON COLUMN public.absences.absence IS 'Unique identification code for the row';
COMMENT ON COLUMN public.absences.on_date IS 'The date when the absence has been done';
COMMENT ON COLUMN public.absences.teacher IS 'The teacher that has validated the absence.';
COMMENT ON COLUMN public.absences.explanation IS 'Explanation for the absences';
COMMENT ON COLUMN public.absences.classroom_student IS 'Student of the Classroom with this absence';


-- Index: public.absences_fx_classroom_student

-- DROP INDEX public.absences_fx_classroom_student;

CREATE INDEX absences_fx_classroom_student
  ON public.absences
  USING btree
  (classroom_student);

-- Index: public.absences_fx_explanation

-- DROP INDEX public.absences_fx_explanation;

CREATE INDEX absences_fx_explanation
  ON public.absences
  USING btree
  (explanation);
COMMENT ON INDEX public.absences_fx_explanation
  IS 'Index to access the relative foreign key.';

-- Index: public.absences_fx_teacher

-- DROP INDEX public.absences_fx_teacher;

CREATE INDEX absences_fx_teacher
  ON public.absences
  USING btree
  (teacher);
COMMENT ON INDEX public.absences_fx_teacher
  IS 'Index to access the relative foreign key.';


-- Trigger: absences_iu on public.absences

-- DROP TRIGGER absences_iu ON public.absences;

CREATE TRIGGER absences_iu
  AFTER INSERT OR UPDATE
  ON public.absences
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_absences_iu();

