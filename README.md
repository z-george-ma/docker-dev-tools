# docker-dev-tools
A few shell scripts to facilitate docker use in local development

Docker is a very powerful tool in clustering and deployment, but when comes to local development, testing docker image may not necessarily be handy, especially with boot2docker on Windows or MacOS.

### docker-init.sh
docker-init will modify boot2docker image in VirtualBox and add a mountpoint to current path. The mountpoint name is visible in .boot2docker-path file.

This enables docker to attach current path as a volume, hence any changes to the files are immediately visible to docker container.

### docker-build.sh
docker-build is a simple script to clean, build and push docker containers.
```
docker-build.sh -p my-container
``` 
will build docker container based on Dockerfile in current path and push it with system timestamp as version number.

### docker-start.sh
docker-start.sh shows an example of using these scripts together with Dockerfile to set up an Apache/PHP/Mysql development environment.

### docker-entry.sh
When developing NodeJS applications, you want to see the changes without rebuilding the docker container (then you have to wait for the build, restart the container with all linked containers etc). docker-entry.sh will automatically restart the NodeJS application when it sees .restart file in its path.

For example, in Dockerfile,
```
CMD docker-entry.sh node app.js
```
will start the nodejs app when you run the container.
```
docker run -v //MOUNT_POINT_12345:/app -d my-container
```
Once you made changes to app.js and want to restart the application, simply create an empty file named .restart, and it will trigger a restart without the need to rebuild the container.
```
touch .restart
```

