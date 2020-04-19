FROM ubuntu
MAINTAINER kiowadriver

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN echo exit 0 > /usr/sbin/policy-rc.d & \
        apt-get update && apt-get install -y \
        apt-utils \
        nano \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        wget \
        gnupg \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
 
# additional files
##################

# install app
############# 
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN echo exit 0 > /usr/sbin/policy-rc.d && \
 apt-get update && apt-get install derbynet-server -y && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 echo "daemon off;" >> /etc/nginx/nginx.conf
 
# docker settings
#################

# map /etc/config to host defined config path (used to store configuration from app)
VOLUME /config
RUN ln -s /etc/derbynet.conf /config/

# expose port for http and https
EXPOSE 80
EXPOSE 443

# on startup make sure derbynet-server is the latest version
CMD ["apt-get update && apt-get install derbynet-server -y"]

# start nginx service
CMD ["service php7.0-fpm start && nginx"]
