/* =========================================================
   04_enrichissement_geographique.sql
   Association des radars à la commune la plus proche
   ========================================================= */

USE Analyse_radars;
GO

/* Je vide la table finale avant réinsertion */
TRUNCATE TABLE analyse.radar_enrichi;
GO

/*
Objectif :
Associer chaque radar à une commune afin d’ajouter des informations
géographiques (commune, département, région, population).

Problème :
Le fichier des radars ne contient pas directement la commune.
Il est donc nécessaire de faire un rattachement indirect.

Méthode utilisée :
On associe chaque radar à la commune la plus proche
en utilisant les coordonnées géographiques.

Fonctionnement :

1. Pour chaque radar (table analyse.radars),
   on compare ses coordonnées (latitude, longitude)
   avec celles de toutes les communes.

2. On calcule une distance simplifiée (distance au carré)
   avec la formule :
   (latitude_radar - latitude_commune)² +
   (longitude_radar - longitude_commune)²


3. Grâce à CROSS APPLY, on exécute une sous-requête
   pour chaque radar.

4. SELECT TOP 1 permet de récupérer uniquement
   la commune la plus proche (distance minimale).

5. On filtre les valeurs NULL pour éviter
   les erreurs de calcul.

Résultat :
Chaque radar est enrichi avec :
- sa commune
- son département
- sa région
- la population associée

Limite :
Cette méthode est une approximation géographique.
Elle ne garantit pas une correspondance administrative exacte.
*/

INSERT INTO analyse.radar_enrichi (
    id_radar,
    type_radar,
    date_mise_en_service,
    annee,
    vma,
    latitude,
    longitude,
    nom_commune,
    nom_departement,
    nom_region,
    population
)
SELECT
    r.id_radar,
    r.type_radar,
    r.date_mise_en_service,
    r.annee,
    r.vma,
    r.latitude,
    r.longitude,
    c_proche.nom_commune,
    c_proche.nom_departement,
    c_proche.nom_region,
    c_proche.population
FROM analyse.radars r
CROSS APPLY (
    SELECT TOP 1
        c.nom_commune,
        c.nom_departement,
        c.nom_region,
        c.population
    FROM analyse.communes c
    WHERE r.latitude IS NOT NULL
      AND r.longitude IS NOT NULL
      AND c.latitude_centre IS NOT NULL
      AND c.longitude_centre IS NOT NULL
    ORDER BY
        POWER(r.latitude - c.latitude_centre, 2) +
        POWER(r.longitude - c.longitude_centre, 2)
) c_proche;
GO


/* Vérification */
SELECT TOP 20 *
FROM analyse.radar_enrichi;
GO

SELECT *
FROM analyse.radar_enrichi;
go


SELECT TOP 50
    id_radar,
    nom_commune,
    nom_departement,
    nom_region
FROM analyse.radar_enrichi;
GO


SELECT TOP 20
    nom_commune,
    nom_departement,
    nom_region,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_commune, nom_departement, nom_region
ORDER BY nombre_radars DESC;
GO