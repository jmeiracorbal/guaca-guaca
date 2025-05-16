#!/bin/bash

set -e

# Launch MariaDB
echo "Starting MariaDB..."
service mariadb start
sleep 5

# Create the database and user if not exist
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'localhost'; FLUSH PRIVILEGES;"

# Import schema if DB is empty
if ! mysql -u root ${MYSQL_DATABASE} -e "SHOW TABLES;" | grep -q guacamole_connection; then
    echo "Import database schema..."
    for file in /initdb/*.sql; do
        echo "Import $file"
        mysql -u root ${MYSQL_DATABASE} < "$file"
    done
else
    echo "Database is enable. Skip import."
fi

# Create properties file in /guac-home
echo "Create properties on /guac-home/guacamole.properties"
mkdir -p /guac-home
cat > /guac-home/guacamole.properties <<EOF
log-backend: console
log-level: info
mysql-hostname: 127.0.0.1
mysql-port: 3306
mysql-database: ${MYSQL_DATABASE}
mysql-username: ${MYSQL_USER}
mysql-password: ${MYSQL_PASSWORD}
EOF

# Set Guacamole home so it loads extensions and JDBC driver
export GUACAMOLE_HOME=/guac-home

# Start Tomcat
echo "Starting Tomcat..."
exec catalina.sh run