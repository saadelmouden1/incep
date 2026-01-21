FROM debian:11-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    php-fpm php-mysql curl wget tar rsync && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/html /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

CMD ["/usr/local/bin/wordpress.sh"]