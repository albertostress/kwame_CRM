# 🚀 Dokploy Deployment Guide - EspoCRM Kwame

Este guia explica como fazer o deployment do EspoCRM customizado no Dokploy seguindo as melhores práticas da documentação oficial.

## 📋 **PASSO A PASSO - DEPLOYMENT CORRETO**

### 🧹 **1. RESET COMPLETO (Se necessário)**
```bash
# No servidor Dokploy via SSH:
./clean-start.sh

# OU no Dokploy Dashboard:
# - Applications → Seu App → Stop
# - Settings → Volumes → Delete all volumes
# - Delete application and recreate
```

### 🏗️ **2. CONFIGURAÇÃO NO DOKPLOY**

#### **A. Criar Aplicação Docker Compose**
1. **Login no Dokploy Panel**: `https://your-dokploy-domain:3000`
2. **Create Project** → Nome: `kwame-crm`
3. **Add Service** → **Docker Compose**
4. **Git Repository**: `https://github.com/albertostress/kwame_CRM.git`
5. **Branch**: `master`
6. **Compose File**: `docker-compose.dokploy.yml` ✅

#### **B. Configurar Variáveis de Ambiente**
```bash
SITE_URL=https://crm.kwameoilandgas.ao
DB_NAME=espocrm_kwame
DB_USER=espocrm_user
DB_PASSWORD=KwameOilGas2024_DB!@#
DB_ROOT_PASSWORD=KwameRoot2024_SQL!@#
```

#### **C. Configurar Domínio**
1. **Domains** → **Create Domain**
2. **Host**: `crm.kwameoilandgas.ao`
3. **Path**: `/`
4. **Container Port**: `80` ✅ (não 8080!)
5. **HTTPS**: `ON`
6. **Certificate**: `Let's Encrypt`

### 🔧 **3. CONFIGURAÇÕES ESPECÍFICAS DOKPLOY**

#### **Volumes (Automático)**
O Dokploy automaticamente cria os volumes persistentes:
- `../files/espocrm-data` → `/var/www/html/data`
- `../files/espocrm-custom` → `/var/www/html/custom`
- `../files/mysql-data` → `/var/lib/mysql`

#### **Network**
- Usa `dokploy-network` (externa, criada automaticamente)
- Comunicação interna entre containers

#### **Health Checks**
- **MySQL**: `mysqladmin ping` (sem autenticação)
- **EspoCRM**: `curl -f http://localhost/`

### 🎯 **4. MELHORES PRÁTICAS APLICADAS**

#### ✅ **Dokploy Best Practices Seguidas:**

1. **Persistent Storage**:
   ```yaml
   volumes:
     - "../files/mysql-data:/var/lib/mysql"  # ✅ Dokploy pattern
   ```

2. **Port Exposure**:
   ```yaml
   expose:
     - "80"  # ✅ Internal only, Dokploy handles external
   ```

3. **Network**:
   ```yaml
   networks:
     - dokploy-network  # ✅ External network
   ```

4. **Traefik Labels** (opcional - pode configurar no UI):
   ```yaml
   labels:
     - "traefik.http.routers.espocrm-app.rule=Host(`crm.kwameoilandgas.ao`)"
   ```

### 🚨 **5. PROBLEMAS EVITADOS**

❌ **Não fazer:**
```yaml
ports:
  - "3306:3306"  # ❌ Conflito de porta
volumes:
  - "/folder:/path"  # ❌ Não persistente no Dokploy
```

✅ **Fazer:**
```yaml
expose:
  - "80"  # ✅ Apenas porta interna
volumes:
  - "../files/mysql-data:/var/lib/mysql"  # ✅ Persistente
```

### 🔄 **6. AUTO-DEPLOY (Opcional)**
1. **Deployments Tab** → Copy **Webhook URL**
2. **GitHub** → Settings → Webhooks → Add webhook
3. **Paste URL** → Select **Push Events** → Save
4. **Auto-deploy** habilitado! 🎉

### 📊 **7. MONITORAMENTO**

#### **Health Status**
- **MySQL**: Deve estar `healthy` em 60s
- **EspoCRM**: Deve estar `healthy` em 120s

#### **Logs**
```bash
# Via Dokploy UI:
Applications → Logs Tab → Real-time logs

# Via SSH:
docker logs espocrm-mysql
docker logs espocrm-app
```

### 🎉 **8. RESULTADO ESPERADO**

✅ **Sucesso quando:**
- MySQL container: `healthy`
- EspoCRM container: `healthy`
- Site accessible: `https://crm.kwameoilandgas.ao`
- Install page: `https://crm.kwameoilandgas.ao/install`

### 🆘 **9. TROUBLESHOOTING**

#### **Volume Issues**
```bash
# Reset volumes no Dokploy:
Settings → Volumes → Delete All → Redeploy
```

#### **Port Conflicts**
```bash
# Verificar portas:
ss -tulnp | grep :80
ss -tulnp | grep :443
```

#### **Health Check Failures**
```bash
# Testar manualmente:
docker exec espocrm-mysql mysqladmin ping -h localhost --silent
docker exec espocrm-app curl -f http://localhost/
```

---

## 🎯 **RESUMO DOS ARQUIVOS**

- `docker-compose.dokploy.yml` → **Configuração otimizada para Dokploy**
- `docker-compose.yml` → **Configuração original (não usar)**
- `Dockerfile.fast` → **Build otimizado**
- `clean-start.sh` → **Script de reset completo**

**🚀 AGORA SEU ESPOCRM CUSTOMIZADO VAI FUNCIONAR PERFEITAMENTE NO DOKPLOY!**