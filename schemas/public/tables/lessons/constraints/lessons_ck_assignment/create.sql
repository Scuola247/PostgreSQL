ALTER TABLE public.lessons
  ADD CONSTRAINT lessons_ck_assignment CHECK (length(btrim(assignment::text)) > 0);
