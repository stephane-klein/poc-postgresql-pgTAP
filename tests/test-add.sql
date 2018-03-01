BEGIN;
  SELECT plan(2);
  SELECT ok(add(1, 2) = 3, 'add 1 + 2');
  SELECT ok(add(1, 2) = 4, 'add 1 + 2');
ROLLBACK;
