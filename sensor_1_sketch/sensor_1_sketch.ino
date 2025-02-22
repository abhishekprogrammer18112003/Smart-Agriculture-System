#include <WiFi.h>
#include <FirebaseESP32.h>
#include "DHT.h"

// WiFi Credentials
const char ssid[] = "minion";
const char password[] = "prasqwer4321";

// Firebase Credentials
#define FIREBASE_HOST "https://smart-agriculture-3816e-default-rtdb.asia-southeast1.firebasedatabase.app/"
#define FIREBASE_AUTH "AIzaSyDaEdhRdcYII01bkKm9bgRtl6lUG9AgCXQ"
const char apiKey[] = "user123";
const char sensorName[] = "Sensor_system_2";
bool pending = true;

// Sensor Pins
#define SOIL_MOISTURE_1 34
#define SOIL_MOISTURE_2 35
#define DHTPIN 4
#define DHTTYPE DHT11
#define RELAY_PIN 5

DHT dht(DHTPIN, DHTTYPE);
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
unsigned long lastUpdate = 0;
unsigned long lastMotorCheck = 0;

void setup() {
    Serial.begin(115200);
    WiFi.begin(ssid, password);
    dht.begin();
    pinMode(RELAY_PIN, OUTPUT);
    digitalWrite(RELAY_PIN, HIGH);

    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Connecting to WiFi...");
    }
    Serial.println("✅ Connected to WiFi");

    // ✅ Initialize Firebase
    config.host = FIREBASE_HOST;
    config.signer.tokens.legacy_token = FIREBASE_AUTH;
    Firebase.begin(&config, &auth);
    Firebase.reconnectWiFi(true);

    ensureSchemaExists();
    resetSensorSchema();

    // ✅ Keep checking pending status until false
    while (checkPendingStatus()) {
        delay(2000);
    }

    Serial.println("✅ Access granted to sensor system 1");
}

bool checkPendingStatus() {
    String path = "/users/" + String(apiKey) + "/sensor/" + String(sensorName) + "/pending";
    
    if (Firebase.getBool(fbdo, path)) {
        pending = fbdo.boolData();
        Serial.println("✅ Pending status: " + String(pending ? "true" : "false"));
    } else {
        Serial.println("❌ Failed to get pending status: " + fbdo.errorReason());
    }

    return pending;
}

// ✅ Function to Reset Sensor Schema
void resetSensorSchema() {
    String sensorPath = "/users/" + String(apiKey) + "/sensor/" + String(sensorName);
    Serial.println("🔄 Resetting sensor schema...");
    
    Firebase.setBool(fbdo, sensorPath + "/pending", true);
    Firebase.setInt(fbdo, sensorPath + "/moisture1", 0);
    Firebase.setInt(fbdo, sensorPath + "/moisture2", 0);
    Firebase.setInt(fbdo, sensorPath + "/humidity", 0);
    Firebase.setInt(fbdo, sensorPath + "/temp", 0);   
    Firebase.setBool(fbdo, sensorPath + "/isMotorOn", false);
}

// ✅ Ensure Firebase Schema Exists
void ensureSchemaExists() {
    String sensorPath = "/users/" + String(apiKey) + "/sensor/" + String(sensorName);
    
    if (!Firebase.getString(fbdo, sensorPath + "/sensor_name")) {
        Serial.println("🔹 Creating sensor schema...");
        Firebase.setString(fbdo, sensorPath + "/sensor_name", sensorName);
        resetSensorSchema();
    }
}

void loop() {
    if (WiFi.status() == WL_CONNECTED) {
        // checkPendingStatus();  // Recheck pending before sending data

        // ✅ **Check Sensor Data Every 5 Seconds**
        if (millis() - lastUpdate > 3000 && !pending) {
            lastUpdate = millis();
        
                float temperature = dht.readTemperature();
                float humidity = dht.readHumidity();
                int soilMoisture1 = analogRead(SOIL_MOISTURE_1);
                int soilMoisture2 = analogRead(SOIL_MOISTURE_2);

                Serial.print("🌡 Temperature: ");
                Serial.print(temperature);
                Serial.print("°C, 💧 Humidity: ");
                Serial.print(humidity);
                Serial.print("%, 🌱 Soil Moisture 1: ");
                Serial.print(soilMoisture1);
                Serial.print(", 🌱 Soil Moisture 2: ");
                Serial.println(soilMoisture2);

                // ✅ Send Data to Firebase
                sendSensorData("temp", temperature);
                sendSensorData("humidity", humidity);
                sendSensorData("moisture1", soilMoisture1);
                sendSensorData("moisture2", soilMoisture2);
        
        }

        // ✅ **Check Motor Status Every 2 Seconds**
        if (millis() - lastMotorCheck > 1000 && !pending) {
            lastMotorCheck = millis();
            listenForMotorStatus();
        }
    } else {
        Serial.println("❌ WiFi Disconnected!");
    }
}

// ✅ **Listen for isMotorOn Updates in Real-Time**
void listenForMotorStatus() {
    String path = "/users/" + String(apiKey) + "/sensor/" + String(sensorName) + "/isMotorOn";

    if (Firebase.getBool(fbdo, path)) {
        bool motorStatus = fbdo.boolData();
        digitalWrite(RELAY_PIN, motorStatus ? LOW : HIGH);
        if(motorStatus){

          Serial.println("🚀 Motor ON");
        } 
    } else {
        Serial.println("❌ Failed to get isMotorOn status: " + fbdo.errorReason());
    }
}

// ✅ Function to Send Sensor Data to Firebase
void sendSensorData(const String& key, float value) {
    String path = "/users/" + String(apiKey) + "/sensor/" + String(sensorName) + "/" + key;
    if (Firebase.setFloat(fbdo, path, value)) {
        Serial.println("✅ " + key + " sent successfully");
    } else {
        Serial.println("❌ Failed to send " + key + ": " + fbdo.errorReason());
    }
}
