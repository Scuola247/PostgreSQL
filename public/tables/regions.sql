-- Table: public.regions

-- DROP TABLE public.regions;

CREATE TABLE public.regions
(
  region smallint NOT NULL, -- Unique identification code for the row
  description character varying(160) NOT NULL, -- The description for the region
  geographical_area geographical_area, -- The geographical area of the regions
  CONSTRAINT regions_pk PRIMARY KEY (region),
  CONSTRAINT regions_uq_description UNIQUE (description),
  CONSTRAINT regions_ck_description CHECK (length(btrim(description::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.regions
  OWNER TO postgres;
GRANT ALL ON TABLE public.regions TO postgres;
GRANT ALL ON TABLE public.regions TO scuola247_executive;
GRANT SELECT ON TABLE public.regions TO postgrest;
COMMENT ON TABLE public.regions
  IS 'Contains all avaible regions';
COMMENT ON COLUMN public.regions.region IS 'Unique identification code for the row';
COMMENT ON COLUMN public.regions.description IS 'The description for the region';
COMMENT ON COLUMN public.regions.geographical_area IS 'The geographical area of the regions';

