FROM ubuntu:latest


RUN apt-get update && apt-get install -y nginx tor


COPY . /var/www/html


RUN echo "HiddenServiceDir /var/lib/tor/my_site/\nHiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc


CMD service nginx start && tor & sleep 5 && cat /var/lib/tor/my_site/hostname && tail -f /dev/null
