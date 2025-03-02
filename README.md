# portainer-docker-install-always-restart for docker and ubuntu

About installPortainerRestartAlways_D&U.sh

A very simple script extract from portnair.io https://portainer.io/install.html in order to install portnair for docker with portnair automatic restart.
Every time i install portainer i always forget to add the persistent option in order that docker bring it up to live at the next reboot ...
Dear head scatterbrained this is my 2 cents for you in order to avoid us to do this by hand.
Have a nice day !


Edit 20 september 2020 :

About installPortainerRestartAlwaysLimit_D&U.sh

Same goal as installPortainerRestartAlways.sh but this version is able to limit the memory an cpu foot print for tinny or / and old computer by default to 20% of 1 CPU, 10M of ram and 90M swap. Please check comments in the script before to use or change values. 

Edit 10 March 2022 :

+ modification docker container Community Edition 2.11.1

+ add a nota about error 'Your kernel does not support swap limit capabilities or the cgroup is not mounted. Memory limited without swap.'
They said :'if docker swap option is disable in cgroup you take the risk that the container was drop by docker if there is not enought ram in the container'
take a look at https://stackoverflow.com/questions/48685667/what-does-docker-mean-when-it-says-memory-limited-without-swap"


