-- Table: public.parents_meetings

-- DROP TABLE public.parents_meetings;

CREATE TABLE public.parents_meetings
(
  parents_meeting bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  teacher bigint NOT NULL, -- Teacher that meets the person on this date
  person bigint, -- Person that meets the teacher on this date
  on_date timestamp without time zone, -- The date that the teacher is avaible for the meet
  CONSTRAINT parents_meetings_pk PRIMARY KEY (parents_meeting),
  CONSTRAINT parents_meetings_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT parents_meetings_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT parents_meetings_uq UNIQUE (teacher, on_date) -- Un teacher non può avere più di un interview in un determiborn momento
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.parents_meetings
  OWNER TO postgres;
GRANT ALL ON TABLE public.parents_meetings TO postgres;
GRANT ALL ON TABLE public.parents_meetings TO scuola247_executive;
GRANT SELECT ON TABLE public.parents_meetings TO postgrest;
COMMENT ON TABLE public.parents_meetings
  IS 'In this table will be memorized all periods of avaibility for the parents meetings';
COMMENT ON COLUMN public.parents_meetings.parents_meeting IS 'Unique identification code for the row';
COMMENT ON COLUMN public.parents_meetings.teacher IS 'Teacher that meets the person on this date';
COMMENT ON COLUMN public.parents_meetings.person IS 'Person that meets the teacher on this date';
COMMENT ON COLUMN public.parents_meetings.on_date IS 'The date that the teacher is avaible for the meet';

COMMENT ON CONSTRAINT parents_meetings_uq ON public.parents_meetings IS 'Un teacher non può avere più di un interview in un determiborn momento';


-- Index: public.parents_meetings_fx_person

-- DROP INDEX public.parents_meetings_fx_person;

CREATE INDEX parents_meetings_fx_person
  ON public.parents_meetings
  USING btree
  (person);

-- Index: public.parents_meetings_fx_teacher

-- DROP INDEX public.parents_meetings_fx_teacher;

CREATE INDEX parents_meetings_fx_teacher
  ON public.parents_meetings
  USING btree
  (teacher);


-- Trigger: parents_meetings_iu on public.parents_meetings

-- DROP TRIGGER parents_meetings_iu ON public.parents_meetings;

CREATE TRIGGER parents_meetings_iu
  AFTER INSERT OR UPDATE
  ON public.parents_meetings
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_parents_meetings_iu();

