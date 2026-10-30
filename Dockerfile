FROM ubuntu:latest

# প্রয়োজনীয় প্যাকেজ ইনস্টল
RUN apt-get update && apt-get install -y nginx tor

# আপনার ফাইল সার্ভারে কপি
COPY . /var/www/html

# Tor Configuration তৈরি
RUN echo "HiddenServiceDir /var/lib/tor/my_site/\nHiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

# Nginx এবং Tor স্বয়ংক্রিয়ভাবে চালু করার কমান্ড
CMD service nginx start && tor
