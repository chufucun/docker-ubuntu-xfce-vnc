# docker-ubuntu-xfce-vnc
Collection of Docker images with VNC environments for development

this is a extend version of [docker-headless-vnc-container](https://github.com/ConSol/docker-headless-vnc-container).

For details, see [Dockerfile](./Dockerfile) 

## Usage

### 1) quick start
default user/password: impdev/impdev

```
docker-compose up -d 
```

### 2) custom username and password

please modify [Dockerfile](./Dockerfile)  line 21
 
### 3) init development script

Init timezone,jdk,ant,maven ..., see [init_dev.sh](./init_dev.sh)  

```
sh init_dev.sh
```


