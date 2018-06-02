-- Table: public.grading_meetings_valutations

-- DROP TABLE public.grading_meetings_valutations;

CREATE TABLE public.grading_meetings_valutations
(
  grading_meeting_valutation bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- The valutation from the grading meeting
  grading_meeting bigint NOT NULL, -- Unique identification code for the row
  classroom bigint NOT NULL, -- The classroom of these valutations from grading meeting
  student bigint NOT NULL, -- Indicates all the valutations of the grading meeting
  subject bigint NOT NULL, -- The subject of the grading meeting
  grade bigint NOT NULL, -- If the teacher is ' this indicates the grade of the grading meeting otherwise the grade of the teacher
  notes character varying(2048), -- The notes in the valutations from the grading meeting
  lack_of_training boolean NOT NULL DEFAULT false, -- Indicates if the student shows formative lacks
  council_vote boolean DEFAULT false, -- Indicates if the grade was chose by the grading metting or it's from the teacher if showed(so the row in the db shows the proposal grade and it can't be ')
  teacher bigint, -- If ' indicates the grade of the grading meeting othwerwise it shows the grade of the teacher
  CONSTRAINT grading_meetings_valutations_pk PRIMARY KEY (grading_meeting_valutation),
  CONSTRAINT grading_meetings_valutations_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_fk_grade FOREIGN KEY (grade)
      REFERENCES public.grades (grade) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_fk_grading_meeting FOREIGN KEY (grading_meeting)
      REFERENCES public.grading_meetings (grading_meeting) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_fk_student FOREIGN KEY (student)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_fk_subject FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_uq_student UNIQUE (grading_meeting, classroom, student, subject, teacher),
  CONSTRAINT grading_meetings_valutations_ck_grade_consiglio CHECK (teacher IS NOT NULL AND council_vote IS NULL OR teacher IS NULL AND council_vote IS NOT NULL), -- Se è indicato il teacher (proposta di grade) allat_time il flag 'council_vote' non deve essere indicato perchè è valido solo per il grade di grading_meeting e viceversa
  CONSTRAINT grading_meetings_valutations_ck_notes CHECK (length(btrim(notes::text)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.grading_meetings_valutations
  OWNER TO postgres;
GRANT ALL ON TABLE public.grading_meetings_valutations TO postgres;
GRANT ALL ON TABLE public.grading_meetings_valutations TO scuola247_executive;
GRANT SELECT ON TABLE public.grading_meetings_valutations TO postgrest;
COMMENT ON COLUMN public.grading_meetings_valutations.grading_meeting_valutation IS 'The valutation from the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations.grading_meeting IS 'Unique identification code for the row';
COMMENT ON COLUMN public.grading_meetings_valutations.classroom IS 'The classroom of these valutations from grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations.student IS 'Indicates all the valutations of the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations.subject IS 'The subject of the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations.grade IS 'If the teacher is '' this indicates the grade of the grading meeting otherwise the grade of the teacher';
COMMENT ON COLUMN public.grading_meetings_valutations.notes IS 'The notes in the valutations from the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations.lack_of_training IS 'Indicates if the student shows formative lacks';
COMMENT ON COLUMN public.grading_meetings_valutations.council_vote IS 'Indicates if the grade was chose by the grading metting or it''s from the teacher if showed(so the row in the db shows the proposal grade and it can''t be '')';
COMMENT ON COLUMN public.grading_meetings_valutations.teacher IS 'If '' indicates the grade of the grading meeting othwerwise it shows the grade of the teacher';

COMMENT ON CONSTRAINT grading_meetings_valutations_ck_grade_consiglio ON public.grading_meetings_valutations IS 'Se è indicato il teacher (proposta di grade) allat_time il flag ''council_vote'' non deve essere indicato perchè è valido solo per il grade di grading_meeting e viceversa';


-- Index: public.grading_meetings_valutations_fx_classroom

-- DROP INDEX public.grading_meetings_valutations_fx_classroom;

CREATE INDEX grading_meetings_valutations_fx_classroom
  ON public.grading_meetings_valutations
  USING btree
  (classroom);

-- Index: public.grading_meetings_valutations_fx_grade

-- DROP INDEX public.grading_meetings_valutations_fx_grade;

CREATE INDEX grading_meetings_valutations_fx_grade
  ON public.grading_meetings_valutations
  USING btree
  (grade);

-- Index: public.grading_meetings_valutations_fx_grading_meeting

-- DROP INDEX public.grading_meetings_valutations_fx_grading_meeting;

CREATE INDEX grading_meetings_valutations_fx_grading_meeting
  ON public.grading_meetings_valutations
  USING btree
  (grading_meeting);

-- Index: public.grading_meetings_valutations_fx_student

-- DROP INDEX public.grading_meetings_valutations_fx_student;

CREATE INDEX grading_meetings_valutations_fx_student
  ON public.grading_meetings_valutations
  USING btree
  (student);

-- Index: public.grading_meetings_valutations_fx_subject

-- DROP INDEX public.grading_meetings_valutations_fx_subject;

CREATE INDEX grading_meetings_valutations_fx_subject
  ON public.grading_meetings_valutations
  USING btree
  (subject);

-- Index: public.idx_grading_meetings_valutations

-- DROP INDEX public.idx_grading_meetings_valutations;

CREATE INDEX idx_grading_meetings_valutations
  ON public.grading_meetings_valutations
  USING btree
  (teacher);


-- Trigger: grading_meetings_valutations_d on public.grading_meetings_valutations

-- DROP TRIGGER grading_meetings_valutations_d ON public.grading_meetings_valutations;

CREATE TRIGGER grading_meetings_valutations_d
  AFTER DELETE
  ON public.grading_meetings_valutations
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_grading_meetings_valutations_d();

-- Trigger: grading_meetings_valutations_iu on public.grading_meetings_valutations

-- DROP TRIGGER grading_meetings_valutations_iu ON public.grading_meetings_valutations;

CREATE TRIGGER grading_meetings_valutations_iu
  AFTER INSERT OR UPDATE
  ON public.grading_meetings_valutations
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_grading_meetings_valutations_iu();

