#!/bin/bash


#WORK_DIR="/app/companyNews/online"
#ENV="online"
#PORT="18080"
#INDEX_JAR="companyNews-0.0.1-SNAPSHOT.jar"

mkdir -p ${WORK_DIR}

cp ./target/*.jar  ${WORK_DIR}

export WORK_DIR ENV PORT INDEX_JAR
app_init.sh restart 
