FROM ubuntu
MAINTAINER kiowadriver

# set environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN echo exit 0 > /usr/sbin/policy-rc.d & \
        apt-get update && apt-get install -y \
        apt-utils \
        supervisor \
        nano \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        wget \
        gnupg \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
 
# install app
############# 
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN echo exit 0 > /usr/sbin/policy-rc.d && \
 apt-get update && apt-get install derbynet-server -y && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 echo "daemon off;" >> /etc/nginx/nginx.conf 

# additional files
##################
# replace the nginx default file
ADD ./root/nginxdefault /etc/nginx/sites-enabled/default

# replace file to use docker env variables instead of hard-coded values
ADD ./root/config-roles.inc /var/www/html/derbynet/local/config-roles.inc
RUN chown www-data:www-data /var/www/html/derbynet/local/config-roles.inc
RUN chmod 644 /var/www/html/derbynet/local/config-roles.inc


# docker settings
#################

# map /media
VOLUME /var/lib/derbynet/

# map /config
VOLUME /boot

# expose port for http and https
EXPOSE 80
EXPOSE 443

# on startup make sure derbynet-server is the latest version
CMD ["apt-get update && apt-get install derbynet-server -y"]

# if a config doesn't alreaady exist, copy one from the /etc directory (boot takes priority)
CMD ["cp -n /etc/derbynet.conf /boot/"]

# setup supervisord
ADD ./root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

