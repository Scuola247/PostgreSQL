-- Type: diagnostic.verbosities

-- DROP TYPE diagnostic.verbosities;

CREATE TYPE diagnostic.verbosities AS ENUM
   ('log',
    'notice',
    'warning',
    'error',
    'fatal',
    'panic',
    'debug1',
    'debug2',
    'debug3',
    'debug4',
    'debug5');
ALTER TYPE diagnostic.verbosities
  OWNER TO scuola247_supervisor;
