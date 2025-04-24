# Build stage for frontend
FROM node:18 AS node-builder

WORKDIR /app
COPY package*.json ./

# Install Node deps, aber noch kein Build
RUN npm install

# PHP base image
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# App files
COPY . .

# Composer dependencies (damit Ziggy vorhanden ist)
RUN composer install --no-dev --optimize-autoloader

# Kopiere Node Build-Stufe hinein (erst jetzt)
COPY --from=node-builder /app/node_modules ./node_modules
COPY --from=node-builder /app/package*.json ./

# Jetzt npm build ausführen – Ziggy ist verfügbar
RUN npm run build

# Rechte setzen
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# PHP-FPM auf Port 5000 (für Dokku)
COPY docker/php/www.conf /usr/local/etc/php-fpm.d/www.conf
EXPOSE 5000
CMD ["php-fpm", "-F", "-y", "/usr/local/etc/php-fpm.conf", "--nodaemonize"]

