ALTER TABLE public.districts
  ADD CONSTRAINT districts_ck_district CHECK (length(btrim(district::text)) > 0);
