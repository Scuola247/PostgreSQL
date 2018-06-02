ALTER TABLE public.qualifications
  ADD CONSTRAINT qualifications_ck_name CHECK (length(btrim(name::text)) > 0);
