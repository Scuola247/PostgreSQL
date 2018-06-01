-- Table: public.persons

-- DROP TABLE public.persons;

CREATE TABLE public.persons
(
  person bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  name character varying(60) NOT NULL, -- Name of the person
  surname character varying(60) NOT NULL, -- The surname of this person
  born date, -- The date when person born
  deceased date, -- Check if the person is deceased
  country_of_birth smallint, -- Country of birth for the person
  tax_code character(16), -- The tax code for every person
  sex sex NOT NULL, -- Sex of the person
  school bigint, -- The school for this person
  sidi bigint, -- Sidi of the person
  city_of_birth character(4), -- The city of birth for the person
  thumbnail image, -- Thumbnail of the person
  note text, -- contains addtional informatio about person
  usename name, -- The usename of these persons
  photo image, -- The photo for these persons
  CONSTRAINT persons_pk PRIMARY KEY (person),
  CONSTRAINT persons_fk_city_of_birth FOREIGN KEY (city_of_birth)
      REFERENCES public.cities (city) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT persons_fk_country_of_birth FOREIGN KEY (country_of_birth)
      REFERENCES public.countries (country) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT persons_fk_school FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT persons_fk_usename FOREIGN KEY (usename)
      REFERENCES public.usenames_ex (usename) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT persons_uq_school_tax_code UNIQUE (school, tax_code),
  CONSTRAINT persons_uq_usename UNIQUE (school, usename), -- for every school we cannot have more than one person with the same usename (we can have hovewer the same person with more roles in the same school)
  CONSTRAINT persons_ck_city_of_birth CHECK (length(btrim(city_of_birth::text)) > 0),
  CONSTRAINT persons_ck_name CHECK (length(btrim(name::text)) > 0),
  CONSTRAINT persons_ck_note CHECK (length(btrim(note)) > 0),
  CONSTRAINT persons_ck_surname CHECK (length(btrim(surname::text)) > 0),
  CONSTRAINT persons_ck_tax_code CHECK (length(btrim(tax_code::text)) > 0),
  CONSTRAINT persons_ck_usename CHECK (length(btrim(usename::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.persons
  OWNER TO postgres;
GRANT ALL ON TABLE public.persons TO postgres;
GRANT SELECT ON TABLE public.persons TO postgrest;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE public.persons TO scuola247_executive;
GRANT SELECT, UPDATE ON TABLE public.persons TO scuola247_relative;
COMMENT ON COLUMN public.persons.person IS 'Unique identification code for the row';
COMMENT ON COLUMN public.persons.name IS 'Name of the person';
COMMENT ON COLUMN public.persons.surname IS 'The surname of this person';
COMMENT ON COLUMN public.persons.born IS 'The date when person born';
COMMENT ON COLUMN public.persons.deceased IS 'Check if the person is deceased';
COMMENT ON COLUMN public.persons.country_of_birth IS 'Country of birth for the person';
COMMENT ON COLUMN public.persons.tax_code IS 'The tax code for every person';
COMMENT ON COLUMN public.persons.sex IS 'Sex of the person';
COMMENT ON COLUMN public.persons.school IS 'The school for this person';
COMMENT ON COLUMN public.persons.sidi IS 'Sidi of the person';
COMMENT ON COLUMN public.persons.city_of_birth IS 'The city of birth for the person';
COMMENT ON COLUMN public.persons.thumbnail IS 'Thumbnail of the person';
COMMENT ON COLUMN public.persons.note IS 'contains addtional informatio about person';
COMMENT ON COLUMN public.persons.usename IS 'The usename of these persons';
COMMENT ON COLUMN public.persons.photo IS 'The photo for these persons';

COMMENT ON CONSTRAINT persons_uq_usename ON public.persons IS 'for every school we cannot have more than one person with the same usename (we can have hovewer the same person with more roles in the same school) ';


-- Index: public.persons_fx_city_of_birth

-- DROP INDEX public.persons_fx_city_of_birth;

CREATE INDEX persons_fx_city_of_birth
  ON public.persons
  USING btree
  (city_of_birth COLLATE pg_catalog."default");

-- Index: public.persons_fx_country_of_birth

-- DROP INDEX public.persons_fx_country_of_birth;

CREATE INDEX persons_fx_country_of_birth
  ON public.persons
  USING btree
  (country_of_birth);

-- Index: public.persons_fx_school

-- DROP INDEX public.persons_fx_school;

CREATE INDEX persons_fx_school
  ON public.persons
  USING btree
  (school);

-- Index: public.persons_fx_usename

-- DROP INDEX public.persons_fx_usename;

CREATE INDEX persons_fx_usename
  ON public.persons
  USING btree
  (usename);

-- Index: public.persons_ix_usename_school

-- DROP INDEX public.persons_ix_usename_school;

CREATE INDEX persons_ix_usename_school
  ON public.persons
  USING btree
  (usename, school);
COMMENT ON INDEX public.persons_ix_usename_school
  IS 'for the policy roles about horizontal security';

