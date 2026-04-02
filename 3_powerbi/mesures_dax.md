# Mesures DAX - Projet Radars France 

Ce document présente les mesures DAX utilisées dans le dashboard Power BI.

Chaque mesure est accompagnée d’un commentaire expliquant :
- son rôle
- sa logique
- les éventuels pièges (très important en BI)


##  1. Indicateurs principaux

```DAX
Nombre de radars =
COUNTROWS('vue_radars_detaillee')

-- Compte le nombre total de lignes dans la table
-- Chaque ligne représente un radar
-- => indicateur principal du volume de données
```

```DAX
Nombre de communes =
DISTINCTCOUNT('vue_radars_detaillee'[nom_commune])

-- Compte le nombre de communes distinctes
-- Permet d’identifier la couverture territoriale
```

```DAX
Nombre de départements =
DISTINCTCOUNT('vue_radars_detaillee'[nom_departement])

-- Compte les départements distincts
-- Utilisé pour mesurer la diffusion géographique
```

```DAX
Nombre de régions =
DISTINCTCOUNT('vue_radars_detaillee'[nom_region])

-- Compte les régions distinctes présentes
-- KPI utilisé en vue d’ensemble
```


##  2. Analyse des radars

```DAX
Nombre de radars feu rouge =
CALCULATE(
    [Nombre de radars],
    'vue_radars_detaillee'[type_radar] = "ETFR"
)

-- Filtre la table pour ne garder que les radars feu rouge
-- CALCULATE modifie le contexte de filtre
```

```DAX
Nombre de radars vitesse moyenne =
CALCULATE(
    [Nombre de radars],
    'vue_radars_detaillee'[type_radar] = "ETVM"
)

-- Même logique que ci-dessus
-- Permet de segmenter les types de radars
```

---

## 3. Indicateurs VMA

```DAX
Nombre de radars sans VMA =
CALCULATE(
    [Nombre de radars],
    ISBLANK('vue_radars_detaillee'[vma])
)

-- Identifie les valeurs manquantes
-- Très important pour la qualité des données
```

```DAX
Nombre de radars avec VMA =
CALCULATE(
    [Nombre de radars],
    NOT ISBLANK('vue_radars_detaillee'[vma])
)

-- Permet de mesurer la partie exploitable des données
```

```DAX
Taux de VMA manquante (%) =
DIVIDE(
    [Nombre de radars sans VMA],
    [Nombre de radars],
    0
)

-- Ratio de qualité de donnée
-- DIVIDE évite les erreurs de division par 0
```

```DAX
VMA moyenne =
AVERAGE('vue_radars_detaillee'[vma])

-- Moyenne simple
-- Les valeurs NULL sont automatiquement ignorées
```

```DAX
VMA moyenne corrigée =
AVERAGEX(
    FILTER(
        'vue_radars_detaillee',
        NOT ISBLANK('vue_radars_detaillee'[vma])
    ),
    'vue_radars_detaillee'[vma]
)

-- Version plus explicite
-- Filtre les valeurs NULL avant calcul
-- Bonne pratique pour être clair en entretien
```

---

## 4. Indicateurs démographiques

```DAX
Population réelle =
SUMX(
    VALUES('vue_radars_detaillee'[nom_commune]),
    MAX('vue_radars_detaillee'[population])
)

-- PROBLÈME :
-- La population est répétée pour chaque radar

-- SOLUTION :
-- VALUES → liste unique des communes
-- MAX → prend une seule population par commune

-- => évite le double comptage
```

```DAX
Population totale (fixe) =
CALCULATE(
    [Population réelle],
    ALL('vue_radars_detaillee')
)

-- Supprime tous les filtres
-- Permet d’avoir une population constante

-- Utile pour :
-- KPI globaux qui ne doivent pas bouger avec les slicers
```

```DAX
Radars pour 100 000 habitants =
DIVIDE(
    [Nombre de radars],
    [Population réelle],
    0
) * 100000

-- Indicateur de densité
-- Permet de comparer les territoires entre eux
```

```DAX
Radars pour 100 000 habitants (fixe) =
DIVIDE(
    [Nombre de radars],
    [Population totale (fixe)],
    0
) * 100000

-- Version stable
-- Ignore les filtres → évite incohérences

-- Utilisation :
-- Page "Vue d’ensemble"
```

```DAX
Nombre moyen de radars par commune =
DIVIDE(
    [Nombre de radars],
    [Nombre de communes],
    0
)

-- Mesure la concentration moyenne
-- Donne une idée de la densité locale
```

## 5. Répartition

```DAX
Part des radars par région (%) =
DIVIDE(
    [Nombre de radars],
    CALCULATE(
        [Nombre de radars],
        ALL('vue_radars_detaillee')
    ),
    0
)

-- Compare la part d’une région au total national
-- ALL supprime les filtres → référence globale
```

##  6. Qualité des données

```DAX
Message qualité des données =
"Le rattachement radar/commune est une approximation géographique. La population a été retraitée pour éviter les doubles comptes. La VMA n’est pas renseignée pour certains types de radars."

-- Message affiché dans le dashboard
-- Permet d’expliquer les limites du dataset
-- Très apprécié en entretien (transparence)
```

## Conclusion

Ces mesures permettent :

- une analyse fiable malgré les biais de données  
- une bonne gestion des filtres Power BI  
- une lecture claire pour un utilisateur métier  

---
## Auteur 

**Wilfried YA. WYN Analytics**  
Data Analyst • SQL • Python • Excel • Power BI 
