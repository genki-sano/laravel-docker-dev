init:
	makedir -p ./src
	cp .env.example .env
	@make build
	@make up
	docker-compose exec app composer create-project "laravel/laravel=11.*" . --prefer-dist
	docker compose exec app php artisan key:generate
	docker compose exec app php artisan storage:link
	docker compose exec app chmod -R 777 storage bootstrap/cache
	docker compose exec web yarn install
	@make fresh
up:
	docker compose up -d
build:
	docker compose build
down:
	docker compose down
restart:
	@make down
	@make up
ps:
	docker compose ps
logs:
	docker compose logs
web:
	docker compose exec nginx bash
app:
	docker compose exec app bash
cache-clear:
	docker compose exec app composer clear-cache
	@make optimize-clear
	docker compose exec app php artisan event:clear
migrate:
	docker compose exec app php artisan migrate
fresh:
	docker compose exec app php artisan migrate:fresh --seed
db:
	docker compose exec db bash
sql:
	docker compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
