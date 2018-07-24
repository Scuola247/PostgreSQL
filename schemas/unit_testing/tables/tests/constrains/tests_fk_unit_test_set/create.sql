-- Foreign Key: unit_testing.tests_fk_unit_test_set

-- ALTER TABLE unit_testing.tests DROP CONSTRAINT tests_fk_unit_test_set;

ALTER TABLE unit_testing.tests
  ADD CONSTRAINT tests_fk_unit_test_set FOREIGN KEY (unit_test_set)
      REFERENCES unit_testing.unit_test_sets (unit_test_set) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;
