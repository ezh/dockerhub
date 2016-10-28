#!/bin/bash

echo "start hbase..."
/hbase/bin/start-hbase.sh

ZK_PORT=2181
START_TIMEOUT=600
start_timeout_exceeded=false
count=0
step=10
while netstat -lnt | awk '$4 ~ /:'$ZK_PORT'$/ {exit 1}'; do
    echo "waiting for zookeeper to be ready"
    sleep $step;
    count=$(expr $count + $step)
    if [ $count -gt $START_TIMEOUT ]; then
        start_timeout_exceeded=true
        break
    fi
done

echo "start kafka..."
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &
KAFKA_PID=$!

wait "$KAFKA_PID"
