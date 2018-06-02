ALTER TABLE public.schools
  ADD CONSTRAINT schools_ck_processing_code CHECK (length(btrim(processing_code::text)) > 0);
