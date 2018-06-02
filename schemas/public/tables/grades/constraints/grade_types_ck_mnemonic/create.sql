ALTER TABLE public.grades
  ADD CONSTRAINT grades_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0);
