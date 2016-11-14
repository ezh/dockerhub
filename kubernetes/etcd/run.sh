#!/bin/bash
etcd \
  --initial-advertise-peer-urls http://127.0.0.1:7001 \
  --advertise-client-urls http://127.0.0.1:4001 \
  --listen-peer-urls http://0.0.0.0:7001 \
  --listen-client-urls http://0.0.0.0:4001 \
  --initial-cluster default=http://127.0.0.1:7001

