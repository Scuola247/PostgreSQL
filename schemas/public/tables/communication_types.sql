-- Table: public.communication_types

-- DROP TABLE public.communication_types;

CREATE TABLE public.communication_types
(
  communication_type bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  description character varying(160) NOT NULL, -- All types of communication avaible
  notification_management boolean NOT NULL DEFAULT false, -- It's indicates if this kind of communication manage the notifications
  school bigint, -- School with these communication type
  CONSTRAINT communication_types_pk PRIMARY KEY (communication_type),
  CONSTRAINT communication_types_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT communication_types_uq_description UNIQUE (school, description),
  CONSTRAINT communication_types_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.communication_types
  OWNER TO postgres;
GRANT ALL ON TABLE public.communication_types TO postgres;
GRANT ALL ON TABLE public.communication_types TO scuola247_executive;
GRANT SELECT ON TABLE public.communication_types TO postgrest;
COMMENT ON TABLE public.communication_types
  IS 'It refers to the kind of communication handled from the school and any notifies management that will be distincted by school, because it could have addictive costs that not every school wants.';
COMMENT ON COLUMN public.communication_types.communication_type IS 'Unique identification code for the row';
COMMENT ON COLUMN public.communication_types.description IS 'All types of communication avaible';
COMMENT ON COLUMN public.communication_types.notification_management IS 'It''s indicates if this kind of communication manage the notifications';
COMMENT ON COLUMN public.communication_types.school IS 'School with these communication type';


-- Index: public.communication_types_fx_school

-- DROP INDEX public.communication_types_fx_school;

CREATE INDEX communication_types_fx_school
  ON public.communication_types
  USING btree
  (school);

