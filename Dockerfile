FROM php:8.1.15-apache

# arguments for non-interactive interface, user & userID
ARG DEBIAN_FRONTEND=noninteractive
ARG user
ARG uid

# install dependencies & PHP extensions
RUN apt-get update && apt-get install -y \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        zip \
        curl \
        unzip \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

# new apache virtual host configuration
COPY laravel_vhost.conf /etc/apache2/sites-available/000-default.conf

RUN a2enmod rewrite

# install composer & move to global path
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# create system user to run Composer & Artisan commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user

RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# set working directory
WORKDIR /var/www/html/laravel

USER $user