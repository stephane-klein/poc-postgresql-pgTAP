DROP FUNCTION IF EXISTS add();

CREATE FUNCTION add(a integer, b integer) RETURNS integer AS $add$
 BEGIN
  RETURN a + b;
 END;
$add$ LANGUAGE plpgsql;

SELECT add(1, 2);
