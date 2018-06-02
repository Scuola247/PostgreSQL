ALTER TABLE public.communications_media
  ADD CONSTRAINT communications_media_ck_description CHECK (length(btrim(description::text)) > 0);
