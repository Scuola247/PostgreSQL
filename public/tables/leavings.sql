-- Table: public.leavings

-- DROP TABLE public.leavings;

CREATE TABLE public.leavings
(
  leaving bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  teacher bigint NOT NULL, -- The teacher that giustified the leaving
  explanation bigint NOT NULL, -- Explanation for the leaving
  on_date date NOT NULL, -- When the leaving has been done
  at_time time without time zone NOT NULL, -- When the student left from the classroom
  classroom_student bigint, -- Student for the leaving
  CONSTRAINT leavings_pk PRIMARY KEY (leaving),
  CONSTRAINT leavings_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT leavings_fk_explanation FOREIGN KEY (explanation)
      REFERENCES public.explanations (explanation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT leavings_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT leavings_uq_classroom_student UNIQUE (classroom_student, on_date) -- Per ub student di una classroom in un on_date è possibile una sola leaving
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.leavings
  OWNER TO postgres;
GRANT ALL ON TABLE public.leavings TO postgres;
GRANT ALL ON TABLE public.leavings TO scuola247_executive;
GRANT SELECT ON TABLE public.leavings TO postgrest;
COMMENT ON TABLE public.leavings
  IS 'Reveals leavings of a student';
COMMENT ON COLUMN public.leavings.leaving IS 'Unique identification code for the row';
COMMENT ON COLUMN public.leavings.teacher IS 'The teacher that giustified the leaving';
COMMENT ON COLUMN public.leavings.explanation IS 'Explanation for the leaving';
COMMENT ON COLUMN public.leavings.on_date IS 'When the leaving has been done';
COMMENT ON COLUMN public.leavings.at_time IS 'When the student left from the classroom';
COMMENT ON COLUMN public.leavings.classroom_student IS 'Student for the leaving';

COMMENT ON CONSTRAINT leavings_uq_classroom_student ON public.leavings IS 'Per ub student di una classroom in un on_date è possibile una sola leaving';


-- Index: public.leavings_fx_classroom_student

-- DROP INDEX public.leavings_fx_classroom_student;

CREATE INDEX leavings_fx_classroom_student
  ON public.leavings
  USING btree
  (classroom_student);

-- Index: public.leavings_fx_explanation

-- DROP INDEX public.leavings_fx_explanation;

CREATE INDEX leavings_fx_explanation
  ON public.leavings
  USING btree
  (explanation);
COMMENT ON INDEX public.leavings_fx_explanation
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.leavings_fx_teacher

-- DROP INDEX public.leavings_fx_teacher;

CREATE INDEX leavings_fx_teacher
  ON public.leavings
  USING btree
  (teacher);
COMMENT ON INDEX public.leavings_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: leavings_iu on public.leavings

-- DROP TRIGGER leavings_iu ON public.leavings;

CREATE TRIGGER leavings_iu
  AFTER INSERT OR UPDATE
  ON public.leavings
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_leavings_iu();

