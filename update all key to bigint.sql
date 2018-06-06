DROP SCHEMA it CASCADE;
DROP VIEW nic_test;
ALTER TABLE public.countries ADD COLUMN processing_code smallint;
COMMENT ON COLUMN public.countries.processing_code IS 'A code that identify the country on the government information system';
UPDATE public.countries SET processing_code = country;
ALTER TABLE public.countries ALTER country SET NOT NULL;
ALTER TABLE public.countries ADD CONSTRAINT countries_uq_processing_code UNIQUE(processing_code);
alter table countries ALTER country TYPE bigint;

alter table regions ALTER region TYPE bigint;
alter table regions ALTER region SET DEFAULT nextval('pk_seq'::regclass);

alter table districts ALTER region TYPE bigint;
alter table districts ALTER region SET NOT NULL;
alter table districts RENAME district to mnemonic;
COMMENT ON COLUMN public.districts.mnemonic IS 'mnemonic identification for district';

ALTER TABLE public.districts ADD COLUMN district bigint;
alter table public.districts ALTER district SET DEFAULT nextval('pk_seq'::regclass);
update public.districts set district = nextval('pk_seq'::regclass);
alter table public.districts ALTER district SET NOT NULL;

ALTER TABLE public.districts ADD CONSTRAINT districts_uq_mnemonic UNIQUE(mnemonic);

alter table cities RENAME district to mnemonic;
ALTER TABLE public.cities ADD COLUMN district bigint;

UPDATE public.cities SET district = d.district FROM districts d WHERE d.mnemonic = cities.mnemonic;
alter table public.cities ALTER district SET NOT NULL;


ALTER TABLE public.cities DROP CONSTRAINT cities_fk_district;
ALTER TABLE public.districts DROP CONSTRAINT districts_pk;
ALTER TABLE public.districts ADD CONSTRAINT districts_pk PRIMARY KEY(district);

ALTER TABLE public.cities
      ADD CONSTRAINT cities_fk_district FOREIGN KEY (district)
      REFERENCES public.districts (district) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


-- View: public.classrooms_students_addresses_ex

-- DROP VIEW public.classrooms_students_addresses_ex;

CREATE OR REPLACE VIEW public.classrooms_students_addresses_ex AS
 SELECT ca.classroom,
    ca.student,
    p.name,
    p.surname,
    p.tax_code,
    p.sex,
    p.born,
    cn.description AS city_of_birth,
    pi.street,
    pi.zip_code,
    ci.description AS city,
    di.mnemonic AS province,
    COALESCE(agrp.absences, 0::bigint) AS absences
   FROM classrooms_students ca
     JOIN persons p ON p.person = ca.student
     JOIN persons_addresses pi ON pi.person = p.person
     LEFT JOIN cities cn ON cn.city = p.city_of_birth
     LEFT JOIN cities ci ON ci.city = pi.city
     LEFT JOIN districts di ON ci.district = di.district
     LEFT JOIN absences_grp agrp ON agrp.student = ca.student
  WHERE p.school = ANY (schools_enabled());

ALTER TABLE public.classrooms_students_addresses_ex
  OWNER TO postgres;
GRANT ALL ON TABLE public.classrooms_students_addresses_ex TO postgres;
GRANT ALL ON TABLE public.classrooms_students_addresses_ex TO scuola247_executive;
GRANT SELECT ON TABLE public.classrooms_students_addresses_ex TO postgrest;
COMMENT ON VIEW public.classrooms_students_addresses_ex
  IS 'Extract all students addresses';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.classroom IS 'The classroom of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.student IS 'Student with these address';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.name IS 'The name of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.surname IS 'The surname of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.tax_code IS 'The tax code of these students';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.sex IS 'sex of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.born IS 'The address where the student born';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.city_of_birth IS 'city of birth for the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.street IS 'The street of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.zip_code IS 'Zip code of student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.city IS 'The city of the student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.province IS 'Province of student';
COMMENT ON COLUMN public.classrooms_students_addresses_ex.absences IS 'The absences of the student';


ALTER TABLE public.cities DROP mnemonic;

alter table cities RENAME city to fiscal_code;


ALTER TABLE public.cities ADD COLUMN city bigint;
alter table public.cities ALTER city SET DEFAULT nextval('pk_seq'::regclass);
update public.cities  set city =nextval('pk_seq'::regclass);
alter table public.cities ALTER city SET NOT NULL;

ALTER TABLE public.cities ADD CONSTRAINT cities_uq_fiscal_code UNIQUE(fiscal_code);


ALTER TABLE public.cities ADD CONSTRAINT cities_uq_district_description UNIQUE(district, description);

alter table public.persons ALTER country_of_birth TYPE bigint;


alter table public.persons RENAME city_of_birth to city_of_birth_fiscal_code;

ALTER TABLE public.persons ADD COLUMN city_of_birth bigint;

alter table public.persons ALTER city_of_birth SET DEFAULT nextval('pk_seq'::regclass);


UPDATE public.persons SET city_of_birth = d.city
  FROM cities d WHERE d.fiscal_code = persons.city_of_birth_fiscal_code;


alter table public.persons_addresses RENAME city to city_fiscal_code;

ALTER TABLE public.persons_addresses ADD COLUMN city bigint;

alter table public.persons_addresses ALTER city SET DEFAULT nextval('pk_seq'::regclass);

UPDATE public.persons_addresses SET city = d.city
  FROM cities d WHERE d.fiscal_code = persons_addresses.city_fiscal_code;

ALTER TABLE public.persons DROP CONSTRAINT persons_fk_city_of_birth;

ALTER TABLE public.persons_addresses DROP CONSTRAINT persons_addresses_fk_city;

DROP VIEW public.residence_grp_city;


ALTER TABLE public.cities DROP CONSTRAINT cities_pk;

ALTER TABLE public.cities
  ADD CONSTRAINT cities_pk PRIMARY KEY(city);

CREATE OR REPLACE VIEW public.residence_grp_city AS
 SELECT p.school,
    c.description,
    count(p.person) AS count
   FROM persons p
     JOIN persons_addresses pi ON pi.person = p.person
     JOIN cities c ON pi.city = c.city
  WHERE pi.address_type = 'Residence'::address_type
  GROUP BY p.school, c.city;

ALTER TABLE public.residence_grp_city
  OWNER TO postgres;
GRANT ALL ON TABLE public.residence_grp_city TO postgres;
GRANT ALL ON TABLE public.residence_grp_city TO scuola247_executive;
GRANT SELECT ON TABLE public.residence_grp_city TO postgrest;
COMMENT ON VIEW public.residence_grp_city
  IS 'Regroup all cities';
COMMENT ON COLUMN public.residence_grp_city.school IS 'School in this city';
COMMENT ON COLUMN public.residence_grp_city.description IS 'Description of the residence';

ALTER TABLE public.persons
  ADD CONSTRAINT persons_fk_city_of_birth FOREIGN KEY (city_of_birth)
      REFERENCES public.cities (city) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE public.persons_addresses
  ADD CONSTRAINT persons_addresses_fk_city FOREIGN KEY (city)
      REFERENCES public.cities (city) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE RESTRICT;
