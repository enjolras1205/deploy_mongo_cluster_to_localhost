#!/usr/bin/env bash

source var.sh

echo "use admin;"
for i in $(seq 1 $SHARD_NUM); do
    SHARD_BASE_PORT=$[BASE_PORT+$i*100]
    echo "sh.addShard(\"shard"$i"/localhost:"$[SHARD_BASE_PORT+1]",localhost:"$[SHARD_BASE_PORT+2]",localhost:"$[SHARD_BASE_PORT+3]"\");"
done