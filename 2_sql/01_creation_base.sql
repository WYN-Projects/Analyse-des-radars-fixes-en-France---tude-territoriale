/* =========================================================
   01_creation_base.sql
   Création de la base, des schémas et des tables
   ========================================================= */

-- Création de la base
CREATE DATABASE Analyse_radars;
GO

-- Utilisation de la base
USE Analyse_radars;
GO

-- Création des schémas
CREATE SCHEMA brut;
GO

CREATE SCHEMA analyse;
GO

/* =========================================================
   Table brute des radars
   ========================================================= */
CREATE TABLE brut.radars (
    numero_radar NVARCHAR(50),
    type_radar NVARCHAR(100),
    date_mise_en_service NVARCHAR(50),
    vma NVARCHAR(50),
    latitude NVARCHAR(50),
    longitude NVARCHAR(50)
);
GO

/* =========================================================
   Table brute des communes
   j'utilise les vrais noms de colonnes du fichier communes
   ========================================================= */
CREATE TABLE brut.communes (
    code_insee NVARCHAR(10),
    nom_standard NVARCHAR(255),
    dep_nom NVARCHAR(150),
    reg_nom NVARCHAR(150),
    population NVARCHAR(50),
    latitude_centre NVARCHAR(50),
    longitude_centre NVARCHAR(50)
);
GO

/* =========================================================
   Table propre des radars
   ========================================================= */
CREATE TABLE analyse.radars (
    id_radar INT IDENTITY(1,1) PRIMARY KEY,
    numero_radar NVARCHAR(50),
    type_radar NVARCHAR(100),
    date_mise_en_service DATE,
    annee INT,
    vma INT,
    latitude FLOAT,
    longitude FLOAT
);
GO

/* =========================================================
   Table propre des communes
   ========================================================= */
CREATE TABLE analyse.communes (
    id_commune INT IDENTITY(1,1) PRIMARY KEY,
    code_insee NVARCHAR(10),
    nom_commune NVARCHAR(255),
    nom_departement NVARCHAR(150),
    nom_region NVARCHAR(150),
    population INT,
    latitude_centre FLOAT,
    longitude_centre FLOAT
);
GO

/* =========================================================
   Table finale enrichie
   ========================================================= */
CREATE TABLE analyse.radar_enrichi (
    id_radar INT,
    type_radar NVARCHAR(100),
    date_mise_en_service DATE,
    annee INT,
    vma INT,
    latitude FLOAT,
    longitude FLOAT,
    nom_commune NVARCHAR(255),
    nom_departement NVARCHAR(150),
    nom_region NVARCHAR(150),
    population INT
);
GO
