-- Table: public.valutations_qualifications

-- DROP TABLE public.valutations_qualifications;

CREATE TABLE public.valutations_qualifications
(
  valutation_qualificationtion bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  valutation bigint NOT NULL, -- The valutation of a qualification
  qualification bigint NOT NULL, -- Unique identification code for the row
  grade bigint NOT NULL, -- Grade of the qualification
  note character varying(2048), -- The note for the qualification
  CONSTRAINT valutations_qualificationtions_pk PRIMARY KEY (valutation_qualificationtion),
  CONSTRAINT valutations_qualificationtions_fk_grade FOREIGN KEY (grade)
      REFERENCES public.grades (grade) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT valutations_qualificationtions_fk_qualification FOREIGN KEY (qualification)
      REFERENCES public.qualifications (qualification) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT valutations_qualificationtions_fk_valutation FOREIGN KEY (valutation)
      REFERENCES public.valutations (valutation) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT valutations_qualificationtions_uq_qualification UNIQUE (valutation, qualification),
  CONSTRAINT valutations_qualifications_schools_ck_note CHECK (length(btrim(note::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.valutations_qualifications
  OWNER TO postgres;
GRANT ALL ON TABLE public.valutations_qualifications TO postgres;
GRANT ALL ON TABLE public.valutations_qualifications TO scuola247_executive;
GRANT SELECT ON TABLE public.valutations_qualifications TO postgrest;
COMMENT ON TABLE public.valutations_qualifications
  IS 'For every valution inserted in valutations table is possible to connect valutation too of qualifications connected that are saved here';
COMMENT ON COLUMN public.valutations_qualifications.valutation_qualificationtion IS 'Unique identification code for the row';
COMMENT ON COLUMN public.valutations_qualifications.valutation IS 'The valutation of a qualification';
COMMENT ON COLUMN public.valutations_qualifications.qualification IS 'Unique identification code for the row';
COMMENT ON COLUMN public.valutations_qualifications.grade IS 'Grade of the qualification';
COMMENT ON COLUMN public.valutations_qualifications.note IS 'The note for the qualification';


-- Index: public.valutations_qualificationtions_fx_grade

-- DROP INDEX public.valutations_qualificationtions_fx_grade;

CREATE INDEX valutations_qualificationtions_fx_grade
  ON public.valutations_qualifications
  USING btree
  (grade);
COMMENT ON INDEX public.valutations_qualificationtions_fx_grade
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.valutations_qualificationtions_fx_qualification

-- DROP INDEX public.valutations_qualificationtions_fx_qualification;

CREATE INDEX valutations_qualificationtions_fx_qualification
  ON public.valutations_qualifications
  USING btree
  (qualification);
COMMENT ON INDEX public.valutations_qualificationtions_fx_qualification
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.valutations_qualificationtions_fx_valutation

-- DROP INDEX public.valutations_qualificationtions_fx_valutation;

CREATE INDEX valutations_qualificationtions_fx_valutation
  ON public.valutations_qualifications
  USING btree
  (valutation);
COMMENT ON INDEX public.valutations_qualificationtions_fx_valutation
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: valutations_qualifications_iu on public.valutations_qualifications

-- DROP TRIGGER valutations_qualifications_iu ON public.valutations_qualifications;

CREATE TRIGGER valutations_qualifications_iu
  AFTER INSERT OR UPDATE
  ON public.valutations_qualifications
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_valutations_qualifications_iu();

