init:
	docker-compose pull
start:
	docker-compose up --build -d
unit:
	pytest tests/test_main.py
recreate:
	docker-compose down
	docker-compose up --build -d
destroy:
	docker-compose down