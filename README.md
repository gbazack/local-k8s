# local-k8s

This toolkit enables deploying a three-node Kubernetes cluster on a Linux-based computer. It also deploys a [Symfony](https://hub.docker.com/r/bitnami/symfony) application with a [Mariadb](https://hub.docker.com/_/mariadb) database server.

## Requirements
| Name    | Version   |
|---------|-----------|
| [Kind](https://kind.sigs.k8s.io/)    | ~> 0.23.0 |
| [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/) | ~> 1.29|
| [docker](https://docs.docker.com/engine/install/) | ~> 27.0|

## How to deploy the local k8s
1. Create the cluster with namespaces, service accounts, secrets and the Nginx ingress controller:
```Bash
make create-env
```

2. Deploy the Mariadb database
```Bash
make deploy-database
```

3. Deploy the Symfony backend
```Bash
make deploy-backend
```

4. Wait one (01) minute for the ingress controller to be ready before exposing the backend via an ingress
```Bash
make deploy-ingress
```

N.B: The command `make dev` performs tasks 1, 2 and 3.

5. Once the backend is exposed, it will be reachable from the local host via [http://localhost:80](http://localhost:80).

6. Clean up everything with the following command:
```Bash
make clean
```