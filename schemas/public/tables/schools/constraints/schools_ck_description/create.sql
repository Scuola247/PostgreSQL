ALTER TABLE public.schools
  ADD CONSTRAINT schools_ck_description CHECK (length(btrim(description::text)) > 0);
