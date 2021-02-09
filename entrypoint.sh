#!/bin/bash
service php7.4-fpm start 
#/usr/sbin/nginx -g 'daemon off;'
/usr/sbin/apache2ctl -D FOREGROUND