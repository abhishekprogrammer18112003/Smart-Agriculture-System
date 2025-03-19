import joblib
import pandas as pd
import random
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Define possible values for moisture sensors
moisture_levels = ["Wet", "Moist", "Dry"]

# Define optimal ranges for each plant type
plant_conditions = {
    "Money Plant": {"humidity_range": (30, 90), "temperature_range": (18, 29)},
    "9 O'Clock Plant": {"humidity_range": (20, 60), "temperature_range": (21, 29)},
}

# Generate dataset considering cumulative moisture readings
data = []
for _ in range(2000):
    plant_type = random.choice(["Money Plant", "9 O'Clock Plant"])
    
    # Simulate soil moisture variation across sensors
    moisture_values = random.choices(moisture_levels, k=3)
    
    humidity = round(random.uniform(*plant_conditions[plant_type]["humidity_range"]), 2)
    temperature = round(random.uniform(*plant_conditions[plant_type]["temperature_range"]), 2)

    # Improved Motor Output Logic
    if plant_type == "Money Plant":
        output = 1 if moisture_values.count("Dry") >= 2 else 0
    elif plant_type == "9 O'Clock Plant":
        output = 1 if moisture_values.count("Dry") == 3 else 0
    else:
        output = 0  # Default fallback

    data.append([plant_type, *moisture_values, humidity, temperature, output])

# Create DataFrame
df = pd.DataFrame(
    data, columns=["Plant Type", "Moisture 1", "Moisture 2", "Moisture 3", "Humidity", "Temperature", "Motor Output"]
)

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

# Split dataset
X = df.drop(columns=["Motor Output"])
y = df["Motor Output"]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train Random Forest Classifier
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluate model
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)

# Save model and encoders
joblib.dump(model, "smart_irrigation_model_rf.pkl")
joblib.dump((le_plant, le_moisture, scaler), "encoders_scaler_rf.pkl")

print(f"Model retrained with accuracy: {accuracy * 100:.2f}%")
print("Model and encoders saved successfully.")
