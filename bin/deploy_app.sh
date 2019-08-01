#!/bin/bash
#
# Time    : 2019-08-01 20:29:58
# Author  : hzzhangyile 
# Function: Deploy artifacts
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
    if [[ -z "${WORK_DIR}" ]]; then
        myPrint "Missing some required variables! WORK_DIR: (${WORK_DIR})" 2
        exit 1
    fi
}

# Main
main() {
    checkParams
    mkdir -p ${WORK_DIR}
    deploy_cmd="cp ./target/*.jar ${WORK_DIR}"
    myPrint "Start to deploy artifacts. deploy_cmd(${deploy_cmd})"
    $deploy_cmd
    ret="$?"
    if [[ $ret != 0 ]]; then
        myPrint "Deploy artifacts faild. exit $ret" 2
        exit $ret
    fi
    
    myPrint "Deploy artifacts successfully"
}

main

exit 0

