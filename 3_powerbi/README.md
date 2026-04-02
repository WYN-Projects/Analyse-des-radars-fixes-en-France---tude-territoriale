## Objectif du dashboard

Ce dashboard Power BI a pour objectif de visualiser la répartition des radars fixes en France, de comprendre leur typologie, d’analyser leur distribution géographique et de produire des indicateurs comparables entre territoires.

Il s’appuie sur un travail préparatoire réalisé en SQL Server : import des données, nettoyage, enrichissement géographique et création de vues analytiques. Les visualisations Power BI constituent donc la dernière étape de la chaîne analytique. 

---

## Sources des données

Le dashboard repose principalement sur les vues SQL suivantes :

- `analyse.vue_radars_detaillee`
- `analyse.vue_radars_par_region`
- `analyse.vue_radars_par_departement`
- `analyse.vue_radars_par_type`
- `analyse.vue_radars_par_annee`

Ces vues ont été créées spécifiquement pour simplifier la connexion avec Power BI et organiser les visuels par thématique.

---

## Modélisation Power BI

Le modèle est volontairement simple :

- table principale : `vue_radars_detaillee`
- une ligne = un radar
- calculs complémentaires réalisés via DAX
- vues agrégées utilisées pour certains visuels ciblés

Ce choix permet de garder un modèle lisible et crédible, tout en traitant les principales limites analytiques par des mesures DAX adaptées.

---

## Structure du dashboard

### Page 1 - Vue d’ensemble

Cette page offre une vision synthétique du parc de radars en France.

**Contenu :**

- KPI principaux :
  - Nombre total de radars
  - Nombre de régions équipées
  - Nombre de départements équipés
  - Nombre de communes équipées

- VMA moyenne (km/h)
- Densité de radars pour 100 000 habitants
- Répartition des radars par région
- Carte de localisation des radars
- Répartition des types de radars
- Bloc "Qualité des données" :
  - Message explicatif
  - Taux de VMA manquante

### Page 2 - Analyse territoriale

Cette page permet de comparer les territoires et d’identifier les zones les plus équipées.

**Contenu :**

- Répartition des radars par département
- Classement des départements 
- Indicateur de densité territoriale (radars pour 100 000 habitants)
- Comparaison par région et département
- Analyse géographique détaillée

### Page 3 - Analyse des types de radars

Cette page permet de comprendre la typologie des radars.

**Contenu :**

- Répartition des radars par type (ETT, ETFR, ETPN, etc.)
- Comparaison des catégories de radars
- Analyse des VMA par type
- Analyse des valeurs manquantes (VMA non renseignée)


### Page 4 - Analyse temporelle

Cette page permet d’analyser l’évolution du parc de radars dans le temps.

**Contenu :**

- Nombre de radars par année
- Courbe d’évolution des mises en service
- Analyse chronologique du déploiement

---

## Mesures DAX

Le dashboard utilise plusieurs mesures DAX pour :

- compter les radars et les territoires couverts
- corriger le biais de population répétée
- calculer la densité de radars
- mesurer la qualité des données
- stabiliser certains KPI face aux slicers Power BI

Voir le fichier :
`mesures_dax.md`

---

## Points d’attention

### 1. Rattachement commune / radar
La commune n’est pas fournie directement dans le fichier des radars. Le rattachement repose sur une approximation géographique par commune la plus proche. Cette méthode est utile pour l’analyse territoriale, mais elle ne constitue pas un rattachement administratif exact. 

### 2. Population répétée
La population est répétée pour chaque radar dans la vue détaillée. Une mesure DAX spécifique a été créée pour éviter les doubles comptes dans les indicateurs démographiques. 

### 3. Valeurs manquantes sur la VMA
Certaines valeurs de VMA sont absentes. Elles ont été conservées comme valeurs manquantes et non remplacées artificiellement, afin de ne pas biaiser les analyses de vitesse. 

### 4. Gestion des filtres
Certains KPI ont nécessité des variantes DAX spécifiques pour éviter que des slicers techniques comme le type de radar, la VMA ou l’année ne perturbent des indicateurs de synthèse, notamment ceux liés à la densité. Cette logique est cohérente avec les mesures documentées dans `mesures_dax.md`.

---

## Apports du dashboard

Ce dashboard permet de :

- visualiser rapidement la répartition des radars
- comparer les territoires entre eux
- comprendre la structure du parc radar
- rendre visibles les limites du dataset
- produire des indicateurs lisibles pour un public non technique

---

## Améliorations possibles

Plusieurs prolongements sont envisageables :

- intégrer des données d’accidentologie
- construire un modèle en étoile plus avancé
- améliorer les analyses territoriales avec un référentiel géographique plus précis
- enrichir le projet avec des données routières complémentaires

---

## Auteur

**Wilfried YA.WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI