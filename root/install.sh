#! /bin/bash

# determine php path
php_path=$(find /etc \( -iname "www.conf" \))

# Change PHP_FPM to not clear env variables
sed -i "s+.*clear_env.*+clear_env = no+" $php_path

php_bin=$(find /usr/sbin/ -print | grep -i fpm)

# update supervisor script
sed -i "s+command = /usr/sbin/php-fpm.*+command = $php_bin -R+" /etc/supervisor/conf.d/supervisord.conf

# update nginx configuration, get the name of the .sock
php_sock=$(sed -n -e 's/^.*listen = //p' $php_path)

# replace the name in the nginx configuration file
sed -i "s+.*fastcgi_pass unix:/run/php.*+                fastcgi_pass unix:$php_sock;+" /etc/nginx/sites-enabled/default

# fix a security flaw the allows anyone to see all of the php env variables and instead restrict to administrators
sed -i "s+.*make_link_button('About', 'about.php', -1,.*+make_link_button('About', 'about.php', SET_UP_PERMISSION, 'other_button');
+" /var/www/html/derbynet/index.php
