FROM ubuntu:20.04

ENV TZ=America/Lima

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y
RUN apt upgrade -y
RUN  apt install apache2 wget -y
RUN apt install -y php-mbstring php-curl php-gd php-xml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-fpm php-imap php-mysql
RUN cd /var/www && wget https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz 
RUN cd /var/www && tar -xf glpi-10.0.6.tgz
RUN chmod -R 777 /var/www/glpi/
RUN chown -R www-data:www-data /var/www/glpi/
#RUN sudo a2enmod rewrite
RUN apt install  libapache2-mod-php -y
RUN echo  /etc/php/7.4/fpm/php.ini | xargs sed -i "s/;date.timezone =.*/date.timezone = America\/Lima/"

COPY glpi.conf /etc/apache2/
#RUN cat /etc/apache2/glpi.conf > /etc/apache2/sites-available/default
RUN cat /etc/apache2/glpi.conf > /etc/apache2/sites-available/000-default.conf

RUN apt -y install cron


#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
#CMD /usr/sbin/php-fpm7.4 --nodaemonize
# ENTRYPOINT /usr/sbin/php-fpm7.4 --nodaemonize
COPY [ "./entrypoint.sh", "/root/entrypoint.sh" ]
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh


EXPOSE  80

#* * * * * /usr/bin/php /var/www/glpi/front/cron.php --force  mailgate
#* * * * * /usr/bin/php /var/www/glpi/front/cron.php --force  queuednotification
#docker exec -i glpi /usr/bin/php /var/www/glpi/front/cron.php --force  mailgate
