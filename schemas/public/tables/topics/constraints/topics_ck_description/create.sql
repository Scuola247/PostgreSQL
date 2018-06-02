ALTER TABLE public.topics
  ADD CONSTRAINT topics_ck_description CHECK (length(btrim(description::text)) > 0);
