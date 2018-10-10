#!/usr/bin/env bash

BASE_PATH=$1
BASE_PORT=$2
SERVER_HOST=localhost

echo "SHARD_NUM=3"
echo "MONGOS_NUM=3"
echo "BASE_PATH="$BASE_PATH
echo "BASE_PORT="$BASE_PORT
echo "SERVER_HOST="$SERVER_HOST
echo "MONGOBIN="$3

# 必须留一行在最后，参考http://stackoverflow.com/questions/20010741/why-does-unix-while-read-not-read-last-line
echo ""