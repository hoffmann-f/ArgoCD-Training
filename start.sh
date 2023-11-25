#!/bin/sh
## Run Container
docker run --network="host" --name argo-cluster -v /var/run/docker.sock:/var/run/docker.sock -it k8s-argo-cluster
docker cp k8s-argo-cluster:/