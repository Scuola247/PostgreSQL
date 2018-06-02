-- Table: public.delays

-- DROP TABLE public.delays;

CREATE TABLE public.delays
(
  delay bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  teacher bigint NOT NULL, -- The teacher with these delays
  explanation bigint, -- explanation for the delay
  on_date date NOT NULL, -- The date for the delay
  at_time time without time zone NOT NULL, -- Date of the delay
  classroom_student bigint, -- The student that did the delay
  CONSTRAINT delays_pk PRIMARY KEY (delay),
  CONSTRAINT delays_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT delays_fk_explanation FOREIGN KEY (explanation)
      REFERENCES public.explanations (explanation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT delays_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT delays_uq_classroom_student_on_date UNIQUE (classroom_student, on_date) -- A student in a classrom can have just one delay for day.
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.delays
  OWNER TO postgres;
GRANT ALL ON TABLE public.delays TO postgres;
GRANT ALL ON TABLE public.delays TO scuola247_executive;
GRANT SELECT ON TABLE public.delays TO postgrest;
COMMENT ON TABLE public.delays
  IS 'Reveals delays of a student';
COMMENT ON COLUMN public.delays.delay IS 'Unique identification code for the row';
COMMENT ON COLUMN public.delays.teacher IS 'The teacher with these delays';
COMMENT ON COLUMN public.delays.explanation IS 'explanation for the delay';
COMMENT ON COLUMN public.delays.on_date IS 'The date for the delay';
COMMENT ON COLUMN public.delays.at_time IS 'Date of the delay';
COMMENT ON COLUMN public.delays.classroom_student IS 'The student that did the delay';

COMMENT ON CONSTRAINT delays_uq_classroom_student_on_date ON public.delays IS 'A student in a classrom can have just one delay for day.';


-- Index: public.delays_fx_classroom_student

-- DROP INDEX public.delays_fx_classroom_student;

CREATE INDEX delays_fx_classroom_student
  ON public.delays
  USING btree
  (classroom_student);

-- Index: public.delays_fx_explanation

-- DROP INDEX public.delays_fx_explanation;

CREATE INDEX delays_fx_explanation
  ON public.delays
  USING btree
  (explanation);
COMMENT ON INDEX public.delays_fx_explanation
  IS 'Index to access the relative foreign key.';

-- Index: public.delays_fx_teacher

-- DROP INDEX public.delays_fx_teacher;

CREATE INDEX delays_fx_teacher
  ON public.delays
  USING btree
  (teacher);
COMMENT ON INDEX public.delays_fx_teacher
  IS 'Index to access the relative foreign key.';


-- Trigger: delays_iu on public.delays

-- DROP TRIGGER delays_iu ON public.delays;

CREATE TRIGGER delays_iu
  AFTER INSERT OR UPDATE
  ON public.delays
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_delays_iu();

