-- Table: public.cities

-- DROP TABLE public.cities;

CREATE TABLE public.cities
(
  city character(4) NOT NULL, -- Unique identification code for the row
  description character varying(160) NOT NULL, -- The description for the city
  district character(2) NOT NULL, -- The district
  CONSTRAINT cities_pk PRIMARY KEY (city),
  CONSTRAINT cities_fk_district FOREIGN KEY (district)
      REFERENCES public.districts (district) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT cities_uq_description UNIQUE (description, district), -- There must not exist two differents cities for district!
  CONSTRAINT cities_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT cities_ck_district CHECK (length(btrim(district::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.cities
  OWNER TO postgres;
GRANT ALL ON TABLE public.cities TO postgres;
GRANT ALL ON TABLE public.cities TO scuola247_executive;
GRANT SELECT ON TABLE public.cities TO postgrest;
COMMENT ON TABLE public.cities
  IS 'Contains all avaible cities';
COMMENT ON COLUMN public.cities.city IS 'Unique identification code for the row';
COMMENT ON COLUMN public.cities.description IS 'The description for the city';
COMMENT ON COLUMN public.cities.district IS 'The district';

COMMENT ON CONSTRAINT cities_uq_description ON public.cities IS 'There must not exist two differents cities for district!';


-- Index: public.cities_fx_district

-- DROP INDEX public.cities_fx_district;

CREATE INDEX cities_fx_district
  ON public.cities
  USING btree
  (district COLLATE pg_catalog."default");

