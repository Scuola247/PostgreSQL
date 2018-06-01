-- Table: public.weekly_timetables

-- DROP TABLE public.weekly_timetables;

CREATE TABLE public.weekly_timetables
(
  weekly_timetable bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  classroom bigint NOT NULL, -- The classroom with this weekly timetable
  description character varying(160), -- The description for the weekly timetable
  CONSTRAINT weekly_timetable_pk PRIMARY KEY (weekly_timetable),
  CONSTRAINT weekly_timetable_fk_classroom FOREIGN KEY (classroom)
      REFERENCES public.classrooms (classroom) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT weekly_timetable_uq_description UNIQUE (classroom, description),
  CONSTRAINT weekly_timetables_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.weekly_timetables
  OWNER TO postgres;
GRANT ALL ON TABLE public.weekly_timetables TO postgres;
GRANT ALL ON TABLE public.weekly_timetables TO scuola247_executive;
GRANT SELECT ON TABLE public.weekly_timetables TO postgrest;
COMMENT ON TABLE public.weekly_timetables
  IS 'Contains the weekly timetables for every school';
COMMENT ON COLUMN public.weekly_timetables.weekly_timetable IS 'Unique identification code for the row';
COMMENT ON COLUMN public.weekly_timetables.classroom IS 'The classroom with this weekly timetable';
COMMENT ON COLUMN public.weekly_timetables.description IS 'The description for the weekly timetable';


-- Index: public.weekly_timetable_fx_classroom

-- DROP INDEX public.weekly_timetable_fx_classroom;

CREATE INDEX weekly_timetable_fx_classroom
  ON public.weekly_timetables
  USING btree
  (classroom);
COMMENT ON INDEX public.weekly_timetable_fx_classroom
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

