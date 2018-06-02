ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_surname CHECK (length(btrim(surname::text)) > 0);
