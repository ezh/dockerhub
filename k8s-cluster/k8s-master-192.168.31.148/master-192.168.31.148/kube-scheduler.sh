#!/bin/sh

MASTER_IP=${MASTER_IP:-'127.0.0.1'}

kube-scheduler --master=${MASTER_IP}:8080 &
