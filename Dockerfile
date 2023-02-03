FROM ubuntu/apache2

RUN apt update && apt install openssl -y

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache.key -out /etc/ssl/certs/apache.crt -subj "/C=ES/ST=Malaga/L=Estepona/OU=2DAW/O=Alejandro/CN=admin@example.com" && \
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apolo.com.key -out /etc/ssl/certs/apolo.com.crt -subj "/C=ES/ST=Malaga/L=Estepona/OU=2DAW/O=Alejandro/CN=apolo.com" && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/w2.empresa.com.key -out /etc/ssl/certs/w2.empresa.com.crt -subj "/C=ES/ST=Malaga/L=Estepona/OU=2DAW/O=Alejandro/CN=w2.empresa.com"

RUN rm /var/www/html/index.html

RUN mkdir /home/usuario
RUN mkdir /home/usuario/fotos
RUN touch /home/usuario/fotos/imagen1.jpg
RUN touch /home/usuario/fotos/imagen2.jpg
RUN touch /home/usuario/fotos/imagen3.jpg

COPY src /var/www/html
COPY apache2.conf /etc/apache2/apache2.conf
COPY ports.conf /etc/apache2/ports.conf
COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY conf/*.conf /etc/apache2/sites-available/

RUN ln -s /home/usuario/fotos/* /var/www/html/w1.empresa.com/imagenes

RUN a2ensite *.conf
RUN a2dissite 000-default.conf
RUN a2enmod ssl

WORKDIR /etc/apache2