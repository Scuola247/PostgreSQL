ALTER TABLE public.persons_addresses
  ADD CONSTRAINT persons_addresses_ck_zip_code CHECK (length(btrim(zip_code::text)) > 0);
