#!/bin/bash
# MySQL Initialization Script for EspoCRM Kwame Oil and Gas
set -e

echo "🔧 Initializing MySQL for EspoCRM..."

# Wait for MySQL to be ready
until mysqladmin ping -h"localhost" --silent; do
    echo "⏳ Waiting for MySQL to be ready..."
    sleep 2
done

echo "✅ MySQL is ready"

# Create database if it doesn't exist
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;
    
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' 
    IDENTIFIED BY '${MYSQL_PASSWORD}';
    
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* 
    TO '${MYSQL_USER}'@'%';
    
    FLUSH PRIVILEGES;
    
    SELECT 'Database and user created successfully' AS status;
EOSQL

echo "🎯 MySQL initialization completed for EspoCRM"
echo "📊 Database: ${MYSQL_DATABASE}"
echo "👤 User: ${MYSQL_USER}"
echo "🏢 Company: Kwame Oil and Gas"