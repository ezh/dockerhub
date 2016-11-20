#!/bin/sh

MASTER_IP=${MASTER_IP:-'127.0.0.1'}

/usr/local/bin/kubelet  \
  --api-servers=${MASTER_IP}:8080 \
  --pod-infra-container-image=kubernetes/pause:latest \
  --hostname-override="127.0.0.1"
