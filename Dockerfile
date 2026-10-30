FROM ubuntu:latest

# আপডেট ও Nginx, Tor ইনস্টল
RUN apt-get update && apt-get install -y nginx tor

# আপনার ওয়েবসাইটের ফাইল কপি
COPY . /var/www/html

# Tor কনফিগারেশন ফোল্ডার তৈরি ও পারমিশন ঠিক করা
RUN mkdir -p /var/lib/tor/my_site/ && chmod 700 /var/lib/tor/my_site/

# torrc ফাইলে Hidden Service যুক্ত করা
RUN echo "HiddenServiceDir /var/lib/tor/my_site/\nHiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

# এন্ট্রি পয়েন্ট স্ক্রিপ্ট: Nginx এবং Tor একসাথে ব্যাকগ্রাউন্ডে চালু রাখা
EXPOSE 80
CMD service nginx start && tor -f /etc/tor/torrc
