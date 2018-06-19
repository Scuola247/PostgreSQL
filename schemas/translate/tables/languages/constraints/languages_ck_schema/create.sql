ALTER TABLE translate.languages
  ADD CONSTRAINT languages_ck_schema CHECK (length(btrim(schema::text)) > 0);
