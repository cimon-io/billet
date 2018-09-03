DECLARE
  projects_counter companies.projects_count%TYPE;
  c_id companies.id%TYPE;
BEGIN
  
  -- 
  INSERT INTO companies (name) VALUES ('company1') RETURNING id, projects_count INTO c_id, projects_counter;
  ASSERT projects_counter = 0, 'companies.projects_count should be zero by default';

  INSERT INTO projects (name, company_id) VALUES ('project0', c_id);

  SELECT projects_count FROM companies WHERE id = c_id INTO projects_counter;
  ASSERT projects_counter = 1, 'companies.projects_count should be increased with insert';

  INSERT INTO projects (name, company_id) VALUES ('project1', c_id), ('project2', c_id), ('project3', c_id);

  SELECT projects_count FROM companies WHERE id = c_id INTO projects_counter;
  ASSERT projects_counter = 4, 'companies.projects_count should be increased with multiinsert';

  DELETE FROM projects WHERE name = 'project1';

  SELECT projects_count FROM companies WHERE id = c_id INTO projects_counter;
  ASSERT projects_counter = 3, 'companies.projects_count should be decreased after destroy';

  DELETE FROM projects WHERE projects.company_id = c_id;

  SELECT projects_count FROM companies WHERE id = c_id INTO projects_counter;
  ASSERT projects_counter = 0, 'companies.projects_count should be set to 0 after destroy all';

  RETURN 'ok';
END;
