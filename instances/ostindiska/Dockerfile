# with php version 8.3, 8.4 is not supported yet
FROM docker.io/library/php:8.3-apache

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

ENV APACHE_DOCUMENT_ROOT=/var/www/html

RUN a2enmod rewrite
RUN a2enmod http2
# Required to enable CORS for serving IIIF images to external clients.
RUN a2enmod headers

RUN mkdir -p /var/www/html/files/

ARG MODULE_AdvancedResourceTemplate_VERSION
ARG MODULE_AdvancedSearch_VERSION
ARG MODULE_AnalyticsSnippet_VERSION
ARG MODULE_AnnotationProfiles_VERSION
ARG MODULE_BlockPlus_VERSION
ARG MODULE_CleanUrl_VERSION
ARG MODULE_Common_VERSION
ARG MODULE_CSSEditor_VERSION
ARG MODULE_CSVImport_VERSION
ARG MODULE_CustomVocab_VERSION
ARG MODULE_DataTypeRdf_VERSION
ARG MODULE_Internationalisation_VERSION
ARG MODULE_NumericDataTypes_VERSION
ARG MODULE_Reference_VERSION
ARG MODULE_Thesaurus_VERSION

RUN /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CustomVocab ${MODULE_CustomVocab_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSVImport ${MODULE_CSVImport_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSSEditor ${MODULE_CSSEditor_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules NumericDataTypes ${MODULE_NumericDataTypes_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedResourceTemplate ${MODULE_AdvancedResourceTemplate_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedSearch ${MODULE_AdvancedSearch_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Reference ${MODULE_Reference_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippet ${MODULE_AnalyticsSnippet_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Internationalisation ${MODULE_Internationalisation_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM BlockPlus ${MODULE_BlockPlus_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM CleanUrl ${MODULE_CleanUrl_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Common ${MODULE_Common_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM DataTypeRdf ${MODULE_DataTypeRdf_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Thesaurus ${MODULE_Thesaurus_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules gu-gridh Omeka-S-module-AnnotationProfiles main - \
&& /usr/local/bin/build_modules_themes.sh modules gu-gridh Omeka-S-module-Datavis ostindiska - \
&& /usr/local/bin/build_modules_themes.sh themes gu-gridh Omeka-S-default-gridh ostindiska -

WORKDIR /var/www/html/themes/gridh
RUN npm install

WORKDIR /var/www/html/

COPY favicon.ico /var/www/html/
COPY LanguageList.php /var/www/html/modules/Internationalisation/src/View/Helper/
COPY SearchingForm.php /var/www/html/modules/AdvancedSearch/src/Site/BlockLayout/
COPY config/ /var/www/html/config/
COPY .htaccess /var/www/html/.htaccess

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]