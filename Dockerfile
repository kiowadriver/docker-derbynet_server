FROM debian:sid
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update && apt-get install -y \
	apt-utils \
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
RUN echo exit 0 > /usr/sbin/policy-rc.d
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN apt-get update && apt-get install derbynet-server -y

# docker settings
#################

# map /etc/config to host defined config path (used to store configuration from app)
VOLUME /config
RUN ln -s /etc/derbynet.conf /config/

# expose port for http
EXPOSE 8081

# set permissions
#################


	
	
