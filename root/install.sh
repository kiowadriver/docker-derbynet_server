#! /bin/bash

# Change PHP_FPM to not clear env variables
sed -i 's/;clear_env = no/clear_env = no/' /etc/php/7.4/fpm/pool.d/www.conf

