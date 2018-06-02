ALTER TABLE public.usenames_ex
  ADD CONSTRAINT usenames_ex_ck_token CHECK (length(btrim(token::text)) > 0);
