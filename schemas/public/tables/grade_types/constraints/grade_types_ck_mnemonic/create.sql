ALTER TABLE public.grade_types
  ADD CONSTRAINT grade_types_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0);
