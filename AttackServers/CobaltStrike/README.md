# Cobaltstrike Docker Setup

## Using docker-compose (recomended)

The recommended way of setting up CobaltStrike docker server is to use 'docker-compose' this provides a few benefits. It allows the use of the `.env` File, protecting your secret data and allowing you to deploy and alter your configuration. The stack also allows you to add things like NGINX or Apache as middleware on the edge if customization is needed. Finally, it also has a default docker volume and network to store your OP data. 

### Add ENV data during setup

```bash
git clone https://github.com/obscuritylabs/RAI.git
cd RAI/AttackServers/CobaltStrike
vim .env
```

example .env file:
```bash
CS_KEY=xxxx-xxxx-xxxx-xxxx
CS_NODE_NAME=cobaltstrike
CS_EXPOSE_PORT=50050
CS_BIND_IP=192.168.1.101
CS_PASSWORD=dds!!AS$^GFDFH

```

### Add ENV data during setup

A few key commands:

1) build the image without starting the services:
```bash
alexanderrymdeko-harvey@alexanders-MacBook-Pro:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose build
Building cobaltstrike
Step 1/12 : FROM ubuntu:18.04
.....SNIP.....
Successfully built b9decf080049
Successfully tagged cobaltstrike_cobaltstrike:latest
```

2) start up the stack and push STDOUT to terminal
```bash
Alexanderrymdeko-harvey@alexanders-MacBook-Pro:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose up
Recreating 799af50009a5_cobaltstrike ... done
Attaching to cobaltstrike
cobaltstrike    | [*] Will use existing X509 certificate and keystore (for SSL)
cobaltstrike    | [+] Team server is up on 50050
cobaltstrike    | [*] SHA256 hash of SSL cert is: 21ae6a46bba0dd11abffc9da072f83145ad3784286f654ebaf47e751f6c856a8
```

3) build, start and demonize the stack:
```bash
alexanderrymdeko-harvey@alexanders-MacBook-Pro-9:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose up -d
Creating network "cobaltstrike_cobaltstrike" with the default driver
Creating cobaltstrike ... done
```

4) jump into the image to debug etc.:
```bash
alexanderrymdeko-harvey@alexanders-MacBook-Pro-9:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose exec cobaltstrike bash
root@2b71e3a279cc:/opt/cobaltstrike# ps
  PID TTY          TIME CMD
   50 pts/0    00:00:00 bash
   62 pts/0    00:00:00 ps
```
5) stop the stack:
```bash
alexanderrymdeko-harvey@alexanders-MacBook-Pro-9:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose down
Stopping cobaltstrike ... done
Removing cobaltstrike ... done
Removing network cobaltstrike_cobaltstrike
```
6) inspect stack logs:
```bash
alexanderrymdeko-harvey@alexanders-MacBook-Pro-9:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose up -d
Creating network "cobaltstrike_cobaltstrike" with the default driver
Creating cobaltstrike ... done
alexanderrymdeko-harvey@alexanders-MacBook-Pro-9:~/Desktop/RAI/AttackServers/CobaltStrike$ docker-compose logs cobaltstrike
Attaching to cobaltstrike
cobaltstrike    | [*] Will use existing X509 certificate and keystore (for SSL)
cobaltstrike    | [+] Team server is up on 50050
cobaltstrike    | [*] SHA256 hash of SSL cert is: 21ae6a46bba0dd11abffc9da072f83145ad3784286f654ebaf47e751f6c856a8
```