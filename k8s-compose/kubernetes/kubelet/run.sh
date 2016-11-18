#!/bin/sh

MASTER_IP=${MASTER_IP:-'127.0.0.1'}

/usr/local/bin/kubelet  \
  --api-servers=${MASTER_IP}:8080 \
  --pod-infra-container-image=10.62.100.97:5000/kubernetes/pause \
  --hostname-override="127.0.0.1"
