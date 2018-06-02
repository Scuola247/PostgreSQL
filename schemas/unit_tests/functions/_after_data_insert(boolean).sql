-- Function: unit_tests._after_data_insert(boolean)

-- DROP FUNCTION unit_tests._after_data_insert(boolean);

CREATE OR REPLACE FUNCTION unit_tests._after_data_insert(
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
    PERFORM unit_testing.build_function_dependencies(diagnostic.function_name(context),'absences',
										       'branches',
										       'cities',
										       'classrooms',
										       'classrooms_students',
										       'communication_types',
										       'communications_media',
										       'conversations',
										       'conversations_invites',
										       'countries',
										       'degrees',
										       'delays',
										       'districts',
										       'explanations',
										       'faults',
										       'grade_types',
										       'grades',
										       'grading_meetings',
										       'grading_meetings_close',
										       'grading_meetings_valutations',
										       'grading_meetings_valutations_qua',
										       'holidays',
										       'leavings',
										       'lessons',
										       'messages',
										       'messages_read',
										       'metrics','notes',
										       'notes_signed',
										       'out_of_classrooms',
										       'parents_meetings',
										       'persons',
										       'persons_addresses',
										       'persons_relations',
										       'persons_roles',
										       'qualifications',
										       'regions',
										       'school_years',
										       'schools',
										       'schools_behavior',
										       'subjects',
										       'teachears_notes',
										       'topics',
										       'usenames_ex',
										       'usenames_schools',
										       'valutations',
										       'valutations_qualifications',
										       'weekly_timetables',
										       'weekly_timetables_days',
										       'wikimedia_files',
										       'wikimedia_files_persons');
    RETURN;
  END IF;

  _results = _results || assert.pass(full_function_name, test_name);
  
RETURN; 
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION unit_tests._after_data_insert(boolean)
  OWNER TO postgres;
COMMENT ON FUNCTION unit_tests._after_data_insert(boolean) IS 'THIS IS A META TEST: ITS PURPOSE IS TO CREATE A POINT OF DEPENDENCY FOR THE TESTS TO RUN AFTER TABLE DATA INSERTED';
