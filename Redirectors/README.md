# **REDIRECTORS USAGE GUIDE**  

## **DNS**

The DNS redirector uses IPTables to forward traffic from the victim machine to the TeamServer.   The  
usage is pretty straight forward.. **_dns_redir.sh ip.to.fwd.to port_**

**EXAMPLE**

```
.\DNS_redir.sh help  
sudo .\DNS_redir.sh 53.43.177.239 2224
```


## **HTTP/HTTPS**

The HTTP/HTTPS redirector is a docker that uses NGINX proxy forwarding to forward traffic from  
the victim maching to the TeamServer.   

**Build the Docker Image**

**TEAM_SERVER** - This is the IP ADDR of the Team Server  
**LPORT** - This is the Port that the NGINX Server will listen on (use 80 for http 443 for https)  
**repo/http:1.0** - This is "repository/imageName:versionNumber" 
**HTTP**
```
docker build --build-arg TEAM_SERVER="http://TEAM_SERVER_IP:port_fwdg_to" --build-arg LPORT=80 -t repo/http:1.0 .  
```
**HTTPS**
```
docker build --build-arg TEAM_SERVER="https://TEAM_SERVER_IP:port_fwdg_to" --build-arg LPORT=443 -t repo/https:1.0 .  
```

**Create a container**  
**a.b.c.d** - This is the public IP for the Redirector  
**(if using AWS, use the internal IP for the server)**  
**e** - This is the port that will be exposed on the host  
**f** - This is the port that will correspond with the port you specified with the LPORT value when  
        the image was built.  It will be mapped to the port exposed on the host.   
```
docker run -d -p a.b.c.d:e:f repo/http:1.0
```
**HTTP Example:**
```
docker run -d -p 53.43.177.239:80:80 repo/http:1.0
```
**HTTPS Example**
```
docker run -d -p 53.43.177.239:443:443 repo/https:1.0
```

