#!/bin/sh

#5.1 ConfigMap to provide the application with background image URL
kubectl  create -f  config.yaml -n final; 

#display config map
kubectl get configmap  -n final;
set -x

#5.2 create secret 
kubectl  create -f  secret-data.yaml -n final; 
set -x

#display config map
kubectl get secret  -n final;
set -x

#5.3 mysql pvc
kubectl  create -f  mysql-pvc.yaml -n final; 
set -x

#display pvc
kubectl get pvc  -n final;
set -x

#5.4 Create IRSA Service Account 
#Get oidc
aws eks describe-cluster --name  finalproject --query cluster.identity.oidc.issuer --output text;
set -x

#get oidc approve
eksctl utils associate-iam-oidc-provider --cluster finalproject --approve;
set -x

#create service account with IAM role and policy attached
eksctl create iamserviceaccount     --name clo835     --namespace final     --cluster finalproject     --attach-policy-arn arn:aws:iam::616865343531:policy/s3-restricted-read     --approve     --override-existing-serviceaccounts;
set -x

#5.5 create mysql deployment
kubectl create -f mysql-deployment.yaml -n final;
set -x

#displey deployment
kubectl get pods  -n final;
set -x
kubectl get all  -n final;
set -x

#5.6 deploy clusterIP service for SQL
kubectl create -f mysql-service.yaml -n final;
set -x

#displey deployment
kubectl get svc -n final;
set -x

#5.7 Deploy Flask application 
kubectl create -f webapp-deployment.yaml -n final;
set -x

#displey deployment
kubectl get pods  -n final;
set -x
kubectl get all  -n final;
set -x

#5.8 loadbalancer
kubectl create -f webapp-service.lb.yaml -n final;
set -x

#displey deployment
kubectl get svc  -n final;
set -x
kubectl get all  -n final;
set -x




