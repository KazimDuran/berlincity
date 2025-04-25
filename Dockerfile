FROM unit:1.34.1-php8.3

# Install necessary dependencies for PHP, Redis, and other required extensions
RUN apt update && apt install -y \
    curl unzip git libicu-dev libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) pcntl opcache pdo pdo_mysql intl zip gd exif ftp bcmath \
    && pecl install redis \
    && docker-php-ext-enable redis

# Custom PHP configurations for performance optimizations
RUN echo "opcache.enable=1" > /usr/local/etc/php/conf.d/custom.ini \
    && echo "opcache.jit=tracing" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "opcache.jit_buffer_size=256M" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "memory_limit=512M" > /usr/local/etc/php/conf.d/custom.ini \
    && echo "upload_max_filesize=64M" >> /usr/local/etc/php/conf.d/custom.ini \
    && echo "post_max_size=64M" >> /usr/local/etc/php/conf.d/custom.ini

# Copy Composer from the official Composer image
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Set the working directory to the Laravel app's root
WORKDIR /var/www/html

# Create necessary directories for Laravel storage and cache
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache

# Set appropriate permissions for Laravel storage and cache directories
RUN chown -R unit:unit /var/www/html/storage bootstrap/cache && chmod -R 775 /var/www/html/storage

# Copy the project files into the container
COPY . .

# Set the proper ownership and permissions for the storage and cache directories
RUN chown -R unit:unit storage bootstrap/cache && chmod -R 775 storage bootstrap/cache

# Install dependencies via Composer
RUN composer install --prefer-dist --optimize-autoloader --no-interaction

# Copy the Nginx Unit configuration
COPY unit.json /docker-entrypoint.d/unit.json

# Expose port 8000
EXPOSE 8000

# Run the Unit daemon when the container starts
CMD ["unitd", "--no-daemon"]
