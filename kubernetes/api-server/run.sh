#!/bin/bash
kube-apiserver \
  --insecure-bind-address=127.0.0.1 \
  --insecure-port=8080 \
  --service-cluster-ip-range='172.17.0.0/24' \
  --etcd-servers=http://etcd:4001 \
  --allow_privileged=false


