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