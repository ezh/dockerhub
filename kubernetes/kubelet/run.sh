#!/bin/bash
IPADDR=`ifconfig eth0 | grep "inet addr" | awk '{ print $2}' | awk -F: '{print $2}'`
kubelet  \
  --api-servers=kube-apiserver:8080 \
  --pod-infra-container-image=kube-pause:0.8.0 \
  --hostname-override="$IPADDR"
