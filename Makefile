GUAC_VERSION=1.5.5

.PHONY: initdb reset env up down rebuild

initdb:
	mkdir -p init
	docker run --rm guacamole/guacamole:$(GUAC_VERSION) /opt/guacamole/bin/initdb.sh --mysql > init/initdb.sql

reset:
	docker compose down -v
	rm -rf data/mysql/*
	rm -rf data/guac_home/*
	make env

env:
	./generate-guac-properties.sh

up:
	docker compose up -d

down:
	docker compose down

rebuild: reset up