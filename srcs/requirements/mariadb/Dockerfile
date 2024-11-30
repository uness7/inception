FROM debian:buster
RUN apt update -y && apt upgrade -y && apt-get install mariadb-server -y
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
EXPOSE 3306
COPY ./tools/create_table_user.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_table_user.sh
RUN apt-get install -y procps
ENTRYPOINT [ "/usr/local/bin/create_table_user.sh" ]
# Command to launch mariadb and enable the database to listen globally - also can be put on mysqldump.cnf file
CMD ["mysqld", "--bind-address=0.0.0.0"]



