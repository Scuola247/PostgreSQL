ALTER TABLE public.wikimedia_files
  ADD CONSTRAINT wikimedia_files_ck_name CHECK (length(btrim(name)) > 0);
