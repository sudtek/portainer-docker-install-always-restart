#!/bin/bash

#original code from https://portainer.io/install.html

#Create a volume data for portnair
docker volume create portnair_data

#install portnair withe auomatic restart at reboot reboot 
docker run -d --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer

echo "In order to acces to portnair interface use your web broser on http://@ipportnair:9000 and choose option localport !"
