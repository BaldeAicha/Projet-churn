-- ============================================================
-- 01. VUE GLOBALE DU CHURN
-- ============================================================

--Quel est le taux de churn ?

SELECT
  COUNT(*) AS nbr_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
  FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean`;

/*
CONSTAT :
Le taux de churn global est de 20,38 %.
Autrement dit, environ 1 client sur 5 a quitté la banque.

INTERPRÉTATION :
Ce taux constitue la référence pour comparer les différents profils
de clients étudiés par la suite.
*/

--Quel pays a le plus de clients qui partent ?

SELECT
  Geography,
  COUNT(*) AS nbr_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean` 
GROUP BY Geography;

/*
CONSTAT :
L'Allemagne présente un taux de churn de 32,44 %,
contre 16,17 % en France et 16,67 % en Espagne.

INTERPRÉTATION :
Le churn observé en Allemagne est environ deux fois plus élevé
que celui observé en France ou en Espagne.

LIMITATION :
Cette analyse est descriptive et ne permet pas d'établir
une relation causale entre la localisation et le churn.
*/

--Le taux de churn est-il différent entre les clients actifs et les clients non actifs ? 

SELECT
  IsActiveMember,
  COUNT(*) AS nbr_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean`  
GROUP BY IsActiveMember;

/*
CONSTAT :
Le taux de churn est de 26,87 % chez les clients non actifs,
contre 14,27 % chez les clients actifs.

Les clients non actifs représentent également davantage de départs :
1 303 contre 735.

INTERPRÉTATION :
Dans cet échantillon, l'inactivité est associée à un taux de churn
plus élevé.

LIMITATION :
Cette analyse descriptive ne permet pas de conclure que
l'inactivité provoque le départ.
Une analyse statistique sera nécessaire pour évaluer la solidité
de cette différence.
*/

--Le nombre de produits détenus par le client est-il associé au churn ?


SELECT
  NumOfProducts,
  COUNT(*) AS nbr_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean` 
GROUP BY NumOfProducts;

/*
CONSTAT :
Le taux de churn varie fortement selon le nombre de produits détenus.

Les clients possédant 3 ou 4 produits présentent des taux de churn
très élevés.

LIMITATION :
Les groupes de 3 et 4 produits sont de petite taille.
Les résultats doivent donc être interprétés avec prudence et ne peuvent
pas être comparés directement aux groupes plus nombreux.

Cette observation constitue une piste à approfondir plutôt qu'une
conclusion définitive.
*/


--Quel est le profil général des 60 clients qui possèdent 4 produits ?

SELECT
  COUNT(*) AS nombre_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  AVG(Age) AS age_moyen,
  MIN(Age) AS age_min,
  MAX(Age) AS age_max,
  AVG(Balance) AS solde_moyen,
  AVG(Tenure) AS anciennete_moyenne,
  COUNTIF(IsActiveMember = 1) AS clients_actifs,
  COUNTIF(IsActiveMember = 0) AS clients_non_actifs
FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean`  
WHERE NumOfProducts = 4;


/*Le groupe des clients possédant quatre produits compte seulement 60 clients et présente un taux de churn de 100 %.
 Ce résultat est descriptivement remarquable, mais la faible taille du groupe impose de rester prudent avant d'en tirer une conclusion générale.*/

--Dans quels pays se trouvent les clients ayant 3 produits, et quelle est leur répartition ?

SELECT 
  Geography,
  COUNT(*) AS nombre_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean` 
WHERE NumOfProducts = 3
GROUP BY Geography;
/*
CONSTAT :
Le groupe des clients possédant 3 produits présente un taux de churn
élevé dans les trois pays.

LIMITATION :
Le groupe reste relativement faible en effectif. Cette observation
doit donc être considérée comme un signal à vérifier statistiquement.
*/

--Le risque de désabonnement varie-t-il selon l’âge des clients ?

--Creation du table temporaire pour categorisé l'age des client

with clientcategori as ( 
  select  Exited, Age, 
  case
    when Age between 10 and 19 THEN "10-19"
    when Age between 20 and 29 THEN "20-29"
    when Age between 30 and 39 THEN "30-39"
    when Age between 40 and 49 THEN "40-49"
    when Age between 50 and 59 THEN "50-59"
    when Age between 60 and 69 THEN "60-69"
    when Age between 70 and 79 THEN "70-79"
    when Age between 80 and 89 THEN "80-89"
    when Age between 90 and 99 THEN "90-99"
  end  as tranche_age
  FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean`) 

select tranche_age,
  COUNT(*) AS nombre_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
from clientcategori 
group by  tranche_age;


-- Cretion d'une nouvelle table  

CREATE TABLE `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_age` AS

WITH clientcategori AS (
  SELECT
    CustomerId,
    Age,
    IsActiveMember,
    Balance,
    `Satisfaction Score` AS Satisfaction_Score,
    Exited,
    CASE
      WHEN Age BETWEEN 10 AND 19 THEN "10-19"
      WHEN Age BETWEEN 20 AND 29 THEN "20-29"
      WHEN Age BETWEEN 30 AND 39 THEN "30-39"
      WHEN Age BETWEEN 40 AND 49 THEN "40-49"
      WHEN Age BETWEEN 50 AND 59 THEN "50-59"
      WHEN Age BETWEEN 60 AND 69 THEN "60-69"
      WHEN Age BETWEEN 70 AND 79 THEN "70-79"
      WHEN Age BETWEEN 80 AND 89 THEN "80-89"
      WHEN Age BETWEEN 90 AND 99 THEN "90-99"
    END AS tranche_age
  FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_clean`
)

SELECT
  CustomerId,
  Age,
  tranche_age,
  IsActiveMember,
  Balance,
  Satisfaction_Score,
  Exited
FROM clientcategori;

--Chez les 40–49 ans, le churn est-il différent entre les clients actifs et les clients non actifs ?


select 
  IsActiveMember,
  count(*)  AS nombre_clients,
  COUNTIF(Exited = 1) AS clients_partis,
  COUNTIF(Exited = 1) / COUNT(*) * 100 AS churn_rate
  from `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_age` 
  where tranche_age = "40-49"
group by IsActiveMember ;

/*Chez les 40–49 ans, le churn est nettement plus élevé chez les clients non actifs (38,04 %) que chez les clients actifs (22,59 %). Les non-actifs représentent également le plus grand nombre de départs (531 contre 276).*/

--Quelles caractéristiques distinguent les différentes tranches d'âge et peuvent aider à comprendre leurs différences de churn ?

SELECT
  tranche_age,
  COUNT(*) AS nombre_clients,
  COUNTIF(Exited = 1) AS nombre_depart,
  ROUND(COUNTIF(Exited = 1) / COUNT(*) * 100, 2) AS taux_churn,

  ROUND(AVG(IsActiveMember) * 100, 2) AS taux_clients_actifs,

  APPROX_QUANTILES(Balance, 2)[OFFSET(1)] AS solde_median,

  ROUND(AVG(Satisfaction_Score), 2) AS satisfaction_moyenne

FROM `project-d1ae418b-71fd-4f45-840.customer_new.customer_churn_age`

GROUP BY tranche_age
ORDER BY tranche_age;

/*
CONSTAT :
Le churn varie fortement selon les tranches d'âge.

Les 50–59 ans présentent le taux de churn le plus élevé (56,04 %).

Les 40–49 ans représentent toutefois le plus grand nombre de départs
avec 807 clients partis.

Le solde médian est relativement élevé chez les 50–59 ans
(103 176,62), tandis que leur satisfaction moyenne est de 3,05/5.

INTERPRÉTATION :
Les résultats suggèrent que l'âge pourrait être associé au niveau
de churn et font apparaître des profils nécessitant une analyse
statistique plus approfondie.

LIMITATION :
Les groupes d'effectif très faible, notamment les 80 ans et plus,
doivent être interprétés avec prudence.
*/

--Pourquoi les 50–59 ans ont-ils un churn de 56,04 % malgré une proportion de clients actifs de 57,08 % ?



/*
============================================================
SUITE DE L'ANALYSE
============================================================

La tranche 50–59 ans présente le taux de churn le plus élevé
(56,04 %) malgré une proportion de clients actifs de 57,08 %.

Cette observation soulève une question :
quelles variables permettent réellement de différencier
les clients ayant quitté la banque de ceux qui sont restés ?

Cette question sera approfondie dans Python à l'aide d'une
analyse statistique, puis éventuellement d'un modèle prédictif.

SQL est utilisé ici pour l'exploration descriptive et la génération
d'hypothèses, et non pour établir des relations causales.
*/



