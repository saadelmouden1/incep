cat Dockerfile
FROM debian:11-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends nginx openssl && \
    rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/ssl.sh /usr/local/bin/ssl.sh

RUN chmod +x /usr/local/bin/ssl.sh && \
    /usr/local/bin/ssl.sh

CMD ["nginx", "-g", "daemon off;"]