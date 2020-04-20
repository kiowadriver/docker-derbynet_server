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
 
# additional files
##################

# install app
############# 
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN echo exit 0 > /usr/sbin/policy-rc.d && \
 apt-get update && apt-get install derbynet-server derbynet-extras -y && \
 apt-get clean && \
 rm -rf /var/lib/apt/lists/* && \
 echo "daemon off;" >> /etc/nginx/nginx.conf 
# echo "daemonize = no" >> /etc/php/7.2/fpm/php-fpm.conf

# Post Install 
#ADD ./root/install.sh /tmp/install.sh
#RUN chmod +x /tmp/install.sh && /tmp/install.sh

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

# start nginx service
#CMD ["service php7.0-fpm start && nginx"]

ADD ./root/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#CMD ["/usr/bin/supervisord", "-n"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

#CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
