#!/bin/sh
## Run Container
docker create --privileged --network host --name argo-cluster-controller -v /var/run/docker.sock:/var/run/docker.sock -it k8s-argo-cluster-controller
docker start argo-cluster-controller
#docker exec -it argo-cluster-controller kind create cluster --config=/root/kind-config.yaml --name=argo-cd-test-cluster
docker exec -it argo-cluster-controller kubectl create namespace argocd
docker exec -it argo-cluster-controller kubectl apply -n argocd -f /install.yaml
docker exec -it argo-cluster-controller "kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}'"
