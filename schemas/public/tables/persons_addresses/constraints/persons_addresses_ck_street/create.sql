ALTER TABLE public.persons_addresses
  ADD CONSTRAINT persons_addresses_ck_street CHECK (length(btrim(street::text)) > 0);
