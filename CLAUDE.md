# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

EspoCRM is an open-source CRM platform built with PHP (backend) and JavaScript (frontend as a single-page application). The application follows SOLID principles, uses dependency injection, and has a metadata-driven architecture.

## Key Architecture Components

### Backend Structure (PHP)
- **Entry Point**: `index.php` → `Application.php`
- **Core Components**:
  - `application/Espo/Core/` - Core framework components (DI container, API routing, ORM, etc.)
  - `application/Espo/Controllers/` - REST API controllers
  - `application/Espo/Services/` - Business logic services
  - `application/Espo/Entities/` - Entity definitions
  - `application/Espo/Repositories/` - Data access layer
- **Custom Code**: 
  - `custom/Espo/Custom/` - Custom business logic
  - `custom/Espo/Modules/` - Custom modules
- **Metadata System**: JSON-based configuration in `application/Espo/Resources/metadata/`

### Frontend Structure (JavaScript)
- **Entry Point**: `client/src/app.js`
- **MVC Framework**: Based on Backbone.js with custom extensions
- **Key Components**:
  - `client/src/views/` - View components
  - `client/src/models/` - Data models
  - `client/src/controllers/` - Frontend controllers
  - `client/src/collections/` - Collections for handling lists of models

### Dependency Injection
The application uses a sophisticated DI container with interface-based programming. Services are configured in metadata and resolved automatically.

## Development Commands

### Build Commands
```bash
# Full build (production)
npm run build
grunt

# Development build (faster, includes source maps)
npm run build-dev
grunt dev

# Build only frontend assets (CSS, JS bundles)
npm run build-frontend
grunt internal

# Build for running tests
npm run build-test
grunt test
```

### Testing Commands
```bash
# Run PHPStan static analysis (level 8)
npm run sa
php vendor/bin/phpstan

# Run unit tests
npm run unit-tests
php vendor/bin/phpunit ./tests/unit

# Run integration tests
npm run integration-tests
php vendor/bin/phpunit ./tests/integration

# Run specific test suite
php vendor/bin/phpunit --testsuite unit
php vendor/bin/phpunit --testsuite integration
```

### Cache Management
```bash
# Clear cache (required after metadata changes)
php clear_cache.php

# Rebuild application (recompiles metadata, clears cache)
php rebuild.php
```

### Development Workflow
```bash
# Install dependencies
composer install
npm install

# Start development (no built-in dev server - use Apache/Nginx)
# Configure web server to point to /public directory

# Create admin user (for fresh installations)
php command.php create-admin-user

# Run cron jobs manually
php cron.php

# Execute console commands
php command.php <command-name>
```

## Key Development Patterns

### Entity Creation
1. Define entity metadata in `application/Espo/Resources/metadata/entityDefs/<EntityName>.json`
2. Create entity class in `application/Espo/Entities/<EntityName>.php` (optional, for custom logic)
3. Create repository in `application/Espo/Repositories/<EntityName>.php` (optional, for custom queries)
4. Run `php rebuild.php` to apply changes

### API Endpoint Creation
1. Create controller in `application/Espo/Controllers/<ControllerName>.php`
2. Define routes in `application/Espo/Resources/routes.json` or use default REST routes
3. Implement service layer in `application/Espo/Services/<ServiceName>.php`

### Custom Module Development
1. Place module code in `custom/Espo/Modules/<ModuleName>/`
2. Follow the same structure as core application
3. Module metadata merges with core metadata automatically

### Frontend View Customization
1. Extend base views from `client/src/views/`
2. Define custom views in `client/custom/src/views/` or module-specific paths
3. Configure view usage in metadata (`clientDefs`)

## Important Considerations

### Metadata-Driven Architecture
- Most configuration is done through JSON metadata files
- Metadata is compiled and cached - run `php rebuild.php` after changes
- Use JSON Schema for autocompletion (schemas in `schema/` directory)

### Database
- Supports MySQL 8.0+, MariaDB 10.3+, PostgreSQL 15+
- Uses Doctrine DBAL for database abstraction
- Custom ORM implementation in `application/Espo/ORM/`

### Security
- All API endpoints require authentication by default
- ACL (Access Control List) system for fine-grained permissions
- CSRF protection enabled
- Input sanitization and validation through field validators

### Performance
- Heavy use of caching (metadata, language, layouts)
- Lazy loading of dependencies through DI container
- Database query optimization through ORM

## Testing Guidelines

### Unit Tests
- Located in `tests/unit/`
- Mock dependencies using `ContainerMocker`
- Follow existing test structure

### Integration Tests
- Located in `tests/integration/`
- Use `BaseTestCase` for database setup
- Tests run against actual database

## Common Tasks

### Adding a New Field to an Entity
1. Edit `application/Espo/Resources/metadata/entityDefs/<EntityName>.json`
2. Add field definition under "fields" section
3. Run `php rebuild.php`
4. Update database schema if needed

### Creating a Scheduled Job
1. Create job class in `application/Espo/Jobs/<JobName>.php`
2. Register in `application/Espo/Resources/metadata/app/scheduledJobs.json`
3. Configure schedule in Admin UI or database

### Implementing a Hook
1. Create hook class in `application/Espo/Hooks/<EntityName>/<HookName>.php`
2. Implement appropriate hook method (beforeSave, afterSave, etc.)
3. Clear cache to register hook

## MySQL Connection Reset Instructions

### 1. Reset MySQL Volume (se conexão falhar)
```bash
# Para volumes do Dokploy
docker volume rm <project_name>_mysql_data

# Para verificar volumes existentes
docker volume ls | grep mysql
```

### 2. Rebuild and Start
```bash
# Subir containers com rebuild
docker compose up -d --build
```

### 3. Reset Completo e Rebuild
```bash
# Reset completo com volumes
docker compose down -v

# Rebuild containers
docker compose up -d --build
```

### 4. Healthcheck e Dependências
**Nova configuração com service_healthy:**
- ✅ EspoCRM só inicia quando MySQL estiver `healthy`
- ✅ `wait-for-mysql.sh` adiciona delay fixo de 20s
- ✅ Mais confiável que loops infinitos

### 5. Test MySQL Connection (Internal Network Only)
```bash
# Conectar diretamente ao MySQL (comando principal)
docker exec -it espocrm-mysql mysql -uespocrm -pespocrm123 espocrm

# Testar ping do EspoCRM para MySQL (rede interna)
docker exec -it espocrm-app ping mysql

# Testar conexão MySQL direta do EspoCRM
docker exec -it espocrm-app mysql -uespocrm -pespocrm123 -h mysql espocrm

# Verificar status dos containers
docker ps

# Ver logs do MySQL
docker logs espocrm-mysql

# Ver logs do EspoCRM
docker logs kwame-crm-app
```

### 6. Configuração MySQL (Rede Interna Docker)
```env
DB_HOST=mysql          # Nome do serviço Docker interno
DB_PORT=3306           # Porta interna (não exposta ao host)
DB_NAME=espocrm
DB_USER=espocrm
DB_PASSWORD=espocrm123
DB_ROOT_PASSWORD=root123
```

**IMPORTANTE:**
- ✅ **Healthcheck**: EspoCRM aguarda MySQL ficar `healthy`
- ✅ **Sem conflito de portas**: MySQL não expõe porta 3306 ao host
- ✅ **Acesso via container**: Use `docker exec -it espocrm-mysql mysql -uespocrm -pespocrm123 espocrm`
- ✅ **Rede interna**: Comunicação entre containers via nome de serviço `mysql`
- ⚠️  **Acesso externo**: Se precisar, reative `ports: - "3307:3306"` no docker-compose.yml

## Docker Build Options

### Production Build (Dockerfile.full) - **DEFAULT**
**Timestamp: 2025-01-24**

O `docker-compose.yml` usa `Dockerfile.full` por padrão para deployments em produção no Dokploy.

**Características:**
- ✅ **Base**: `php:8.2-fpm-alpine`
- ✅ **Dependências completas**: composer, nginx, supervisor
- ✅ **Extensões PHP**: pdo, pdo_mysql, mysqli, intl, zip
- ✅ **Configurações otimizadas**: 512MB memory_limit, timezone Africa/Luanda
- ✅ **Port**: 8080 (interno)
- ✅ **Composer install**: `--no-dev --optimize-autoloader`
- ✅ **Permissões corretas**: www-data ownership, 775 em data/custom

### Development Build (Dockerfile.fast)
Para desenvolvimento local ou debug:

```yaml
# Temporário no docker-compose.yml:
build:
  context: .
  dockerfile: Dockerfile.fast  # Trocar para debug/local
```

**Como alternar entre builds:**
```bash
# Para produção (Dokploy)
sed -i 's/Dockerfile.fast/Dockerfile.full/' docker-compose.yml

# Para desenvolvimento local  
sed -i 's/Dockerfile.full/Dockerfile.fast/' docker-compose.yml

# Rebuild after change
docker compose down && docker compose up --build
```

### Dokploy Deployment
- ✅ **Usar**: `Dockerfile.full` (já configurado)
- ✅ **Port interno**: 8080
- ✅ **Domain mapping**: Container port 8080 → https://crm.kwameoilandgas.ao
- ✅ **Healthcheck**: Aguarda MySQL healthy + EspoCRM ready

## 📑 Nginx Configuration
**Timestamp: 2025-01-25 - Final Production Configuration**

### Current Configuration 
✅ **O nginx.conf agora aponta para `/var/www/html/public`**

```nginx
server {
    listen 80;
    server_name _;
    root /var/www/html/public;  # ✅ EspoCRM public directory
    index index.php index.html;

    # Client assets directory alias (EspoCRM frontend)
    location /client/ {
        alias /var/www/html/client/;
        try_files $uri $uri/ /index.php?$query_string;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Main location - EspoCRM PHP entry point
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # [Outros blocos mantidos: API, Portal, PHP, Security, Cache]
}
```

### Mudanças Aplicadas (2025-01-25)
- ✅ **Root Directory**: O nginx.conf agora aponta para `/var/www/html/public`
- ✅ **Assets JS/CSS**: Assets JS/CSS do EspoCRM são servidos via `/client/` com alias `/var/www/html/client/`
- ✅ **Try Files**: Cliente agora usa `try_files $uri $uri/ /index.php?$query_string`
- ✅ **Dockerfile.full**: Mantém `COPY nginx.conf /etc/nginx/nginx.conf`
- ✅ **Segurança**: Todos blocos de segurança existentes mantidos

### Troubleshooting
⚠️ **Se aparecer tela branca ou sem estilos**, verificar se o container está com o nginx.conf atualizado:
```bash
docker exec -it kwame-crm-app cat /etc/nginx/nginx.conf | grep "root"
# Deve mostrar: root /var/www/html/public;
```

### Rebuild Command (Após mudanças)
```bash
docker-compose build --no-cache kwame-crm-app
docker-compose up -d
```

### Rebuild and Deploy
```bash
docker compose up -d --build
```

### Testing Commands
```bash
# Test main application endpoint
docker exec -it kwame-crm-app curl -I http://localhost/

# Test client assets directory
docker exec -it kwame-crm-app curl -I http://localhost/client/

# Test specific CSS/JS assets
docker exec -it kwame-crm-app curl -I http://localhost/client/css/espo/main.css
```
**Esperado:** `HTTP/1.1 200 OK`

### FastCGI Configuration
O nginx está configurado para processar PHP via PHP-FPM na porta 9000:
- FastCGI pass: `127.0.0.1:9000`
- Timeout de leitura: 180s
- Buffer otimizado para aplicações PHP

### Segurança
As regras de segurança permanecem ativas:
- Nega acesso a `/data`, `/application`, `/custom`, `/vendor`, etc.
- Nega arquivos `.json`, `.lock`, `.tpl`, `.md`, `.sh`, `.sql`
- Headers de segurança: X-Frame-Options, X-Content-Type-Options, etc.

**Nota**: O `Dockerfile.full` copia automaticamente a versão atualizada do `nginx.conf`.

## 🚦 Traefik Routing & Debug no Dokploy
**Timestamp: 2025-01-24**

### Configuração Traefik
✅ **Labels configurados** no `docker-compose.yml` e `dokploy.yaml`:

```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.espocrm.rule=Host(`crm.kwameoilandgas.ao`)"
  - "traefik.http.routers.espocrm.entrypoints=websecure"
  - "traefik.http.routers.espocrm.tls.certresolver=myresolver"
  - "traefik.http.services.espocrm.loadbalancer.server.port=8080"
  # HTTP to HTTPS redirect
  - "traefik.http.routers.espocrm-http.rule=Host(`crm.kwameoilandgas.ao`)"
  - "traefik.http.routers.espocrm-http.entrypoints=web"
  - "traefik.http.routers.espocrm-http.middlewares=redirect-to-https"
  - "traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https"
  - "traefik.http.middlewares.redirect-to-https.redirectscheme.permanent=true"
```

### Debug do Traefik
Para verificar se o Traefik está a rotear correctamente:

```bash
# Ver logs do Traefik (últimas 50 linhas)
docker logs dokploy-traefik --tail=50

# Ver logs em tempo real
docker logs dokploy-traefik -f

# Verificar configuração do Traefik
docker exec dokploy-traefik traefik config
```

### Teste Local de Routing
```bash
# Testar se domínio está a responder
curl -I -H "Host: crm.kwameoilandgas.ao" http://127.0.0.1

# Testar HTTPS (se certificado estiver configurado)
curl -I -H "Host: crm.kwameoilandgas.ao" https://127.0.0.1 -k

# Testar directo ao container
curl -I http://container-ip:8080/index.php
```

### Redeploy no Dokploy
Para forçar um redeploy completo:

```bash
# Via CLI (se disponível)
dokploy redeploy crm2025-kwamecrm-xuacgh

# Via interface web do Dokploy
# 1. Aceder ao painel Dokploy
# 2. Seleccionar o projeto "kwame-crm"
# 3. Clicar "Redeploy" ou "Build & Deploy"
```

### Verificações de Rede
```bash
# Verificar se container está na rede dokploy-network
docker network inspect dokploy-network

# Ver todos os containers da rede
docker network ls | grep dokploy

# Testar conectividade entre containers
docker exec kwame-crm-app ping dokploy-traefik
```

### Troubleshooting Comum
1. **502 Bad Gateway**: Container não responde na porta 8080
   - Verificar: `docker logs kwame-crm-app`
   - Testar: `curl -I http://container-ip:8080`

2. **404 Not Found**: Routing não configurado
   - Verificar labels Traefik no container
   - Confirmar domínio DNS aponta para o VPS

3. **Certificate Error**: SSL não configurado
   - Verificar `certresolver=myresolver`
   - Aguardar geração de certificado (pode demorar)

### Container Health Check
```bash
# Verificar saúde dos containers
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

# Ver detalhes do healthcheck
docker inspect kwame-crm-app | grep -A 10 Health
```

**Nota**: Após alterações nos labels Traefik, é necessário fazer redeploy completo no Dokploy.

## ⚙️ EspoCRM Configuração Automática
**Timestamp: 2025-01-24**

### Problema Resolvido
✅ **Issue**: Redirecionamento infinito para `/install/` por falta de `data/config.php`
✅ **Solução**: Geração automática de configuração no startup

### Como Funciona
1. **Template**: `config.template.php` contém configuração base com variáveis de ambiente
2. **Geração automática**: No startup, se `data/config.php` não existir, é gerado automaticamente
3. **Variáveis**: Usa `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`, `SITE_URL` do ambiente

### Configurações Automáticas
O `config.template.php` gera:
```php
<?php
return array (
  'database' => array (
    'driver' => 'pdo_mysql',
    'host' => getenv('DB_HOST') ?: 'mysql',
    'port' => getenv('DB_PORT') ?: '3306',
    'dbname' => getenv('DB_NAME') ?: 'espocrm',
    'user' => getenv('DB_USER') ?: 'espocrm',
    'password' => getenv('DB_PASSWORD') ?: 'espocrm123',
    'charset' => 'utf8mb4',
  ),
  'siteUrl' => getenv('SITE_URL') ?: 'https://crm.kwameoilandgas.ao',
  'isInstalled' => true,
  'cryptKey' => bin2hex(random_bytes(16)), // Gerado automaticamente
  'applicationName' => 'Kwame Oil and Gas CRM',
  'timeZone' => 'Africa/Luanda',
  'defaultCurrency' => 'AOA',
  'language' => 'pt_PT',
  // ... outras configurações
);
```

### Personalização da Empresa
✅ **Nome**: "Kwame Oil and Gas CRM"
✅ **Timezone**: Africa/Luanda
✅ **Moeda**: AOA (Kwanza Angolano)
✅ **Idioma**: Português (pt_PT)
✅ **Email**: noreply@kwameoilandgas.ao

### Regenerar Configuração
Se precisares alterar credenciais da base de dados:

```bash
# Aceder ao container
docker exec -it espocrm-app bash

# Remover config atual
rm /var/www/html/data/config.php

# Sair e reiniciar container
exit
docker restart kwame-crm-app

# Verificar logs da regeneração
docker logs kwame-crm-app --tail=20
```

### Debug da Configuração
```bash
# Ver se config.php existe
docker exec kwame-crm-app ls -la /var/www/html/data/config.php

# Ver conteúdo da configuração (sem passwords)
docker exec kwame-crm-app php -r "
\$config = include('/var/www/html/data/config.php');
unset(\$config['database']['password']);
print_r(\$config);
"

# Testar conexão à base de dados
docker exec kwame-crm-app php -r "
\$config = include('/var/www/html/data/config.php');
try {
  \$pdo = new PDO(
    'mysql:host=' . \$config['database']['host'] . ';dbname=' . \$config['database']['dbname'],
    \$config['database']['user'],
    \$config['database']['password']
  );
  echo 'Database connection: OK\n';
} catch (Exception \$e) {
  echo 'Database connection: FAILED - ' . \$e->getMessage() . '\n';
}
"
```

### Troubleshooting
1. **Still redirects to /install/**: 
   - Verificar se `data/config.php` existe e tem `'isInstalled' => true`
   - Verificar permissões do ficheiro (deve ser 640 www-data:www-data)

2. **Database connection errors**:
   - Verificar variáveis de ambiente no docker-compose.yml
   - Testar conexão manual com `mysql -h mysql -u espocrm -p`

3. **Permission errors**:
   - Verificar ownership: `chown -R www-data:www-data /var/www/html/data`
   - Verificar permissões: `chmod 775 /var/www/html/data && chmod 640 /var/www/html/data/config.php`

**Nota**: A configuração é gerada automaticamente no primeiro startup. Não requer instalação manual.

## 🔌 Porta de Exposição Padronizada
**Timestamp: 2025-01-24**

### Padronização para Porta 80
✅ **Consistência**: Todos os componentes agora usam porta **80**
- **Nginx**: `listen 80;` (já estava correcto)
- **Container**: `EXPOSE 80` (era 8080)
- **Healthcheck**: `curl http://localhost:80/` 
- **Traefik**: `loadbalancer.server.port=80`
- **docker-compose.yml**: `expose: ["80"]`

### Como Funciona
- **Interno**: EspoCRM roda na **porta 80** dentro do container
- **Externo**: Dokploy/Traefik faz roteamento via domínio configurado (`SITE_URL`)
- **Acesso**: `https://crm.kwameoilandgas.ao` → Traefik → Container:80

### Debug Local
Se quiseres expor manualmente para debug local:
```bash
# Expor porta 80 do container para 8080 do host
docker compose up -d
docker run -p 8080:80 espocrm-app

# Testar directamente
curl -I http://localhost:8080/index.php
```

### Verificações de Porta
```bash
# Ver que porta o container expõe
docker ps --format "table {{.Names}}\t{{.Ports}}"

# Testar healthcheck interno
docker exec kwame-crm-app curl -I http://localhost:80/

# Ver logs de healthcheck
docker inspect kwame-crm-app | grep -A 5 Health
```

### Troubleshooting de Porta
1. **Connection refused**: Container não está a responder na porta 80
   - Verificar nginx está a fazer `listen 80;`
   - Testar: `docker exec kwame-crm-app netstat -tlnp | grep :80`

2. **Healthcheck failing**: Curl não consegue conectar
   - Verificar se nginx está running: `docker exec kwame-crm-app ps aux | grep nginx`
   - Testar endpoint manualmente: `docker exec kwame-crm-app curl -v http://localhost:80/`

3. **502 Bad Gateway**: Traefik não consegue proxy
   - Verificar label: `traefik.http.services.espocrm.loadbalancer.server.port=80`
   - Container deve estar na rede `dokploy-network`

**Nota**: Todas as referências antigas à porta 8080 foram removidas para consistência.

## 🔐 Gestão de Permissões e Persistência
**Timestamp: 2025-01-24**

### Correção Automática de Permissões
✅ **Startup Script**: O container corrige automaticamente permissões em cada startup

**Diretórios criados e corrigidos automaticamente:**
```bash
/var/www/html/data/          # 775 www-data:www-data
├── cache/                   # Cache da aplicação
├── logs/                    # Logs do EspoCRM
├── upload/                  # Ficheiros carregados
└── tmp/                     # Temporários

/var/www/html/custom/        # 775 www-data:www-data
└── Espo/Custom/             # Customizações

/var/www/html/client/custom/ # 775 www-data:www-data
```

### Volumes Persistentes
O docker-compose.yml usa volumes nomeados para persistência:
```yaml
volumes:
  espocrm_data:    # /var/www/html/data - configs, uploads, logs
  espocrm_custom:  # /var/www/html/custom - customizações
  mysql_data:      # /var/lib/mysql - base de dados
```

### Testar Permissões
```bash
# Verificar ownership dos diretórios
docker exec kwame-crm-app ls -la /var/www/html/data/

# Testar escrita em logs
docker exec kwame-crm-app touch /var/www/html/data/logs/test.log
docker exec kwame-crm-app rm /var/www/html/data/logs/test.log

# Verificar user www-data
docker exec kwame-crm-app id www-data

# Ver processos rodando como www-data
docker exec kwame-crm-app ps aux | grep www-data
```

### Resolver "Permission Denied"
Se aparecer erro de permissões:

#### 1. Forçar correção manual:
```bash
# Entrar no container
docker exec -it espocrm-app bash

# Corrigir permissões manualmente
chown -R www-data:www-data /var/www/html/data
chown -R www-data:www-data /var/www/html/custom
chmod -R 775 /var/www/html/data
chmod -R 775 /var/www/html/custom

# Sair e reiniciar
exit
docker restart kwame-crm-app
```

#### 2. Verificar logs de erro:
```bash
# Ver logs do PHP-FPM
docker exec kwame-crm-app tail -f /var/log/php-fpm.log

# Ver logs do EspoCRM
docker exec kwame-crm-app tail -f /var/www/html/data/logs/espo.log

# Ver logs do container
docker logs kwame-crm-app --tail=50
```

#### 3. Debug de permissões específicas:
```bash
# Verificar permissão de um ficheiro específico
docker exec kwame-crm-app stat /var/www/html/data/config.php

# Listar todos os ficheiros com problemas de permissão
docker exec kwame-crm-app find /var/www/html/data -not -user www-data

# Verificar espaço em disco
docker exec kwame-crm-app df -h /var/www/html/data
```

### Troubleshooting Comum

#### "Could not write to cache"
```bash
# Limpar e recriar cache
docker exec kwame-crm-app rm -rf /var/www/html/data/cache/*
docker exec kwame-crm-app php /var/www/html/clear_cache.php
```

#### "Failed to open log file"
```bash
# Verificar e criar diretório de logs
docker exec kwame-crm-app mkdir -p /var/www/html/data/logs
docker exec kwame-crm-app chown www-data:www-data /var/www/html/data/logs
docker exec kwame-crm-app chmod 775 /var/www/html/data/logs
```

#### "Upload failed"
```bash
# Verificar diretório de upload
docker exec kwame-crm-app ls -la /var/www/html/data/upload/
docker exec kwame-crm-app chown -R www-data:www-data /var/www/html/data/upload
docker exec kwame-crm-app chmod -R 775 /var/www/html/data/upload
```

### Backup e Restore de Volumes
```bash
# Backup do volume de dados
docker run --rm -v espocrm_data:/data -v $(pwd):/backup alpine tar czf /backup/espocrm_data_backup.tar.gz -C /data .

# Restore do volume
docker run --rm -v espocrm_data:/data -v $(pwd):/backup alpine tar xzf /backup/espocrm_data_backup.tar.gz -C /data

# Listar volumes
docker volume ls | grep espocrm

# Inspecionar volume
docker volume inspect espocrm_data
```

### Permissões no Dokploy
No ambiente Dokploy, os volumes são geridos automaticamente. Se houver problemas:

1. **Via interface Dokploy**: 
   - Aceder aos logs do container
   - Executar comando: `chown -R www-data:www-data /var/www/html/data`

2. **Via SSH no VPS**:
```bash
# Encontrar o container
docker ps | grep espocrm

# Executar correção
docker exec <container_id> chown -R www-data:www-data /var/www/html/data
```

**Nota**: As permissões são corrigidas automaticamente no startup, mas podem ser necessárias correções manuais após updates ou migrações.

## 🔄 Recovery & First Install
**Timestamp: 2025-01-24**

### Detecção Automática de Base de Dados Vazia
O container verifica automaticamente se a base de dados tem tabelas:
- ✅ **Com tabelas**: Inicia normalmente com config.php existente
- ⚠️ **Sem tabelas**: Remove config.php e força wizard de instalação

### Como Funciona
```bash
# No startup, o container executa:
mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" -e "SHOW TABLES;"

# Se não encontrar tabelas:
- Remove /var/www/html/data/config.php
- Limpa /var/www/html/data/cache/*
- Corrige permissões
- Wizard aparece ao abrir o domínio
```

### Forçar Wizard Manualmente
Se precisares reinstalar ou reconfigurar:

```bash
# Remover configuração e cache
docker exec -it espocrm-app rm -f /var/www/html/data/config.php
docker exec -it espocrm-app rm -rf /var/www/html/data/cache/*

# Reiniciar container
docker restart kwame-crm-app

# Abrir domínio - wizard vai aparecer
https://crm.kwameoilandgas.ao/install/
```

### Cenários de Uso

#### 1. **Primeira Instalação**
- Base de dados vazia → Wizard automático
- Preencher formulário de instalação
- Criar admin user
- Sistema fica configurado

#### 2. **Migração de Base de Dados**
```bash
# Importar backup da BD
docker exec -i espocrm-mysql mysql -uespocrm -pespocrm123 espocrm < backup.sql

# Container detecta tabelas existentes
# Mantém config.php e inicia normalmente
```

#### 3. **Reset Completo**
```bash
# Limpar base de dados
docker exec kwame-crm-mysql mysql -uespocrm -pespocrm123 -e "DROP DATABASE espocrm; CREATE DATABASE espocrm;"

# Reiniciar container
docker restart kwame-crm-app

# Wizard aparece automaticamente
```

### Verificar Estado da Instalação
```bash
# Ver se BD tem tabelas
docker exec kwame-crm-mysql mysql -uespocrm -pespocrm123 espocrm -e "SHOW TABLES;" | wc -l

# Ver se config.php existe
docker exec kwame-crm-app ls -la /var/www/html/data/config.php

# Ver logs do processo de detecção
docker logs kwame-crm-app | grep -E "Database|wizard|config.php"
```

### Troubleshooting

#### Wizard não aparece com BD vazia
```bash
# Forçar manualmente
docker exec kwame-crm-app bash -c 'rm -f /var/www/html/data/config.php && rm -rf /var/www/html/data/cache/*'
docker restart kwame-crm-app
```

#### Erro "Access denied" no MySQL
```bash
# Verificar credenciais
docker exec kwame-crm-app printenv | grep DB_

# Testar conexão manual
docker exec kwame-crm-app mysql -h"${DB_HOST}" -u"${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" -e "SELECT 1;"
```

#### Loop infinito de redirecionamento
```bash
# Limpar tudo e reiniciar
docker exec kwame-crm-app bash -c 'rm -rf /var/www/html/data/cache/* && rm -f /var/www/html/data/config.php'
docker exec kwame-crm-app chown -R www-data:www-data /var/www/html/data
docker restart kwame-crm-app
```

### Notas Importantes
- 🔐 **Segurança**: O wizard só aparece se a BD estiver vazia
- 💾 **Persistência**: Volumes mantêm dados entre restarts
- 🔄 **Automático**: Não requer intervenção manual em instalações normais
- ⚠️ **Cuidado**: Remover config.php força reinstalação completa

**Comportamento Esperado**:
1. **BD vazia** → Wizard de instalação
2. **BD com dados** → Login direto
3. **Config removido** → Wizard aparece novamente