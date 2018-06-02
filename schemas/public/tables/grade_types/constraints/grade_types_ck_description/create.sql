ALTER TABLE public.grade_types
  ADD CONSTRAINT grade_types_ck_description CHECK (length(btrim(description::text)) > 0);
