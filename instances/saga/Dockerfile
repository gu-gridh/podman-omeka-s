FROM localhost/omeka-base:4.1.1

RUN mkdir -p /var/www/html/files

ARG MODULE_AdvancedResourceTemplate_VERSION
ARG MODULE_AdvancedSearch_VERSION
ARG MODULE_AnalyticsSnippet_VERSION
ARG MODULE_AnalyticsSnippetPiwik_VERSION
ARG MODULE_ApiInfo_VERSION
ARG MODULE_BlockPlus_VERSION
ARG MODULE_BulkEdit_VERSION
ARG MODULE_CleanUrl_VERSION
ARG MODULE_Common_VERSION
ARG MODULE_CopyResources_VERSION
ARG MODULE_CSSEditor_VERSION
ARG MODULE_CSVImport_VERSION
ARG MODULE_CustomVocab_VERSION
ARG MODULE_ImageAnnotate_VERSION
ARG MODULE_ItemCarouselBlock_VERSION
ARG MODULE_Mapping_VERSION
ARG MODULE_NumericDataTypes_VERSION
ARG MODULE_SearchSolr_VERSION
ARG MODULE_Timeline_VERSION
ARG THEME_Freedom_VERSION

RUN /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CopyResources ${MODULE_CopyResources_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSSEditor ${MODULE_CSSEditor_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CustomVocab ${MODULE_CustomVocab_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSVImport ${MODULE_CSVImport_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules ImageAnnotate ${MODULE_ImageAnnotate_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules ItemCarouselBlock ${MODULE_ItemCarouselBlock_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules Mapping ${MODULE_Mapping_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules NumericDataTypes ${MODULE_NumericDataTypes_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedResourceTemplate ${MODULE_AdvancedResourceTemplate_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedSearch ${MODULE_AdvancedSearch_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippet ${MODULE_AnalyticsSnippet_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippetPiwik ${MODULE_AnalyticsSnippetPiwik_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM ApiInfo ${MODULE_ApiInfo_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Common ${MODULE_Common_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM BlockPlus ${MODULE_BlockPlus_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM BulkEdit ${MODULE_BulkEdit_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM CleanUrl ${MODULE_CleanUrl_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM SearchSolr ${MODULE_SearchSolr_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Timeline ${MODULE_Timeline_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh themes gu-gridh freedom saga -

COPY config/ /var/www/html/config/
RUN chown www-data:www-data /var/www/html/config/cleanurl.config.php
COPY .htaccess /var/www/html/.htaccess

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]