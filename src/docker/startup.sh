#!/bin/bash

cd /var/www/polr/

if ! [ -f /data/env ]; then
    cat /var/www/polr/.env.setup > /data/env
fi

ln -s /data/env .env
ln -s /data/storage /var/www/polr/.

mkdir -p /data/storage/app
mkdir -p /data/storage/logs
mkdir -p /data/storage/framework/cache
mkdir -p /data/storage/framework/sessions
mkdir -p /data/storage/framework/views

chown root:www-data -R /var/www/polr
chmod 750 -R /var/www/polr

chown root:www-data -R /data
chmod 770 -R /data

/usr/bin/supervisord
