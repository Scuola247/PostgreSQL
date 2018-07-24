-- Constraint: unit_testing.tests_details_pk

-- ALTER TABLE unit_testing.tests_details DROP CONSTRAINT tests_details_pk;

ALTER TABLE unit_testing.tests_details
  ADD CONSTRAINT tests_details_pk PRIMARY KEY(tests_detail);
