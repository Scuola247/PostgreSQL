ALTER TABLE translate.languages
  ADD CONSTRAINT languages_ck_description CHECK (length(btrim(description::text)) > 0);
