FROM php:7.4.5-apache

# Instalar dependencias necesarias para las extensiones de PHP
RUN apt-get update && apt-get install -y \
    gnupg2 \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    libzip-dev \
    unixodbc-dev \
    && apt-get clean

# Instalar las extensiones necesarias para PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_mysql

# Instalar Microsoft ODBC y extensiones SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get -y --no-install-recommends install msodbcsql17 \
    && pecl install sqlsrv-5.10.0 pdo_sqlsrv-5.10.0 \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# Copiar la configuración del VirtualHost de Apache
COPY ./vhost.conf /etc/apache2/sites-available/000-default.conf

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Exponer el puerto 9000
EXPOSE 9000

# Copiar la aplicación Laravel al contenedor
WORKDIR /var/www
COPY . /var/www

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar las dependencias de Laravel
RUN composer install

# Iniciar Apache
CMD ["apache2-foreground"]
