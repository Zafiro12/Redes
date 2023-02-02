FROM ubuntu/apache2

RUN apt update && apt install openssl -y
RUN mkdir /etc/apache2/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=ES/ST=Malaga/L=Estepona/O=Alejandro/CN=admin@example.com" && \
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apolo.com.key -out /etc/ssl/certs/apolo.com.crt -subj "/C=ES/ST=Malaga/L=Estepona/O=Alejandro/CN=apolo.com"

RUN rm /var/www/html/index.html
COPY src /var/www/html
COPY apache2.conf /etc/apache2/apache2.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY conf/*.conf /etc/apache2/sites-available/

RUN a2ensite *.conf
RUN a2enmod ssl

WORKDIR /etc/apache2