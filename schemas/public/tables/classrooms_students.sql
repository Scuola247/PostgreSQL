-- Table: public.classrooms_students

-- DROP TABLE public.classrooms_students;

CREATE TABLE public.classrooms_students
(
  classroom_student bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  classroom bigint NOT NULL, -- Classroom for these students
  student bigint NOT NULL, -- Student of the classroom
  retreat_on date, -- The date when the student has retreated from the classroom, or when he changed to another classroom of the same school, or another one.
  classroom_destination bigint, -- It's kept the trace about classroom where the student was transfered.
  CONSTRAINT classrooms_students_pk PRIMARY KEY (classroom_student),
  CONSTRAINT classrooms_students_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT classrooms_students_fk_student FOREIGN KEY (student)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT classrooms_students_uq_classroom_student UNIQUE (classroom, student)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.classrooms_students
  OWNER TO postgres;
GRANT ALL ON TABLE public.classrooms_students TO postgres;
GRANT ALL ON TABLE public.classrooms_students TO scuola247_executive;
GRANT SELECT ON TABLE public.classrooms_students TO postgrest;
COMMENT ON COLUMN public.classrooms_students.classroom_student IS 'Unique identification code for the row';
COMMENT ON COLUMN public.classrooms_students.classroom IS 'Classroom for these students';
COMMENT ON COLUMN public.classrooms_students.student IS 'Student of the classroom';
COMMENT ON COLUMN public.classrooms_students.retreat_on IS 'The date when the student has retreated from the classroom, or when he changed to another classroom of the same school, or another one.';
COMMENT ON COLUMN public.classrooms_students.classroom_destination IS 'It''s kept the trace about classroom where the student was transfered.';


-- Index: public.classrooms_students_fx_classroom

-- DROP INDEX public.classrooms_students_fx_classroom;

CREATE INDEX classrooms_students_fx_classroom
  ON public.classrooms_students
  USING btree
  (classroom);
COMMENT ON INDEX public.classrooms_students_fx_classroom
  IS 'Index to access the relative foreign key.';


-- Trigger: classrooms_students_iu on public.classrooms_students

-- DROP TRIGGER classrooms_students_iu ON public.classrooms_students;

CREATE TRIGGER classrooms_students_iu
  AFTER INSERT OR UPDATE
  ON public.classrooms_students
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_classrooms_students_iu();

