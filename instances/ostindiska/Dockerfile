FROM localhost/omeka-base:4.1.1

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
COPY config/ /var/www/html/config/
RUN chown www-data:www-data /var/www/html/config/cleanurl.config.php
COPY .htaccess /var/www/html/.htaccess

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]