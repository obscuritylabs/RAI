# to create the env setup
# Ussage:
#	./build.sh example.com http://127.0.0.1/ 80

export domain_name=$1
export team_server=$2
export l_port=$3

docker run -it -p80:80 -v /certs/letsencrypt:/etc/letsencrypt -v /certs/log/letsencrypt:/var/log/letsencrypt certbot/certbot -t certonly --standalone --register-unsafely-without-email --agree-tos -d $1

docker-compose up -d
