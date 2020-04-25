#! /bin/bash

# determine php path
php_path=$(find /etc \( -iname "www.conf" \))

# Change PHP_FPM to not clear env variables
sed -i '/clear_env/c\clear_env = no/' $php_path

php_bin=$(find /usr/sbin/ -print | grep -i fpm)

# update supervisor script
sed -i "s+command = /usr/sbin/php-fpm.*+command = $php_bin -R+" /etc/supervisor/conf.d/supervisord.conf

# update nginx configuration, get the name of the .sock
php_sock=$(sed -n -e 's/^.*listen = //p' $php_path)

# replace the name in the nginx configuration file
sed -i "s+.*fastcgi_pass unix:/run/php.*+                fastcgi_pass unix:$php_sock;+" /etc/nginx/sites-enabled/default
