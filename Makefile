.PHONY: dev create-env deploy-all

dev: create-env deploy-all

create-env:
	@echo "Creating a local k8s cluster..."
	kind create cluster --config ./kind-cluster-config.yaml
	@echo "Creating Namespaces, ServiceAccounts and Secrets..."
	kubectl apply -f ./app/1-ns-sa-secret.yaml
	@echo "Deploying the Nginx Ingress controller..."
	kubectl apply -f ./ingress/nginx-controller

deploy-all: deploy-database deploy-backend

deploy-database:
	@echo "Deploying the Mariadb database..."
	kubectl apply -f ./app/2-sts-database.yaml

deploy-backend:
	@echo "Deploying the Symfony backend..."
	kubectl apply -f ./app/3-deploy-backend.yaml

deploy-ingress:
	@echo "Exposing the Symfony backend..."
	kubectl apply -f ./ingress/ingress.yaml

clean-database:
	@echo "Deleting the statefulset Mariadb..."
	kubectl delete -f ./app/2-sts-database.yaml --force --grace-period=0

clean-backend:
	@echo "Deleting the deployment Symfony..."
	kubectl delete -f ./app/3-deploy-backend.yaml --force --grace-period=0

clean-ingress:
	@echo "Deleting the Nginx Ingress..."
	kubectl delete -f ./ingress/ingress.yaml --force --grace-period=0

clean:
	@echo "Destroying the local k8s cluster..."
	kind delete clusters local-k8s