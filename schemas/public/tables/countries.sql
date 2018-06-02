-- Table: public.countries

-- DROP TABLE public.countries;

CREATE TABLE public.countries
(
  country smallint NOT NULL, -- Unique identification code for the row
  description character varying(160) NOT NULL, -- A description for the countries
  existing boolean NOT NULL DEFAULT true, -- Checked if the country exist
  CONSTRAINT countries_pk PRIMARY KEY (country),
  CONSTRAINT countries_uq_description UNIQUE (description),
  CONSTRAINT countries_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.countries
  OWNER TO postgres;
GRANT ALL ON TABLE public.countries TO postgres;
GRANT ALL ON TABLE public.countries TO scuola247_executive;
GRANT SELECT ON TABLE public.countries TO postgrest;
COMMENT ON TABLE public.countries
  IS 'Contains all avaible countries';
COMMENT ON COLUMN public.countries.country IS 'Unique identification code for the row';
COMMENT ON COLUMN public.countries.description IS 'A description for the countries';
COMMENT ON COLUMN public.countries.existing IS 'Checked if the country exist';

