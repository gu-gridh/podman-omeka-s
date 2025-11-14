FROM localhost/omeka-base:4.1.1

RUN mkdir -p /var/www/html/files/

ARG MODULE_AdvancedResourceTemplate_VERSION
ARG MODULE_AnalyticsSnippet_VERSION
ARG MODULE_BlockPlus_VERSION
ARG MODULE_Common_VERSION
ARG MODULE_CSSEditor_VERSION
ARG MODULE_CSVImport_VERSION
ARG MODULE_CustomVocab_VERSION
ARG MODULE_FacetedBrowse_VERSION
ARG MODULE_Internationalisation_VERSION
ARG MODULE_NumericDataTypes_VERSION
ARG MODULE_Search_VERSION
ARG MODULE_Solr_VERSION
ARG MODULE_Taxonomy_VERSION
ARG THEME_Foundation_VERSION

RUN /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CustomVocab ${MODULE_CustomVocab_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSVImport ${MODULE_CSVImport_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSSEditor ${MODULE_CSSEditor_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules FacetedBrowse ${MODULE_FacetedBrowse_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules NumericDataTypes ${MODULE_NumericDataTypes_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedResourceTemplate ${MODULE_AdvancedResourceTemplate_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippet ${MODULE_AnalyticsSnippet_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Internationalisation ${MODULE_Internationalisation_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Common ${MODULE_Common_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM BlockPlus ${MODULE_BlockPlus_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules BibLibre Search ${MODULE_Search_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules BibLibre Solr ${MODULE_Solr_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules BibLibre Taxonomy ${MODULE_Taxonomy_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh themes omeka-s-themes foundation ${THEME_Foundation_VERSION} -

WORKDIR /var/www/html/themes/foundation
RUN npm install

WORKDIR /var/www/html/

COPY config/ /var/www/html/config/
COPY .htaccess /var/www/html/.htaccess

RUN chown -R www-data:www-data /var/www/html/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]