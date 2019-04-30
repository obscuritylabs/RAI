# Pull The 16.04 Baseline Image
FROM ubuntu:16.04
MAINTAINER @real_slacker007

# Environment Variables.. 
# (Be Careful.. Each will persist inside the container)

# Build Time Arguments..
ARG TEAM_SERVER
ARG LPORT

# Update The Baseline
RUN apt-get update && apt-get upgrade -y && apt-get install vim nginx -y

# Install Tools
#RUN apt-get install vim nginx -y 

# Configure Tools
WORKDIR /etc/nginx
RUN mv nginx.conf old.nginx.conf && \
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
echo "server {\n  listen $LPORT;\n" >> nginx.conf && \
echo "  location  / {" >> nginx.conf && \
echo "\t\tproxy_pass $TEAM_SERVER;" >> nginx.conf && \
echo "\t\tproxy_set_header X-Forwarded-For \$remote_addr;" >> nginx.conf && \
echo "\t\tproxy_set_header Host \$host;" >> nginx.conf && \
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
