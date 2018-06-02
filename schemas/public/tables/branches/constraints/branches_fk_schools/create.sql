ALTER TABLE public.branches
  ADD CONSTRAINT branches_fk_schools FOREIGN KEY (school)
      REFERENCES public.schools (school) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT;

