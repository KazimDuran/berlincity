# Base Image: PHP mit FPM
FROM php:8.2-fpm

LABEL maintainer="ilimix / duran"

# Set working directory
WORKDIR /var/www

# Install System-Abhängigkeiten
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    unzip \
    zip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    npm \
    nodejs \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Optional: Node.js manuell (wenn npm aus Paketquelle zu alt ist)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Installiere Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Kopiere Projektdateien
COPY . .

# Installiere PHP- und Node-Abhängigkeiten
RUN composer install --no-interaction && \
    npm install && \
    npm run build

# Rechte setzen
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Port für Laravel (wenn PHP-FPM genutzt wird)
EXPOSE 9000

# Start FPM beim Containerstart
CMD ["php-fpm"]
