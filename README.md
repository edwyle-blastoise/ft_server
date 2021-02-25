# ft_server

This project set up web server with Nginx in one docker container. The container OS is debian buster. Web server run WordPress website, phpMyAdmin and MySQL services at the same time.
SQL database works with the WordPress and phpMyAdmin. Server use the SSL protocol.

Run Docker.
```
docker build -t image_name .
docker run --container_name -it -p 80:80 -p 443:443 image_name
```
