#!/bin/bash
# Reset MySQL Volume Script for EspoCRM Kwame
echo "🧹 Resetting corrupted MySQL volume..."

# Stop all containers
echo "⏹️ Stopping containers..."
docker compose down -v 2>/dev/null || echo "No running containers to stop"

# Remove specific MySQL volume
echo "🗑️ Removing corrupted MySQL volume..."
docker volume rm mysql_data 2>/dev/null || echo "Volume mysql_data not found"
docker volume rm crm2025-kwamecrm-xuacgh_mysql_data 2>/dev/null || echo "Volume crm2025-kwamecrm-xuacgh_mysql_data not found"

# List all volumes for verification
echo "📋 Current volumes:"
docker volume ls | grep -E "(mysql|crm2025)" || echo "No related volumes found"

echo "✅ MySQL volume reset complete!"
echo "🚀 Now redeploy your application in Dokploy"