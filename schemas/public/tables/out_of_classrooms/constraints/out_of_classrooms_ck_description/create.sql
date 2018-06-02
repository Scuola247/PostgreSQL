ALTER TABLE public.out_of_classrooms
  ADD CONSTRAINT out_of_classrooms_ck_description CHECK (length(btrim(description::text)) > 0);
