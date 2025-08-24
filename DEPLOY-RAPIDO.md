# Deploy Rápido - Kwame CRM

## 🚀 Solução dos Problemas de Build

### ✅ **Correções Aplicadas:**
1. **Dockerfile.fast** - Build simplificado sem npm/composer scripts
2. **docker-compose.yml** - Configuração otimizada
3. **Removido scripts problemáticos** - Sem postinstall e vendor-cleanup

### ⚡ **Deploy no Dokploy - MÉTODO RÁPIDO:**

#### Passo 1: Configurar Aplicação
- **Nome**: `kwame-crm`
- **Tipo**: `Docker Compose`
- **Repositório**: `https://github.com/albertostress/kwame_CRM.git`
- **Branch**: `master`

#### Passo 2: Variáveis de Ambiente (COPIE EXATAMENTE):
```env
SITE_URL=https://crm.kwameoilandgas.ao
DB_NAME=espocrm_kwame
DB_USER=espocrm_user
DB_PASSWORD=KwameOilGas2024_DB!@#
DB_ROOT_PASSWORD=KwameRoot2024_SQL!@#
APP_PORT=80
```

#### Passo 3: Domínio
- **Domínio**: `crm.kwameoilandgas.ao`
- **SSL**: ✅ Ativado
- **Porta**: `80`

#### Passo 4: Deploy
- Clicar **Deploy**
- Aguardar ~5-10 minutos (muito mais rápido agora)

### 📱 **Primeiro Acesso:**
1. **URL**: https://crm.kwameoilandgas.ao
2. **Setup**: Seguir wizard de instalação
3. **Database**: 
   - Host: `mysql`
   - Nome: `espocrm_kwame`
   - User: `espocrm_user` 
   - Senha: `KwameOilGas2024_DB!@#`
4. **Admin**:
   - User: `admin`
   - Senha: `KwameAdmin2024!@#`

### 🔧 **Se Ainda Der Erro:**
Logs comuns e soluções:

**MySQL Connection Error:**
```bash
# Verificar se containers estão rodando
docker ps

# Verificar logs MySQL
docker logs espocrm-mysql

# Verificar logs EspoCRM  
docker logs espocrm-app
```

**Build Error:**
- O `Dockerfile.fast` deve resolver os problemas de npm/composer
- Se persistir, verifique os logs de build no Dokploy

**Timeout:**
- Build agora deve levar ~5-10 minutos
- Se demorar mais, verificar recursos do servidor

### 🎯 **URLs Importantes:**
- **CRM**: https://crm.kwameoilandgas.ao
- **Instalação**: https://crm.kwameoilandgas.ao/install  
- **GitHub**: https://github.com/albertostress/kwame_CRM

### 📞 **Próximos Passos Após Deploy:**
1. ✅ Completar instalação
2. ✅ Alterar senha admin
3. ✅ Configurar empresa (Kwame Oil and Gas)
4. ✅ Configurar email SMTP
5. ✅ Personalizar campos para setor petrolífero

---

**Build otimizado e testado** - Deve funcionar agora! 🎉