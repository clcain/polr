FROM ubuntu:16.04

RUN apt-get update && apt-get dist-upgrade -y

RUN apt-get install -y \
    supervisor apache2 git php7.0 libapache2-mod-php7.0 php7.0-cli \
    php7.0-mysql php7.0-xml php7.0-mbstring php7.0-curl php7.0-zip

RUN a2enmod php7.0
RUN a2enmod rewrite

RUN mkdir /var/www/polr
COPY ./src /var/www/polr/

RUN rm -rf /var/www/polr/storage
RUN mv /var/www/polr/docker/apache.conf /etc/apache2/sites-available/000-default.conf
RUN mv /var/www/polr/docker/supervisor.conf /etc/supervisor/conf.d/apache.conf
RUN apt-get install curl  -y
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer
RUN chmod +x /usr/bin/composer

WORKDIR /var/www/polr
RUN composer install

CMD ["/bin/bash", "/var/www/polr/docker/startup.sh"]
