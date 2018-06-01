-- Table: public.weekly_timetables_days

-- DROP TABLE public.weekly_timetables_days;

CREATE TABLE public.weekly_timetables_days
(
  weekly_timetable_day bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  weekly_timetable bigint NOT NULL, -- Unique identification code for the row
  weekday utility.week_day NOT NULL, -- Weekday for the timetable
  teacher bigint, -- Teacher for the weekly timetable
  subject bigint, -- Subject in the weekly timetable
  team_teaching smallint NOT NULL DEFAULT 1, -- Indicates the amount of team_teaching (1 first teacher, 2 second teacher ecc.) if there's only a teacher you have to insert 1
  from_time time(0) without time zone NOT NULL, -- When the weekly timetable starts
  to_time time(0) without time zone NOT NULL, -- Time when the timetable finish
  CONSTRAINT weekly_timetables_days_pk PRIMARY KEY (weekly_timetable_day),
  CONSTRAINT weekly_timetables_days_fk_subject FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT weekly_timetables_days_fk_teacher FOREIGN KEY (teacher)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT weekly_timetables_days_fk_weekly_timetable FOREIGN KEY (weekly_timetable)
      REFERENCES public.weekly_timetables (weekly_timetable) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT weekly_timetables_days_uq_weekly_timetable UNIQUE (weekly_timetable, weekday, teacher, subject, from_time),
  CONSTRAINT weekly_timetables_days_ck_teacher_subject CHECK (teacher IS NOT NULL OR subject IS NOT NULL) -- Almeno uno dei campi tra teacher e subject deve essere compilato.
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.weekly_timetables_days
  OWNER TO postgres;
GRANT ALL ON TABLE public.weekly_timetables_days TO postgres;
GRANT ALL ON TABLE public.weekly_timetables_days TO scuola247_executive;
GRANT SELECT ON TABLE public.weekly_timetables_days TO postgrest;
COMMENT ON COLUMN public.weekly_timetables_days.weekly_timetable_day IS 'Unique identification code for the row';
COMMENT ON COLUMN public.weekly_timetables_days.weekly_timetable IS 'Unique identification code for the row';
COMMENT ON COLUMN public.weekly_timetables_days.weekday IS 'Weekday for the timetable';
COMMENT ON COLUMN public.weekly_timetables_days.teacher IS 'Teacher for the weekly timetable';
COMMENT ON COLUMN public.weekly_timetables_days.subject IS 'Subject in the weekly timetable';
COMMENT ON COLUMN public.weekly_timetables_days.team_teaching IS 'Indicates the amount of team_teaching (1 first teacher, 2 second teacher ecc.) if there''s only a teacher you have to insert 1';
COMMENT ON COLUMN public.weekly_timetables_days.from_time IS 'When the weekly timetable starts';
COMMENT ON COLUMN public.weekly_timetables_days.to_time IS 'Time when the timetable finish';

COMMENT ON CONSTRAINT weekly_timetables_days_ck_teacher_subject ON public.weekly_timetables_days IS 'Almeno uno dei campi tra teacher e subject deve essere compilato.';


-- Index: public.weekly_timetables_days_fx_subject

-- DROP INDEX public.weekly_timetables_days_fx_subject;

CREATE INDEX weekly_timetables_days_fx_subject
  ON public.weekly_timetables_days
  USING btree
  (subject);
COMMENT ON INDEX public.weekly_timetables_days_fx_subject
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.weekly_timetables_days_fx_teacher

-- DROP INDEX public.weekly_timetables_days_fx_teacher;

CREATE INDEX weekly_timetables_days_fx_teacher
  ON public.weekly_timetables_days
  USING btree
  (teacher);
COMMENT ON INDEX public.weekly_timetables_days_fx_teacher
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.weekly_timetables_days_fx_weekly_timetable

-- DROP INDEX public.weekly_timetables_days_fx_weekly_timetable;

CREATE INDEX weekly_timetables_days_fx_weekly_timetable
  ON public.weekly_timetables_days
  USING btree
  (weekly_timetable);
COMMENT ON INDEX public.weekly_timetables_days_fx_weekly_timetable
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

