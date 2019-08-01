#!/bin/bash


__GIT_REPO__="https://github.com/zhangyile/company-news-test.git"
__GIT_BRANCH__="master"
__ENV__="online"
__PORT__="18080"
__INDEX_JAR__="companyNews-0.0.1-SNAPSHOT.jar"
__WORK_DIR__="/app/companyNews/${__GIT_BRANCH__}"


TEMPLATE_FILE="company-news.gopipeline.json.template"
OUTPUT_FILE="company-news.${__GIT_BRANCH__}.gopipeline.json"

if [[ ! -f "${TEMPLATE_FILE}" ]]; then
    echo "[ERR]: Can't find template file."
    exit 1
fi

sed "s#__GIT_REPO__#${__GIT_REPO__}#; \
     s#__GIT_BRANCH__#${__GIT_BRANCH__}#; \
     s#__WORK_DIR__#${__WORK_DIR__}#; \
     s#__ENV__#${__ENV__}#; \
     s#__PORT__#${__PORT__}#; \
     s#__INDEX_JAR__#${__INDEX_JAR__}#" ${TEMPLATE_FILE} > ${OUTPUT_FILE}


