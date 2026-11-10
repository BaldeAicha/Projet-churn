# 📊 Analyse du désabonnement bancaire — SQL & Power BI

> **Portfolio Data Analyst** | Diagnostic global terminé · Segmentation avancée en cours · Machine Learning prévu

## 1. Contexte et problématique métier

La fidélisation des clients représente un enjeu pour les banques. Avant de définir une stratégie de rétention, il faut comprendre **combien de clients quittent la banque**, **quels profils sont concernés** et **quels segments méritent une analyse prioritaire**.

**Question métier :** quels profils présentent les taux de churn les plus élevés et quels segments concentrent le plus de départs ?

L'étude est descriptive : une association entre une caractéristique et le départ ne démontre pas un lien de causalité.

## 2. Objectifs

1. Calculer le taux de churn global.
2. Comparer les départs et les taux selon l'âge, le pays, le genre, l'activité, les produits et l'ancienneté.
3. Distinguer les **volumes** des **taux**, en tenant compte de la taille des segments.
4. Explorer des croisements de variables pour proposer des pistes métier.
5. Préparer une phase ultérieure de **prédiction du churn en Python**.

## 3. Dataset et outils

Le fichier [Customer-Churn-Records.csv](Customer-Churn-Records.csv) contient **10 000 clients**. La variable cible `Exited` vaut **1** si le client est parti et **0** s'il est resté.

Variables analysées : `Age`, `Gender`, `Geography`, `IsActiveMember`, `Tenure`, `NumOfProducts`, `Balance`.

**Stack :** Google Sheets (contrôles initiaux), **Google BigQuery / SQL** (exploration et agrégations), **Power BI** (mesures DAX et visualisation), GitHub (documentation). **Python / scikit-learn : à venir.**

## 4. Étape 1 — Contrôle et préparation des données

Les contrôles réalisés portent sur les dimensions du dataset, les doublons, les valeurs manquantes, les types et la cohérence des variables. Des regroupements facilitent la lecture : tranches d'âge, catégories d'ancienneté et statut d'activité.

Les transformations Power Query et leurs résultats détaillés seront complétés après vérification du fichier Power BI.

## 5. Étape 2 — Analyse exploratoire SQL

Les requêtes figurent dans [churn_sql.sql](churn_sql.sql). Elles permettent de calculer les indicateurs globaux, comparer les pays, l'activité et les produits, explorer l'âge et croiser âge et activité.

**Formule :** `Taux de churn (%) = Clients avec Exited = 1 / Nombre total de clients × 100`.

Les requêtes documentent les observations et les limites des comparaisons, notamment pour les petits effectifs.

## 6. Étape 3 — Dashboard Power BI : diagnostic global

### Page 1 — Diagnostic global (terminée)

**Capture du dashboard :** à intégrer au dépôt dans `images/dashboard_diagnostic_global.png`. La capture a été préparée séparément et sera ajoutée à cette section dès son dépôt sur GitHub.

| KPI | Résultat |
|---|---:|
| Total clients | **10 000** |
| Clients perdus | **2 038** |
| Taux de churn | **20,38 %** |

### Lecture métier des six graphiques

**1. Churn selon l'activité.** Les clients inactifs ont un taux de churn de **26,87 %**, contre **14,27 %** chez les actifs, soit **12,60 points** d'écart. Ce résultat suggère un segment à approfondir, sans établir de causalité.

**2. Départs selon l'âge.** Les **40–49 ans** enregistrent le plus grand nombre de départs (**807**, taux **30,83 %**). Les **50–59 ans** ont un taux plus élevé (**56,04 %**) mais moins de départs (**487**). **Volume et taux ne conduisent pas nécessairement aux mêmes priorités.**

**3. Churn par genre.** Le taux atteint **25,07 %** chez les femmes et **16,47 %** chez les hommes. Une analyse multivariée serait nécessaire avant d'interpréter cet écart.

**4. Départs selon le pays.** L'Allemagne compte **814** départs, la France **811** et l'Espagne **413**. Le taux de churn allemand est d'environ **32,44 %**, contre environ **16 %** en France et en Espagne. Les taux sont plus pertinents que les volumes seuls pour comparer des populations de tailles différentes.

**5. Nombre de produits.** Le churn est d'environ **28 %** pour un produit, **8 %** pour deux, **83 %** pour trois et **100 %** pour quatre. Le groupe de quatre produits compte seulement **60 clients** : les taux extrêmes exigent une interprétation prudente.

**6. Ancienneté.** Les départs sont répartis entre **0–2 ans : 528**, **3–5 ans : 625**, **6–8 ans : 570**, **9–10 ans : 315**. Le segment 3–5 ans concentre le plus de départs, mais cela ne signifie pas qu'il présente le taux le plus élevé.

### Enseignement principal

L'analyse met en évidence des écarts selon **l'activité**, **l'âge** et **le pays**. Ces observations guident les analyses suivantes ; elles ne prouvent pas que ces caractéristiques causent le churn.

## 7. Étape 4 — Page 2 : segmentation et recommandations (en cours)

**Question métier :** quels segments combinent un taux de churn élevé et un volume suffisant pour mériter une investigation prioritaire ?

Analyses prévues :
- **Âge × activité :** taux, effectifs et nombre de départs.
- **Nombre de produits × activité :** vérification des écarts après segmentation.
- **Pays × profils :** approfondissement du cas allemand.

Les recommandations définitives seront rédigées après vérification des croisements. À ce stade, les pistes sont l'engagement des clients inactifs, l'analyse des **40–59 ans** et l'étude du segment allemand.

## 8. Étape 5 — Machine Learning (à venir)

Une fois les analyses descriptives terminées, une **classification supervisée** cherchera à estimer la probabilité de départ d'un client :

1. Séparation apprentissage / test et prévention des fuites de données.
2. Prétraitement reproductible.
3. **Régression logistique** comme modèle de référence.
4. Comparaison éventuelle avec un modèle non linéaire.
5. Évaluation : matrice de confusion, précision, rappel, F1, ROC-AUC et PR-AUC selon le besoin métier.
6. Interprétation et limites des résultats.

**Aucun modèle prédictif n'a encore été entraîné dans le cadre de cette phase.**

## 9. Limites et précautions

- Étude descriptive, non causale.
- Les taux doivent toujours être rapprochés de leurs dénominateurs.
- Les groupes de petite taille peuvent produire des taux instables.
- Les filtres Power BI modifient les indicateurs affichés.
- Ce dataset d'étude de cas ne suffit pas à estimer le retour financier d'une campagne de fidélisation.

## 10. Organisation du dépôt

```text
Projet-churn/
├── Customer-Churn-Records.csv
├── churn_sql.sql
├── readme.md
└── images/                    # capture Power BI à ajouter
```

Le fichier `.pbix` et le dossier `machine_learning/` seront ajoutés au fil de l'avancement.

## 11. Conclusion

Sur **10 000 clients**, **2 038** ont quitté la banque, soit **20,38 %**. Le diagnostic souligne l'importance de distinguer **le nombre de départs**, **le taux de churn** et **la taille des segments**. La suite du projet approfondira les profils et proposera des recommandations, avant une phase distincte de prédiction avec Python.

*Projet portfolio évolutif — seules les étapes effectivement réalisées sont présentées comme terminées.*
