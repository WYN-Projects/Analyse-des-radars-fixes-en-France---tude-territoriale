# Méthodologie

## 1. Compréhension des données

Le projet repose sur deux fichiers :
- un fichier des radars
- un fichier des communes

Le fichier des communes contient de nombreuses colonnes. Seules les colonnes utiles ont été sélectionnées.

## 2. Import

Les fichiers CSV sont importés dans le schéma `brut`.

## 3. Nettoyage

Les transformations principales sont :
- conversion des textes en nombres
- conversion des dates
- extraction de l’année
- conversion des coordonnées

## 4. Enrichissement géographique

Comme le fichier des radars ne contient pas la commune, un enrichissement est réalisé.

Pour chaque radar, la commune retenue est celle dont le centroïde est le plus proche.

La logique utilisée est `CROSS APPLY` avec `TOP 1`.

## 5. Analyse

Des requêtes simples sont utilisées pour analyser :
- la répartition par type
- la répartition par région
- la répartition par département
- la répartition par VMA
- la répartition dans le temps

## 6. Power BI

Des vues SQL sont préparées pour simplifier la création du dashboard.

Des mesures DAX permettent aussi de corriger le problème de population dupliquée.

## 7. Limite principale

Le rattachement radar → commune n’est pas officiel.  
Il s’agit d’une approximation géographique adaptée à un projet d’apprentissage.

---

## Auteur 

**Wilfried YA. WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI 