-- Function: unit_tests_public._after_data_insert(boolean)

-- DROP FUNCTION unit_tests_public._after_data_insert(boolean);

CREATE OR REPLACE FUNCTION unit_tests_public._after_data_insert(
    IN _build_dependencies boolean DEFAULT false,
    OUT _results unit_testing.unit_test_result[])
  RETURNS unit_testing.unit_test_result[] AS
$BODY$
<<me>>
DECLARE 
  context               text;
  full_function_name 	text;
  test_name		text = 'META test';
BEGIN
--------------------------------------------------------------------------------------------------------------------------
--- THIS IS A META TEST: ITS PURPOSE IS TO CREATE A POINT OF DEPENDENCY FOR THE TESTS TO RUN AFTER TABLE DATA INSERTED ---
--------------------------------------------------------------------------------------------------------------------------
  GET DIAGNOSTICS context = PG_CONTEXT;
  full_function_name = diagnostic.full_function_name(context);
  -- check to build dependencies
  IF _build_dependencies THEN
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'unit_tests_public.absences',
										       'unit_tests_public.branches',
										       'unit_tests_public.cities',
										       'unit_tests_public.classrooms',
										       'unit_tests_public.classrooms_students',
										       'unit_tests_public.communication_types',
										       'unit_tests_public.communications_media',
										       'unit_tests_public.conversations',
										       'unit_tests_public.conversations_invites',
										       'unit_tests_public.countries',
										       'unit_tests_public.degrees',
										       'unit_tests_public.delays',
										       'unit_tests_public.districts',
										       'unit_tests_public.explanations',
										       'unit_tests_public.faults',
										       'unit_tests_public.grade_types',
										       'unit_tests_public.grades',
										       'unit_tests_public.grading_meetings',
										       'unit_tests_public.grading_meetings_close',
										       'unit_tests_public.grading_meetings_valutations',
										       'unit_tests_public.grading_meetings_valutations_qua',
										       'unit_tests_public.holidays',
										       'unit_tests_public.leavings',
										       'unit_tests_public.lessons',
										       'unit_tests_public.messages',
										       'unit_tests_public.messages_read',
										       'unit_tests_public.metrics','unit_tests_public.notes',
										       'unit_tests_public.notes_signed',
										       'unit_tests_public.out_of_classrooms',
										       'unit_tests_public.parents_meetings',
										       'unit_tests_public.persons',
										       'unit_tests_public.persons_addresses',
										       'unit_tests_public.persons_relations',
										       'unit_tests_public.persons_roles',
										       'unit_tests_public.qualifications',
										       'unit_tests_public.regions',
										       'unit_tests_public.school_years',
										       'unit_tests_public.schools',
										       'unit_tests_public.schools_behavior',
										       'unit_tests_public.subjects',
										       'unit_tests_public.teachears_notes',
										       'unit_tests_public.topics',
										       'unit_tests_public.usenames_ex',
										       'unit_tests_public.usenames_schools',
										       'unit_tests_public.valutations',
										       'unit_tests_public.valutations_qualifications',
										       'unit_tests_public.weekly_timetables',
										       'unit_tests_public.weekly_timetables_days',
										       'unit_tests_public.wikimedia_files',
										       'unit_tests_public.wikimedia_files_persons');
    RETURN;
  END IF;

  _results = _results || assert.pass(full_function_name, test_name);
  
RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests_public._after_data_insert(boolean)
  OWNER TO postgres;
COMMENT ON FUNCTION unit_tests_public._after_data_insert(boolean) IS 'THIS IS A META TEST: ITS PURPOSE IS TO CREATE A POINT OF DEPENDENCY FOR THE TESTS TO RUN AFTER TABLE DATA INSERTED';
