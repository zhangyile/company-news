FROM centos:7
WORKDIR /app
COPY ./bin/ /usr/local/bin/
EXPOSE 8153 18080 18081
CMD ["install.sh"]
