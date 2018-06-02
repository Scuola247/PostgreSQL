ALTER TABLE public.districts
  ADD CONSTRAINT districts_ck_description CHECK (length(btrim(description::text)) > 0);
