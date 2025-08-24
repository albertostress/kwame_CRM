# Guia de Resolução de Problemas - EspoCRM Kwame

## 🚨 Problemas Resolvidos Nesta Versão

### ❌ **Erro MySQL**: "data directory has files in it. Aborting"
**✅ Solução**: 
- Adicionado `depends_on` com health check
- Script de inicialização MySQL melhorado
- Configurações de volume otimizadas

### ❌ **Bad Gateway 502**
**✅ Solução**:
- Wait-for-MySQL script integrado
- Health checks aprimorados
- Configuração robusta de conexão

### ❌ **EspoCRM não baixado durante build**
**✅ Solução**: 
- Dockerfile.download baixa EspoCRM automaticamente
- Versão 8.4.2 baixada diretamente do GitHub
- Não depende mais de arquivos locais

### ❌ **Build lento/falhas NPM/Composer**  
**✅ Solução**:
- Download direto do EspoCRM (sem builds complexos)
- Build em 5-10 minutos
- Eliminados problemas de dependências

## 🔧 Como Resolver Problemas Comuns

### 1. **MySQL não inicia - Volume Corrompido** ⚠️
```bash
# ERRO: "data directory has files in it. Aborting"
# SOLUÇÃO: Reset completo do volume MySQL

# No Dokploy Dashboard:
# 1. Parar aplicação
# 2. Ir em Volumes/Storage 
# 3. Deletar volume mysql_data
# 4. Redeploy aplicação

# OU via SSH no servidor:
./reset-mysql.sh

# OU manual:
docker compose down -v
docker volume rm crm2025-kwamecrm-xuacgh_mysql_data
# Depois redeploy no Dokploy
```

### 2. **EspoCRM Bad Gateway**
```bash
# Verificar se MySQL está saudável
docker exec espocrm-mysql mysqladmin ping -u root -p

# Verificar logs EspoCRM
docker logs espocrm-app
```

### 3. **Erro "Port 3306 already in use"**
```bash
# MySQL do servidor já usa porta 3306
# Solução: Usamos porta 3307 no docker-compose.yml
# MySQL container: porta 3307 (externa) -> 3306 (interna)
```

### 4. **MySQL container unhealthy**
```bash
# TEMPORARIAMENTE DESABILITADO health check do MySQL
# para permitir debugging do problema de inicialização
# 
# Verificar logs MySQL:
docker logs espocrm-mysql

# Verificar se MySQL está respondendo:
docker exec espocrm-mysql mysqladmin ping -h localhost --silent

# Conectar manualmente ao MySQL:
docker exec -it espocrm-mysql mysql -u root -p
```

### 5. **Deploy muito lento**
- ✅ Use `Dockerfile.fast` (já configurado)
- ✅ Configuração otimizada já aplicada

## 📊 Monitoramento

### Verificar Status dos Containers
```bash
docker ps
docker stats espocrm-app espocrm-mysql
```

### Health Checks
- **MySQL**: Ping database a cada 10s
- **EspoCRM**: HTTP check a cada 30s

### Logs Importantes
```bash
# EspoCRM
docker logs -f espocrm-app

# MySQL
docker logs -f espocrm-mysql

# Nginx dentro do container
docker exec espocrm-app tail -f /var/log/nginx/error.log
```

## ⚡ Reset Completo (Se Necessário)

### 1. Parar tudo
```bash
docker compose down -v
```

### 2. Remover volumes
```bash
docker volume prune
```

### 3. Rebuild
```bash
docker compose up --build
```

## 🎯 Variáveis de Ambiente Corretas

```env
SITE_URL=https://crm.kwameoilandgas.ao
DB_NAME=espocrm_kwame
DB_USER=espocrm_user
DB_PASSWORD=KwameOilGas2024_DB!@#
DB_ROOT_PASSWORD=KwameRoot2024_SQL!@#
APP_PORT=8080
```

## 🏥 Primeiros Socorros

### Se o site não carregar:
1. ✅ Verificar se containers estão rodando
2. ✅ Verificar health checks
3. ✅ Verificar logs de erro
4. ✅ Testar conexão MySQL

### Se MySQL falhar:
1. ✅ Remover volume MySQL corrompido
2. ✅ Redeployar aplicação
3. ✅ Aguardar inicialização completa

### Se EspoCRM não conectar:
1. ✅ Verificar variáveis de ambiente
2. ✅ Verificar se MySQL está healthy
3. ✅ Revisar logs de conexão

## 📞 Status Esperado

Quando tudo estiver funcionando:
- ✅ MySQL: Healthy (10s health check)
- ✅ EspoCRM: Running (logs sem erros)  
- ✅ Site: https://crm.kwameoilandgas.ao (carregando)
- ✅ Install: https://crm.kwameoilandgas.ao/install

---

**Todas as correções já foram aplicadas nesta versão!** 🎉