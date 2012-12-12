#!/bin/bash

LOG=`cat $(dirname $0)/do_sync.py | grep "LOG_FILE = " | head -n 1 | awk '{print $3}' | tr -d \'`
BASE_DIR=`cat $(dirname $0)/do_sync.py | grep "BASE_DIR = " | head -n 1 | awk '{print $3}' | tr -d \'`
tester=`/bin/ps aux | grep -v grep | grep do_sync.py`
if [[ ! -z $tester ]];then
    echo "sync.sh already running"
else
    echo "/usr/bin/inotifywait -mrq --format '%w%f' -e modify,delete,create,move $BASE_DIR | $(dirname $0)/do_sync.py > $LOG &"
    /usr/bin/inotifywait -mrq --format '%w%f' -e modify,delete,create,move $BASE_DIR | $(dirname $0)/do_sync.py > $LOG &
fi
