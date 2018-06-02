ALTER TABLE public.countries
  ADD CONSTRAINT countries_ck_description CHECK (length(btrim(description::text)) > 0);
