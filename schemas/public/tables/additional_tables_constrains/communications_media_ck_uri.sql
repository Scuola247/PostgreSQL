-- Check: public.communications_media_ck_uri

-- ALTER TABLE public.communications_media DROP CONSTRAINT communications_media_ck_uri;

ALTER TABLE public.communications_media
  ADD CONSTRAINT communications_media_ck_uri CHECK (length(btrim(uri::text)) > 0);
