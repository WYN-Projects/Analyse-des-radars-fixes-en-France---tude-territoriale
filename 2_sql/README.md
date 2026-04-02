# Scripts SQL

Ce dossier contient tous les scripts SQL du projet.

## Organisation

Le projet utilise deux schémas :

- `brut` : données importées sans transformation
- `analyse` : données nettoyées et enrichies

## Ordre d’exécution

1. `01_creation_base.sql`
2. `02_import_donnees.sql`
3. `03_nettoyage.sql`
4. `04_enrichissement_geographique.sql`
5. `05_requetes_analytiques.sql`
6. `06_vues_powerbi.sql`

## Objectif

L’objectif est de garder un SQL :
- simple
- lisible
- commenté

## Limite

Le rattachement radar → commune est une approximation géographique basée sur le centroïde communal.

---

## Auteur 

**Wilfried YA. WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI 