FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libxml2-dev \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install \
    pdo \
    pdo_mysql \
    mysqli \
    gd \
    zip \
    intl \
    soap

WORKDIR /var/www/html

RUN wget -q -O prestashop.zip \
    "https://github.com/PrestaShop/PrestaShop/releases/download/8.1.0/prestashop_8.1.0.zip" \
    && unzip -q prestashop.zip \
    && unzip -q prestashop.zip prestashop.zip -d . 2>/dev/null || true \
    && rm -f prestashop.zip

RUN chown -R www-data:www-data /var/www/html/ \
    && chmod -R 755 /var/www/html/

EXPOSE 80
