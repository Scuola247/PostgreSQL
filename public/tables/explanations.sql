-- Table: public.explanations

-- DROP TABLE public.explanations;

CREATE TABLE public.explanations
(
  explanation bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  student bigint NOT NULL, -- The student with this explanation
  description character varying(2048) NOT NULL, -- Description for the explanation
  created_on timestamp without time zone NOT NULL, -- Date when the explanation has been created
  created_by bigint NOT NULL, -- The person, school teacher, family or student also, if adult, that has insert the explanation
  registered_on timestamp without time zone, -- Date for register when the explanation has been insert
  registered_by bigint, -- Whom have insert the explanation
  from_time date, -- The starting absence time of an explanation
  to_time date, -- The return at school time of an explanation
  coming_at time without time zone, -- When the student came at school (delay)
  leaving_at time without time zone, -- When the student had leave the school
  type explanation_type, -- The type for the explanation
  CONSTRAINT explanations_pk PRIMARY KEY (explanation),
  CONSTRAINT explanations_fk_created_by FOREIGN KEY (created_by)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT explanations_fk_registered_by FOREIGN KEY (registered_by)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT explanations_fk_student FOREIGN KEY (student)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT explanations_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT explanations_ck_leaving_at CHECK (leaving_at > coming_at),
  CONSTRAINT explanations_ck_registered_on CHECK (registered_on >= created_on),
  CONSTRAINT explanations_ck_to_time CHECK (to_time >= from_time)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.explanations
  OWNER TO postgres;
GRANT ALL ON TABLE public.explanations TO postgres;
GRANT ALL ON TABLE public.explanations TO scuola247_executive;
GRANT SELECT ON TABLE public.explanations TO postgrest;
COMMENT ON TABLE public.explanations
  IS 'Contains the explanations for absences, delay annd leavings.
It can be done by a schoolteacher that will compile the description or by a parents';
COMMENT ON COLUMN public.explanations.explanation IS 'Unique identification code for the row';
COMMENT ON COLUMN public.explanations.student IS 'The student with this explanation';
COMMENT ON COLUMN public.explanations.description IS 'Description for the explanation';
COMMENT ON COLUMN public.explanations.created_on IS 'Date when the explanation has been created';
COMMENT ON COLUMN public.explanations.created_by IS 'The person, school teacher, family or student also, if adult, that has insert the explanation';
COMMENT ON COLUMN public.explanations.registered_on IS 'Date for register when the explanation has been insert';
COMMENT ON COLUMN public.explanations.registered_by IS 'Whom have insert the explanation';
COMMENT ON COLUMN public.explanations.from_time IS 'The starting absence time of an explanation';
COMMENT ON COLUMN public.explanations.to_time IS 'The return at school time of an explanation';
COMMENT ON COLUMN public.explanations.coming_at IS 'When the student came at school (delay)';
COMMENT ON COLUMN public.explanations.leaving_at IS 'When the student had leave the school';
COMMENT ON COLUMN public.explanations.type IS 'The type for the explanation';


-- Index: public.explanations_fx_created_by

-- DROP INDEX public.explanations_fx_created_by;

CREATE INDEX explanations_fx_created_by
  ON public.explanations
  USING btree
  (created_by);

-- Index: public.explanations_fx_student

-- DROP INDEX public.explanations_fx_student;

CREATE INDEX explanations_fx_student
  ON public.explanations
  USING btree
  (student);
COMMENT ON INDEX public.explanations_fx_student
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.explanations_fx_usata_from_time

-- DROP INDEX public.explanations_fx_usata_from_time;

CREATE INDEX explanations_fx_usata_from_time
  ON public.explanations
  USING btree
  (registered_by);


-- Trigger: explanations_iu on public.explanations

-- DROP TRIGGER explanations_iu ON public.explanations;

CREATE TRIGGER explanations_iu
  AFTER INSERT OR UPDATE
  ON public.explanations
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_explanations_iu();

