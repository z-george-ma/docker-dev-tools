#!/bin/sh
MOUNT_TAG="DOCKER_MOUNT_"$(date +"%s")
VBOXMANAGE=$(which VBoxManage)
BOOT2DOCKER=$(which boot2docker)
if [ x$VBOXMANAGE = x ]; then
  VBOXMANAGE="$VBOX_MSI_INSTALL_PATH/VBoxManage"
fi
if [ $# -ge 1 ]; then
  docker-machine stop $1
  "$VBOXMANAGE" sharedfolder add $1 -name $MOUNT_TAG -hostpath `pwd`
  docker-machine start $1
  docker-machine ssh $1 "sudo sh -c \"if [ ! -d /$MOUNT_TAG ]; then mkdir /$MOUNT_TAG; fi\" && sudo mount -t vboxsf $MOUNT_TAG /$MOUNT_TAG"
else
  boot2docker down
  "$VBOXMANAGE" sharedfolder add boot2docker-vm -name $MOUNT_TAG -hostpath `pwd`
  boot2docker up
  boot2docker ssh "sudo sh -c \"if [ ! -d /$MOUNT_TAG ]; then mkdir /$MOUNT_TAG; fi\" && sudo mount -t vboxsf $MOUNT_TAG /$MOUNT_TAG"
fi
echo $MOUNT_TAG > .boot2docker-path
