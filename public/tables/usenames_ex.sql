-- Table: public.usenames_ex

-- DROP TABLE public.usenames_ex;

CREATE TABLE public.usenames_ex
(
  usename name NOT NULL, -- The usename for the person
  token character varying(1024), -- Used for the password reset
  language utility.language, -- Preferred language for the user
  CONSTRAINT usenames_ex_pk PRIMARY KEY (usename),
  CONSTRAINT usenames_ex_uq_usename UNIQUE (usename), -- ad ogni db_user di sistema deve corrispondere un solo db_user
  CONSTRAINT usenames_ex_ck_token CHECK (length(btrim(token::text)) > 0)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.usenames_ex
  OWNER TO postgres;
GRANT ALL ON TABLE public.usenames_ex TO postgres;
GRANT ALL ON TABLE public.usenames_ex TO scuola247_executive;
GRANT SELECT ON TABLE public.usenames_ex TO postgrest;
COMMENT ON TABLE public.usenames_ex
  IS 'Add informations to usename''s system table usefull only to scuola247';
COMMENT ON COLUMN public.usenames_ex.usename IS 'The usename for the person';
COMMENT ON COLUMN public.usenames_ex.token IS 'Used for the password reset';
COMMENT ON COLUMN public.usenames_ex.language IS 'Preferred language for the user';

COMMENT ON CONSTRAINT usenames_ex_uq_usename ON public.usenames_ex IS 'ad ogni db_user di sistema deve corrispondere un solo db_user ';


-- Trigger: usenames_ex_iu on public.usenames_ex

-- DROP TRIGGER usenames_ex_iu ON public.usenames_ex;

CREATE TRIGGER usenames_ex_iu
  AFTER INSERT OR UPDATE
  ON public.usenames_ex
  FOR EACH ROW
  EXECUTE PROCEDURE public.tr_usename_iu();

