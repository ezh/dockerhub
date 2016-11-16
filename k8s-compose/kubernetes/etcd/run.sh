#!/bin/sh

/usr/local/bin/etcd --initial-advertise-peer-urls http://localhost:7001   --advertise-client-urls http://localhost:4001   --listen-peer-urls http://0.0.0.0:7001   --listen-client-urls http://0.0.0.0:4001   --initial-cluster default=http://localhost:7001 --data-dir /var/etcd/data
