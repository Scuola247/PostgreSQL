ALTER TABLE datasets.entity_coding
  ADD CONSTRAINT entity_coding_ck_coding CHECK (length(btrim(coding::text)) > 0));
