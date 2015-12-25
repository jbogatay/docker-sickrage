FROM jbogatay/baseimage-python
MAINTAINER "Jeff Bogatay <jeff@bogatay.com>"

VOLUME ["/config","/downloads","/tv","/blackhole"]
EXPOSE 8081
CMD ["/app/start.sh"]

ADD app/ /app/