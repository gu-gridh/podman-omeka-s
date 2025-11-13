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
nodejs \
npm

# PHP extensions
RUN docker-php-ext-install \
# omeka s core dependencies
pdo pdo_mysql xml \
# for NumericDataTypes which we use in all versions
intl

# Composer for modules
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Omeka S
ARG OMEKA_S_VERSION
WORKDIR /var/www/html
RUN curl -L https://github.com/omeka/omeka-s/releases/download/v${OMEKA_S_VERSION}/omeka-s-${OMEKA_S_VERSION}.zip --output /var/www/latest_omeka_s.zip && \
    unzip -q /var/www/latest_omeka_s.zip -d /var/www/ && \
    rm /var/www/latest_omeka_s.zip && \
    cp -a /var/www/omeka-s/. /var/www/html

COPY --chmod=755 build_modules_themes.sh /usr/local/bin/build_modules_themes.sh

# Apache permissions
RUN chown -R www-data:www-data /var/www/html
ENV APACHE_DOCUMENT_ROOT=/var/www/html

RUN a2enmod rewrite
RUN a2enmod http2
# Required to enable CORS for serving IIIF images to external clients.
RUN a2enmod headers

