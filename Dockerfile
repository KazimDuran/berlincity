# Build stage for frontend (Vue + Inertia)
FROM node:18 AS node-builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# PHP base image
FROM php:8.2-fpm

# System-Abhängigkeiten
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Arbeitsverzeichnis
WORKDIR /var/www

# App-Dateien
COPY . .

# Composer (damit Ziggy etc. verfügbar ist)
RUN composer install --no-dev --optimize-autoloader

# Frontend: Nur build-Output übernehmen (nicht node_modules!)
COPY --from=node-builder /app/public /var/www/public
COPY --from=node-builder /app/resources/js /var/www/resources/js
COPY --from=node-builder /app/resources/css /var/www/resources/css

# Rechte setzen
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose Port für Dokku
EXPOSE 5000

# php-fpm auf Port 5000 (ohne eigene www.conf)
RUN sed -i 's/9000/5000/' /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm"]
