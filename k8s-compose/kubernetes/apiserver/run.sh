#!/bin/sh
MASTER_IP=${MASTER_IP:-'127.0.0.1'}
CLUSTER_IP=${CLUSTER_IP:-'172.17.0.0/24'}

/usr/local/bin/kube-apiserver \
  --insecure-bind-address=${MASTER_IP} \
  --insecure-port=8080 \
  --service-cluster-ip-range=${CLUSTER_IP} \
  --etcd-servers=http://${MASTER_IP}:4001 \
  --allow_privileged=false 
