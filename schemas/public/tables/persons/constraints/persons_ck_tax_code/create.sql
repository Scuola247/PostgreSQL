ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_tax_code CHECK (length(btrim(tax_code::text)) > 0);
