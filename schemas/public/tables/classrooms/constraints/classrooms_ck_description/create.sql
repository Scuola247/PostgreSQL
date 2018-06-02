-- Check: public.branches_ck_description

-- ALTER TABLE public.branches DROP CONSTRAINT branches_ck_description;

ALTER TABLE public.classrooms
  ADD CONSTRAINT classrooms_ck_description CHECK (length(btrim(description::text)) > 0);
