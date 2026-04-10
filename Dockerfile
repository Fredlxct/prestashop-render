FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libxml2-dev \
    unzip wget curl \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd \
       --with-freetype --with-jpeg \
    && docker-php-ext-install \
       pdo pdo_mysql mysqli gd zip intl soap \
    && a2enmod rewrite \
    && sed -i 's/AllowOverride None/AllowOverride All/g' \
       /etc/apache2/apache2.conf

WORKDIR /var/www/html

RUN curl -L \
    "https://github.com/PrestaShop/PrestaShop/releases/download/8.1.0/prestashop_8.1.0.zip" \
    -o ps.zip \
    && unzip -q ps.zip \
    && rm ps.zip \
    && chown -R www-data:www-data . \
    && chmod -R 755 .

EXPOSE 80
