ALTER TABLE public.branches
  ADD CONSTRAINT branches_ck_description CHECK (length(btrim(description::text)) > 0);
