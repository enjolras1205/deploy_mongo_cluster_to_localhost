#!/usr/bin/env bash
set -e

if [ $# != 3 ]; then
    echo "usage : bash $0 ~/mongo_cluster(working_dir) 30000(base port) /home/enjolras/git/mongo(mongo bin path)"
    exit
fi

bash gen_var.sh $1 $2 $3 > ./var.sh

source util.sh
source var.sh
echo "base path is "$BASE_PATH
echo "base port is "$BASE_PORT
set -x
mkdir -p $BASE_PATH/data/config1
mkdir -p $BASE_PATH/data/config2
mkdir -p $BASE_PATH/data/config3
for i in $(seq 1 $SHARD_NUM); 
do 
    mkdir -p $BASE_PATH"/data/shard"$i"_replset1"
    mkdir -p $BASE_PATH"/data/shard"$i"_replset2"
    mkdir -p $BASE_PATH"/data/shard"$i"_replset3"
done
mkdir -p $BASE_PATH/conf
mkdir -p $BASE_PATH/log
mkdir -p $BASE_PATH/pid
mkdir -p $BASE_PATH/js
set +x

vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+1] "SERVER_ID=1")
sed_and_cmp $vars template/config.conf.tpl $BASE_PATH/conf/config1.conf
vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+2] "SERVER_ID=2")
sed_and_cmp $vars template/config.conf.tpl $BASE_PATH/conf/config2.conf
vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+3] "SERVER_ID=3")
sed_and_cmp $vars template/config.conf.tpl $BASE_PATH/conf/config3.conf
vars=("ID=configs" "SERVER_HOST="$SERVER_HOST "PORT0="$[BASE_PORT+1] "PORT1="$[BASE_PORT+2] "PORT2="$[BASE_PORT+3])
sed_and_cmp $vars template/config_replset.js.tpl $BASE_PATH/js/config.js
for i in $(seq 1 $MONGOS_NUM); 
do 
    vars=("BASE_PATH="$BASE_PATH
     "PORT="$[BASE_PORT+$i*10+1] 
     "SERVER_ID="$i 
     "CONFIG_SERVER1="$SERVER_HOST":"$[BASE_PORT+1]
     "CONFIG_SERVER2="$SERVER_HOST":"$[BASE_PORT+2]
     "CONFIG_SERVER3="$SERVER_HOST":"$[BASE_PORT+3]
    )
    sed_and_cmp $vars template/router.conf.tpl $BASE_PATH"/conf/mongos"$i.conf
done
for i in $(seq 1 $SHARD_NUM); 
do 
    vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+$i*100+1] "SERVER_ID="$i "REPLSET_ID="1)
    sed_and_cmp $vars template/shard.conf.tpl $BASE_PATH"/conf/shard"$i"_replset1".conf
    vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+$i*100+2] "SERVER_ID="$i "REPLSET_ID="2)
    sed_and_cmp $vars template/shard.conf.tpl $BASE_PATH"/conf/shard"$i"_replset2".conf
    vars=("BASE_PATH="$BASE_PATH "PORT="$[BASE_PORT+$i*100+3] "SERVER_ID="$i "REPLSET_ID="3)
    sed_and_cmp $vars template/shard.conf.tpl $BASE_PATH"/conf/shard"$i"_replset3".conf
    vars=("ID=shard"$i 
        "SERVER_HOST="$SERVER_HOST 
        "PORT0="$[BASE_PORT+$i*100+1] 
        "PORT1="$[BASE_PORT+$i*100+2] 
        "PORT2="$[BASE_PORT+$i*100+3]
    )
    sed_and_cmp $vars template/shard_replset.js.tpl $BASE_PATH"/js/shard"$i".js"
done 
bash gen_addshard_js.sh > $BASE_PATH"/js/addshard.js"
