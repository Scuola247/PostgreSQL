ALTER TABLE public.classrooms
  ADD CONSTRAINT classrooms_ck_section CHECK (length(btrim(section::text)) > 0);
