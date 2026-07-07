{% docs under5_mortality_methodology %}
Le taux de mortalité des moins de 5 ans est exprimé pour 1 000 naissances vivantes.

Ces données proviennent du **UN IGME** (UN Inter-agency Group for Child Mortality
Estimation), une collaboration entre l'UNICEF, l'OMS, la Banque mondiale et la
Division de la population des Nations Unies. Elles sont diffusées via l'API
Banque mondiale sous l'indicateur `SH.DYN.MORT`.

**Points d'attention méthodologiques :**
- Les données antérieures à 1990 reposent sur des méthodes d'estimation moins
  robustes (peu d'enregistrements d'état civil fiables dans plusieurs pays de
  la région à cette époque)
- Les valeurs peuvent être révisées rétroactivement d'une publication annuelle
  à l'autre par le UN IGME
- La comparaison entre pays doit tenir compte des différences de qualité des
  systèmes de collecte de données nationaux
{% enddocs %}

{% docs staging_layer_purpose %}
Cette couche **staging** applique un nettoyage minimal aux données brutes :
renommage des colonnes, typage, et légère classification métier. Elle ne
contient aucune jointure ni agrégation — ces logiques sont réservées aux
couches `intermediate` et `marts`.
{% enddocs %}