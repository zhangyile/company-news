#!/bin/bash
#
# Time    : 2019-08-01 20:42:10
# Author  : hzzhangyile 
# Function: Install software for CI/CD
# 
# TODO: retry policy
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

checkErr() {
    if [[ $1 != 0 ]]; then
        myPrint "Install faild! Now exit $1" 2
        exit $1
    fi
}

main() {
    # config yum repo and make cache
    myPrint "Config yum repo and make cache"
    curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
    checkErr $?
    
    yum makecache
    checkErr $?
    
    
    # Dependence package
    myPrint "Start to install dependence package..."
    yum -y install sysvinit-tools
    checkErr $?
    myPrint "Install dependence package done."
    
    
    # Install latest git
    myPrint "Start to install latest git..."
    #yum -y remove git*
    yum -y install  https://centos7.iuscommunity.org/ius-release.rpm
    checkErr $?
    yum -y install  git2u-all
    checkErr $?
    myPrint "Install latest git done."
    
    
    # Install maven, go-server, go-agent
    myPrint "Start to install maven, go-server, go-agent..."
    yum -y install maven go-server go-agent 
    checkErr $?
    myPrint "Install maven, go-server, go-agent done."
    
    
    
    # Start go-server and go-agent
    /etc/init.d/go-server start 
    checkErr $?
    /etc/init.d/go-agent start 
    checkErr $?
    
    
    # Config app envrioment
    mkdir /app && chown go:go /app
    checkErr $?
}


main
exit 0

