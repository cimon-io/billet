DECLARE
  company_name companies.name%TYPE;
BEGIN

  -- 
  INSERT INTO companies (name) VALUES ('qwe1') RETURNING name INTO company_name;
  ASSERT company_name = 'qwe1', 'companies.name is allowed to be a string';

  -- 
  BEGIN
    INSERT INTO companies (name) VALUES ('qwe1') RETURNING name INTO company_name;
    ASSERT FALSE, 'companies.name should raise unique violation';
  EXCEPTION
    WHEN unique_violation THEN
      ASSERT TRUE;
  END;

  RETURN 'ok';
END;
