-- Constraint: public.branches_uq_description

-- ALTER TABLE public.branches DROP CONSTRAINT branches_uq_description;

ALTER TABLE public.branches
  ADD CONSTRAINT branches_uq_description UNIQUE(school, description);
