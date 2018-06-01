-- Table: public.out_of_classrooms

-- DROP TABLE public.out_of_classrooms;

CREATE TABLE public.out_of_classrooms
(
  out_of_classroom bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school_operator bigint NOT NULL, -- School operator with out of classrooms
  description character varying(160) NOT NULL, -- The description for whom out of classroom
  on_date date NOT NULL, -- The date when out of classroom
  from_time time without time zone NOT NULL, -- at_time of leaving
  to_time time without time zone NOT NULL, -- at_time of return
  classroom_student bigint, -- The classroom of the student
  CONSTRAINT out_of_classrooms_pk PRIMARY KEY (out_of_classroom),
  CONSTRAINT out_of_classrooms_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT out_of_classrooms_fk_school_operator FOREIGN KEY (school_operator)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT out_of_classrooms_uq_classroom_student_on_date UNIQUE (classroom_student, on_date),
  CONSTRAINT out_of_classrooms_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT out_of_classrooms_ck_to_time CHECK (to_time > from_time)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.out_of_classrooms
  OWNER TO postgres;
GRANT ALL ON TABLE public.out_of_classrooms TO postgres;
GRANT ALL ON TABLE public.out_of_classrooms TO scuola247_executive;
GRANT SELECT ON TABLE public.out_of_classrooms TO postgrest;
COMMENT ON TABLE public.out_of_classrooms
  IS 'Indicates when a student isn''t present in classroom but don''t has to be considered absent, example for sports activity';
COMMENT ON COLUMN public.out_of_classrooms.out_of_classroom IS 'Unique identification code for the row';
COMMENT ON COLUMN public.out_of_classrooms.school_operator IS 'School operator with out of classrooms';
COMMENT ON COLUMN public.out_of_classrooms.description IS 'The description for whom out of classroom';
COMMENT ON COLUMN public.out_of_classrooms.on_date IS 'The date when out of classroom';
COMMENT ON COLUMN public.out_of_classrooms.from_time IS 'at_time of leaving';
COMMENT ON COLUMN public.out_of_classrooms.to_time IS 'at_time of return';
COMMENT ON COLUMN public.out_of_classrooms.classroom_student IS 'The classroom of the student';


-- Index: public.out_of_classrooms_fx_classroom_student

-- DROP INDEX public.out_of_classrooms_fx_classroom_student;

CREATE INDEX out_of_classrooms_fx_classroom_student
  ON public.out_of_classrooms
  USING btree
  (classroom_student);

-- Index: public.out_of_classrooms_fx_school_operator

-- DROP INDEX public.out_of_classrooms_fx_school_operator;

CREATE INDEX out_of_classrooms_fx_school_operator
  ON public.out_of_classrooms
  USING btree
  (school_operator);
COMMENT ON INDEX public.out_of_classrooms_fx_school_operator
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: out_of_classrooms_iu on public.out_of_classrooms

-- DROP TRIGGER out_of_classrooms_iu ON public.out_of_classrooms;

CREATE TRIGGER out_of_classrooms_iu
  AFTER INSERT OR UPDATE
  ON public.out_of_classrooms
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_out_of_classrooms_iu();

