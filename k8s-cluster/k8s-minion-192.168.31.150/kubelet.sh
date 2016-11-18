#!/bin/sh
MASTER_IP=${MASTER_IP:-'127.0.0.1'}
kubelet  \
  --api-servers=${MASTER_IP}:8080 \
  --pod-infra-container-image=192.168.31.148:5000/kubernetes/pause:latest \
  --hostname-override="192.168.31.150" &
