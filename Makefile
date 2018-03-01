.PHONY: init
init:
	docker-compose up -d postgres
	docker-compose run --rm wait_postgres
	cat create.sql | docker exec -i --user postgres `docker-compose ps -q postgres` psql db

.PHONY: tests
tests:
	docker-compose run --rm db_check

.PHONY: delete
delete:
	docker-compose stop
	docker-compose rm -f
	rm data/ -rf
