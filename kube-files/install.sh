#!/bin/sh

echo "5.1 ConfigMap to provide the application with background image URL"
kubectl  create -f  configmap.yaml -n final; 
sleep 5
echo "display config map"
kubectl get configmap  -n final;
set -x
sleep 5
echo "5.2 create secret"
kubectl  create -f  secret-data.yaml -n final; 
set -x
sleep 5
 echo "display config map"
kubectl get secret  -n final;
set -x
sleep 5
echo "5.3 mysql pvc"
kubectl  create -f  mysql-pvc.yaml -n final; 
set -x
sleep 5
echo "display pvc"
kubectl get pvc  -n final;
set -x
sleep 5

echo "create mysql deployment"
kubectl create -f mysql-deployment.yaml -n final;
set -x
sleep 10
echo "displey deployment"
kubectl get pvc  -n final;
set -x
sleep 5
echo "display all"
kubectl get all  -n final;
set -x
sleep 5
echo "5.6 deploy clusterIP service for SQL"
kubectl create -f mysql-service.yaml -n final;
set -x
sleep 5
echo "displey deployment"
kubectl get svc -n final;
set -x
sleep 5
echo "5.7 Deploy Flask application" 
kubectl create -f webapp-deployment.yaml -n final;
set -x
sleep 5
echo "displey deployment"
kubectl get pods  -n final;
set -x
kubectl get all  -n final;
set -x
sleep 5
echo "5.8 loadbalancer"
kubectl create -f webapp-service.lb.yaml -n final;
set -x
sleep 30

echo "displey deployment"
kubectl get svc  -n final;
set -x
kubectl get all  -n final;
set -x




