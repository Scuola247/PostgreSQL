ALTER TABLE public.usenames_schools
  ADD CONSTRAINT usenames_schools_ck_usename CHECK (length(btrim(usename::text)) > 0);
