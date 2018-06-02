-- Table: public.qualifications_plan

-- DROP TABLE public.qualifications_plan;

CREATE TABLE public.qualifications_plan
(
  qualificationtion_plan bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  qualification bigint NOT NULL, -- The qualification
  degree bigint, -- Degree of the qualifications
  course_year course_year, -- Course year with these qualifications
  subject bigint, -- Subject in the qulification plan
  CONSTRAINT qualificationtions_plan_pk PRIMARY KEY (qualificationtion_plan),
  CONSTRAINT qualificationtions_plan_fk_degree FOREIGN KEY (degree)
      REFERENCES public.degrees (degree) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT qualificationtions_plan_fk_qualification FOREIGN KEY (qualification)
      REFERENCES public.qualifications (qualification) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT qualificationtions_plan_fk_subjects FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT qualificationtions_plan_uq_qualification UNIQUE (degree, course_year, subject, qualification)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.qualifications_plan
  OWNER TO postgres;
GRANT ALL ON TABLE public.qualifications_plan TO postgres;
GRANT ALL ON TABLE public.qualifications_plan TO scuola247_executive;
GRANT SELECT ON TABLE public.qualifications_plan TO postgrest;
COMMENT ON TABLE public.qualifications_plan
  IS 'Contains the connections about the information plan (degree, course_year e subject) and qualificationtions.
It is necessary in valutation fase for presenting the qualifications to the parents about valutations';
COMMENT ON COLUMN public.qualifications_plan.qualificationtion_plan IS 'Unique identification code for the row';
COMMENT ON COLUMN public.qualifications_plan.qualification IS 'The qualification';
COMMENT ON COLUMN public.qualifications_plan.degree IS 'Degree of the qualifications';
COMMENT ON COLUMN public.qualifications_plan.course_year IS 'Course year with these qualifications';
COMMENT ON COLUMN public.qualifications_plan.subject IS 'Subject in the qulification plan';


-- Index: public.qualificationtions_plan_fx_degree

-- DROP INDEX public.qualificationtions_plan_fx_degree;

CREATE INDEX qualificationtions_plan_fx_degree
  ON public.qualifications_plan
  USING btree
  (degree);

-- Index: public.qualificationtions_plan_fx_qualification

-- DROP INDEX public.qualificationtions_plan_fx_qualification;

CREATE INDEX qualificationtions_plan_fx_qualification
  ON public.qualifications_plan
  USING btree
  (qualification);

-- Index: public.qualificationtions_plan_fx_subject

-- DROP INDEX public.qualificationtions_plan_fx_subject;

CREATE INDEX qualificationtions_plan_fx_subject
  ON public.qualifications_plan
  USING btree
  (subject);

