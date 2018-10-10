pidfilepath = {BASE_PATH}/pid/shard{SERVER_ID}_replset{REPLSET_ID}.pid
dbpath = {BASE_PATH}/data/shard{SERVER_ID}_replset{REPLSET_ID}
logpath = {BASE_PATH}/log/shard{SERVER_ID}_replset{REPLSET_ID}.log
logappend = true

bind_ip = 0.0.0.0
port = {PORT}
fork = true
 
replSet=shard{SERVER_ID}
 
#declare this is a shard db of a cluster;
shardsvr = true
 
maxConns=20000
