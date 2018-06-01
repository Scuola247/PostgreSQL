-- Table: public.lessons

-- DROP TABLE public.lessons;

CREATE TABLE public.lessons
(
  lesson bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  classroom bigint NOT NULL, -- Classroom that have these lessons
  on_date date NOT NULL, -- Date when the lessons start
  subject bigint NOT NULL, -- The subject at lesson
  teacher bigint NOT NULL, -- The teacher for these lessons
  description character varying(2048) NOT NULL, -- The description for the lessons
  substitute boolean NOT NULL DEFAULT false, -- Indicates if the lesson is a taken by a sobstitute teacher not owning the teacher post
  from_time time without time zone NOT NULL, -- Time to begin the lessons
  to_time time without time zone NOT NULL, -- Time to end the lessons
  assignment character varying(2048), -- assignments gaven during the lesson
  period tsrange, -- Period for the lessons
  CONSTRAINT lessons_pk PRIMARY KEY (lesson),
  CONSTRAINT lessons_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lessons_fk_subject FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lessons_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT lessons_ck_assignment CHECK (length(btrim(assignment::text)) > 0),
  CONSTRAINT lessons_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT lessons_ck_to_time CHECK (to_time > from_time)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.lessons
  OWNER TO postgres;
GRANT ALL ON TABLE public.lessons TO postgres;
GRANT ALL ON TABLE public.lessons TO scuola247_executive;
GRANT SELECT ON TABLE public.lessons TO postgrest;
COMMENT ON COLUMN public.lessons.lesson IS 'Unique identification code for the row';
COMMENT ON COLUMN public.lessons.classroom IS 'Classroom that have these lessons';
COMMENT ON COLUMN public.lessons.on_date IS 'Date when the lessons start';
COMMENT ON COLUMN public.lessons.subject IS 'The subject at lesson';
COMMENT ON COLUMN public.lessons.teacher IS 'The teacher for these lessons';
COMMENT ON COLUMN public.lessons.description IS 'The description for the lessons';
COMMENT ON COLUMN public.lessons.substitute IS 'Indicates if the lesson is a taken by a sobstitute teacher not owning the teacher post';
COMMENT ON COLUMN public.lessons.from_time IS 'Time to begin the lessons';
COMMENT ON COLUMN public.lessons.to_time IS 'Time to end the lessons';
COMMENT ON COLUMN public.lessons.assignment IS 'assignments gaven during the lesson';
COMMENT ON COLUMN public.lessons.period IS 'Period for the lessons';


-- Index: public.lessons_fx_classroom

-- DROP INDEX public.lessons_fx_classroom;

CREATE INDEX lessons_fx_classroom
  ON public.lessons
  USING btree
  (classroom);
COMMENT ON INDEX public.lessons_fx_classroom
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.lessons_fx_subject

-- DROP INDEX public.lessons_fx_subject;

CREATE INDEX lessons_fx_subject
  ON public.lessons
  USING btree
  (subject);
COMMENT ON INDEX public.lessons_fx_subject
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.lessons_fx_teacher

-- DROP INDEX public.lessons_fx_teacher;

CREATE INDEX lessons_fx_teacher
  ON public.lessons
  USING btree
  (teacher);
COMMENT ON INDEX public.lessons_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: lessons_iu on public.lessons

-- DROP TRIGGER lessons_iu ON public.lessons;

CREATE TRIGGER lessons_iu
  AFTER INSERT OR UPDATE
  ON public.lessons
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_lessons_iu();

