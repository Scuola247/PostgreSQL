ALTER TABLE public.explanations
  ADD CONSTRAINT explanations_ck_description CHECK (length(btrim(description::text)) > 0);
