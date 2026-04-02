# Analyse des radars fixes en France

## Objectif

Ce projet a pour objectif d’analyser la répartition des radars fixes en France à partir de données open data. Il couvre l’ensemble de la chaîne analytique, depuis l’import des fichiers CSV jusqu’à la création d’un dashboard Power BI interactif.

L’objectif est double :
- produire une analyse territoriale claire et exploitable
- démontrer une démarche de Data Analyst structurée, documentée et transparente sur les limites du dataset.


## Technologies utilisées

- SQL Server
- Power BI
- Excel 
- Power Query

## Organisation de la base

Le projet utilise deux schémas :

- `brut` : stockage des données importées sans transformation
- `analyse` : dstockage des données nettoyées, enrichies et prêtes à être analysées

Tables principales :

- `analyse.radars`
- `analyse.communes`
- `analyse.radar_enrichi`

## Questions métier analysées

- Combien y a-t-il de radars fixes en France ?
- Quels types de radars sont les plus représentés ?
- Quelles régions concentrent le plus de radars ?
- Quels départements sont les plus équipés ?
- Quelle est la répartition des vitesses maximales autorisées (VMA) ?
- Comment évoluent les installations dans le temps ?
- Quel est le niveau d’équipement rapporté à la population ?

## Structure du projet

```bash
Analyse_des_radars_en_France
│
├── README.md
│
├── 1_donnees
│   ├── jeu-de-donnees-liste-des-radars-fixes-en-france-12-2025.csv
│   ├── communes-france-2025.csv
│   └── README.md
│
├── 2_sql
│   ├── 01_creation_base.sql
│   ├── 02_import_donnees.sql
│   ├── 03_nettoyage.sql
│   ├── 04_enrichissement_geographique.sql
│   ├── 05_requetes_analytiques.sql
│   ├── 06_vues_powerbi.sql
│   └── README.md
│
├── 3_powerbi
│   ├── dashboard_radars.pbix
│   ├── README.md
│   └── mesures_dax.md
│
├── 4_documentation
│   ├── dictionnaire_donnees.md
│   └── methodologie.md
│
└── 5_images
│   ├── 1-Vue_genarale.png
│   ├── 2-Vue_d_ensemble.png
│   ├── 3-Analyse_territoriale.png
│   ├── 4-Analyse_des_types_de_radars.png
│   └── 5-Analyse_temporelle.png


## Limite importante

- Le fichier des radars ne contient pas directement la commune, l’enrichissement géographique va donc reposer sur la commune dont le centre est le plus proche des coordonnées du radar. C’est une approximation raisonnable ce n’est pas un géocodage administratif officiel, chaque radar est associé à la commune dont le centroïde est le plus proche.
- Le champ `VMA ` contient des valeurs manquantes : **678 lignes**.
- Le projet analyse la **répartition** des radars, pas leur efficacité réelle sur l’accidentologie, car aucune donnée d’accident n’est fournie ici.
- La population est répétée pour chaque radar dans la table enrichie. Ce biais est corrigé dans Power BI via une mesure DAX dédiée.
- Le dataset des radars contient une date maximale observée de **2025-12-30**. Cela correspond au fichier fourni et doit être présenté comme une observation du jeu de données, sans surinterprétation.

---

## Étapes du projet  

1. Import des données brutes
2. Création de la base et des schémas SQL
3. Nettoyage et normalisation des colonnes
4. Enrichissement géographique par commune la plus proche
5. Création de requêtes analytiques SQL
6. Création de vues dédiées à Power BI
7. Construction des mesures DAX
8. Création d’un dashboard interactif
---

## Travaux réalisés

1. Import des fichiers CSV dans SQL Server  
2. Création des tables brutes et des tables d’analyse  
3. Conversion des dates, nombres et coordonnées  
4. Sélection des colonnes utiles du dataset communes  
5. Rattachement de chaque radar à la commune la plus proche via `CROSS APPLY`  
6. Création de requêtes analytiques simples et lisibles  
7. Création de vues SQL dédiées à Power BI  
8. Création de mesures DAX pour le dashboard  
9. Correction du problème de population dupliquée dans les indicateurs  
10. Création d’un dashboard interactif  

---

##  Structure du dashboard

Le dashboard Power BI est structuré en plusieurs pages permettant une lecture progressive : vue globale, analyse détaillée et exploration des données.

### Page 1 - Vue d’ensemble
Cette page donne une lecture immédiate du parc de radars fixes en France.

Contenu :
- nombre total de radars
- nombre de régions équipées
- nombre de départements équipés
- nombre de communes équipées
- VMA moyenne
- densité de radars pour 100 000 habitants
- répartition des radars par région
- carte de localisation des radars
- répartition des types de radars
- bloc qualité des données

### Page 2 - Analyse territoriale
Cette page permet de comparer les territoires entre eux.

Contenu :
- répartition des radars par département
- indicateur de densité territoriale
- comparaisons par région et département
- lecture géographique plus fine

### Page 3 - Analyse des types de radars
Cette page permet d’identifier les catégories les plus représentées et d’examiner leur lien avec la VMA.

Contenu :
- répartition des radars par type
- indicateurs par catégorie
- analyse de la VMA
- lecture des valeurs manquantes

### Page 4 - Analyse temporelle
Cette page permet d’observer l’évolution des mises en service.

Contenu :
- nombre de radars par année
- lecture chronologique du déploiement
- analyse complémentaire dans le temps

---

## Compétences démontrées

- import de fichiers CSV
- modélisation simple en SQL Server
- nettoyage et normalisation de données
- conversion de types
- enrichissement géographique
- utilisation de CROSS APPLY
- création de requêtes analytiques
- création de vues SQL pour un usage BI
- création de mesures DAX
- construction d’un dashboard Power BI
- documentation et transparence sur les limites du dataset

---

## Résultat attendu

Le projet permet d’identifier :

- les régions les plus équipées
- les départements les plus équipés
- les types de radars les plus fréquents
- la distribution des VMA renseignées
- la part de données VMA manquantes
- l’évolution des radars dans le temps
- un niveau d’équipement rapporté à la population

---

## Auteur 

**Wilfried YA. WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI 