SERVICE = application
API_URL = application.localhost
SCALE ?= 5

up:
	@npm install
	@npm run build
	@docker-compose up --build --detach --scale $(SERVICE)=$(SCALE) --force-recreate

down:
	@docker-compose down --remove-orphans --volumes

logs:
	@docker-compose logs --follow $(SERVICE)

test:
	@npx autocannon \
			--connections 30 \
			--method GET \
			--duration 30 \
			http://$(API_URL)
