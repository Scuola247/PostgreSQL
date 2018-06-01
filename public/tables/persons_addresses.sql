-- Table: public.persons_addresses

-- DROP TABLE public.persons_addresses;

CREATE TABLE public.persons_addresses
(
  person_address bigint NOT NULL DEFAULT nextval('pk_seq'::regclass), -- Unique identification code for the row
  person bigint NOT NULL, -- Person that have that address
  address_type address_type NOT NULL, -- The address type of the person
  street character varying(160) NOT NULL, -- The street
  zip_code character varying(15) NOT NULL, -- The zip code
  city character(4) NOT NULL, -- City of the person
  CONSTRAINT persons_addresses_pk PRIMARY KEY (person_address),
  CONSTRAINT persons_addresses_fk_city FOREIGN KEY (city)
      REFERENCES public.cities (city) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT persons_addresses_fk_person FOREIGN KEY (person)
      REFERENCES public.persons (person) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT persons_addresses_uq_indirizzo UNIQUE (person, street, zip_code, city),
  CONSTRAINT persons_addresses_ck_city CHECK (length(btrim(city::text)) > 0),
  CONSTRAINT persons_addresses_ck_street CHECK (length(btrim(street::text)) > 0),
  CONSTRAINT persons_addresses_ck_zip_code CHECK (length(btrim(zip_code::text)) > 0)
)
WITH (
  OIDS=TRUE
);
ALTER TABLE public.persons_addresses
  OWNER TO postgres;
GRANT ALL ON TABLE public.persons_addresses TO postgres;
GRANT ALL ON TABLE public.persons_addresses TO scuola247_executive;
GRANT SELECT ON TABLE public.persons_addresses TO postgrest;
COMMENT ON TABLE public.persons_addresses
  IS 'Contains the address for every person registered in a school';
COMMENT ON COLUMN public.persons_addresses.person_address IS 'Unique identification code for the row';
COMMENT ON COLUMN public.persons_addresses.person IS 'Person that have that address';
COMMENT ON COLUMN public.persons_addresses.address_type IS 'The address type of the person';
COMMENT ON COLUMN public.persons_addresses.street IS 'The street';
COMMENT ON COLUMN public.persons_addresses.zip_code IS 'The zip code';
COMMENT ON COLUMN public.persons_addresses.city IS 'City of the person';


-- Index: public.persons_addresses_fx_city

-- DROP INDEX public.persons_addresses_fx_city;

CREATE INDEX persons_addresses_fx_city
  ON public.persons_addresses
  USING btree
  (city COLLATE pg_catalog."default");

-- Index: public.persons_addresses_fx_person

-- DROP INDEX public.persons_addresses_fx_person;

CREATE INDEX persons_addresses_fx_person
  ON public.persons_addresses
  USING btree
  (person);

