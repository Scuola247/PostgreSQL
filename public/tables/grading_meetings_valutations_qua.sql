-- Table: public.grading_meetings_valutations_qua

-- DROP TABLE public.grading_meetings_valutations_qua;

CREATE TABLE public.grading_meetings_valutations_qua
(
  grading_meeting_valutation_qua bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- The valutation from the grading meeting
  grading_meeting_valutation bigint NOT NULL, -- The grading meeting valutation
  qualification bigint NOT NULL, -- The qualification for the grading meeting
  grade bigint NOT NULL, -- The final grade from the grading meeting
  notes character varying(2048), -- The notes at the grading meetings
  CONSTRAINT grading_meetings_valutations_qua_pk PRIMARY KEY (grading_meeting_valutation_qua),
  CONSTRAINT grading_meetings_valutations_qua_fk_grade FOREIGN KEY (grade)
      REFERENCES public.grades (grade) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_qua_fk_grading_meeting_valutation FOREIGN KEY (grading_meeting_valutation)
      REFERENCES public.grading_meetings_valutations (grading_meeting_valutation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_valutations_qua_fk_qualification FOREIGN KEY (qualification)
      REFERENCES public.qualifications (qualification) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT grading_meetings_valutations_qua_uq_qualification UNIQUE (grading_meeting_valutation, qualification),
  CONSTRAINT grading_meetings_valutations_qua_ck_notes CHECK (length(btrim(notes::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.grading_meetings_valutations_qua
  OWNER TO postgres;
GRANT ALL ON TABLE public.grading_meetings_valutations_qua TO postgres;
GRANT ALL ON TABLE public.grading_meetings_valutations_qua TO scuola247_executive;
GRANT SELECT ON TABLE public.grading_meetings_valutations_qua TO postgrest;
COMMENT ON TABLE public.grading_meetings_valutations_qua
  IS 'Shows all grading meetings, close or still open';
COMMENT ON COLUMN public.grading_meetings_valutations_qua.grading_meeting_valutation_qua IS 'The valutation from the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations_qua.grading_meeting_valutation IS 'The grading meeting valutation';
COMMENT ON COLUMN public.grading_meetings_valutations_qua.qualification IS 'The qualification for the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations_qua.grade IS 'The final grade from the grading meeting';
COMMENT ON COLUMN public.grading_meetings_valutations_qua.notes IS 'The notes at the grading meetings';


-- Index: public.grading_meetings_valutations_qua_fx_grade

-- DROP INDEX public.grading_meetings_valutations_qua_fx_grade;

CREATE INDEX grading_meetings_valutations_qua_fx_grade
  ON public.grading_meetings_valutations_qua
  USING btree
  (grade);
COMMENT ON INDEX public.grading_meetings_valutations_qua_fx_grade
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.grading_meetings_valutations_qua_fx_grading_meeting_valutation

-- DROP INDEX public.grading_meetings_valutations_qua_fx_grading_meeting_valutation;

CREATE INDEX grading_meetings_valutations_qua_fx_grading_meeting_valutation
  ON public.grading_meetings_valutations_qua
  USING btree
  (grading_meeting_valutation);
COMMENT ON INDEX public.grading_meetings_valutations_qua_fx_grading_meeting_valutation
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.grading_meetings_valutations_qua_fx_qualification

-- DROP INDEX public.grading_meetings_valutations_qua_fx_qualification;

CREATE INDEX grading_meetings_valutations_qua_fx_qualification
  ON public.grading_meetings_valutations_qua
  USING btree
  (qualification);
COMMENT ON INDEX public.grading_meetings_valutations_qua_fx_qualification
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: grading_meetings_valutations_qua_d on public.grading_meetings_valutations_qua

-- DROP TRIGGER grading_meetings_valutations_qua_d ON public.grading_meetings_valutations_qua;

CREATE TRIGGER grading_meetings_valutations_qua_d
  AFTER DELETE
  ON public.grading_meetings_valutations_qua
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_grading_meetings_valutations_qua_d();

-- Trigger: grading_meetings_valutations_qua_iu on public.grading_meetings_valutations_qua

-- DROP TRIGGER grading_meetings_valutations_qua_iu ON public.grading_meetings_valutations_qua;

CREATE TRIGGER grading_meetings_valutations_qua_iu
  AFTER INSERT OR UPDATE
  ON public.grading_meetings_valutations_qua
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_grading_meetings_valutations_qua_iu();

