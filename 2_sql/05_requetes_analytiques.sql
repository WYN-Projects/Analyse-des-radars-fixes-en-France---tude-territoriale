/* =========================================================
   05_requetes_analytiques.sql
   Requêtes analytiques 
   ========================================================= */

-- 1. Compter le nombre total de radars
SELECT COUNT(*) AS nombre_total_radars
FROM analyse.radar_enrichi;
GO

-- 2. Afficher les types de radars différents
SELECT DISTINCT type_radar
FROM analyse.radar_enrichi;
GO

-- 3. Compter le nombre de radars par type
SELECT
    type_radar,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY type_radar
ORDER BY nombre_radars DESC;
GO

-- 4. Compter le nombre de radars par vitesse maximale autorisée
SELECT
    vma,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY vma
ORDER BY vma;
GO

-- 5. Compter le nombre de radars par région
SELECT
    nom_region,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_region
ORDER BY nombre_radars DESC;
GO

-- 6. Compter le nombre de radars par département
SELECT
    nom_departement,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_departement
ORDER BY nombre_radars DESC;
GO

-- 7. Afficher les 10 départements avec le plus de radars
SELECT TOP 10
    nom_departement,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_departement
ORDER BY nombre_radars DESC;
GO

-- 8. Compter le nombre de radars par commune
SELECT
    nom_commune,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_commune
ORDER BY nombre_radars DESC;
GO

-- 9. Compter les radars mis en service par année
SELECT
    annee,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
WHERE annee IS NOT NULL
GROUP BY annee
ORDER BY annee;
GO

-- 10. Calculer la vitesse moyenne contrôlée
SELECT AVG(vma) AS vitesse_moyenne
FROM analyse.radar_enrichi;
GO

-- 11. Compter le nombre de radars feu rouge
SELECT COUNT(*) AS nombre_radars_feu_rouge
FROM analyse.radar_enrichi
WHERE type_radar = 'ETFR';
GO

-- 12. Compter le nombre de radars de vitesse moyenne
SELECT COUNT(*) AS nombre_radars_vitesse_moyenne
FROM analyse.radar_enrichi
WHERE type_radar = 'ETVM';
GO

-- 13. Afficher les radars d’une région précise
SELECT *
FROM analyse.radar_enrichi
WHERE nom_region = 'Île-de-France';
GO

-- 14. Afficher les radars avec une VMA supérieure ou égale à 110
SELECT *
FROM analyse.radar_enrichi
WHERE vma >= 110;
GO

-- 15. Calculer le nombre moyen de radars par département
SELECT AVG(nombre_radars * 1.0) AS moyenne_radars_par_departement
FROM (
    SELECT
        nom_departement,
        COUNT(*) AS nombre_radars
    FROM analyse.radar_enrichi
    GROUP BY nom_departement
) AS resultat;
GO
