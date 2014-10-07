FROM nicohvi/ruby

# install passenger
RUN  gem install passenger 

# install passenger nginx-module
RUN /bin/bash -l -c 'passenger-install-nginx-module --auto-download --auto --prefix=/etc/nginx'

# add nginx startup-script
ADD nginx.sh /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx

# add the log directory
RUN mkdir -p /var/log/nginx

# add the directory housing our ruby app
RUN mkdir -p /var/www/nplol/public
ADD index.html /var/www/nplol/public/

# setup the correct nginx.conf 
RUN useradd nginx
ADD nginx.conf /etc/nginx/

# run nginx in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

ENTRYPOINT sudo /etc/init.d/nginx start
