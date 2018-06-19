ALTER TABLE datasets.entity_coding
  ADD CONSTRAINT entity_coding_ck_entity CHECK (length(btrim(entity::text)) > 0);
