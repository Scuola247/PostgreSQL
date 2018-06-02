-- Check: public.classrooms_ck_description

-- ALTER TABLE public.classrooms DROP CONSTRAINT classrooms_ck_description;

ALTER TABLE public.classrooms
  ADD CONSTRAINT classrooms_ck_description CHECK (length(btrim(description::text)) > 0);
