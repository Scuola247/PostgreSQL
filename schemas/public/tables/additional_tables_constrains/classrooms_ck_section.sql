-- Check: public.classrooms_ck_section

-- ALTER TABLE public.classrooms DROP CONSTRAINT classrooms_ck_section;

ALTER TABLE public.classrooms
  ADD CONSTRAINT classrooms_ck_section CHECK (length(btrim(section::text)) > 0);
