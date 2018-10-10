pidfilepath = {BASE_PATH}/pid/config{SERVER_ID}.pid
logpath = {BASE_PATH}/log/config{SERVER_ID}.log
logappend = true
dbpath = {BASE_PATH}/data/config{SERVER_ID}
 
bind_ip = 0.0.0.0
port = {PORT}
fork = true
 
#declare this is a config db of a cluster;
configsvr = true

replSet=configs
 
maxConns=20000
