FROM centos:7
COPY ./bin/install.sh /usr/local/bin/
EXPOSE 8153 18080 18081
CMD ["/bin/bash"]
