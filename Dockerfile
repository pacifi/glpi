FROM ubuntu:latest


ENV TZ=America/Lima

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update -y
RUN apt upgrade -y
RUN  apt install apache2 wget -y
RUN apt install -y php-mbstring php-curl php-gd php-xml php-intl php-ldap php-apcu php-xmlrpc php-cas php-zip php-bz2 php-fpm php-imap php-mysql
RUN cd /var/www && wget https://github.com/glpi-project/glpi/releases/download/9.4.5/glpi-9.4.5.tgz 
RUN cd /var/www && tar -xf glpi-9.4.5.tgz
RUN chmod -R 777 /var/www/glpi/
RUN chown -R www-data:www-data /var/www/glpi/
#RUN sudo a2enmod rewrite
RUN apt install  libapache2-mod-php -y


COPY glpi.conf /etc/apache2/
#RUN cat /etc/apache2/glpi.conf > /etc/apache2/sites-available/default
RUN cat /etc/apache2/glpi.conf > /etc/apache2/sites-available/000-default.conf


#CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
#CMD /usr/sbin/php-fpm7.4 --nodaemonize
# ENTRYPOINT /usr/sbin/php-fpm7.4 --nodaemonize
COPY [ "./entrypoint.sh", "/root/entrypoint.sh" ]
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh


EXPOSE  80
