#!/bin/bash

WP_PATH="/var/www/html/wordpress"
WP_CONFIG="$WP_PATH/wp-config.php"

if [ ! -f "$WP_PATH/wp-load.php" ]; then
    wget -q https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    mkdir -p "$WP_PATH"
    rsync -a wordpress/ "$WP_PATH/"
    rm -rf wordpress latest.tar.gz
fi

if [ ! -f "$WP_CONFIG" ]; then
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST" --dbprefix="${DB_PREFIX:-wp_}" --allow-root --path="$WP_PATH"
    wp core install --url="sel-moud.42.fr" --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" --skip-email --allow-root --path="$WP_PATH"
    wp user create "$WP_NEW_USER" "$WP_NEW_EMAIL" --user_pass="$WP_NEW_PASS" --role=editor --allow-root --path="$WP_PATH"
fi

exec /usr/sbin/php-fpm7.4 -F