ALTER TABLE public.cities
  ADD CONSTRAINT cities_ck_description CHECK (length(btrim(description::text)) > 0);
