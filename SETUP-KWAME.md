# Setup Rápido - Kwame Oil and Gas CRM

## 🚀 Deploy no Dokploy

### Pré-requisitos
- ✅ DNS configurado: `crm.kwameoilandgas.ao` → Seu servidor Dokploy
- ✅ Dokploy instalado e funcionando
- ✅ Repositório no GitHub: https://github.com/albertostress/kwame_CRM

### Passo 1: Configurar Aplicação no Dokploy

1. **Acessar Dashboard Dokploy**
2. **Criar Nova Aplicação**:
   - Nome: `kwame-crm`
   - Tipo: `Docker Compose`
3. **Conectar GitHub**:
   - URL: `https://github.com/albertostress/kwame_CRM.git`
   - Branch: `master`
   - ✅ Ativar Auto-deploy

### Passo 2: Configurar Variáveis de Ambiente

Usar as configurações do arquivo `.env.production`:

```env
# Aplicação
SITE_URL=https://crm.kwameoilandgas.ao
APP_ENV=production

# Banco de Dados
DB_NAME=espocrm_kwame
DB_USER=espocrm_user
DB_PASSWORD=KwameOilGas2024_DB!@#
DB_ROOT_PASSWORD=KwameRoot2024_SQL!@#

# Administrador
ADMIN_USERNAME=admin
ADMIN_PASSWORD=KwameAdmin2024!@#
ADMIN_EMAIL=admin@kwameoilandgas.ao

# Email SMTP
SMTP_HOST=mail.kwameoilandgas.ao
SMTP_USER=crm@kwameoilandgas.ao
SMTP_FROM_ADDRESS=noreply@kwameoilandgas.ao
SMTP_FROM_NAME=Kwame Oil and Gas CRM

# Empresa
COMPANY_NAME=Kwame Oil and Gas
DEFAULT_LANGUAGE=pt_BR
TIMEZONE=Africa/Luanda
CURRENCY=AOA
```

### Passo 3: Configurar Domínio

1. **Adicionar Domínio**: `crm.kwameoilandgas.ao`
2. **SSL**: ✅ Ativado (Let's Encrypt automático)
3. **Porta**: `80`

### Passo 4: Deploy

1. **Clicar em "Deploy"**
2. **Aguardar build** (pode demorar alguns minutos)
3. **Verificar logs** para erros

### Passo 5: Primeiro Acesso

1. **Acessar**: https://crm.kwameoilandgas.ao
2. **Completar instalação** (primeira vez):
   - Ir para: `/install`
   - Seguir wizard
   - Usar credenciais configuradas
3. **Login**:
   - Usuário: `admin`
   - Senha: `KwameAdmin2024!@#`

## 📋 Checklist Pós-Deploy

### Configurações Imediatas
- [ ] Alterar senha do admin
- [ ] Configurar SMTP para emails
- [ ] Configurar logo da empresa
- [ ] Definir moeda para AOA (Kwanza)
- [ ] Configurar fuso horário (Africa/Luanda)

### Configurações de Segurança
- [ ] Ativar 2FA para admin
- [ ] Configurar papéis de usuários
- [ ] Revisar permissões de acesso
- [ ] Configurar backup automático

### Customizações Kwame Oil and Gas
- [ ] Adicionar campos específicos do setor petrolífero
- [ ] Configurar pipeline de vendas
- [ ] Criar relatórios personalizados
- [ ] Configurar integrações necessárias

## 🔧 Configurações Específicas

### Campos Personalizados Sugeridos
- **Contacts**: Cargo, Empresa Petrolífera, Certificações
- **Accounts**: Tipo de Operação, Licenças, Volume Produção
- **Opportunities**: Tipo Contrato, Prazo, Valor em AOA

### Integrações Recomendadas
- Sistema de gestão angolano
- Plataformas de pagamento locais
- APIs governamentais (se aplicável)

## 📞 Suporte

- **Documentação**: Ver `deployment-guide.md`
- **Logs**: Dashboard Dokploy → Logs
- **Backup**: Automático diário às 02:00 WAT

## 🌐 URLs Importantes

- **CRM**: https://crm.kwameoilandgas.ao
- **Instalação**: https://crm.kwameoilandgas.ao/install
- **API**: https://crm.kwameoilandgas.ao/api/v1
- **Documentação**: https://docs.espocrm.com

---

**Kwame Oil and Gas** - Sistema CRM Corporativo  
Powered by EspoCRM & Dokploy