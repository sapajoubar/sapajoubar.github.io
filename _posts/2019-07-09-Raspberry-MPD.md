---
title: mon installation audiophile
tags: [Raspberry, Hardware]
layout: post
toc: true

---

Ayant un ampli [BC Acoustique EX-222](https://www.bc-acoustique.com/vintage/gamme-2012-et-plus-serie-ex/ex-2221-amplificateur-hi-fi-2x70w-bluetooth-detail) couplé à des enceintes Micromega MySpeaker, je cherchais une solution pour écouter de la musique en haute qualité... 

Je n'ai pas l'intention de faire du streaming depuis Spotify, SoundCloud, Google Music ou autre webradios. Je veux juste écouter ma musique en local et la commander depuis n'importe quelle source connectée (ordi, tablette, smartphone ...)
De rapides recherches m'ont orienté vers Volumio ou Runeaudio ou encore pimusicbox ... Mais ce genre de Players << clefs-en-main >> nécessitent le gravage d'une carte SD dédiée sans possibilité de s'en servir pour autre chose et en plus cela semble être des versions préconfigurées de MPD avec une surcouche graphique couplé avec un serveur DLNA.

J'ai donc décidé d'installer directement MPD pour respecter la philosophie UNIX : *un programme doit faire une seule chose, mais le faire bien*


**Donc voici comment j'ai procédé :**
* TOC
{:toc}
<!--more-->

## La carte son
Malheureusement le raspberry ne possède pas une carte son performante et encore moins de connectique adaptée avec sa sortie audio Jack de 3.5 mm.Heureusement L’EX-222 intègre un convertisseur numérique-analogique Cirrus Logic 8415 qui est compatible avec les signaux numériques jusqu'à 24bits/96 kHz et il dispose d’une entrée Optique et d’une entrée Coaxiale.
C'est pourquoi j'ai fait l'acquisition d'une [HiFiBerry Digi+](https://www.hifiberry.com/products/digiplus/)   100% compatible avec le raspberry (aucune soudure nécessaire, il suffit de la connecter aux pins GPIO)

## installation du système

Le système d'exploitation est une [Raspian light](https://www.raspberrypi.org/downloads/raspbian/). C'est une version allégée de Raspian sans interface graphique qui inclut uniquement la base du système d’exploitation. J’ai téléchargé le fichier zip et j’ai copié son contenu sur la carte micro SD avec la commande "dd".

## Activer la connexion ssh
Depuis l’attaque qui visait les objets connectés en novembre 2016, la Fondation Raspberry Pi a décidé de ne plus activer les connexions SSH par défaut. Mais afin de ne pas bloquer les personnes optant pour une installation sans écran et sans clavier, headless donc, la Fondation a mis en place une solution simple et rapide pour activer le SSH. Il vous suffit de créer un fichier nommé ssh dans la partition boot (le fichier n’attend aucune extension).


> For headless setup, SSH can be enabled by placing a file named ssh, without any extension, onto the boot partition of the SD card from another computer. When the Pi boots, it looks for the ssh file. If it is found, SSH is enabled and the file is deleted. The content of the file does not matter; it could contain text, or nothing at all.

>  If you have loaded Raspbian onto a blank SD card, you will have two partitions. The first one, which is the smaller one, is the boot partition. Place the file into this one.


Après avoir assigné une adresse IP fixe je peux me connecter :
```bash 
ssh pi@192.168.0.9
``` 
## Configuration des drivers pour la carte son digi+

Comme expliqué sur le site de [hifiberry](https://www.hifiberry.com/docs/software/configuring-linux-3-18-x/) il y a quelques modifications a faire pour que la carte soit reconnue : 
Editer le fichier /boot/config.txt
```bash
pi@raspberrypi:~ $ sudo nano /boot/config.txt
```
Commenter la ligne :
```bash
dtparam=audio=on
```
et ajouter à la fin du fichier :
```bash
dtoverlay=hifiberry-digi
```


## Ajout d'un disque dur
Mes fichiers musicaux sont au format FLAC et donc la carte SD n'est pas suffisante pour le stockage . Il est vite indispensable d'installer un disque dur externe.
Par défaut, le Raspberry Pi ne délivre pas plus que 0.6A via USB. Nous avons besoin d’augmenter cette limite dans le but d’alimenter un disque dur externe. Pour ce faire, éditez le fichier /boot/config.txt et ajoutez :

``` bash
max_usb_current=1
```

Une fois le disque branché je peux l'identifier avec la commande ***fdisk***
``` bash
pi@raspberrypi:~ $  sudo fdisk -l
Disk /dev/mmcblk0: 7.4 GiB, 7948206080 bytes, 15523840 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x6c586e13

Device         Boot  Start      End  Sectors  Size Id Type
/dev/mmcblk0p1        8192   532479   524288  256M  c W95 FAT32 (LBA)
/dev/mmcblk0p2      532480 15523839 14991360  7.2G 83 Linux


Disk /dev/sda: 74.5 GiB, 80026361856 bytes, 156301488 sectors
Disk model: HTS541680J9SA00 
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x0007fdbb

Device     Boot Start       End   Sectors  Size Id Type
/dev/sda1        2048 156301311 156299264 74.5G 83 Linux
 ``` 
Notre disque est identifié sous : ***/dev/sda1***

J'utilise la commande blkid comme indiqué dans le fichier ***fstab*** (voir plus bas)
```bash
pi@raspberrypi:~ $ blkid
/dev/mmcblk0p1: LABEL_FATBOOT="boot" LABEL="boot" UUID="5203-DB74" TYPE="vfat" PARTUUID="6c586e13-01"
/dev/mmcblk0p2: LABEL="rootfs" UUID="2ab3f8e1-7dc6-43f5-b0db-dd5759d51d4e" TYPE="ext4" PARTUUID="6c586e13-02"
/dev/sda1: UUID="780f86cd-3c40-4032-a1a1-ea19c48a17c3" TYPE="ext4" PARTUUID="0007fdbb-01"
```

éditez le fichier /etc/fstab

```bash
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
bashproc            /proc           proc    defaults          0       0
PARTUUID=6c586e13-01  /boot           vfat    defaults          0       2
PARTUUID=6c586e13-02  /               ext4    defaults,noatime  0       1
PARTUUID=0007fdbb-01  /media/DD1      ext4    defaults     0       2
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
``` 
Je vois que dans cette version de Debian (buster) les disques sont identifiés avec leur **PARTUUID**, c'est donc ça que je vais utiliser pour identifier mon disque .

## Installation de MPD
```bash
sudo apt-get install mpd mpc alsa-utils lame flac faad vorbis-tools
```

mon fichier /etc/mpd.conf :

J'ai **uniquement** renseigné le chemin de mon disque dur et décommenté la ligne *mixer_type...*

``` bash
bind_to_address		"localhost"
music_directory		"/media/DD1"
audio_output {
	type		"alsa"
	name		"My ALSA Device"
#	device		"hw:0,0"	# optional
	mixer_type      "software"      # optional
#	mixer_device	"default"	# optional
#	mixer_control	"PCM"		# optional
#	mixer_index	"0"		# optional
}
``` 

## choix du client

Il existe une foule de [clients pour mpd](https://www.musicpd.org/clients/) .

 Jai choisi un client en console : [ncmpcpp](https://rybczak.net/ncmpcpp/) qui est hyper complet et vraiment superbe !

![My helpful screenshot](/assets/Capture1.jpg)

```bash
##############################################################################
## This is the example configuration file. Copy it to $HOME/.ncmpcpp/config ##
## or $XDG_CONFIG_HOME/ncmpcpp/config and set up your preferences.          ##
##############################################################################
#
##### directories ######
##
## Directory for storing ncmpcpp related files.  Changing it is useful if you
## want to store everything somewhere else and provide command line setting for
## alternative location to config file which defines that while launching
## ncmpcpp.
##
#
ncmpcpp_directory = ~/.ncmpcpp
#
##
## Directory for storing downloaded lyrics. It defaults to ~/.lyrics since other
## MPD clients (eg. ncmpc) also use that location.
##
#
lyrics_directory = ~/.lyrics
#
##### connection settings #####
#
mpd_host = 192.168.0.9
#
mpd_port = 6600
#
#mpd_connection_timeout = 5
#
## Needed for tag editor and file operations to work.
##
mpd_music_dir = /media/DD1
```

<!--- <figure>
   <a href="http://jekyllrb.com">
   <img src="/assets/2019-10-03 17-35-32.jpg" style="max-width: 400px;"
      alt="Jekyll logo" />
   </a>
   <figcaption>This is the Jekyll logo</figcaption>
</figure> --->


