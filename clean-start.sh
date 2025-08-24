#!/bin/bash
# Clean Start Script - Remove Everything and Start Fresh
echo "🧹 CLEAN SLATE - Removing all EspoCRM containers and volumes..."

echo "⏹️ Stopping all related containers..."
docker stop $(docker ps -aq --filter "name=espocrm") 2>/dev/null || echo "No EspoCRM containers running"
docker stop $(docker ps -aq --filter "name=crm2025") 2>/dev/null || echo "No CRM2025 containers running"

echo "🗑️ Removing all EspoCRM containers..."
docker rm $(docker ps -aq --filter "name=espocrm") 2>/dev/null || echo "No EspoCRM containers to remove"
docker rm $(docker ps -aq --filter "name=crm2025") 2>/dev/null || echo "No CRM2025 containers to remove"

echo "📦 Removing all related volumes..."
docker volume rm $(docker volume ls -q | grep -E "(espocrm|crm2025|mysql)") 2>/dev/null || echo "No related volumes to remove"

echo "🌐 Removing related networks..."
docker network rm $(docker network ls -q --filter "name=espocrm") 2>/dev/null || echo "No EspoCRM networks to remove"
docker network rm $(docker network ls -q --filter "name=crm2025") 2>/dev/null || echo "No CRM2025 networks to remove"

echo "🖼️ Removing related images (optional)..."
docker image rm $(docker images -q --filter "reference=*espocrm*") 2>/dev/null || echo "No EspoCRM images to remove"
docker image rm $(docker images -q --filter "reference=*crm2025*") 2>/dev/null || echo "No CRM2025 images to remove"

echo "🧽 Clean up unused resources..."
docker system prune -f --volumes

echo ""
echo "✨ CLEAN SLATE COMPLETE! ✨"
echo "📋 Summary:"
echo "   - All EspoCRM/CRM2025 containers removed"
echo "   - All related volumes deleted"
echo "   - All related networks removed"
echo "   - System cleaned up"
echo ""
echo "🚀 Ready for fresh deployment in Dokploy!"
echo "💡 Tip: Now redeploy your application and it will start completely fresh"