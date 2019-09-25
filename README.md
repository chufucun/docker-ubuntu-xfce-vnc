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

If you want to change the password, please modify [Dockerfile#L20](https://github.com/chufucun/docker-ubuntu-xfce-vnc/blob/057cd8b531c220c296fcbb1e850681e272a1e3be/Dockerfile#L20)
 
### 3) init development script

Init timezone,jdk,ant,maven ..., see [init_dev.sh](./init_dev.sh)  

```
./login.sh
cd /opt
sh init_dev.sh
```


