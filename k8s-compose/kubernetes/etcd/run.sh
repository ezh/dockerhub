#!/bin/sh

MASTER_IP=${MASTER_IP:-'127.0.0.1'}

/usr/local/bin/etcd --initial-advertise-peer-urls http://${MASTER_IP}:7001   --advertise-client-urls http://${MASTER_IP}:4001   --listen-peer-urls http://0.0.0.0:7001   --listen-client-urls http://0.0.0.0:4001   --initial-cluster default=http://${MASTER_IP}:7001 --data-dir /var/etcd/data

