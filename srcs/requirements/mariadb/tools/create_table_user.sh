#!/bin/sh

# Start MySQL in safe mode with skip-grant-tables
mysqld_safe --skip-grant-tables &

# Wait for MySQL to start
sleep 5

# Secure the installation and set up database
mysql << MYSQL_SCRIPT
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Shutdown the unsecured instance
mysqladmin -u root shutdown

# Start MySQL normally
exec mysqld_safe
