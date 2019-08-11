---
layout: post
title:  "installer se propres serveurs dns!"
date:   2019-01-29 17:40:25 +0100
category: Dev
tags: [web, jekyll]
---
Ce tuto est valable pour Ubuntu et ses dérivés. Il fonctionne sans soucis sur Linux Mint 17 (Et 18).
Le serveur DNS, c’est ce qui permet de relier le nom d’un site (sapajout.net) à un serveur ailleurs sur le net (5.39.16.10 pour ce site).

En général, vous utilisez les DNS de votre opérateur, mais ceux-ci vont devenir malsain au fur et à mesure que les gouvernements vont leur demande de bloquer des sites dérangeant.
Vous pouvez utiliser les serveurs DNS alternatifs, comme ceux de Google ou d’OpenDNS, mais ces serveurs DNS subiront le même problème que ceux des opérateurs, en plus de constituer un problème manifeste pour la vie privée.

Sachez qu’il est possible d’installer un serveur DNS directement sur votre ordinateur : quand vous voudrez vous connecter à un site, votre ordinateur contactera lui-même les serveurs DNS racine, sans passer par un serveur DNS intermédiaire.
Dans mon cas, la navigation est également devenu sensiblement plus rapide.

Sous Ubuntu et ses dérivés, il y a un paquet à installer. Ouvrez un terminal et copiez ceci 
