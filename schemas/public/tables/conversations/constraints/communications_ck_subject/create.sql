ALTER TABLE public.conversations
  ADD CONSTRAINT conversations_ck_subject CHECK (length(btrim(subject::text)) > 0);
