ALTER TABLE public.communication_types
  ADD CONSTRAINT communication_types_ck_description CHECK (length(btrim(description::text)) > 0);
