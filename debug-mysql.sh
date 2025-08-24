#!/bin/bash
# MySQL Debug Script for Dokploy

echo "🔍 MySQL Debug Script"
echo "===================="

echo "1. Checking MySQL container status..."
docker ps -a | grep mysql

echo ""
echo "2. MySQL logs (last 50 lines)..."
docker logs espocrm-mysql --tail 50 2>&1

echo ""
echo "3. Testing MySQL connection..."
docker exec espocrm-mysql mysqladmin ping -h localhost --silent && echo "✅ MySQL is responding to ping" || echo "❌ MySQL not responding"

echo ""
echo "4. Checking MySQL volume..."
docker volume ls | grep mysql

echo ""
echo "5. Network connectivity test..."
docker network ls | grep dokploy

echo ""
echo "6. Testing connection from EspoCRM container..."
docker exec espocrm-app ping -c 1 mysql 2>&1 || echo "Cannot reach MySQL host from EspoCRM"

echo ""
echo "7. Checking for Dokploy containers specifically..."
docker ps -a | grep -E "(crm|kwame|dokploy)"

echo ""
echo "7. Environment variables in EspoCRM..."
docker exec espocrm-app env | grep -E "DB_|MYSQL_"

echo ""
echo "===================="
echo "📋 Debug complete!"