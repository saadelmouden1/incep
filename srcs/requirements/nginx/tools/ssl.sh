#!/bin/bash

ssl_certificate="/etc/nginx/nginx.crt"
ssl_certificate_key="/etc/nginx/nginx.key"

if [[ -f "$ssl_certificate" && -f "$ssl_certificate_key" ]]; then
    echo "SSL certificates already exist."
else
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "$ssl_certificate_key" -out "$ssl_certificate" \
        -subj "/CN=sel-moud.42.fr"
fi