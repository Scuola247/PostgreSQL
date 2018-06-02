ALTER TABLE public.branches
  ADD CONSTRAINT branches_uq_description UNIQUE(school, description);
