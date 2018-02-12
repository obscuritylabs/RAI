# **REDIRECTORS USAGE GUIDE**  

## **DNS**

The DNS redirector uses IPTables to forward traffic from the victim machine to one of the  
core redirectors.  The core redirectors listen for DNS via ports [2220-2229]. The  
usage is pretty straight forward.. **_dns_redir.sh ip.to.fwd.to port_**

**EXAMPLE**

```
.\DNS_redir.sh help  
sudo .\DNS_redir.sh 53.43.177.239 2224
```


## **HTTP/HTTPS**

The HTTP/HTTPS redirector is a docker that uses NGINX proxy forwarding to forward traffic from  
the victim maching to one of the core redirectors.   

**Build the Docker Image**

**CORE_REDIR** - This is the IP ADDR of the Core Redirector  
**LPORT** - This is the Port that the NGINX Server will listen on (use 80 for http 443 for https)  
**gte/http:1.0** - This is "repository/imageName:versionNumber" 
```
docker build --build-arg CORE_REDIR="CORE REDIR IP" --build-arg LPORT=80 -t gte/http:1.0 .  
```

**Create a container**  
**a.b.c.d** - This is the public IP for the Redirector  
**e** - This is the port that will be exposed on the host  
**f** - This is the port that will correspond with the port you specified with the LPORT value when  
the image was built.  It will be mapped to the port exposed on the host.   
```
docker run -p a.b.c.d:e:f gte/http:1.0
docker run -p 53.43.177.239:80:80 gte/http:1.0
```

