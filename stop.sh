#!/usr/bin/env bash

# set -e

source var.sh

find $BASE_PATH"/pid" -type f | xargs cat | xargs kill -s SIGTERM

yes | rm -f $BASE_PATH"/pid/*"
