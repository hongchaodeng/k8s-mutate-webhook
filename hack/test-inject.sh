#!/usr/bin/env bash

# build and deploy injector webhook
make docker
kubectl apply -f ./deploy/webhook.yaml

# test deployment
sleep 10
kubectl apply -f ./deploy/noenv.yaml

