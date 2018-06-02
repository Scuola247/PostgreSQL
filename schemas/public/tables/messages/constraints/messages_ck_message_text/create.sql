ALTER TABLE public.messages
  ADD CONSTRAINT messages_ck_message_text CHECK (length(btrim(message_text::text)) > 0);
