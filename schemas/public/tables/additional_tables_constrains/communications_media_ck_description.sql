-- Check: public.communications_media_ck_description

-- ALTER TABLE public.communications_media DROP CONSTRAINT communications_media_ck_description;

ALTER TABLE public.communications_media
  ADD CONSTRAINT communications_media_ck_description CHECK (length(btrim(description::text)) > 0);
