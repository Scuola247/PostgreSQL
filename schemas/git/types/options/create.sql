-- Type: git.options

-- DROP TYPE git.options;

CREATE TYPE git.options AS ENUM
   ('Pull',
    'Push');
ALTER TYPE git.options
  OWNER TO scuola247_supervisor;
