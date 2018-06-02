ALTER TABLE public.branches ALTER COLUMN branch SET DEFAULT nextval('pk_seq'::regclass);

