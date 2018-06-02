-- Table: public.grading_meetings

-- DROP TABLE public.grading_meetings;

CREATE TABLE public.grading_meetings
(
  grading_meeting bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  school_year bigint, -- The school year for the grading meeting
  on_date date, -- Date of the grading meeting
  description character varying(60) NOT NULL, -- The description for the grading meeting
  closed boolean NOT NULL DEFAULT false, -- Indicates if the grading meeting is closed and the changes are locked
  CONSTRAINT grading_meetings_pk PRIMARY KEY (grading_meeting),
  CONSTRAINT grading_meetings_fk_school_year FOREIGN KEY (school_year)
      REFERENCES public.school_years (school_year) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT grading_meetings_uq_description UNIQUE (school_year, description),
  CONSTRAINT grading_meetings_uq_on_date UNIQUE (school_year, on_date),
  CONSTRAINT grading_meetings_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.grading_meetings
  OWNER TO postgres;
GRANT ALL ON TABLE public.grading_meetings TO postgres;
GRANT ALL ON TABLE public.grading_meetings TO scuola247_executive;
GRANT SELECT ON TABLE public.grading_meetings TO postgrest;
COMMENT ON COLUMN public.grading_meetings.grading_meeting IS 'Unique identification code for the row';
COMMENT ON COLUMN public.grading_meetings.school_year IS 'The school year for the grading meeting';
COMMENT ON COLUMN public.grading_meetings.on_date IS 'Date of the grading meeting';
COMMENT ON COLUMN public.grading_meetings.description IS 'The description for the grading meeting';
COMMENT ON COLUMN public.grading_meetings.closed IS 'Indicates if the grading meeting is closed and the changes are locked';


-- Index: public.grading_meetings_fx_school

-- DROP INDEX public.grading_meetings_fx_school;

CREATE INDEX grading_meetings_fx_school
  ON public.grading_meetings
  USING btree
  (school_year);


-- Trigger: grading_meetings_iu on public.grading_meetings

-- DROP TRIGGER grading_meetings_iu ON public.grading_meetings;

CREATE TRIGGER grading_meetings_iu
  AFTER INSERT OR UPDATE
  ON public.grading_meetings
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_grading_meetings_iu();

