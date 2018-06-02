ALTER TABLE public.persons
  ADD CONSTRAINT persons_ck_city_of_birth CHECK (length(btrim(city_of_birth::text)) > 0);
