#!/bin/bash
# Reset completo do deployment EspoCRM para instalação limpa
# Use este script quando quiser fazer uma instalação completamente nova

echo "🧹 RESET COMPLETO DO ESPOCRM - Kwame Oil and Gas"
echo "================================================"

echo "⚠️  ATENÇÃO: Este script vai APAGAR TODOS os dados!"
echo "   - Banco de dados MySQL"
echo "   - Volumes Docker"
echo "   - Configurações EspoCRM"
echo ""
read -p "Tem certeza? Digite 'SIM' para continuar: " confirm

if [ "$confirm" != "SIM" ]; then
    echo "❌ Operação cancelada"
    exit 1
fi

echo "🛑 Parando containers..."
docker compose down

echo "🗑️  Removendo volumes (dados persistentes)..."
docker volume rm -f espocrm_data espocrm_custom espocrm_uploads mysql_data 2>/dev/null || true

echo "🧹 Removendo containers órfãos..."
docker system prune -f

echo "🔨 Rebuild e restart com volumes limpos..."
docker compose build --no-cache
docker compose up -d

echo ""
echo "✅ RESET COMPLETO!"
echo "🌐 Aguarde alguns minutos e acesse: https://crm.kwameoilandgas.ao/"
echo "🚀 O instalador EspoCRM deve aparecer para configuração inicial"
echo ""
echo "📋 Credenciais do banco (para o instalador):"
echo "   Host: mysql"
echo "   Database: espocrm"
echo "   User: espocrm"
echo "   Password: (confira no .env)"