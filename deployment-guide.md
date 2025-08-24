# EspoCRM Deployment Guide for Dokploy

This guide will help you deploy EspoCRM to Dokploy using the prepared Docker configuration.

## Prerequisites

1. **Dokploy Instance**: Have Dokploy installed and running on your server
2. **Domain**: A domain name pointing to your server
3. **GitHub Repository**: Your fork at `https://github.com/albertostress/kwame_CRM.git`
4. **SSL Certificate**: Dokploy will handle this automatically via Let's Encrypt

## Deployment Steps

### Step 1: Push Code to GitHub

```bash
# Add all deployment files
git add Dockerfile docker-compose.yml .dockerignore nginx.conf supervisord.conf dokploy.yaml .env.example deployment-guide.md CLAUDE.md

# Commit changes
git commit -m "Add Dokploy deployment configuration for EspoCRM"

# Push to your repository
git push origin master
```

### Step 2: Configure Dokploy

1. **Log into Dokploy Dashboard**
   - Access your Dokploy instance at `https://your-dokploy-domain.com`

2. **Create New Application**
   - Click "New Application"
   - Select "Docker Compose" as deployment type
   - Name it "kwame-crm"

3. **Connect GitHub Repository**
   - Repository URL: `https://github.com/albertostress/kwame_CRM.git`
   - Branch: `master`
   - Enable auto-deploy on push

4. **Configure Environment Variables**
   - Copy contents from `.env.example`
   - Update with your actual values:
     ```env
     SITE_URL=https://crm.yourdomain.com
     DB_PASSWORD=generate_secure_password
     DB_ROOT_PASSWORD=generate_secure_root_password
     ADMIN_PASSWORD=generate_secure_admin_password
     ADMIN_EMAIL=your-email@domain.com
     ```

5. **Domain Configuration**
   - Add your domain: `crm.yourdomain.com`
   - Enable SSL (Let's Encrypt)
   - Port: 80

### Step 3: Deploy Application

1. **Initial Deployment**
   - Click "Deploy" button in Dokploy
   - Monitor build logs for any errors
   - Wait for containers to start

2. **Verify Deployment**
   - Access `https://crm.yourdomain.com`
   - You should see EspoCRM installation or login page

3. **Complete Installation** (First time only)
   - Navigate to `https://crm.yourdomain.com/install`
   - Follow installation wizard
   - Use the database credentials from your environment variables

### Step 4: Post-Deployment Configuration

1. **Set Up Cron Jobs**
   - Cron is already configured in the container via supervisord
   - Verify it's running: Check container logs

2. **Configure Email**
   - Go to Administration → Outbound Emails
   - Configure SMTP settings from your `.env` file

3. **Security Hardening**
   - Change default admin password
   - Configure 2FA if needed
   - Set up proper ACL roles

## Maintenance

### Updating EspoCRM

1. **Pull latest changes**
   ```bash
   git pull upstream master
   git push origin master
   ```

2. **Dokploy Auto-Deploy**
   - If enabled, push will trigger automatic deployment
   - Otherwise, click "Deploy" in Dokploy dashboard

### Backup Strategy

1. **Automatic Backups**
   - Configured in `dokploy.yaml` to run daily at 2 AM
   - 7-day retention policy

2. **Manual Backup**
   ```bash
   # Database backup
   docker exec espocrm-mysql mysqldump -u espocrm -p espocrm > backup.sql
   
   # Files backup
   docker cp espocrm-app:/var/www/html/data ./backup-data
   docker cp espocrm-app:/var/www/html/custom ./backup-custom
   ```

### Monitoring

1. **Health Checks**
   - Endpoint: `/api/v1/App/health`
   - Configured to check every 30 seconds

2. **Logs**
   - View in Dokploy dashboard
   - Or via Docker commands:
   ```bash
   docker logs espocrm-app
   docker logs espocrm-mysql
   ```

3. **Resource Usage**
   - Monitor CPU, Memory, Disk usage in Dokploy dashboard
   - Configured limits: 1GB RAM, 1 CPU

## Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check environment variables
   - Verify MySQL container is running
   - Check database credentials

2. **Permission Issues**
   ```bash
   docker exec espocrm-app chown -R www-data:www-data /var/www/html
   docker exec espocrm-app chmod -R 755 /var/www/html
   ```

3. **Cache Issues**
   ```bash
   docker exec espocrm-app php clear_cache.php
   docker exec espocrm-app php rebuild.php
   ```

4. **Build Failures**
   - Check Dockerfile syntax
   - Verify all required files are present
   - Review build logs in Dokploy

### Debug Commands

```bash
# Enter container shell
docker exec -it espocrm-app /bin/sh

# Check PHP configuration
docker exec espocrm-app php -i

# Test database connection
docker exec espocrm-app php -r "new PDO('mysql:host=mysql;dbname=espocrm', 'espocrm', 'password');"

# View nginx error logs
docker exec espocrm-app tail -f /var/log/nginx/error.log
```

## Performance Optimization

1. **Enable OPcache**
   - Already configured in Dockerfile
   - Verify: `docker exec espocrm-app php -i | grep opcache`

2. **Database Optimization**
   - Configured with InnoDB buffer pool
   - Regular optimization: `docker exec espocrm-mysql mysqlcheck -o espocrm`

3. **Static Asset Caching**
   - Configured in nginx.conf
   - 30-day cache for static files

## Security Best Practices

1. **Regular Updates**
   - Keep EspoCRM updated
   - Update Docker base images
   - Apply security patches

2. **Strong Passwords**
   - Use password generator for all credentials
   - Enable password policies in EspoCRM

3. **Network Security**
   - Use Dokploy's built-in firewall rules
   - Restrict database port access

4. **Regular Backups**
   - Test restore procedures
   - Store backups off-site

## Support

- **EspoCRM Documentation**: https://docs.espocrm.com
- **Dokploy Documentation**: https://docs.dokploy.com
- **GitHub Issues**: https://github.com/albertostress/kwame_CRM/issues

## Environment Variables Reference

| Variable | Description | Default |
|----------|-------------|---------|
| `SITE_URL` | Full URL of your CRM | http://localhost:8080 |
| `DB_NAME` | Database name | espocrm |
| `DB_USER` | Database user | espocrm |
| `DB_PASSWORD` | Database password | *required* |
| `ADMIN_USERNAME` | Initial admin username | admin |
| `ADMIN_PASSWORD` | Initial admin password | *required* |
| `PHP_MEMORY_LIMIT` | PHP memory limit | 256M |
| `PHP_MAX_EXECUTION_TIME` | Max execution time | 180 |

## Next Steps

1. Configure your CRM settings
2. Import existing data if migrating
3. Set up user accounts and roles
4. Configure integrations (email, calendar, etc.)
5. Customize entities and layouts as needed

---

**Note**: This deployment is optimized for production use with Dokploy. For development, you may want to adjust resource limits and enable debug mode.