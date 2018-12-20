#!/bin/bash

set -e


# Pull flannel images from Aliyun
docker pull registry.cn-shanghai.aliyuncs.com/daizhiming/flannel:v0.10.0-amd64
docker tag registry.cn-shanghai.aliyuncs.com/daizhiming/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64
docker rmi registry.cn-shanghai.aliyuncs.com/daizhiming/flannel:v0.10.0-amd64

wget https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
kubectl apply -f kube-flannel.yml

# Wait a while to let network takes effect
sleep 10
kubectl get pods --all-namespaces

# Check component status
kubectl get cs

# Check pods status incase any pods are not in running status
kubectl get pods --all-namespaces | grep -v Running
