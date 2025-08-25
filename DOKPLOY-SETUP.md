# 🚀 SETUP COMPLETO DOKPLOY - EspoCRM Kwame Oil and Gas

## 📋 **DEPLOYMENT AUTOMÁTICO - PASSO A PASSO**

### **🎯 OBJETIVO**
Deploy completo do EspoCRM do zero no Dokploy para `crm.kwameoilandgas.ao`

---

## **ETAPA 1: PREPARAR DEPLOYMENT**

### **1.1 Execute o Script de Deploy Completo**
```bash
# No diretório do projeto:
./DEPLOY-COMPLETE.sh
```
✅ **Este script vai:**
- Verificar todos os arquivos necessários
- Fazer commit e push completo para GitHub
- Preparar todas as configurações para Dokploy

---

## **ETAPA 2: CONFIGURAR DOKPLOY**

### **2.1 Criar Novo Projeto**
1. **Acesse Dokploy Dashboard**
2. **New Project** → **Docker Compose**
3. **Nome**: `kwame-crm`

### **2.2 Configurar Repository**
```
Repository URL: https://github.com/albertostress/kwame_CRM.git
Branch: master
Compose File: docker-compose.yml
Build Context: /
Auto Deploy: ON (opcional)
```

### **2.3 Configurar Domain**
```
Domain: crm.kwameoilandgas.ao
Port: 80
HTTPS: ON
Certificate: Let's Encrypt
Path: /
```

### **2.4 Environment Variables**
**Copie do arquivo `.env.production`** ou configure manualmente:

```env
# === PRINCIPAIS ===
SITE_URL=https://crm.kwameoilandgas.ao
DB_PASSWORD=KwameOil2025Secure!
DB_ROOT_PASSWORD=RootKwame2025!

# === BANCO ===
DB_HOST=mysql
DB_NAME=espocrm
DB_USER=espocrm

# === ADMIN INICIAL ===
ESPOCRM_ADMIN_USERNAME=admin
ESPOCRM_ADMIN_PASSWORD=KwameAdmin2025!
ESPOCRM_ADMIN_EMAIL=admin@kwameoilandgas.ao

# === EMPRESA ===
COMPANY_NAME=Kwame Oil and Gas
TZ=Africa/Luanda
CURRENCY=AOA
LOCALE=pt_PT
```

---

## **ETAPA 3: DEPLOY**

### **3.1 Executar Deploy**
1. **Clique em "Deploy"** no Dokploy
2. **Aguarde Build** (~5-10 minutos)
3. **Monitore Logs** para erros

### **3.2 Verificar Containers**
✅ **Esperado:**
- `kwame-crm-mysql`: healthy (~60s)
- `kwame-crm-app`: healthy (~120s)

### **3.3 Testar Acesso**
- **URL**: https://crm.kwameoilandgas.ao
- **Esperado**: Instalador EspoCRM ou tela de login

---

## **ETAPA 4: CONFIGURAR ESPOCRM**

### **4.1 Instalação Inicial** (Se aparecer instalador)
1. **Acesse**: https://crm.kwameoilandgas.ao
2. **Sistema Requirements**: ✅ (deve passar)
3. **Database Settings**:
   ```
   Host: mysql
   Database: espocrm  
   User: espocrm
   Password: KwameOil2025Secure!
   ```
4. **Admin User**:
   ```
   Username: admin
   Password: KwameAdmin2025!
   Email: admin@kwameoilandgas.ao
   ```
5. **Finalizar Instalação**

### **4.2 Pós-Instalação**
1. **Login**: https://crm.kwameoilandgas.ao
2. **Administration** → **System** → **Settings**
3. **Configurar**:
   - Nome da empresa: Kwame Oil and Gas
   - Timezone: Africa/Luanda
   - Moeda: AOA (Kwanza)
   - Idioma: Português

---

## **ETAPA 5: MONITORAMENTO**

### **5.1 Health Checks**
```bash
# Via Dokploy Dashboard ou:
docker ps  # Verificar containers running
docker logs kwame-crm-app  # Logs EspoCRM
docker logs kwame-crm-mysql  # Logs MySQL
```

### **5.2 Teste Funcional**
- ✅ Login admin funciona
- ✅ Páginas carregam sem 404
- ✅ CSS/JS funcionam
- ✅ Database conecta

---

## **TROUBLESHOOTING**

### **❌ Se der erro de container**
```bash
# No Dokploy:
1. Rebuild containers
2. Check logs em tempo real
3. Verificar variables de ambiente
```

### **❌ Se instalador não aparecer**
```bash
# Reset completo:
1. Stop containers no Dokploy  
2. Delete volumes (se disponível)
3. Rebuild e restart

# OU usar script:
./reset-deployment.sh  # (se executar localmente)
```

### **❌ Se database não conectar**
```bash
# Verificar no Dokploy logs:
1. MySQL container healthy?
2. Variables de ambiente corretas?
3. Network dokploy-network ativa?
```

---

## **🎯 CONFIGURAÇÕES IMPORTANTES**

### **Docker Compose Features**
- ✅ **Network**: `dokploy-network` (externa)
- ✅ **Ports**: `expose: 80` (sem conflitos)
- ✅ **Volumes**: Persistentes para data/custom/uploads
- ✅ **Health Checks**: MySQL e EspoCRM
- ✅ **Dependencies**: EspoCRM espera MySQL healthy

### **Security Features**
- ✅ **Senhas seguras** (KwameOil2025Secure!)
- ✅ **SSL automático** (Let's Encrypt)
- ✅ **Network interna** Docker
- ✅ **Volumes persistentes**

### **Production Ready**
- ✅ **PHP optimizado** (512MB memory, timezone Angola)
- ✅ **Nginx otimizado** (assets, cache, security headers)
- ✅ **MySQL tuned** (InnoDB buffer, charset utf8mb4)
- ✅ **Supervisor** (process management)

---

## **📚 ARQUIVOS IMPORTANTES**

| Arquivo | Função |
|---------|--------|
| `docker-compose.yml` | Configuração principal Dokploy |
| `Dockerfile.full` | Container produção otimizado |
| `.env.production` | Variáveis de ambiente completas |
| `nginx.conf` | Configuração web server |
| `DEPLOY-COMPLETE.sh` | Script deployment automático |
| `reset-deployment.sh` | Reset completo para recomeçar |

---

## **✅ RESULTADO ESPERADO**

🎯 **URL Final**: https://crm.kwameoilandgas.ao
🏢 **Empresa**: Kwame Oil and Gas  
🌍 **Localização**: Angola (timezone/moeda)
🔐 **Admin**: admin / KwameAdmin2025!
💾 **Database**: MySQL 8.0 com dados persistentes
🚀 **Status**: Production-ready deployment

---

## **🆘 SUPORTE**

- **Logs**: Dokploy Dashboard → Logs
- **Reset**: `./reset-deployment.sh`  
- **Database**: `./reset-database.sql`
- **Docs**: `CLAUDE.md` (documentação técnica)

---

**🎉 DEPLOY COMPLETO PRONTO PARA DOKPLOY!** 🚀