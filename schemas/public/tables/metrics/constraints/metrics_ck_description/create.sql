ALTER TABLE public.metrics
  ADD CONSTRAINT metrics_ck_description CHECK (length(btrim(description::text)) > 0);
