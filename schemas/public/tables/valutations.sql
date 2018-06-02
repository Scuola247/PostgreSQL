-- Table: public.valutations

-- DROP TABLE public.valutations;

CREATE TABLE public.valutations
(
  valutation bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  subject bigint NOT NULL, -- The subject with these valutations
  grade_type bigint NOT NULL, -- The type of grade
  topic bigint, -- The topic for these valutations
  grade bigint NOT NULL, -- The grade for the valutation
  evaluation character varying(160), -- The evaluation
  private boolean NOT NULL DEFAULT false, -- Indicates that the grade is visible for only the teacher that has insert it
  teacher bigint NOT NULL, -- The teacher coloumn has been inserted because the techer during the school year could  be changed, in this mode will be tracked who insert the value
  on_date date NOT NULL, -- When the valutation was insert
  note bigint, -- The note associated to the valutation
  classroom_student bigint NOT NULL,
  CONSTRAINT valutations_pk PRIMARY KEY (valutation),
  CONSTRAINT valutations_fk_classroom_student FOREIGN KEY (classroom_student)
      REFERENCES public.classrooms_students (classroom_student) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT valutations_fk_grade FOREIGN KEY (grade)
      REFERENCES public.grades (grade) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT valutations_fk_grade_type FOREIGN KEY (grade_type)
      REFERENCES public.grade_types (grade_type) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT valutations_fk_note FOREIGN KEY (note)
      REFERENCES public.notes (note) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT valutations_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT valutations_fk_topic FOREIGN KEY (topic)
      REFERENCES public.topics (topic) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.valutations
  OWNER TO postgres;
GRANT ALL ON TABLE public.valutations TO postgres;
GRANT ALL ON TABLE public.valutations TO scuola247_executive;
GRANT SELECT ON TABLE public.valutations TO postgrest;
COMMENT ON TABLE public.valutations
  IS 'Contains valutations of all students did by all teachers';
COMMENT ON COLUMN public.valutations.valutation IS 'Unique identification code for the row';
COMMENT ON COLUMN public.valutations.subject IS 'The subject with these valutations';
COMMENT ON COLUMN public.valutations.grade_type IS 'The type of grade';
COMMENT ON COLUMN public.valutations.topic IS 'The topic for these valutations';
COMMENT ON COLUMN public.valutations.grade IS 'The grade for the valutation';
COMMENT ON COLUMN public.valutations.evaluation IS 'The evaluation';
COMMENT ON COLUMN public.valutations.private IS 'Indicates that the grade is visible for only the teacher that has insert it';
COMMENT ON COLUMN public.valutations.teacher IS 'The teacher coloumn has been inserted because the techer during the school year could  be changed, in this mode will be tracked who insert the value';
COMMENT ON COLUMN public.valutations.on_date IS 'When the valutation was insert';
COMMENT ON COLUMN public.valutations.note IS 'The note associated to the valutation';


-- Index: public.valutations_fx_classroom_student

-- DROP INDEX public.valutations_fx_classroom_student;

CREATE INDEX valutations_fx_classroom_student
  ON public.valutations
  USING btree
  (classroom_student);

-- Index: public.valutations_fx_grade

-- DROP INDEX public.valutations_fx_grade;

CREATE INDEX valutations_fx_grade
  ON public.valutations
  USING btree
  (grade);

-- Index: public.valutations_fx_grade_type

-- DROP INDEX public.valutations_fx_grade_type;

CREATE INDEX valutations_fx_grade_type
  ON public.valutations
  USING btree
  (grade_type);
COMMENT ON INDEX public.valutations_fx_grade_type
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.valutations_fx_note

-- DROP INDEX public.valutations_fx_note;

CREATE INDEX valutations_fx_note
  ON public.valutations
  USING btree
  (note);

-- Index: public.valutations_fx_teacher

-- DROP INDEX public.valutations_fx_teacher;

CREATE INDEX valutations_fx_teacher
  ON public.valutations
  USING btree
  (teacher);
COMMENT ON INDEX public.valutations_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.valutations_fx_topic

-- DROP INDEX public.valutations_fx_topic;

CREATE INDEX valutations_fx_topic
  ON public.valutations
  USING btree
  (topic);
COMMENT ON INDEX public.valutations_fx_topic
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: valutations_iu on public.valutations

-- DROP TRIGGER valutations_iu ON public.valutations;

CREATE TRIGGER valutations_iu
  AFTER INSERT OR UPDATE
  ON public.valutations
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_valutations_iu();

