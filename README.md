docker-tomcat
=============

docker-tomcat image based in alpine-base

To build

```
docker build -t <repo>/tomcat:<version> .
```

To run:

```
docker run -d --name=<name> -e "DEPLOY_ENV=dev" <repo>/tomcat:<version> 
```