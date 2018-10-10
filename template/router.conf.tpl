pidfilepath = {BASE_PATH}/pid/mongos{SERVER_ID}.pid
logpath = {BASE_PATH}/log/mongos{SERVER_ID}.log
logappend = true

bind_ip = 0.0.0.0
port = {PORT}
fork = true

configdb = configs/{CONFIG_SERVER1},{CONFIG_SERVER2},{CONFIG_SERVER3}
 
maxConns=20000
