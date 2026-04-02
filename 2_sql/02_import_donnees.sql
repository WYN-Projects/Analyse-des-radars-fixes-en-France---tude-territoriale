/* =========================================================
   02_import_donnees.sql
   Import des données brutes
   ========================================================= */

USE Analyse_radars;
GO

/* Import du fichier des radars */
BULK INSERT brut.radars
FROM 'C:\data\jeu-de-donnees-liste-des-radars-fixes-en-france-12-2025.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0d0a'
);
GO

/* Import du fichier des communes réduit  */
BULK INSERT brut.communes
FROM 'C:\data\communes-france-2025.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001'  
);
GO

/* Vérification rapide */
SELECT TOP 10 *
FROM brut.radars;
GO

SELECT TOP 10 *
FROM brut.communes;
GO
