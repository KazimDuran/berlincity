# Build stage for frontend
FROM node:18 AS node-builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# PHP base image
FROM php:8.2-fpm

# Install system deps
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# App setup
WORKDIR /var/www
COPY . .

# Copy built frontend assets
COPY --from=node-builder /app/public /var/www/public

# Install PHP deps
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

EXPOSE 5000
CMD ["php-fpm", "-F", "-y", "/usr/local/etc/php-fpm.conf", "--nodaemonize"]

