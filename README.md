# MuchToDo Container Assessment

## Overview

This project containerizes the MuchToDo Golang backend application and deploys it locally using Docker Compose and Kubernetes (Kind).

The application consists of:

* Golang Backend API
* MongoDB Database
* Docker Compose local environment
* Kubernetes deployment on Kind

---

## Prerequisites

Install the following:

* Docker Desktop
* kubectl
* Kind
* Git

---

## Project Structure

```text
much-to-do/
├── Dockerfile
├── docker-compose.yml
├── kubernetes/
├── scripts/
├── evidence/
└── README.md
```

---

## Docker Deployment

### Build Docker Image

```bash
docker build -t much-to-do-backend:latest .
```

or

```bash
./scripts/docker-build.sh
```

### Start Application

```bash
docker compose up --build
```

or

```bash
./scripts/docker-run.sh
```

### Verify Application

```bash
curl http://localhost:8080/
```

Expected:

```json
{"message":"Welcome to MuchToDo API"}
```

### Health Check

```bash
curl http://localhost:8080/health
```

Expected:

```json
{"cache":"disabled","database":"ok"}
```

---

## Kubernetes Deployment

### Create Kind Cluster

```bash
kind create cluster --name muchtodo
```

### Load Docker Image into Kind

```bash
kind load docker-image much-to-do-backend:latest --name muchtodo
```

### Deploy Resources

```bash
./scripts/k8s-deploy.sh
```

or

```bash
kubectl apply -f kubernetes/namespace.yaml
kubectl apply -f kubernetes/mongodb/
kubectl apply -f kubernetes/backend/
kubectl apply -f kubernetes/ingress.yaml
```

---

## Verify Deployment

Check Pods:

```bash
kubectl get pods -n muchtodo
```

Check Services:

```bash
kubectl get svc -n muchtodo
```

Check Deployments:

```bash
kubectl get all -n muchtodo
```

---

## Application Access

Port forward service:

```bash
kubectl port-forward svc/backend-service 8080:80 -n muchtodo
```

Access application:

```text
http://localhost:8080
```

Health endpoint:

```text
http://localhost:8080/health
```

---

## Cleanup

Delete Kubernetes resources:

```bash
./scripts/k8s-cleanup.sh
```

or

```bash
kubectl delete namespace muchtodo
```

---

## Evidence

Screenshots demonstrating successful deployment are included in the `evidence/` directory.

Included evidence:

* Docker build success
* Docker Compose running
* Application accessible via Docker
* Kind cluster creation
* Kubernetes node status
* Kubernetes pod status
* Kubernetes services
* Full deployment status
* Health endpoint verification

```
```
