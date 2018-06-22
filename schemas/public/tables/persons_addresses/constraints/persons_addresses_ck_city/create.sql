-- Check: public.persons_addresses_ck_city

-- ALTER TABLE public.persons_addresses DROP CONSTRAINT persons_addresses_ck_city;

ALTER TABLE public.persons_addresses
  ADD CONSTRAINT persons_addresses_ck_city CHECK (length(btrim(city_fiscal_code::text)) > 0);
