-- Table: public.districts

-- DROP TABLE public.districts;

CREATE TABLE public.districts
(
  district character(2) NOT NULL, -- Unique identification code for the row
  description character varying(160) NOT NULL, -- Unique identification code for the row
  region smallint, -- The region
  CONSTRAINT districts_pk PRIMARY KEY (district),
  CONSTRAINT districts_fk_region FOREIGN KEY (region)
      REFERENCES public.regions (region) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT districts_uq_description UNIQUE (description),
  CONSTRAINT districts_ck_description CHECK (length(btrim(description::text)) > 0),
  CONSTRAINT districts_ck_district CHECK (length(btrim(district::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.districts
  OWNER TO postgres;
GRANT ALL ON TABLE public.districts TO postgres;
GRANT ALL ON TABLE public.districts TO scuola247_executive;
GRANT SELECT ON TABLE public.districts TO postgrest;
COMMENT ON TABLE public.districts
  IS 'Contains all avaible districts';
COMMENT ON COLUMN public.districts.district IS 'Unique identification code for the row';
COMMENT ON COLUMN public.districts.description IS 'Unique identification code for the row';
COMMENT ON COLUMN public.districts.region IS 'The region';

