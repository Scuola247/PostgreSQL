-- Schema: assert

-- DROP SCHEMA assert;

CREATE SCHEMA assert
  AUTHORIZATION postgres;

GRANT ALL ON SCHEMA assert TO postgres;
GRANT USAGE ON SCHEMA assert TO scuola247_student;
COMMENT ON SCHEMA assert
  IS 'Contains all the asserts used in the unit_testing project';

