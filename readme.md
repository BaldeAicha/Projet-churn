# 📊 Analyse du churn bancaire — Customer Churn

## 🎯 Objectif du projet

Ce projet consiste à analyser le **churn client** d'une banque afin d'identifier les caractéristiques associées au départ des clients.

L'objectif est de comprendre :

* Quel est le taux de churn global ?
* Quels profils de clients quittent le plus la banque ?
* Le churn varie-t-il selon l'âge, la géographie ou l'activité du client ?
* Le nombre de produits détenus est-il associé au départ des clients ?
* Quels indicateurs peuvent aider à mieux comprendre le phénomène de churn ?

---

## 🗂️ Dataset

Le projet utilise un dataset de **10 000 clients** et **18 variables**.

Les principales variables étudiées sont :

| Variable          | Description                             |
| ----------------- | --------------------------------------- |
| `CustomerId`      | Identifiant du client                   |
| `CreditScore`     | Score de crédit                         |
| `Geography`       | Pays du client                          |
| `Gender`          | Genre                                   |
| `Age`             | Âge                                     |
| `Tenure`          | Ancienneté auprès de la banque          |
| `Balance`         | Solde du compte                         |
| `NumOfProducts`   | Nombre de produits détenus              |
| `HasCrCard`       | Possession d'une carte bancaire         |
| `IsActiveMember`  | Statut de membre actif                  |
| `EstimatedSalary` | Salaire estimé                          |
| `Exited`          | Indique si le client a quitté la banque |

La variable `Exited` constitue la variable cible :

* `0` → client resté
* `1` → client parti

---

## 🧹 1. Nettoyage et préparation des données

Avant l'analyse, plusieurs contrôles ont été réalisés afin de vérifier la qualité des données :

* Vérification du nombre de lignes et de colonnes
* Recherche des doublons
* Vérification des valeurs manquantes
* Vérification des types de données
* Contrôle des valeurs aberrantes ou incohérentes
* Vérification des variables numériques
* Contrôle des valeurs de `EstimatedSalary`
* Vérification des valeurs de `Balance`
* Création de catégories d'âge pour faciliter l'analyse

Le dataset contient **10 000 observations** et aucune ligne dupliquée n'a été identifiée.

---

## 🔎 2. Analyse exploratoire

Le taux de churn global observé dans le dataset est de :

**20,38 %**

L'analyse a ensuite porté sur plusieurs dimensions :

### 🌍 Géographie

Le taux de churn varie selon le pays.

| Pays      | Taux de churn |
| --------- | ------------: |
| France    |       16,17 % |
| Allemagne |       32,44 % |
| Espagne   |       16,67 % |

Cette comparaison permet d'identifier des différences importantes selon la zone géographique.

### 👤 Activité du client

Le statut de membre actif est également étudié.

Les clients inactifs présentent un taux de churn supérieur aux clients actifs dans le dataset.

### 🎂 Âge

L'analyse par tranche d'âge montre également des différences importantes.

Certaines tranches d'âge présentent un taux de départ nettement supérieur à la moyenne globale.

### 📦 Nombre de produits

Le nombre de produits détenus par un client a également été étudié afin d'observer son association avec le churn.

Une attention particulière a été portée aux groupes ayant un nombre de clients faible, afin d'éviter d'interpréter trop rapidement des taux extrêmes.

---

## 🧮 3. Analyse avec SQL

L'analyse des données a été réalisée avec **SQL dans Google BigQuery**.

Les requêtes ont notamment permis de :

* calculer le taux de churn ;
* comparer le churn entre différentes catégories de clients ;
* analyser le churn par pays ;
* analyser le churn selon l'activité du client ;
* étudier le churn par tranche d'âge ;
* analyser le nombre de produits détenus ;
* croiser plusieurs variables afin d'approfondir l'analyse.

---

## 📈 4. Visualisation

Les résultats sont ensuite visualisés dans **Power BI** afin de construire un tableau de bord permettant d'explorer les principaux indicateurs du churn.

Le dashboard a pour objectif de rendre les résultats accessibles et de faciliter l'identification des profils présentant des taux de churn différents.

---

## 💡 Principaux enseignements

L'analyse met notamment en évidence :

* un churn global de **20,38 %** ;
* des différences importantes de churn selon la géographie ;
* un taux de churn plus élevé chez les clients inactifs ;
* des écarts importants entre les différentes tranches d'âge ;
* une relation à explorer entre le nombre de produits détenus et le churn.

Ces résultats permettent de formuler des pistes d'analyse supplémentaires plutôt que de conclure directement à des relations causales.

---

## 🛠️ Outils utilisés

* **Google Sheets** — préparation et premiers contrôles
* **Google BigQuery** — analyse SQL
* **Power BI** — visualisation et dashboard
* **GitHub** — documentation et versionnement du projet

---

## 📁 Structure du projet

```text
Aissatou.balde/
│
├── README.md
│
├── data/
│   └── customer_churn.csv
│
├── sql/
│   └── churn_analysis.sql
│
└── powerbi/
    └── customer_churn_dashboard.pbix
```

---

## 🚀 Compétences mobilisées

**Data analysis**

* Nettoyage des données
* Contrôle de qualité des données
* Analyse exploratoire
* Analyse descriptive
* Construction d'indicateurs

**SQL**

* Agrégations
* `COUNT`
* `COUNTIF`
* `GROUP BY`
* Analyse par catégories
* Calcul de taux

**Data visualisation**

* Power BI
* Création de KPI
* Analyse comparative
* Data storytelling
**Machine Learning**
*Préparation des données
*Classification
*Évaluation des modèles
*Prédiction du churn
*Analyse des variables importantes
---

## 📌 Conclusion

Ce projet m'a permis de mettre en pratique une démarche complète d'analyse de données, depuis le **contrôle et la préparation des données jusqu'à l'analyse SQL et la visualisation des résultats**.

L'objectif n'est pas uniquement d'identifier les clients qui quittent la banque, mais de comprendre **quels facteurs sont associés aux différences de churn** et quelles questions pourraient être approfondies dans une analyse future.
