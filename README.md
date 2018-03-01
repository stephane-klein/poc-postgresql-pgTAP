This is a POC to test [pgTAP](http://pgtap.org/) to write and execute
[PL/pgSQL - SQL Procedural Language](https://www.postgresql.org/docs/current/static/plpgsql.html) tests.

After reading this issue [theory/pgtap - Packaged on Alpine](https://github.com/theory/pgtap/issues/139) I have decided to use [LREN-CHUV/docker-pgtap](https://github.com/LREN-CHUV/docker-pgtap) Docker image.

Start and initialize PostgreSQL database with [create.sql](create.sql) file:

```
$ make init
docker-compose up -d postgres
Creating pocpostgresqlpgtap_postgres_1 ... done
docker-compose run wait_postgres
Waiting for postgres:5432  ...............  up!
Everything is up
cat create.sql | docker exec -i --user postgres `docker-compose ps -q postgres` psql db
DROP FUNCTION
NOTICE:  function add() does not exist, skipping
CREATE FUNCTION
 add
-----
   3
(1 row)
```

This is a simple test ([test-add.sql](tests/test-add.sql)):

```
BEGIN;
  SELECT plan(2);
  SELECT ok(add(1, 2) = 3, 'add 1 + 2');
  SELECT ok(add(1, 2) = 4, 'this test must fail');
ROLLBACK;
```

Now, this is the test execution:

```
$ make tests
docker-compose run --rm db_check
Waiting for database...
2018/03/01 13:31:55 Waiting for: tcp://postgres:5432
2018/03/01 13:31:55 Connected to tcp://postgres:5432

Running tests: /test/*.sql -v
/test/test-add.sql ..
1..2
ok 1 - add 1 + 2
not ok 2 - add 1 + 2
# Failed test 2: "add 1 + 2"
Failed 1/2 subtests

Test Summary Report
-------------------
/test/test-add.sql (Wstat: 0 Tests: 2 Failed: 1)
  Failed test:  2
Files=1, Tests=2,  1 wallclock secs ( 0.03 usr +  0.00 sys =  0.03 CPU)
Result: FAIL
make: *** [tests] Error 1
```

You can this that the first test success and second test failed.
