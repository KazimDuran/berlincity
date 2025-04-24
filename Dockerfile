FROM php:8.2-apache

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2


# Systempakete + PHP-Erweiterungen
RUN apt-get update && apt-get install -y \
    git curl zip unzip libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# App-Code rein
COPY . /var/www/html

# Rechte setzen
RUN chown -R www-data:www-data /var/www/html

# Apache config
COPY ./docker/apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

WORKDIR /var/www/html

# Abhängigkeiten installieren
RUN composer install --no-dev --optimize-autoloader

EXPOSE 80
CMD exec apache2 -DFOREGROUND

