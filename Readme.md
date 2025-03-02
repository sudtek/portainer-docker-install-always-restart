# Portainer install Always Restart

02/mars/2025
yannick SUDRIE

Vous trouverez plusieurs version d'un script permetant d'installer le gestionnaire de container Portainer version communeautysur differentes distribution. 

## installPortainerRestartAlways_DU.sh
Un script très simple extrait de [portnair.io](https://portainer.io/install.html) pour installer Portnair pour Docker avec redémarrage automatique de Portnair sur distribution Ubuntu (ou équivalent).
au  02/03/2025 je vous conseille de ne plus l'installer à moins que votre distribution n'implémente pas less cgroups.

### installPortainerRestartAlwaysLimit_DU.sh
Même objectif que le script installPortainerRestartAlways.sh, mais cette version permet de limiter l'empreinte mémoire et CPU pour les petits ordinateurs ou anciens ... par défaut à 20 % d'un CPU, 10 Mo de RAM et 90 Mo de swap. Veuillez vérifier les commentaires dans le script avant de l'utiliser ou de modifier les valeurs.

Edit 10 March 2022 :

+ modification update vers Portainer Community Edition 2.11.1

+ add a nota about error 'Your kernel does not support swap limit capabilities or the cgroup is not mounted. Memory limited without swap.'
They said :'if docker swap option is disable in cgroup you take the risk that the container was drop by docker if there is not enought ram in the container'
take a look at https://stackoverflow.com/questions/48685667/what-does-docker-mean-when-it-says-memory-limited-without-swap"


