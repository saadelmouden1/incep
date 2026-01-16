LOGIN = sel-moud

# paths to persistent data
WP_DATA = /home/$(LOGIN)/data/wordpress
DB_DATA = /home/$(LOGIN)/data/mariadb

# docker compose command
COMPOSE = docker compose -f docker-compose.yml

# Default target
all: up

# Build Docker images
build:
	$(COMPOSE) build

# Create data directories and start containers
up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	$(COMPOSE) up -d

# Stop containers
stop:
	$(COMPOSE) stop

# Start stopped containers
start:
	$(COMPOSE) start

# Stop and remove containers (keep volumes)
down:
	$(COMPOSE) down

# Clean project (containers + volumes + host data)
clean:
	$(COMPOSE) down -v
	@rm -rf /home/$(LOGIN)/data

# Full system prune (optional / nuclear)
fclean: clean
	@docker system prune -a --volumes -f

# Rebuild everything from scratch
re: fclean up

# Phony targets
.PHONY: all build up stop start down clean fclean re