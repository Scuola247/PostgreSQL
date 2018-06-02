-- Table: public.faults

-- DROP TABLE public.faults;

CREATE TABLE public.faults
(
  fault bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  student bigint NOT NULL, -- The student with these faults
  description character varying(2048) NOT NULL, -- Description for the faults
  lesson bigint NOT NULL, -- The lesson with these faults
  note bigint, -- Note for the fault
  CONSTRAINT faults_pk PRIMARY KEY (fault),
  CONSTRAINT faults_fk_lesson FOREIGN KEY (lesson)
      REFERENCES public.lessons (lesson) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT faults_fk_student FOREIGN KEY (student)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT faults_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.faults
  OWNER TO postgres;
GRANT ALL ON TABLE public.faults TO postgres;
GRANT ALL ON TABLE public.faults TO scuola247_executive;
GRANT SELECT ON TABLE public.faults TO postgrest;
COMMENT ON TABLE public.faults
  IS 'Reveals the faults of a student';
COMMENT ON COLUMN public.faults.fault IS 'Unique identification code for the row';
COMMENT ON COLUMN public.faults.student IS 'The student with these faults';
COMMENT ON COLUMN public.faults.description IS 'Description for the faults';
COMMENT ON COLUMN public.faults.lesson IS 'The lesson with these faults';
COMMENT ON COLUMN public.faults.note IS 'Note for the fault';


-- Index: public.faults_fx_lesson

-- DROP INDEX public.faults_fx_lesson;

CREATE INDEX faults_fx_lesson
  ON public.faults
  USING btree
  (lesson);

-- Index: public.faults_fx_student

-- DROP INDEX public.faults_fx_student;

CREATE INDEX faults_fx_student
  ON public.faults
  USING btree
  (student);
COMMENT ON INDEX public.faults_fx_student
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: faults_iu on public.faults

-- DROP TRIGGER faults_iu ON public.faults;

CREATE TRIGGER faults_iu
  AFTER INSERT OR UPDATE
  ON public.faults
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_faults_iu();

