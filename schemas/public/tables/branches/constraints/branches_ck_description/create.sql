﻿-- Check: public.branches_ck_description

-- ALTER TABLE public.branches DROP CONSTRAINT branches_ck_description;
-- another comment line

ALTER TABLE public.branches
  ADD CONSTRAINT branches_ck_description CHECK (length(btrim(description::text)) > 0);
