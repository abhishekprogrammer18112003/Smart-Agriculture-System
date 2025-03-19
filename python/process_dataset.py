import pandas as pd
from sklearn.preprocessing import LabelEncoder, StandardScaler

# Load structured dataset
df = pd.read_csv("raw_data.csv")

# Encode categorical variables
le_plant = LabelEncoder()
df["Plant Type"] = le_plant.fit_transform(df["Plant Type"])

le_moisture = LabelEncoder()
df["Moisture 1"] = le_moisture.fit_transform(df["Moisture 1"])
df["Moisture 2"] = le_moisture.transform(df["Moisture 2"])
df["Moisture 3"] = le_moisture.transform(df["Moisture 3"])

# Normalize numerical features
scaler = StandardScaler()
df[["Humidity", "Temperature"]] = scaler.fit_transform(df[["Humidity", "Temperature"]])

# Save processed dataset to CSV
df.to_csv("processed_data.csv", index=False)

print("✅ Processed dataset saved as smart_irrigation_data_processed_10k.csv")
