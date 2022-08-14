#!/bin/sh

curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 > get_helm.sh;

chmod 700 get_helm.sh;

./get_helm.sh;

helm repo add stable https://charts.helm.sh/stable;

helm install kube-ops-view stable/kube-ops-view --set service.type=LoadBalancer --set rbac.create=True;


