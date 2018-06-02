ALTER TABLE public.cities
  ADD CONSTRAINT cities_ck_district CHECK (length(btrim(district::text)) > 0);
