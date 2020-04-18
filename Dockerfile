FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
	apt-transport-https \
    nano \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
# additional files
##################
# add supervisor conf file for app
#ADD build/*.conf /etc/supervisor/conf.d/

# add bash scripts to install app
#ADD build/root/*.sh /root/

# add bash script to setup iptables
#ADD run/root/*.sh /root/

# add bash script to run deluge
#ADD run/nobody/*.sh /home/nobody/

# add python script to configure deluge
#ADD run/nobody/*.py /home/nobody/

# add pre-configured config files for deluge
#ADD config/nobody/ /home/nobody/

# install app
############# 
RUN wget -q -O- https://jeffpiazza.org/derbynet/debian/jeffpiazza_derbynet.gpg | sudo apt-key add -
RUN echo "deb [arch=all] https://jeffpiazza.org/derbynet/debian stable main" | sudo tee /etc/apt/sources.list.d/derbynet.list > /dev/null
RUN apt-get update && apt-get install derbynet-server -y
RUN apt-get remove apache2 -y


# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# expose port for http
EXPOSE 8081

# set permissions
#################

# run script to set uid, gid and permissions
#CMD ["/bin/bash", "/usr/local/bin/init.sh"]

	
	