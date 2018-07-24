-- Foreign Key: unit_testing.tests_details_fk_tests

-- ALTER TABLE unit_testing.tests_details DROP CONSTRAINT tests_details_fk_tests;

ALTER TABLE unit_testing.tests_details
  ADD CONSTRAINT tests_details_fk_tests FOREIGN KEY (test)
      REFERENCES unit_testing.tests (test) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
