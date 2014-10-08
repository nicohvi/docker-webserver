FROM nicohvi/rails

RUN useradd nginx

# install passenger
RUN  gem install passenger 

# install passenger nginx-module
RUN /bin/bash -l -c 'passenger-install-nginx-module --auto-download --auto --prefix=/etc/nginx'

# add nginx startup-script
ADD nginx.sh /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx

# add default nginx.conf
ADD nginx.conf /etc/nginx/nginx.conf
RUN chown -R nginx:nginx /etc/nginx/* 

# add the log directory
RUN mkdir -p /var/log/nginx

# make default web folder
RUN mkdir -p /var/www
ADD index.html /var/www/

# expose port 80 and the necessary volumes
EXPOSE 80
VOLUME ["/var/log/", "/etc/nginx"]

# add nginx user

# and run the sever
# CMD sudo /etc/init.d/nginx start

