#!/bin/bash
#
# Time    : 2019-08-01 20:18:01
# Author  : hzzhangyile 
# Function: Manage spring_boot app
# 
# 
#WORK_DIR="/app/companyNews/online"
#ENV="online"
#PORT="18080"
#INDEX_JAR="companyNews-0.0.1-SNAPSHOT.jar"
#

# Formating output
myPrint() {
    # 0 => INFO, 1 => WARN, 2 => ERR
    case $2 in
        1) level='WARN' ;;
        2) level='ERR'  ;;
        *) level='INFO' ;;
    esac
    time_str=`date "+%F %T"`
    echo "[$level] ${time_str} $1"
}

# Check params
checkParams() {
    if [[ -z "${WORK_DIR}" ]] || [[ -z "${ENV}" ]] || [[ -z "${PORT}" ]] || [[ -z "${INDEX_JAR}" ]]; then
        myPrint "Missing some required variables! WORK_DIR: (${WORK_DIR}), ENV: (${ENV}), PORT: (${PORT}), INDEX_JAR: (${INDEX_JAR})" 2
        exit 1
    fi
}


start() {
    cd ${WORK_DIR} 
    nohup $start_cmd >>$LogFile 2>&1 &
    sleep 1
    status
    ret="$?"
    if [[ $ret != 0 ]]; then
        myPrint "Start app faild start_cmd:(cd ${WORK_DIR} && $start_cmd). exit $ret" 2
        exit $ret
    fi
    myPrint "Start app OK start_cmd:(cd ${WORK_DIR} && $start_cmd)"
    return $ret
}

stop() {
    pid=`ps aux | grep "${start_cmd}" | grep -v grep | awk '{print $2}'`
    kill -9 $pid
    myPrint "Stop app OK" 1
}

status() {
    ps aux | grep -v grep | grep "${start_cmd}" 
    return $?
}

# Main
LogFile="${WORK_DIR}/logs/start.log"
mkdir -p ${WORK_DIR}/logs

myPrint "WORK_DIR: $WORK_DIR" 
start_cmd="java -Dspring.profiles.active=${ENV} -Dserver.port=${PORT} -jar ${INDEX_JAR}"
myPrint "start_cmd: ($start_cmd)"

checkParams
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

exit 0
