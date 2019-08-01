#!/bin/bash

# TODO
# retry count
# 


# install git client
#yum -y remove git*
yum -y install  https://centos7.iuscommunity.org/ius-release.rpm
yum -y install  git2u-all


# install maven
yum -y install maven


# install gocd
curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
yum install -y go-server go-agent sysvinit-tools

/etc/init.d/go-server start 
/etc/init.d/go-agent start 


# app envrioment
mkdir /logs /app
chown go:go /logs /app

