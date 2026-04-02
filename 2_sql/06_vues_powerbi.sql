/* =========================================================
   06_vues_powerbi.sql
   Vues SQL pour Power BI
   ========================================================= */

-- Vue détaillée principale
CREATE OR ALTER VIEW analyse.vue_radars_detaillee AS
SELECT
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
FROM analyse.radar_enrichi;
GO

-- Vue du nombre de radars par région
CREATE OR ALTER VIEW analyse.vue_radars_par_region AS
SELECT
    nom_region,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_region;
GO

-- Vue du nombre de radars par type
CREATE OR ALTER VIEW analyse.vue_radars_par_type AS
SELECT
    type_radar,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY type_radar;
GO

-- Vue du nombre de radars par année
CREATE OR ALTER VIEW analyse.vue_radars_par_annee AS
SELECT
    annee,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
WHERE annee IS NOT NULL
GROUP BY annee;
GO

-- Vue du nombre de radars par département
CREATE OR ALTER VIEW analyse.vue_radars_par_departement AS
SELECT
    nom_departement,
    COUNT(*) AS nombre_radars
FROM analyse.radar_enrichi
GROUP BY nom_departement;
GO


/* Vérification */

SELECT *
FROM analyse.vue_radars_detaillee;
go

SELECT *
FROM analyse.vue_radars_par_annee;
go

SELECT *
FROM analyse.vue_radars_par_departement;
go

SELECT *
FROM analyse.vue_radars_par_region;
go

SELECT *
FROM analyse.vue_radars_par_type;
go