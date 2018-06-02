ALTER TABLE public.grades
  ADD CONSTRAINT grades_ck_description CHECK (length(btrim(description::text)) > 0);
