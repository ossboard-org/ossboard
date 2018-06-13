HANAMI_ENV ?= development
RUN := run --rm
DOCKER_COMPOSE_RUN := docker-compose $(RUN)

default: test

test:
	bundle exec rspec

app-web:
	${DOCKER_COMPOSE_RUN} --service-ports web

app-job:
	${DOCKER_COMPOSE_RUN} job

app-bash:
	${DOCKER_COMPOSE_RUN} -e "HANAMI_ENV=${HANAMI_ENV}" app bash

app-down:
	docker-compose down

app-build:
	docker-compose build app
