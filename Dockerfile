FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
	apt-transport-https \
    nano \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
# additional files
##################

# install app
############# 
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | sudo apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | sudo tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN apt-get update && apt-get install derbynet-server -y
RUN apt-get remove apache2 -y

# docker settings
#################

# map /etc/config to host defined config path (used to store configuration from app)
VOLUME /config
RUN ln -s /etc/derbynet.conf /config/

# expose port for http
EXPOSE 8081

# set permissions
#################


	
	
