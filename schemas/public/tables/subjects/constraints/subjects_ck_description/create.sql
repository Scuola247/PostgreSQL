ALTER TABLE public.subjects
  ADD CONSTRAINT subjects_ck_description CHECK (length(btrim(description::text)) > 0);
