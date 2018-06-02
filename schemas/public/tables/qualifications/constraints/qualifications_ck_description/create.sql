ALTER TABLE public.qualifications
  ADD CONSTRAINT qualifications_ck_description CHECK (length(btrim(description::text)) > 0);
