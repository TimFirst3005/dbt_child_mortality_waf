# Projet dbt — Mortalité infantile en Afrique de l'Ouest

Projet pédagogique complet démontrant une maîtrise de dbt Core, de l'ingestion
de données brutes jusqu'à la restitution BI, en passant par la modélisation
dimensionnelle, les tests, le Semantic Layer et l'intégration continue.

## Stack
- **Transformation** : dbt Core 1.11 + DuckDB
- **CI/CD** : GitHub Actions
- **Semantic Layer** : MetricFlow (dbt-metricflow)
- **BI** : Power BI (connexion ODBC)

## Architecture
Source Banque mondiale (SH.DYN.MORT, SP.POP.TOTL)
  → seeds (raw_child_mortality, seed_raw_population_fixture, seed_country_reference)
  → staging (nettoyage, typage)
  → intermediate (calculs : évolution YoY, enrichissement population)
  → marts (dim_country, fct_mortality en incrémental, fct_mortality_trends)
  → snapshot (historisation SCD Type 2)
  → Semantic Layer (métriques : taux moyen, population affectée)
  → Power BI

## Qualité
24 tests (génériques, singuliers, dbt_expectations), documentation complète,
pipeline CI validé à chaque push.


---

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


## ⚠️ Point d'attention : deux fichiers profiles.yml

Ce projet contient un `profiles.yml` à sa racine, dédié à la CI GitHub Actions
(target `ci`, base `ci.duckdb`). Ce fichier prend automatiquement la priorité
sur celui de `~/.dbt/profiles.yml` dès que dbt est lancé depuis ce dossier.

**En développement local**, pour utiliser le target `dev` (base `dev.duckdb`),
il faut définir explicitement le profil global attendu, par exemple avec :

    $env:DBT_PROFILES_DIR = "C:\Users\TON_USERNAME_SESSION\.dbt"

Placer cette ligne en tout début de chaque session PowerShell de travail sur
ce projet.