/* =========================================================
   03_nettoyage.sql
   Nettoyage et préparation des tables d'analyse
   ========================================================= */

USE Analyse_radars;
GO

/* =========================================================
   Nettoyage des communes

Cette requête nettoie et charge les données des communes depuis la table brute vers la table d'analyse.
Il effectue des conversions de types de données et normalise le format des coordonnées géographiques en remplaçant 
les virgules par des points pour les valeurs de latitude et longitude.
   ========================================================= */

INSERT INTO analyse.communes
(
    code_insee,
    nom_commune,
    nom_departement,
    nom_region,
    population,
    latitude_centre,
    longitude_centre
)
SELECT
    code_insee,
    nom_standard,
    reg_nom,
    dep_nom,
    TRY_CAST(population AS INT),
    TRY_PARSE(latitude_centre AS FLOAT USING 'en-US'),
    TRY_PARSE(longitude_centre AS FLOAT USING 'en-US')
FROM brut.communes;
GO

/* Contrôle rapide */
SELECT TOP 20
    nom_commune,
    latitude_centre,
    longitude_centre
FROM analyse.communes;
GO

/* =========================================================
   Nettoyage des radars
Cette requête charge et nettoie les données des radars automatiques depuis la table brut.radars 
vers la table d'analyse analyse.radars. Il effectue des conversions de types, normalise les formats de 
dates et coordonnées géographiques, et supprime les espaces superflus.

Le numéro de radar contient des lettres et des chiffres
(exemple : FE110000). Il ne peut donc pas être converti
en entier sans perte de données.

On le conserve au format texte.

La colonne VMA contient parfois la valeur 'NA'.
Ces valeurs sont converties en NULL grâce à TRY_CAST.

Les coordonnées latitude/longitude contiennent un signe '+'
et un point décimal. On supprime le '+' et on utilise
TRY_PARSE avec la culture 'en-US' pour convertir correctement
les valeurs en FLOAT.
*/
   ========================================================= */
INSERT INTO analyse.radars
(
    numero_radar,
    type_radar,
    date_mise_en_service,
    annee,
    vma,
    latitude,
    longitude
)
SELECT
    LTRIM(RTRIM(numero_radar)),
    type_radar,
    TRY_CONVERT(DATE, date_mise_en_service, 103),
    YEAR(TRY_CONVERT(DATE, date_mise_en_service, 103)),
    TRY_CAST(vma AS INT),
    TRY_PARSE(REPLACE(latitude, '+', '') AS FLOAT USING 'en-US'),
    TRY_PARSE(REPLACE(longitude, '+', '') AS FLOAT USING 'en-US')
FROM brut.radars;
GO
SELECT *
FROM analyse.radars;
go

/* Contrôle rapide */
SELECT COUNT(*) AS nombre_radars_nettoyes
FROM analyse.radars;
GO

SELECT COUNT(*) AS nombre_communes_nettoyees
FROM analyse.communes;
GO
