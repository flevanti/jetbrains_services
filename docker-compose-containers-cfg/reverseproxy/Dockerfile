FROM nginx:alpine

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/default_vhost
COPY ./default_vhost/ /var/www/default_vhost/