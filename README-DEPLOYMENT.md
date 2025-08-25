# 🚀 EspoCRM Deployment Package - Kwame Oil and Gas

## **DEPLOYMENT COMPLETO PARA DOKPLOY - TUDO EM UM PACOTE**

Este repositório contém tudo necessário para fazer deploy completo do EspoCRM no Dokploy do zero.

---

## **🎯 DEPLOY RÁPIDO (1 COMANDO)**

```bash
# Execute este comando no diretório do projeto:
./DEPLOY-COMPLETE.sh
```

**Este comando vai:**
- ✅ Verificar todos os arquivos necessários
- ✅ Fazer commit e push completo para GitHub  
- ✅ Preparar tudo para deploy no Dokploy
- ✅ Exibir instruções passo-a-passo

---

## **📋 O QUE ESTÁ INCLUÍDO**

### **🐳 Container Configuration**
- `docker-compose.yml` - Configuração otimizada para Dokploy
- `Dockerfile.full` - Container produção com todas dependências
- `nginx.conf` - Web server otimizado para EspoCRM
- `supervisord.conf` - Gerenciamento de processos

### **⚙️ Environment & Security**  
- `.env.production` - Configuração completa de produção
- `.env.example` - Template para customização
- Senhas seguras pré-configuradas
- SSL automático via Let's Encrypt

### **🛠️ Deploy & Maintenance Scripts**
- `DEPLOY-COMPLETE.sh` - Deploy automático completo
- `reset-deployment.sh` - Reset completo para recomeçar
- `reset-database.sql` - Limpeza manual do banco
- `wait-for-mysql.sh` - Sincronização de containers

### **📚 Documentação Completa**
- `DOKPLOY-SETUP.md` - Guia passo-a-passo Dokploy
- `DEPLOY-DOKPLOY.md` - Referência rápida
- `deployment-guide.md` - Guia técnico completo
- `CLAUDE.md` - Documentação técnica detalhada

---

## **🚀 PASSOS PARA DEPLOY**

### **1. Preparar Deploy**
```bash
git clone https://github.com/albertostress/kwame_CRM.git
cd kwame_CRM/espocrm
./DEPLOY-COMPLETE.sh
```

### **2. Configurar Dokploy**
1. **New Project** → **Docker Compose**
2. **Repository**: `https://github.com/albertostress/kwame_CRM.git`
3. **Branch**: `master`
4. **Domain**: `crm.kwameoilandgas.ao`
5. **Environment**: Use `.env.production`

### **3. Deploy & Access**
- **Deploy** no Dokploy Dashboard
- **Aguarde** build completar (~5-10 min)
- **Acesse**: https://crm.kwameoilandgas.ao

---

## **🎯 RESULTADO ESPERADO**

✅ **URL**: https://crm.kwameoilandgas.ao  
✅ **Company**: Kwame Oil and Gas  
✅ **Timezone**: Africa/Luanda  
✅ **Currency**: AOA (Kwanza)  
✅ **Language**: Português  
✅ **Admin**: admin / KwameAdmin2025!  
✅ **Database**: MySQL 8.0 persistente  
✅ **SSL**: Automático via Let's Encrypt  

---

## **🔧 TECNOLOGIAS INCLUÍDAS**

- **EspoCRM 8.4+** - CRM completo
- **PHP 8.2** - Backend otimizado
- **MySQL 8.0** - Database tuned para performance  
- **Nginx** - Web server com cache
- **Docker** - Containerização completa
- **Traefik** - Proxy reverso (via Dokploy)
- **Let's Encrypt** - SSL automático

---

## **📊 CARACTERÍSTICAS**

### **🏢 Business Ready**
- Multi-language (PT/EN)
- Angola timezone/currency
- Email templates customizados
- Dashboard executivo
- Relatórios avançados

### **⚡ Performance Optimized**  
- PHP OpCache habilitado
- Nginx asset caching
- MySQL InnoDB tuned
- Container health checks
- Persistent volumes

### **🔒 Production Security**
- Strong password defaults
- Security headers
- SSL/HTTPS enforced  
- Docker network isolation
- File upload restrictions

### **🛠️ DevOps Ready**
- One-command deployment
- Complete reset capabilities
- Comprehensive logging
- Health monitoring
- Backup strategies

---

## **🆘 TROUBLESHOOTING**

### **Deploy Falhou?**
```bash
# Reset completo:
./reset-deployment.sh

# Ou rebuild manual:
docker compose down -v
docker compose up --build -d
```

### **Instalador Não Aparece?**
```bash
# Forçar ambiente limpo:
docker exec kwame-crm-app rm -f /var/www/html/data/config.php
docker restart kwame-crm-app
```

### **Database Issues?**
```bash
# Reset database:  
docker exec -i kwame-crm-mysql mysql -uroot -pRootKwame2025! < reset-database.sql
```

---

## **📞 SUPORTE**

- **📖 Docs**: Veja `DOKPLOY-SETUP.md` para guia passo-a-passo
- **🔧 Technical**: Consulte `CLAUDE.md` para detalhes técnicos  
- **🐛 Issues**: https://github.com/albertostress/kwame_CRM/issues
- **📧 Email**: admin@kwameoilandgas.ao

---

## **📅 VERSIONING**

- **v1.0** - Deploy inicial funcional
- **v2.0** - Otimizações de performance  
- **v3.0** - Deploy completo Dokploy
- **v4.0** - Reset e cleanup automatizado
- **v5.0** - **CURRENT** - Deployment package completo

---

## **⭐ FEATURES PRINCIPAIS**

🎯 **Deploy com 1 comando** - `./DEPLOY-COMPLETE.sh`  
🧹 **Reset completo** - `./reset-deployment.sh`  
📱 **Mobile responsive** - Interface otimizada  
🌍 **Multi-idioma** - PT/EN support  
💰 **Multi-moeda** - AOA/USD/EUR  
📊 **Dashboards** - Analytics integrados  
📧 **Email marketing** - Campanhas automatizadas  
👥 **Multi-user** - Teams e permissões  
📈 **Reports** - Relatórios avançados  
🔄 **API REST** - Integrações externas  

---

**🚀 PRONTO PARA DEPLOY EM PRODUÇÃO!**

Execute `./DEPLOY-COMPLETE.sh` e siga as instruções!