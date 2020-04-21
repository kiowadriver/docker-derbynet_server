#! /bin/bash

# items in the boot folder take priority. Copy all config files over so they can be saved/shared
# -n = only copy if the file doesn't already exist
cp -n /etc/derbynet*.conf /boot/

# Fix nginx so derbynet is the base URL path
/etc/nginx/sites-enabled/default

 # Add index.php to the list if you are using PHP
sed -i 's#index index.html index.htm index.nginx-debian.html;#index index.php index.html index.htm index.nginx-debian.html;#' /etc/nginx/sites-enabled/default

# change derbynet to be the root
sed -i 's#root /var/www/html;#root /var/www/html/derbynet;#' /etc/nginx/sites-enabled/default

