FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libxml2-dev \
    unzip wget git \
    && docker-php-ext-install pdo pdo_mysql \
    mysqli gd zip intl soap

RUN wget https://github.com/PrestaShop/PrestaShop/releases/download/8.1.0/prestashop_8.1.0.zip \
    && unzip prestashop_8.1.0.zip -d /var/www/html/ \
    && rm prestashop_8.1.0.zip

RUN chown -R www-data:www-data /var/www/html/
EXPOSE 80
