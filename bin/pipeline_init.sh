#!/bin/bash
#
# Time    : 2019-08-01 20:39:04
# Author  : hzzhangyile 
# Function: Init GOCD's pipeline
# 
# ::Params::
#  __ENV__       : The params of start_cmd `-Dspring.profiles.active`
#  __PORT__      : The Port for spring_boot application
#  __GIT_REPO__  : Your remote git repository url
#  __GIT_BRANCH__: branch name
#  __INDEX_JAR__ : The index file of start spring_boot application
#  __WORK_DIR__  : The directory of deployments
#

__ENV__="online"
__PORT__="18080"
__GIT_REPO__=""
__GIT_BRANCH__="master"
__INDEX_JAR__="companyNews-0.0.1-SNAPSHOT.jar"
__WORK_DIR__="/app/companyNews/${__GIT_BRANCH__}"


TEMPLATE_FILE="company-news.gopipeline.json.template"
OUTPUT_FILE="company-news.gopipeline.json"

if [[ ! -f "${TEMPLATE_FILE}" ]]; then
    echo "[ERR]: Can't find TEMPLATE_FILE(${TEMPLATE_FILE})."
    exit 1
fi
if [[ -z "${__GIT_REPO__}" ]]; then
    echo "[ERR]: Please declare variables of __GIT_REPO__(${__GIT_REPO__})."
    exit 1
fi

sed "s#__GIT_REPO__#${__GIT_REPO__}#; \
     s#__GIT_BRANCH__#${__GIT_BRANCH__}#; \
     s#__WORK_DIR__#${__WORK_DIR__}#; \
     s#__ENV__#${__ENV__}#; \
     s#__PORT__#${__PORT__}#; \
     s#__INDEX_JAR__#${__INDEX_JAR__}#" ${TEMPLATE_FILE} > ${OUTPUT_FILE}


