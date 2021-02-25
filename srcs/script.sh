#!bin/bash
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'eblastoi'@'localhost' IDENTIFIED BY '1111';" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'eblastoi'@'localhost' IDENTIFIED BY '1111' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "update mysql.user set plugin='' where user='eblastoi';"| mysql -u root
service php7.3-fpm start
service nginx start
bash