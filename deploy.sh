#!/usr/bin/env bash

IMAGES=( client server worker )
CONTAINER_PREFIX=eu.gcr.io/docker-kubernetes-237606/jsdevtom/multi-

for i in "${IMAGES[@]}"
do
	docker build -t ${CONTAINER_PREFIX}${i} -f ./${i}/Dockerfile ./${i}
    docker push ${CONTAINER_PREFIX}${i}
done

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=eu.gcr.io/docker-kubernetes-237606/jsdevtom/multi-server
