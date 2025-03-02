#!/bin/bash

# 10/mars/2022
# yannick SUDRIE
#
# Create a container with portainer in order to easly manage docker container Community Edition
# Original code from https://docs.portainer.io/v/ce-2.11/start/install/server/docker/linux
# This version is able to limit the memory an cpu foot print for tinny and old computer  
#
# DU = Docker & Ubuntu
#
# Tested on Ubuntu.
# DOCKER CLIENT :
#  Version: 19.03.8
#  API version: 1.40
#  Go version: go1.13.8
#  OS/Arch: linux/amd64
# DOCKER server:
# Engine:
#  Version:          19.03.8
#  API version:      1.40 (minimum version 1.12)
#  Go version:       go1.13.8
#  OS/Arch:          linux/amd64
#  Experimental:     false

# Portainer basic conf
PORTAINER_REPOSITORY=portainer/portainer-ce
# PORTAINER_VERSION=2.11.1
PORTAINER_VERSION=2.27.1

# Container basic conf
CONTAINER_NAME=Portainer
CONTAINER_INSIDE_PORT=9000
CONTAINER_OUTSIDE_PORT=9000
CONTAINER_VOLUME_NAME=portainer_data

# Limit the container footprint (usefull on old / tiny computer )
# Take a look to 'sudo docker update --help' for more option  (limit IO could be usefull on sdcard)
# or https://docs.docker.com/config/containers/resource_constraints/

# https://docs.docker.com/config/containers/resource_constraints/#limit-a-containers-access-to-memory 
# here sA : if --memory="300m" and --memory-swap="1g", the container can use 300m of memory and 700m (1g - 300m) here usable swap is 90m
# Portianer need at least more than 12M to work  
MEMORY_LIMIT=15m
SWAP_LIMIT=100m

# https://docs.docker.com/config/containers/resource_constraints/#configure-the-default-cfs-scheduler
# Only compliant with docker 1.13 and higher
CPU_LIMIT=.2

# before  1.13 or if you have a problem
#Limit a group to 20% of 1 CPU.
# With 50ms period, 10ms quota will be equivalent to 20% of 1 CPU.
# echo 10000 > cpu.cfs_quota_us /* quota = 10ms */
# echo 50000 > cpu.cfs_period_us /* period = 50ms */
# By using a small period here we are ensuring a consistent latency response at the expense of burst capacity.
CPU_LIMIT_PERIODE=50000 
CPU_LIMIT_QUOTA=10000

# Create a volume data for portnair
docker volume create $CONTAINER_VOLUME_NAME

# Install portnair withe auomatic restart at reboot reboot 
docker run -d --name=$CONTAINER_NAME --restart=always -p $CONTAINER_INSIDE_PORT:$CONTAINER_OUTSIDE_PORT -v /var/run/docker.sock:/var/run/docker.sock -v $CONTAINER_VOLUME_NAME:/data $PORTAINER_REPOSITORY:$PORTAINER_VERSION
# docker run -d --name=Portainer --restart=always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.11.1

# ---- Apply limit footprint -> update the container -----
# MEMORY 
docker update $CONTAINER_NAME --memory $MEMORY_LIMIT --memory-swap $SWAP_LIMIT 
# SWAP_LIMIT only apply if your kernel support swap limit capabilities and / or the cgroup is mounted -> Memory limited without swap.

# CPU
# Docker version >= 1.3
docker update $CONTAINER_NAME --cpus $CPU_LIMIT
# XOR for previuous Docker version !!!     
#docker update $CONTAINER_NAME --cpu-period $CPU_LIMIT_PERIODE --cpu-quota $CPU_LIMIT_QUOTA

echo "In order to acces to portnair interface use your web browser http://@ipportnair:'$CONTAINER_OUTSIDE_PORT' "
echo "When configuring Portainer choose option localport for the endpoint !"
echo "In order to check if limitation are corectly apply to your container $CONTAINER_NAME use the command :"
echo "$sudo docker stats"
echo "------------------------------------------------------------------------------------------------------"
echo "NOTA : if you get error 'Your kernel does not support swap limit capabilities or the cgroup is not mounted. Memory limited without swap.' "
echo "take a look at https://stackoverflow.com/questions/48685667/what-does-docker-mean-when-it-says-memory-limited-without-swap"
echo "'if docker swap option is disable in cgroup you take the risk that the container was drop by docker if ther is not enought ram in the container ' "
