# Node-Stage: nur Abhängigkeiten installieren
FROM node:18 AS node-deps

WORKDIR /app
COPY package*.json ./
RUN npm install

# PHP-Stage
FROM php:8.2-fpm

# System Abhängigkeiten
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    nodejs npm \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# App-Code kopieren
COPY . .

# Composer installieren (damit Ziggy existiert)
RUN composer install --no-dev --optimize-autoloader

# Node modules + build jetzt (nach Composer)
COPY --from=node-deps /app/node_modules ./node_modules
COPY package*.json ./
COPY package*.json ./
RUN npm install
RUN npm run build


# Berechtigungen setzen
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# PHP-FPM auf Port 5000 umstellen (für Dokku)
RUN sed -i 's/9000/5000/' /usr/local/etc/php-fpm.d/www.conf

EXPOSE 5000
CMD ["php-fpm"]
