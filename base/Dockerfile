# with php version 8.3, 8.4 is not supported yet
FROM php:8.3-apache

# System deps
RUN apt-get update && apt-get install -y \
curl \
nano \
git \
netcat-traditional \
unzip \
imagemagick \
libpng-dev \
libjpeg-dev \
libtiff-dev \
libxml2-dev \
libicu-dev \
libzip-dev \
nodejs \
npm

# PHP extensions
RUN docker-php-ext-install \
# omeka s core dependencies
pdo pdo_mysql xml \
# for NumericDataTypes which we use in all versions
intl \
# needed for timeline
zip

# Composer for modules
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Omeka S
WORKDIR /var/www/html
RUN curl -L https://github.com/gu-gridh/omeka-s/archive/refs/heads/gridh_main_4.1.zip --output /var/www/latest_omeka_s.zip && \
    unzip -q /var/www/latest_omeka_s.zip -d /var/www/ && \
    rm /var/www/latest_omeka_s.zip && \
    mv /var/www/omeka-s-gridh_main_4.1/* /var/www/html && \
    mv /var/www/omeka-s-gridh_main_4.1/.htaccess.dist /var/www/html && \
    mv /var/www/omeka-s-gridh_main_4.1/.php* /var/www/html

COPY --chmod=755 build_modules_themes.sh /usr/local/bin/build_modules_themes.sh
RUN npm install
RUN npx gulp init

# Apache permissions
RUN chown -R www-data:www-data /var/www/html
ENV APACHE_DOCUMENT_ROOT=/var/www/html

RUN a2enmod rewrite
RUN a2enmod http2
# Required to enable CORS for serving IIIF images to external clients.
RUN a2enmod headers

