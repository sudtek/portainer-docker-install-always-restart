# Portainer install Always Restart

02/mars/2025

yannick SUDRIE

Vous trouverez plusieurs version de scripts permetant d'installer le gestionnaire de container Portainer version communeauty sur differentes distribution. 

## Distribution UBUNTU + DOCKER.

### installPortainerRestartAlways_DU.sh
Un script très simple extrait de [portnair.io](https://portainer.io/install.html) pour installer Portnair pour Docker avec redémarrage automatique de Portnair sur distribution Ubuntu.

Note du 02/03/2025 :

+ Je vous conseille de ne plus l'utiliser à moins que votre distribution ne gére pas les cgroups.
+ Update vers Portainer Community Edition 2.27.1


### installPortainerRestartAlwaysLimit_DU.sh
Même objectif que le script précedent installPortainerRestartAlways.sh, mais cette version permet de limiter l'empreinte mémoire et CPU dasnune envelope de ressource prédéfinie  ... par défaut à 20 % d'un CPU, 10 Mo de RAM et 90 Mo de swap. Veuillez vérifier les commentaires dans le script avant de l'utiliser ou de modifier les valeurs.

Note du 10 Mars 2022 :

+ Update vers Portainer Community Edition 2.11.1

+ add a nota about error 'Your kernel does not support swap limit capabilities or the cgroup is not mounted. Memory limited without swap.'
They said :'if docker swap option is disable in cgroup you take the risk that the container was drop by docker if there is not enought ram in the container'
take a look at https://stackoverflow.com/questions/48685667/what-does-docker-mean-when-it-says-memory-limited-without-swap"

Note du 03 Mars 2025 :

+ Update vers Portainer Community Edition 2.27.1


Script d'Installation de Portainer avec Podman en Mode Rootless sur Alpine Linux

-----

# Distribution Alpine + PODMAN.

## installPortainerRestartAlwaysLimit_PA.sh

Ce script automatise l'installation de Portainer avec Podman en mode rootless sur une distribution Alpine Linux. Il configure Portainer pour qu'il redémarre automatiquement au démarrage et limite les ressources CPU et mémoire pour les anciens ou petits ordinateurs.


##installPortainerRestartAlwaysLimit_DU.sh
## Prérequis

- Alpine Linux v3.21 ou supérieure.
- Podman installé en mode rootless.
- Accès utilisateur avec les droits nécessaires pour exécuter Podman.

## Instructions d'Utilisation

### 1. Vérification des Prérequis

Avant d'exécuter le script, assurez-vous que Podman est installé et configuré en mode rootless. Vous pouvez vérifier cela en exécutant :

```sh
podman info
Assurez-vous que le socket Podman est accessible :

Copier
ls -l /run/podman/podman.sock
2. Exécution du Script
Téléchargez le script et exécutez-le dans votre terminal. Ne pas exécuter ce script avec sudo ou doas, car cela empêcherait Portainer de fonctionner en mode rootless.

Copier
./install_portainer.sh
3. Vérifications Avant Installation
Le script effectue les vérifications suivantes avant d'installer Portainer :

Port 9000 : Vérifie si le port 9000 est disponible. Si le port est utilisé, le script affiche un message d'avertissement.
Conteneur Portainer : Vérifie si un conteneur nommé "Portainer" est en cours d'exécution. Si c'est le cas, le script l'arrête et le supprime.
4. Installation de Portainer
Le script configure et lance un conteneur Portainer avec les paramètres suivants :

Nom du Conteneur : Portainer
Ports : 9000:9000
Volume : portainer_data
Limites de Ressources :
Mémoire : 15 Mo
Swap : 100 Mo
CPU : 0.2
5. Vérification de l'Installation
Pour vérifier que Portainer est correctement installé et que les limites de ressources sont appliquées, utilisez la commande suivante :

Copier
podman stats
Notes Importantes
Mode Rootless : Ce script doit être exécuté sans sudo ou doas pour que Portainer fonctionne en mode rootless.
Erreurs de Swap : Si vous rencontrez l'erreur Your kernel does not support swap limit capabilities or the cgroup is not mounted, consultez la documentation de Podman et vérifiez les options de cgroup disponibles sur votre système.
Volume de Données : Le script supprime et recrée le volume de données portainer_data. Assurez-vous de ne pas avoir de données importantes dans ce volume avant d'exécuter le script.

Conclusion
Ce script facilite l'installation de Portainer avec Podman en mode rootless sur Alpine Linux. En suivant ces instructions, vous pouvez gérer vos conteneurs via l'interface web de Portainer exactement comme sous docker.


Note

#
# Avant d'installer Portainer il faut impérativement vérifier la disponiblité du port local 9000 !
# Si la commande '$(netstat -lap)' confirme que le port 9000 existe sans PID -
#
# $(netstat -lap)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 0.0.0.0:9000            0.0.0.0:*               LISTEN      -
#
# Il faut confirmer via la commande '$(podman stats -a)' qu'il n'y a pas / plus de container nommé 'Portainer' en éxécution :
#
# $(podman stats -a)
# ID          NAME        CPU %       MEM USAGE / LIMIT  MEM %       NET IO      BLOCK IO    PIDS        CPU TIME    AVG CPU
#
# Si le stats -a confirme qu'il n'y a aucun conteneur nommé 'Portainer' et aucun PIDS commun avec le port local 9000 -> un zombie squate votre port 9000 !
# Ce problème semble subvenir lorsque l'on relance ce script  sans avoir pris soin de tout netoyer manuelement. La commande '$(podman --replace ...)'
# n'arrete pas le container Portainer entrain de tourner, ni ne libére le port ... et il faut faire le ménage' manuelement' avant de recréer  !
# ----------------------------------------------------------------------------------------------------------------------------------------
