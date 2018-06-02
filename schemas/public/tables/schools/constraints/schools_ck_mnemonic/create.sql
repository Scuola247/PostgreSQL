ALTER TABLE public.schools
  ADD CONSTRAINT schools_ck_mnemonic CHECK (length(btrim(mnemonic::text)) > 0);
