ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_usename CHECK (length(btrim(usename::text)) > 0);
