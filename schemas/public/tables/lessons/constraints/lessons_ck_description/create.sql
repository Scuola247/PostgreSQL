ALTER TABLE public.lessons
  ADD CONSTRAINT lessons_ck_description CHECK (length(btrim(description::text)) > 0);
