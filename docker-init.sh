#!/bin/sh
MOUNT_TAG="DOCKER_MOUNT_"$(date +"%s")
VBOXMANAGE="$VBOX_MSI_INSTALL_PATH/VBoxManage"
boot2docker down
"$VBOXMANAGE" sharedfolder add boot2docker-vm -name $MOUNT_TAG -hostpath `pwd`
boot2docker up
boot2docker ssh "sudo sh -c \"if [ ! -d /work ]; then mkdir /$MOUNT_TAG; fi\" && sudo mount -t vboxsf $MOUNT_TAG /$MOUNT_TAG"
echo $MOUNT_TAG > .boot2docker-path
