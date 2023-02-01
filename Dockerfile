FROM ubuntu

RUN apt update && apt install apache2 -y

RUN rm /var/www/html/index.html

COPY src /var/www/html

COPY apache2.conf /etc/apache2/apache2.conf
COPY conf/*.conf /etc/apache2/sites-available/

RUN a2ensite *.conf