FROM tomcat:9-jdk17

ENV GUAC_VERSION=1.5.3
ENV DEBIAN_FRONTEND=noninteractive

# Install libraries and MySQL (MariaDB because is not available in the jdk image)
RUN apt-get update && apt-get install -y mariadb-server wget curl unzip && rm -rf /var/lib/apt/lists/*

# Create required directories for Guacamole structure
RUN mkdir -p /initdb /etc/guacamole

# Copy the extension directory
COPY ./guac-home/ /guac-home/

# Download the Guacamole WAR
RUN wget https://downloads.apache.org/guacamole/${GUAC_VERSION}/binary/guacamole-${GUAC_VERSION}.war -O /usr/local/tomcat/webapps/guacamole.war

# Download JDBC auth extension and schema
RUN wget https://downloads.apache.org/guacamole/${GUAC_VERSION}/binary/guacamole-auth-jdbc-${GUAC_VERSION}.tar.gz -O /tmp/auth-jdbc.tar.gz \
 && tar -xzf /tmp/auth-jdbc.tar.gz -C /tmp \
 && cp /tmp/guacamole-auth-jdbc-${GUAC_VERSION}/mysql/guacamole-auth-jdbc-mysql-${GUAC_VERSION}.jar /guac-home/extensions/ \
 && cp /tmp/guacamole-auth-jdbc-${GUAC_VERSION}/mysql/schema/*.sql /initdb/

# Copy own entrypoint to run create the database and launch Tomcat
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]