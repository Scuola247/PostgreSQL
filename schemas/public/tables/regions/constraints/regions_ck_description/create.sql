ALTER TABLE public.regions
  ADD CONSTRAINT regions_ck_description CHECK (length(btrim(description::text)) > 0);
