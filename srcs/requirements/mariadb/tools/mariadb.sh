#!/bin/bash

DB_NAME="${DB_NAME}"
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

DB_PATH="/var/lib/mysql/${DB_NAME}"
SQL_FILE_PATH="/tmp/init.sql"

if [ -d "$DB_PATH" ]; then
    echo "Database already exists"
    # Start mysqld normally
    mysqld
else
    cat > "$SQL_FILE_PATH" <<EOF
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqld --init-file="$SQL_FILE_PATH"