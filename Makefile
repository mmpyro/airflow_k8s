output='requirements.txt'
image='airflow_mm:1.0'
deployment_airflow='./k8s_deployments/airflow.yaml'
deployment_postgres='./k8s_deployments/postgres.yaml'

freeze:
	pip freeze > $(output)

restore:
	pip install -r $(output)

build:
	docker build -t $(image) .

apply:
	kubectl apply -f $(deployment_airflow)

apply_postgres:
	kubectl apply -f $(deployment_postgres)

delete:
	kubectl delete -f $(deployment_airflow)

restart:
	kubectl get pods|grep airflow|awk '{print $1}'|xargs kubectl delete pod

local_postgres:
	docker-compose up -d

local_airflow:
	docker-compose -f docker-compose.yml -f docker-compose-airflow.yml up -d

local_down:
	docker-compose -f docker-compose.yml -f docker-compose-airflow.yml down

local_ps:
	docker-compose -f docker-compose.yml -f docker-compose-airflow.yml ps