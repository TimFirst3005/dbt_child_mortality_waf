Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


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