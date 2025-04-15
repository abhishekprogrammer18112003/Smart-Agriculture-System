from fastapi import FastAPI
import joblib
import pandas as pd
from pydantic import BaseModel

# Load the trained model
model = joblib.load("smart_irrigation_best_model.pkl")

# Initialize FastAPI app
app = FastAPI()

# Define request schema
class SensorData(BaseModel):
    plant_type: str
    moisture_1: str
    moisture_2: str
    # moisture_3: str
    humidity: float
    temperature: float

# Define label encoders (same as training)
moisture_mapping = {"Dry": 0, "Moist": 1, "Wet": 2}
plant_mapping = {"Money Plant": 0, "9 O'Clock Plant": 1}

# API root endpoint
@app.get("/")
def root():
    return {"message": "Smart Irrigation API is running!"}

# Prediction endpoint
@app.post("/predict")
def predict_motor_state(data: SensorData):
    try:
        # Convert categorical values to numbers
        plant_type_encoded = plant_mapping.get(data.plant_type, -1)
        moisture_1_encoded = moisture_mapping.get(data.moisture_1, -1)
        moisture_2_encoded = moisture_mapping.get(data.moisture_2, -1)
        # moisture_3_encoded = moisture_mapping.get(data.moisture_3, -1)

        if -1 in [plant_type_encoded, moisture_1_encoded, moisture_2_encoded]:
            return {"error": "Invalid input values"}

        # Create DataFrame for model prediction
        input_data = pd.DataFrame([[plant_type_encoded, moisture_1_encoded, moisture_2_encoded, data.humidity, data.temperature]],
                                  columns=["Plant Type", "Moisture 1", "Moisture 2", "Humidity", "Temperature"])

        # Make prediction
        prediction = model.predict(input_data)[0]

        # Return result
        return {"Motor State": int(prediction)}
    
    except Exception as e:
        return {"error": str(e)}

# Run API using Uvicorn
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
