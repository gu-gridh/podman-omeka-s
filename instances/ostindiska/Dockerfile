FROM localhost/omeka-base:4.1.0

RUN mkdir -p /var/www/html/volume/files/ && \
    rm -Rf /var/www/html/files/ && \
    ln -s /var/www/html/volume/files/ /var/www/html/files

# COPY ../../builder/fetch_assets.sh /usr/local/bin/fetch_assets.sh
# RUN chmod +x /usr/local/bin/fetch_assets.sh
# COPY modules.json /build/modules.json
# COPY themes.json /build/themes.json

# RUN /usr/local/bin/fetch_assets.sh /build/modules.json /build/themes.json

COPY config/ /var/www/html/config/

RUN chown -R www-data:www-data /var/www/html/

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]