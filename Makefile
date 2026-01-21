DC        = docker compose -f ./srcs/docker-compose.yml
DATA      = /home/sel-moud/data
WP_DATA   = $(DATA)/wordpress_data
DB_DATA   = $(DATA)/mariadb_data


all: up-build

up-build:
	$(DC) up --build

up:
	$(DC) up

down:
	$(DC) down

clean:
	sudo rm -rf $(WP_DATA)/* $(DB_DATA)/*
	@if [ -n "$$(docker ps -qa)" ]; then \
		echo "Stopping and removing all containers..."; \
		docker stop $$(docker ps -qa) && docker rm $$(docker ps -qa); \
	fi
	@if [ -n "$$(docker images -qa)" ]; then \
		echo "Removing all Docker images..."; \
		docker rmi -f $$(docker images -qa); \
	fi
	@if [ -n "$$(docker volume ls -q)" ]; then \
		echo "Removing all Docker volumes..."; \
		docker volume rm $$(docker volume ls -q); \
	fi
	@if [ -n "$$(docker network ls -q --filter type=custom)" ]; then \
		echo "Removing custom Docker networks..."; \
		docker network rm $$(docker network ls -q --filter type=custom); \
	fi