#!/bin/sh
echo "Using database: $SQL_DATABASE"
echo "Using user: $SQL_USER"
echo "Using password: $SQL_PASSWORD"
echo "Using host: mariadb:3306"

# Wait for MariaDB to be fully ready
while ! mysqladmin ping -h mariadb -u"$SQL_USER" -p"$SQL_PASSWORD" --silent; do
    echo "Waiting for database connection..."
    sleep 5
done

# Ensure wp-config.php is created
wp config create --allow-root \
    --dbname="$SQL_DATABASE" \
    --dbuser="$SQL_USER" \
    --dbpass="$SQL_PASSWORD" \
    --dbhost=mariadb:3306 \
    --path='/var/www/html' \
    --force

# Download WordPress core if not installed
wp core download --allow-root --path='/var/www/html' || true

# Install WordPress if not already installed
wp core install --allow-root \
    --url="https://yzioual.42.fr" \
    --title="My WordPress Site" \
    --admin_user="admin" \
    --admin_password="adminpassword" \
    --admin_email="admin@example.com" \
    --path='/var/www/html' || true

# Create an additional user
wp user create user user@example.com --role=subscriber --user_pass=userpassword --allow-root --path='/var/www/html' || true

# Start PHP-FPM
exec /usr/sbin/php-fpm7.3 -F
