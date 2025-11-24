FROM localhost/omeka-base:4.1.1

RUN mkdir -p /var/www/html/volume/files/ && \
    rm -Rf /var/www/html/files/ && \
    ln -s /var/www/html/volume/files/ /var/www/html/files

ARG MODULE_AdvancedResourceTemplate_VERSION
ARG MODULE_AnalyticsSnippet_VERSION
ARG MODULE_AnalyticsSnippetPiwik_VERSION
ARG MODULE_BlockPlus_VERSION
ARG MODULE_CleanUrl_VERSION
ARG MODULE_Common_VERSION
ARG MODULE_CopyResources_VERSION
ARG MODULE_CSSEditor_VERSION
ARG MODULE_CSVImport_VERSION
ARG MODULE_CustomVocab_VERSION
ARG MODULE_FacetedBrowse_VERSION
ARG MODULE_FieldAsTags_VERSION
ARG MODULE_InverseProperties_VERSION
ARG MODULE_Mapping_VERSION
ARG MODULE_MetadataBrowse_VERSION
ARG MODULE_NumericDataTypes_VERSION
ARG THEME_ThanksRoy_VERSION

RUN /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CopyResources ${MODULE_CopyResources_VERSION} - \
/usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSSEditor ${MODULE_CSSEditor_VERSION} - \
/usr/local/bin/build_modules_themes.sh modules omeka-s-modules CustomVocab ${MODULE_CustomVocab_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules CSVImport ${MODULE_CSVImport_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules FacetedBrowse ${MODULE_FacetedBrowse_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules InverseProperties ${MODULE_InverseProperties_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules Mapping ${MODULE_Mapping_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules MetadataBrowse ${MODULE_MetadataBrowse_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules omeka-s-modules NumericDataTypes ${MODULE_NumericDataTypes_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AdvancedResourceTemplate ${MODULE_AdvancedResourceTemplate_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippet ${MODULE_AnalyticsSnippet_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM AnalyticsSnippetPiwik ${MODULE_AnalyticsSnippetPiwik_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM Common ${MODULE_Common_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM BlockPlus ${MODULE_BlockPlus_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Daniel-KM CleanUrl ${MODULE_CleanUrl_VERSION} composer \
&& /usr/local/bin/build_modules_themes.sh modules Libnamic FieldAsTags ${MODULE_FieldAsTags_VERSION} - \
&& /usr/local/bin/build_modules_themes.sh themes omeka-s-themes thanksroy ${THEME_ThanksRoy_VERSION} -

COPY config/ /var/www/html/config/

RUN chown -R www-data:www-data /var/www/html/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]