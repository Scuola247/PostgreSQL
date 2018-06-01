-- Check: public.messages_ck_message_text

-- ALTER TABLE public.messages DROP CONSTRAINT messages_ck_message_text;

ALTER TABLE public.messages
  ADD CONSTRAINT messages_ck_message_text CHECK (length(btrim(message_text::text)) > 0);
