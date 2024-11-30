FROM debian:buster 
RUN apt update -y \
    && apt upgrade -y \
    && apt -y install wget php7.3 php-fpm php-mysql mariadb-client

# Download WordPress directly to /var/www/html
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www/html
RUN cd /var/www/html && tar -xzf wordpress-6.0-fr_FR.tar.gz --strip-components=1 && rm wordpress-6.0-fr_FR.tar.gz
RUN chown -R www-data:www-data /var/www/html

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN mkdir /run/php
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]
WORKDIR /var/www/html
EXPOSE 9000
CMD ["/usr/sbin/php-fpm7.3", "-F"]
