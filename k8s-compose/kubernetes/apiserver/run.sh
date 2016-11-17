#!/bin/sh


/usr/local/bin/kube-apiserver \
  --insecure-bind-address=10.62.100.73 \
  --insecure-port=8080 \
  --service-cluster-ip-range='172.17.0.0/24' \
  --etcd-servers=http://10.62.100.73:4001 \
  --allow_privileged=false 
