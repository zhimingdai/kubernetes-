#!/bin/bash

set -e

# Check version in https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm-init/
# Search "Running kubeadm without an internet connection"
# For running kubeadm without an internet connection you have to pre-pull the required master images for the version of choice:
#Use domestic resources to download the image
KUBE_VERSION=v1.11.0
KUBE_PAUSE_VERSION=3.1

GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-shanghai.aliyuncs.com/daizhiming
#registry.cn-shanghai.aliyuncs.com/daizhiming

# When test v1.11.0, I found Kubernetes depends on both pause-amd64:3.1 and pause:3.1 

images=(kube-proxy-amd64:${KUBE_VERSION}
pause-amd64:${KUBE_PAUSE_VERSION}
pause:${KUBE_PAUSE_VERSION})


for imageName in ${images[@]} ; do
  docker pull $ALIYUN_URL/$imageName
  #Rename the image using the "docker tag" command
  docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

docker images
