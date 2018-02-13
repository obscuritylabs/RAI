# C2 Server Docker builds
One of the major benfits of using Docker is the ability to refresh, restore and start multiple Team Servers. We use the raw docker builds to ensure 100% clean enviroments in RAI.


## Empire
The manual process looks like this to build:

1. Build command: `docker build -t empireproject/empire .`
2. Create volume storage: `docker create -v /opt/Empire --name data empireproject/empire`
3. Run out container: `docker run -ti --volumes-from data empireproject/empire` 
4. Finally to expose it to a public IP: `docker run -ti --volumes-from data -p 70.x.x.x:80:80 empireproject/empire`

To overwrite the entry point simply do:
```
$ docker run -ti --entrypoint bash empireproject/empire
```
More reading and examples:
```
https://blog.obscuritylabs.com/docker-command-controll-c2/
```
## CobaltStike 
