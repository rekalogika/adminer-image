FROM docker.io/adminer:4.8.0-standalone

USER root
ENV INSTALL_PHP_EXTENSION_URL 'https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions'
ENV PHP_EXTENSIONS "pdo_dblib oci8 mongodb"

RUN set -eux ; \
	curl -sSLf -o '/usr/local/bin/install-php-extensions' $INSTALL_PHP_EXTENSION_URL ; \
	chmod +x '/usr/local/bin/install-php-extensions' ; \
	install-php-extensions $PHP_EXTENSIONS

USER adminer
CMD	[ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]
EXPOSE 8080