#!/usr/bin/env bash

set -e

require_command_exists(){
  command -v "$1" > /dev/null 2>&1 || (echo "$1 is require but is not installed. Aborting." >&2; exit 1;)
}

require_command_exists docker
require_command_exists docker-compose
require_command_exists kubectl

this_dir=$(cd -P "$(dirname "$0")" && pwd)

sudo docker info > /dev/null
if [ $? != 0 ];then
  echo "A running Docker engine is required. Is your Docker host up?"
  exit 1
fi

cd "$this_dir/kubernetes"
. "$this_dir/bin/env.sh"
sudo docker-compose -f docker-compose-master.yml up -d --build
sudo docker-compose -f docker-compose-minion.yml up -d --build 

cd "$this_dir/kubernetes/proxy"
sh run.sh &
sleep 15s

# ##############
kubectl get nodes
