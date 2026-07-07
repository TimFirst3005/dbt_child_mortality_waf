import pandas as pd
import duckdb

# --- Chemin à adapter si besoin ---
INPUT_CSV = r"C:\Users\t.akanji\Downloads\wb_population\API_SP.POP.TOTL_DS2_EN_csv_v2_3107.csv"

WEST_AFRICA_CODES = [
    "BEN", "BFA", "CPV", "CIV", "GMB", "GHA", "GIN", "GNB",
    "LBR", "MLI", "MRT", "NER", "NGA", "SEN", "SLE", "TGO"
]

# 1. Lecture en sautant les 4 lignes parasites
df = pd.read_csv(INPUT_CSV, skiprows=4)

# 2. Filtrage sur les pays d'Afrique de l'Ouest
df = df[df["Country Code"].isin(WEST_AFRICA_CODES)]

# 3. Format large -> long
id_cols = ["Country Name", "Country Code", "Indicator Name", "Indicator Code"]
year_cols = [c for c in df.columns if c.isdigit()]

df_long = df.melt(
    id_vars=id_cols,
    value_vars=year_cols,
    var_name="year",
    value_name="population_total"
)

df_long = df_long.dropna(subset=["population_total"])
df_long["year"] = df_long["year"].astype(int)
df_long["population_total"] = df_long["population_total"].astype("int64")

df_long = df_long.rename(columns={
    "Country Name": "country_name",
    "Country Code": "country_code"
})[["country_code", "country_name", "year", "population_total"]]

df_long = df_long.sort_values(["country_code", "year"])

# 4. Chargement DIRECT dans DuckDB (hors dbt) -> simule une ingestion externe
#    On crée un schéma "raw" dédié aux données brutes externes, comme en vraie production
con = duckdb.connect("dev.duckdb")
con.execute("CREATE SCHEMA IF NOT EXISTS raw")
con.execute("DROP TABLE IF EXISTS raw.population")
con.execute("CREATE TABLE raw.population AS SELECT * FROM df_long")

print("Table raw.population créée avec succès")
print(con.sql("SELECT COUNT(*) AS nb_lignes FROM raw.population"))
print(con.sql("SELECT * FROM raw.population LIMIT 5"))

con.close()