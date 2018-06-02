-- Table: public.topics

-- DROP TABLE public.topics;

CREATE TABLE public.topics
(
  topic bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  subject bigint NOT NULL, -- Subject for the topic
  description character varying(160) NOT NULL, -- The description of the topic
  course_year course_year, -- The course year with these topics
  degree bigint NOT NULL, -- The degree for the topic
  CONSTRAINT topics_pk PRIMARY KEY (topic),
  CONSTRAINT topics_fk_degree FOREIGN KEY (degree)
      REFERENCES public.degrees (degree) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT topics_fk_subject FOREIGN KEY (subject)
      REFERENCES public.subjects (subject) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT topics_uq_description UNIQUE (degree, course_year, subject, description), -- test
  CONSTRAINT topics_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.topics
  OWNER TO postgres;
GRANT ALL ON TABLE public.topics TO postgres;
GRANT ALL ON TABLE public.topics TO scuola247_executive;
GRANT SELECT ON TABLE public.topics TO postgrest;
COMMENT ON TABLE public.topics
  IS 'Contains the object topics of a valutation';
COMMENT ON COLUMN public.topics.topic IS 'Unique identification code for the row';
COMMENT ON COLUMN public.topics.subject IS 'Subject for the topic';
COMMENT ON COLUMN public.topics.description IS 'The description of the topic';
COMMENT ON COLUMN public.topics.course_year IS 'The course year with these topics';
COMMENT ON COLUMN public.topics.degree IS 'The degree for the topic';

COMMENT ON CONSTRAINT topics_uq_description ON public.topics IS 'test';


-- Index: public.topics_fx_degree

-- DROP INDEX public.topics_fx_degree;

CREATE INDEX topics_fx_degree
  ON public.topics
  USING btree
  (degree);

-- Index: public.topics_fx_subject

-- DROP INDEX public.topics_fx_subject;

CREATE INDEX topics_fx_subject
  ON public.topics
  USING btree
  (subject);
COMMENT ON INDEX public.topics_fx_subject
  IS 'Indice per l''acceso from_timela relativa chiave esterna';


-- Trigger: topics_iu on public.topics

-- DROP TRIGGER topics_iu ON public.topics;

CREATE TRIGGER topics_iu
  AFTER INSERT OR UPDATE
  ON public.topics
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_topics_iu();

