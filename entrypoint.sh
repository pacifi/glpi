#!/bin/bash
service php7.4-fpm start 
service cron start
#/usr/sbin/nginx -g 'daemon off;'
/usr/sbin/apache2ctl -D FOREGROUND