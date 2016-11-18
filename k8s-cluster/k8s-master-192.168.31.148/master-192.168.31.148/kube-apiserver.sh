#!/bin/sh

MASTER_IP=${MASTER_IP:-'127.0.0.1'}
CLUSTER_IP_RANGE=${CLUSTER_IP_RANGE:-'172.17.0.0/24'}

kube-apiserver  \
  --insecure-bind-address=${MASTER_IP} \
  --insecure-port=8080 \
  --service-cluster-ip-range=${CLUSTER_IP_RANGE} \
  --etcd-servers=http://${MASTER_IP}:4001 \
  --allow_privileged=false &
