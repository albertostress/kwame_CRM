# 🚀 Deploy EspoCRM no Dokploy - Guia Simples

## ✅ **MUDANÇAS APLICADAS (Mínimas e Seguras)**

### 🔧 **docker-compose.yml - Ajustes para Dokploy:**

1. **Port Exposure** (mudança principal):
   ```yaml
   # ANTES:
   ports:
     - "${APP_PORT:-8080}:80"
   
   # AGORA:
   expose:
     - "80"
   ```
   ✅ **Por que**: Dokploy gerencia portas automaticamente

2. **Network** (mudança essencial):
   ```yaml
   # ANTES:
   networks:
     - espocrm-network
   
   # AGORA:  
   networks:
     - dokploy-network  # ✅ Network do Dokploy
   
   # No final do arquivo:
   networks:
     dokploy-network:
       external: true  # ✅ Usa network externa do Dokploy
   ```

3. **Health Check** (reabilitado):
   ```yaml
   # MySQL health check reabilitado para estabilidade
   healthcheck:
     test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "--silent"]
   ```

## 📋 **COMO FAZER DEPLOY NO DOKPLOY**

### **1. No Dokploy Dashboard**
- **Create** → **Docker Compose** 
- **Repository**: `https://github.com/albertostress/kwame_CRM.git`
- **Branch**: `master`
- **Compose File**: `docker-compose.yml` ✅

### **2. Configurar Domínio**
- **Domains** → **Add Domain**
- **Host**: `crm.kwameoilandgas.ao`
- **Container Port**: `80` ✅ (importante!)
- **HTTPS**: ON
- **Certificate**: Let's Encrypt

### **3. Variáveis de Ambiente** (se necessário)
```bash
SITE_URL=https://crm.kwameoilandgas.ao
DB_NAME=espocrm_kwame
DB_USER=espocrm_user
DB_PASSWORD=KwameOilGas2024_DB!@#
DB_ROOT_PASSWORD=KwameRoot2024_SQL!@#
```

## 🎯 **O QUE ESPERAR**

✅ **Deploy vai funcionar porque:**
- Usando `dokploy-network` (network padrão)
- Usando `expose` em vez de `ports` (sem conflitos)
- Health checks habilitados (estabilidade)
- Volumes locais (dados persistentes)

✅ **Resultado esperado:**
- MySQL: healthy em ~60s
- EspoCRM: healthy em ~120s  
- Site: https://crm.kwameoilandgas.ao

## 🔄 **Se Der Problema de Volume**
```bash
# Reset apenas volumes (não todo Dokploy):
./clean-start.sh
```

---

**🎉 CONFIGURAÇÃO MINIMALISTA MAS OTIMIZADA PARA DOKPLOY!**

**Mudanças mínimas, máxima compatibilidade!** ✅