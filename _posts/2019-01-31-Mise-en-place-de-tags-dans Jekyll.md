---
layout: post
title:  "Mise en place de tags et catégories dans Jekyll"
tags: [astuce, jekyll]
---

Je me suis demandé qu’elle était la différence entre les termes tags et catégorie dans Jekyll.
Une catégorie permet de précéder le nom de votre post, dans l’url, par une catégorie.
Par exemple : http://dodoalive.github.io/DodoAlive-Blog/Jekyll/2015/12/13/Mise-en-place-de-tags-et-categories-dans-Jekyll.html.

Un tag permet d’être utilisé, sans artifice (comme la catégorie), dans vos pages et plugins.

Je vais prendre uniquement la gestion des posts via les tags.

Il y a plusieurs façon de gérer les tags.

    Afficher tous les tags sur une seule page (expliqué sur le blog de [CodInfox] (http://codinfox.github.io/dev/2015/03/06/use-tags-and-categories-in-your-jekyll-based-github-pages/).
    Créer une page par tag (expliqué sur le blog de Christian Specht).
    Utiliser un plugin sur Jekyll Plugins.

Je ne savais pas que l’on pouvait agrémenter Jekyll de plugins.

Donc, je me suis porté sur la solution 3 … Grrrrrr !

J’ai suivi la procédure jusqu’à la fin :-), je l’ai testé en local. Ca fonctionnait à merveille jusqu’au moment où je l’ai uploadé sur mon Github Pages …

J’ai essayé d’utiliser l’url pour accèder au tag … Rien, page 404 not found !

Après quelques recherches, je suis arrivé sur une page Github expliquant que Github Pages pouvait exécuter des plugins MAIS supportés par eux. Malheureusement, le plugin jekyll n’est pas dans liste des plugins supportés.

J’ai fait un rollback et j’ai décidé de choisir la solution 2, en attendant que je mette en place le Raspberry Pi pour le blog.
Etape 1 : Créer le layout

J’ai créé un nouveau layout tag_page.html.

J’ai dupliqué le layout de la page d’accueil sans les liens sociaux et en changeant la boucle pour les posts.


