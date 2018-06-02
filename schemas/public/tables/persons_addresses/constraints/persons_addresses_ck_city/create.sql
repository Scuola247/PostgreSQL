ALTER TABLE public.persons_addresses
  ADD CONSTRAINT persons_addresses_ck_city CHECK (length(btrim(city::text)) > 0);
