# Single-stage build for EspoCRM
FROM php:8.2-fpm-alpine

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    nginx \
    supervisor \
    nodejs \
    npm \
    curl \
    zip \
    unzip \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    icu-dev \
    oniguruma-dev \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
    gd \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    mysqli \
    zip \
    intl \
    mbstring \
    xml \
    dom \
    opcache \
    exif \
    bcmath \
    && rm -rf /var/cache/apk/*

# Install composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configure PHP
RUN echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/memory.ini \
    && echo "max_execution_time=180" >> /usr/local/etc/php/conf.d/execution.ini \
    && echo "post_max_size=50M" >> /usr/local/etc/php/conf.d/upload.ini \
    && echo "upload_max_filesize=50M" >> /usr/local/etc/php/conf.d/upload.ini \
    && echo "max_input_time=180" >> /usr/local/etc/php/conf.d/input.ini

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Install Node.js dependencies and build frontend
COPY build-frontend.sh /build-frontend.sh
RUN chmod +x /build-frontend.sh && /build-frontend.sh

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod -R 775 /var/www/html/data \
    && chmod -R 775 /var/www/html/custom \
    && chmod -R 775 /var/www/html/client/custom \
    && chmod -R 775 /var/www/html/application/Espo/Modules

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create directories and set permissions
RUN mkdir -p /var/log/supervisor \
    && mkdir -p /run/nginx \
    && mkdir -p /var/www/html/data/cache \
    && mkdir -p /var/www/html/data/logs \
    && mkdir -p /var/www/html/data/tmp \
    && mkdir -p /var/www/html/data/upload \
    && chown -R www-data:www-data /var/www/html/data

# Create startup script
RUN echo '#!/bin/sh' > /start.sh \
    && echo 'set -e' >> /start.sh \
    && echo 'echo "Starting EspoCRM..."' >> /start.sh \
    && echo 'if [ -f /var/www/html/clear_cache.php ]; then' >> /start.sh \
    && echo '  php /var/www/html/clear_cache.php || true' >> /start.sh \
    && echo 'fi' >> /start.sh \
    && echo 'exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf' >> /start.sh \
    && chmod +x /start.sh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost/api/v1/App/health || exit 1

EXPOSE 80

CMD ["/start.sh"]