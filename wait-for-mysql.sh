#!/bin/bash
echo "🔍 Waiting for MySQL (20s fixed delay)..."
sleep 20

if mysqladmin ping -h"${DB_HOST:-mysql}" -u"${DB_USER}" -p"${DB_PASSWORD}" --silent; then
  echo "✅ MySQL is reachable!"
else
  echo "⚠️ Could not confirm MySQL, but continuing..."
fi