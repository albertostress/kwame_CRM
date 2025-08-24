#!/bin/bash
# VPS Debug Script - Execute na sua VPS via SSH

echo "🔍 EspoCRM Dokploy Debug Script"
echo "==============================="

echo "1. Dokploy containers status..."
docker ps -a

echo ""
echo "2. Specific EspoCRM/MySQL containers..."
docker ps -a | grep -E "(espocrm|mysql|crm|kwame)"

echo ""
echo "3. Dokploy networks..."
docker network ls

echo ""
echo "4. Docker Compose logs (if running)..."
cd /path/to/your/dokploy/project
docker compose logs --tail=50

echo ""
echo "5. MySQL specific logs (if container exists)..."
docker logs $(docker ps -aq --filter name=mysql) --tail=50 2>/dev/null || echo "No MySQL container found"

echo ""
echo "6. EspoCRM specific logs (if container exists)..."
docker logs $(docker ps -aq --filter name=espocrm) --tail=50 2>/dev/null || echo "No EspoCRM container found"

echo ""
echo "7. System resources..."
df -h
free -h

echo ""
echo "8. Port usage..."
netstat -tulpn | grep -E ":80|:3306|:3307"

echo ""
echo "==============================="
echo "📋 VPS Debug complete!"