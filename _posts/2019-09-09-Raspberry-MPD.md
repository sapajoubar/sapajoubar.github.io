---
title: Mon installation audiophile 
tags: [Raspberry, Hardware]
layout: post
toc: true
comments: [
"c'est instructif, dommage qu'il n'y ai pas la suite -marcoz"
]
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

## Installation du système

Le système d'exploitation est une [Raspian light](https://www.hifiberry.com/build/download/). C'est une version allégée de Raspian sans interface graphique qui inclut uniquement la base du système d’exploitation,  modifiée pour la détection et la configuration automatique de la Hifiberry Digi+. J’ai téléchargé le fichier zip et j’ai copié son contenu sur la carte micro SD avec la commande "dd".

## Activer la connexion ssh
Depuis l’attaque qui visait les objets connectés en novembre 2016, la Fondation Raspberry Pi a décidé de ne plus activer les connexions SSH par défaut. Mais afin de ne pas bloquer les personnes optant pour une installation sans écran et sans clavier, headless donc, la Fondation a mis en place une solution simple et rapide pour activer le SSH. Il vous suffit de créer un fichier nommé ssh dans la partition boot (le fichier n’attend aucune extension).


> For headless setup, SSH can be enabled by placing a file named ssh, without any extension, onto the boot partition of the SD card from another computer. When the Pi boots, it looks for the ssh file. If it is found, SSH is enabled and the file is deleted. The content of the file does not matter; it could contain text, or nothing at all.

>  If you have loaded Raspbian onto a blank SD card, you will have two partitions. The first one, which is the smaller one, is the boot partition. Place the file into this one.


Après avoir assigné une adresse IP fixe je peux me connecter :
```highlight bash 
ssh pi@192.168.0.9
``` 

## Installation de MPD
``` bash
sudo apt-get install mpd mpc alsa-utils lame flac faad vorbis-tools
```

mon fichier /etc/mpd.conf :
``` bash
bind_to_address		"192.168.0.9"
music_directory		"/media/DD1"
audio_output {
	type		"alsa"
	name		"My ALSA Device"
#	device		"hw:0,0"	# optional
#	mixer_type      "software"      # optional
#	mixer_device	"default"	# optional
#	mixer_control	"PCM"		# optional
#	mixer_index	"0"		# optional
}
``` 


## Ajout d'un disque dur
Mes fichiers musicaux sont au format FLAC et donc la carte SD n'est pas suffisante pour le stockage . Il est vite indispensable d'installer un disque dur externe.


Par défaut, le Raspberry Pi ne délivre pas plus que 0.6A via USB. Nous avons besoin d’augmenter cette limite dans le but d’alimenter un disque dur externe. Pour ce faire, éditez le fichier /boot/config.txt et ajoutez :

``` bash
max_usb_current=1
``` 
éditez le fichier /etc/fstab

``` bash
``` 

## choix du client

