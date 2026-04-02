# Dictionnaire des données

## Table `brut.radars`

| Colonne | Description |
|---|---|
| numero_radar | Numéro radar brut |
| type_radar | Type radar brut |
| date_mise_en_service | Date brute |
| vma | VMA brute |
| latitude | Latitude brute |
| longitude | Longitude brute |

## Table `brut.communes`

| Colonne | Description |
|---|---|
| code_insee | Code INSEE |
| nom_standard | Nom standard |
| dep_nom | Département |
| reg_nom | Région |
| population | Population brute |
| latitude_centre | Latitude du centroïde |
| longitude_centre | Longitude du centroïde |

## Table `analyse.radars`

| Colonne | Description |
|---|---|
| id_radar | Identifiant radar |
| numero_radar | Numéro radar |
| type_radar | Type radar |
| date_mise_en_service | Date convertie |
| annee | Année |
| vma | VMA convertie |
| latitude | Latitude convertie |
| longitude | Longitude convertie |

## Table `analyse.communes`

| Colonne | Description |
|---|---|
| id_commune | Identifiant commune |
| code_insee | Code INSEE |
| nom_commune | Nom commune |
| nom_departement | Département |
| nom_region | Région |
| population | Population convertie |
| latitude_centre | Latitude centroïde |
| longitude_centre | Longitude centroïde |

## Table `analyse.radar_enrichi`

| Colonne | Description |
|---|---|
| id_radar | Identifiant radar |
| type_radar | Type radar |
| date_mise_en_service | Date de mise en service |
| annee | Année |
| vma | VMA |
| latitude | Latitude radar |
| longitude | Longitude radar |
| nom_commune | Commune associée |
| nom_departement | Département associé |
| nom_region | Région associée |
| population | Population associée |

---

## Auteur 

**Wilfried YA. WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI 