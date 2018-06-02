ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_name CHECK (length(btrim(name::text)) > 0);
