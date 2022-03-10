#!/bin/bash

# 10 mars 2022
# Create a conainer with portainer in order to easly manage docker container Community Edition
# original code from https://portainer.io/install.html
# Original code from https://docs.portainer.io/v/ce-2.11/start/install/server/docker/linux

#Create a volume data for portainer
docker volume create portainer_data

#install portnair withe auomatic restart at reboot reboot 
#docker run -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
docker run -d --name=Portainer --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

echo "In order to acces to portainer interface use your web broser on http://@ipportnair:9000 and choose option localport !"
