# Pull The 16.04 Baseline Image
FROM ubuntu:16.04
MAINTAINER @killswitch_gui

# Build Time Arguments..
ARG TeamServer
ARG LPORT

# Update The Baseline
RUN apt-get update && apt-get install -y \
	nginx 

# Configure Tools
WORKDIR /etc/nginx
RUN mv nginx.conf old.nginx.conf && \
mkdir /etc/nginx/ssl &&\
mkdir /data && \
mkdir /data/nginx && \
touch /data/nginx/cache && \
touch nginx.conf && \
echo "user www-data;"  >> nginx.conf && \
echo "worker_processes auto;"  >> nginx.conf && \
echo "pid /run/nginx.pid;"  >> nginx.conf && \
echo "events {\n\t\tworker_connections 768;\n}" >> nginx.conf && \
echo "http {\n\t\tproxy_cache_path /data/nginx/cache levels=1:2 keys_zone=STATIC:10m"  >> nginx.conf && \
echo "\t\tinactive=24h max_size=1g;"  >> nginx.conf && \
echo "server {\n  listen $LPORT ssl;\n" >> nginx.conf && \
echo "ssl_certificate /etc/nginx/ssl/fullchain.pem;" >> nginx.conf && \
echo "ssl_certificate_key /etc/nginx/ssl/privkey.pem;" >> nginx.conf && \
echo "ssl_verify_client  off;" >> nginx.conf && \
echo "  location  / {" >> nginx.conf && \
echo "\t\tproxy_pass $TeamServer;" >> nginx.conf && \
echo "\t\tproxy_set_header Host \$host;" >> nginx.conf && \
echo "\t\tproxy_set_header X-Forwarded-For \$remote_addr;" >> nginx.conf && \
echo "\t\tproxy_ssl_certificate /etc/nginx/ssl/fullchain.pem;" >> nginx.conf && \
echo "\t\tproxy_ssl_certificate_key /etc/nginx/ssl/privkey.pem;" >> nginx.conf && \
echo "\t\tproxy_ssl_verify  off;"  >> nginx.conf && \
echo "\t\tproxy_cache STATIC;" >> nginx.conf && \
echo "\t\tproxy_cache_valid 200 1d;" >> nginx.conf && \
echo "\t\tproxy_cache_use_stale error timeout invalid_header updating" >> nginx.conf && \
echo "\t\t\thttp_500 http_502 http_504;\n\t}\n}\n}" >> nginx.conf && \
echo "\ndaemon off;" >> nginx.conf && \
chown -R www-data:www-data /var/lib/nginx

# Define Mountable Directories
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", \
"/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define Working Directory
WORKDIR /etc/nginx

# Default Command
CMD ["nginx"]

# Expose Ports
EXPOSE $LPORT