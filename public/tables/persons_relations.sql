-- Table: public.persons_relations

-- DROP TABLE public.persons_relations;

CREATE TABLE public.persons_relations
(
  person_relation bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- The relation of this person with the student
  person bigint NOT NULL, -- Person that has this relation
  person_related_to bigint NOT NULL, -- Indicates the person related to the student
  sign_request boolean NOT NULL DEFAULT true, -- Indicates that, in case of classroom notes (example: museum visit) or disciplinary notes, the teacher has to check if the parent checked the note
  relationship relationships NOT NULL, -- The relationship about the parent and the student
  can_do_explanation boolean DEFAULT false, -- Indicates if can do explanations for the student
  CONSTRAINT persons_relations_pk PRIMARY KEY (person_relation),
  CONSTRAINT persons_relations_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT persons_relations_fk_person_related_to FOREIGN KEY (person_related_to)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT persons_relations_uq_person UNIQUE (person, relationship, person_related_to)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.persons_relations
  OWNER TO postgres;
GRANT ALL ON TABLE public.persons_relations TO postgres;
GRANT ALL ON TABLE public.persons_relations TO scuola247_executive;
GRANT SELECT ON TABLE public.persons_relations TO postgrest;
COMMENT ON TABLE public.persons_relations
  IS 'Indicates the relations abount persons: tipically student(coloumn person) will have for relationship ''Parent''  the father (person_related_to) for indicates the mother will add a row with same values as said before but looking that this time to insert in coloumn person_related_to the code of person that identifies the mother';
COMMENT ON COLUMN public.persons_relations.person_relation IS 'The relation of this person with the student';
COMMENT ON COLUMN public.persons_relations.person IS 'Person that has this relation';
COMMENT ON COLUMN public.persons_relations.person_related_to IS 'Indicates the person related to the student';
COMMENT ON COLUMN public.persons_relations.sign_request IS 'Indicates that, in case of classroom notes (example: museum visit) or disciplinary notes, the teacher has to check if the parent checked the note';
COMMENT ON COLUMN public.persons_relations.relationship IS 'The relationship about the parent and the student';
COMMENT ON COLUMN public.persons_relations.can_do_explanation IS 'Indicates if can do explanations for the student';


-- Index: public.persons_relations_fx_person

-- DROP INDEX public.persons_relations_fx_person;

CREATE INDEX persons_relations_fx_person
  ON public.persons_relations
  USING btree
  (person);
COMMENT ON INDEX public.persons_relations_fx_person
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

-- Index: public.persons_relations_fx_person_related_to

-- DROP INDEX public.persons_relations_fx_person_related_to;

CREATE INDEX persons_relations_fx_person_related_to
  ON public.persons_relations
  USING btree
  (person_related_to);
COMMENT ON INDEX public.persons_relations_fx_person_related_to
  IS 'Indice per l''acceso from_timela relativa chiave esterna';

