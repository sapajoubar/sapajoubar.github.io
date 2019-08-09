---
layout: post
date: 2019-03-01
title: Canon Pixma-MX475 
tags: [Hardware]
toc: true
---

L'installation pas à pas d'une imprimante [canon Pixma-MX475](https://www.canon.fr/printers/inkjet/pixma/pixma_mx475/)   sous ubuntu 18.04.

<!--more-->

## Installation

Bon, ben rien de spécial, j'ai suivi la [doc ubuntu](https://doc.ubuntu-fr.org/tutoriel/installer_imprimante_canon). Les pilotes d'impression sont déjà pré-installés avec cups ( *le Système Commun d'Impression Unix* ) et pour l'impression en réseau via le wifi il faut installer le paquet cups-backend-bjnp

## Configuration de la connexion sans fil

Il y a deux façons de se connecter : la Méthode de connexion WPS et la Méthode de connexion standart. J'ai une freebox 4K qui prend en charge la fonction WPS ce qui évite de rentrer le code wpa manuellement . Ensuite, il faut lancer le gestionnaire de configuration des imprimantes
1. Cliquer sur + ou **Ajouter** ou **Ajouter une imprimante**, une nouvelle fenêtre s'ouvre.
2. Développer la branche Imprimante réseau (Pour développer une branche, il suffit de cliquer sur le petit triangle qui la précède). Patientez un peu ;
3. Sélectionner l'imprimante dans la liste puis cliquer sur le bouton Valider 
4. Cliquer sur le bouton Suivant, la recherche des pilotes commence…

### Installation du pilote

cliquer sur *selectionnez une imprimante dans la base de données*...

  1.  Sélectionnez la marque de votre imprimante dans la liste fournie et cliquez sur suivant.
  2.  Sélectionnez le modèle de votre imprimante parmi la liste et cliquez sur suivant.


{:.text-center img}
![installation du pilote]({{ site.urlimg }}/assets/print1.png "installation du pilote")

### Configurer une imprimante installée
toujours dans le gestionnaire de configuration des imprimantes :
1. Modifier les différents paramètres en fonction de vos souhaits.
2. Cliquer sur le bouton Imprimer la page de test pour vérifier la conformité de vos souhaits.

![configuration]({{ site.urlimg }}/assets/print2.png "configuration de l'imprimante")

Voila... Simple comme ubuntu

> <i class="far fa-3x fa-lightbulb"></i>
 Savez-vous que vous pouvez avoir accès à plusieurs configurations par défaut pour une seule imprimante tout simplement en 
 la dupliquant? Par exemple avoir une configuration "Couleur" et une configuration "N/B", ou encore une configuration 
 "Impression rapide" et "Haute Définition", etc. Pour cela, depuis la fenêtre principale de System-config-printer, il suffit  de dupliquer l'imprimante.
>
> 1. A l'aide d'un simple clic droit, choisir "dupliquer" dans le menu déroulant puis,
> 2. Renommer le duplicata, ATTENTION :!: : Les caractères « / », « # » et « espace » ne sont pas acceptés;
    Configurer ses options selon vos souhaits.
>
> Vous aurez alors le choix entre deux imprimantes différentes même si le travail sera exécuté par la même machine. 
