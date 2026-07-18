import pandas as pd

INPUT_CSV = r"C:\Users\t.akanji\Downloads\wb_population\API_SP.POP.TOTL_DS2_EN_csv_v2_3107.csv"
OUTPUT_CSV = r"external_data\raw_population.csv"

WEST_AFRICA_CODES = [
    "BEN", "BFA", "CPV", "CIV", "GMB", "GHA", "GIN", "GNB",
    "LBR", "MLI", "MRT", "NER", "NGA", "SEN", "SLE", "TGO"
]

df = pd.read_csv(INPUT_CSV, skiprows=4)
df = df[df["Country Code"].isin(WEST_AFRICA_CODES)]

id_cols = ["Country Name", "Country Code", "Indicator Name", "Indicator Code"]
year_cols = [c for c in df.columns if c.isdigit()]

df_long = df.melt(id_vars=id_cols, value_vars=year_cols, var_name="year", value_name="population_total")
df_long = df_long.dropna(subset=["population_total"])
df_long["year"] = df_long["year"].astype(int)
df_long["population_total"] = df_long["population_total"].astype("int64")

df_long = df_long.rename(columns={"Country Name": "country_name", "Country Code": "country_code"})[
    ["country_code", "country_name", "year", "population_total"]
]
df_long = df_long.sort_values(["country_code", "year"])
df_long.to_csv(OUTPUT_CSV, index=False)

print(f"Fixture generee : {OUTPUT_CSV} ({len(df_long)} lignes)")