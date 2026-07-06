import pandas as pd

# --- Chemins à adapter si besoin ---
INPUT_CSV = r"C:\Users\t.akanji\Downloads\API_SH.DYN.MORT_DS2_en_csv_v2_2476\API_SH.DYN.MORT_DS2_en_csv_v2_2476.csv"
OUTPUT_CSV = r"seeds\raw_child_mortality.csv"

WEST_AFRICA_CODES = [
    "BEN", "BFA", "CPV", "CIV", "GMB", "GHA", "GIN", "GNB",
    "LBR", "MLI", "MRT", "NER", "NGA", "SEN", "SLE", "TGO"
]

# 1. Lecture en sautant les 4 lignes parasites
df = pd.read_csv(INPUT_CSV, skiprows=4)

# 2. Filtrage sur les pays d'Afrique de l'Ouest
df = df[df["Country Code"].isin(WEST_AFRICA_CODES)]

# 3. Colonnes identifiants vs colonnes années
id_cols = ["Country Name", "Country Code", "Indicator Name", "Indicator Code"]
year_cols = [c for c in df.columns if c.isdigit()]

# 4. Passage du format large au format long
df_long = df.melt(
    id_vars=id_cols,
    value_vars=year_cols,
    var_name="year",
    value_name="under5_mortality_rate"
)

# 5. Nettoyage : suppression des lignes sans valeur, typage correct
df_long = df_long.dropna(subset=["under5_mortality_rate"])
df_long["year"] = df_long["year"].astype(int)
df_long["under5_mortality_rate"] = df_long["under5_mortality_rate"].astype(float)

# 6. Renommage propre des colonnes
df_long = df_long.rename(columns={
    "Country Name": "country_name",
    "Country Code": "country_code"
})[["country_code", "country_name", "year", "under5_mortality_rate"]]

# 7. Tri et export
df_long = df_long.sort_values(["country_code", "year"])
df_long.to_csv(OUTPUT_CSV, index=False)

print(f"Fichier généré : {OUTPUT_CSV}")
print(f"Nombre de lignes : {len(df_long)}")
print(df_long.head(10))