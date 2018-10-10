# shell script for deploy mongo cluster to localhost
## usage
### 1.generate all files and directory
    bash setup.sh ~/test 30000 /usr/bin

param1: base path

all files will be generate at ~/test

param2: base port

base port is 30000

param3: mongo_bin_dir

mongo_bin_dir is /usr/bin

### 2.run all servers (config servers/shard servers/mongos servers)

    bash run.sh

### stop all
    bash stop.sh

## config
### gen_var.sh
#### SHARD_NUM
shard num default to be 3

each shard has three replset instance, exp, 3 shard will run 9 shard replset instances
#### MONGOS_NUM
mongos num default to be 3

### PORT
config server port is [base port + 1, base port + 2, base port + 3]

mongos server port is [base port + 11, base port + 21, base port + 31 ... ]

mongo shard server port is [base port + 100 * shard_idx + 1, base port + 100 * shard_idx + 2, base port + 100 * shard_idx + 3 ... ]

### directory
#### log
all log in {base path}/log
#### conf
all conf in {base path}/log
#### data
all data in {base path}/data