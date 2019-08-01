#!/bin/bash


#WORK_DIR="/app/companyNews/online"
#ENV="online"
#PORT="18080"
#INDEX_JAR="companyNews-0.0.1-SNAPSHOT.jar"

echo $WORK_DIR
start_cmd="java -Dspring.profiles.active=${ENV} -Dserver.port=${PORT} -jar ${INDEX_JAR}"
echo $start_cmd

LogFile="${WORK_DIR}/logs/start.log"
mkdir -p ${WORK_DIR}/logs


start() {
    cd ${WORK_DIR} 
    nohup $start_cmd >>$LogFile 2>&1 &
    sleep 1
    status
    ret="$?"
    if [[ $ret != 0 ]]; then
        echo "Start app faild start_cmd:(cd ${WORK_DIR} && $start_cmd)! exit $ret"
        exit $ret
    fi
    echo "Start app OK start_cmd:(cd ${WORK_DIR} && $start_cmd)! exit $ret"
    return $ret
}


stop() {
    pid=`ps aux | grep "${start_cmd}" | grep -v grep | awk '{print $2}'`
    kill -9 $pid
    echo "Stop app OK"
}

status() {
    ps aux | grep -v grep | grep "${start_cmd}" 
    return $?
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage app_init.sh [start|stop|restart|status]"
        exit 1
        ;;
esac

echo "TEST OK"
exit 0
