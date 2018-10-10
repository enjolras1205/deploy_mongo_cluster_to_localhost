#!/usr/bin/env bash

set -ex

source var.sh

MONGOD=${MONGOBIN}/mongod
MONGOS=${MONGOBIN}/mongos
MONGO=${MONGOBIN}/mongo
${MONGOD} -f $BASE_PATH"/conf/config1.conf"
${MONGOD} -f $BASE_PATH"/conf/config2.conf"
${MONGOD} -f $BASE_PATH"/conf/config3.conf"
${MONGO} --port $[BASE_PORT+1] < $BASE_PATH"/js/config.js"
for i in $(seq 1 $SHARD_NUM); 
do 
    ${MONGOD} -f $BASE_PATH"/conf/shard"$i"_replset1.conf"
    ${MONGOD} -f $BASE_PATH"/conf/shard"$i"_replset2.conf"
    ${MONGOD} -f $BASE_PATH"/conf/shard"$i"_replset3.conf"
    ${MONGO} --port $[BASE_PORT+$i*100+1] < $BASE_PATH"/js/shard"$i".js"
done
for i in $(seq 1 $MONGOS_NUM); 
do 
    ${MONGOS} -f $BASE_PATH"/conf/mongos"$i".conf"
done
${MONGO} --port $[BASE_PORT+$i*10+1] < $BASE_PATH"/js/addshard.js"
