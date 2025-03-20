<!-- # About

FYP - Smart Agriculture System using IOT Devices

We have created a smart agriculture system with facilities like crop health monitoring, real time crop monitoring, manual/automatic irrigation etc. We have used iot devices like soil moisture sensors, Humidity/Temperature sensors, Arduino Uno, Esp 32, relay + Water pumping kit and Esp 32 web cam.

================= FLOW ====================
We have created a wireless sensor network in which we have considered two sensor nodes. Each sensor node consist of -
1) Sensing Unit -> 3 Soil moisture Sensor, Dht 11 (humidity and temp sensor) , Pumping kit, Esp 32 Cam and ultrasonic Sensor.
2) Processing unit -> ESP32 Wifi module.
3) Power unit -> Arduino Uno (for power source and debugging).

Now data is sensed from the sensor and then the data is send to Base Station (Spring boot server). From the base station, the sensors data is stored to real time firebase database.
An flutter application is also build for monitoring the field data and manual watering the field.
Automatic watering feature is also there.We have created an LLM Model which takes input as plant type, Soil moisture 1 ,2, 3 data, humidity data and temp data. Output 1 -> motor On and 0 -> motor off. We have used around 100k entries in raw data and the model is trained using Random Forest Classifier, getting an accuracy of 99.92%. -->


# Smart Agriculture System Using IoT & AI
We have developed an advanced Smart Agriculture System that leverages IoT and AI to revolutionize modern farming. Our system offers features like real-time crop monitoring, crop health analysis, and an intelligent irrigation mechanism that operates both manually and automatically.

## 🚀 Key Features
✅ Real-Time Crop Monitoring – Track field conditions remotely through a mobile app.
✅ AI-Powered Smart Irrigation – Automatic watering based on sensor data and machine learning.
✅ Wireless Sensor Network – Efficiently collects and transmits field data.
✅ Live Camera Surveillance – ESP32 Cam for real-time field monitoring.

## 🔧 System Architecture
Our system is built around a Wireless Sensor Network (WSN), with each sensor node comprising:

1️⃣ Sensing Unit
📌 3 Soil Moisture Sensors – Measure water content in soil.
📌 DHT11 Sensor – Monitors humidity & temperature.
📌 Ultrasonic Sensor – Assesses field conditions.
📌 ESP32 Cam – Provides live field visuals.
📌 Water Pumping Kit – Controls irrigation.

2️⃣ Processing Unit
🔹 ESP32 WiFi Module – Processes sensor data and transmits it wirelessly.

3️⃣ Power Unit
⚡ Arduino Uno – Supplies power and enables debugging.

## 🔗 Data Flow & Communication
1️⃣ Sensors collect real-time data on soil moisture, humidity, and temperature.
2️⃣ Data is transmitted to the Base Station, built using Spring Boot, which processes and stores it in Firebase Realtime Database.
3️⃣ A Flutter mobile application allows farmers to monitor field conditions and manually control irrigation.
4️⃣ AI-Powered Automatic Irrigation – A machine learning model predicts whether to turn the water pump ON/OFF based on real-time sensor readings.

## 🧠 AI-Powered Decision Making
We developed a custom Large Language Model (LLM) trained with 100K+ data points to optimize irrigation decisions. The model uses input parameters such as:
🔹 Plant Type
🔹 Soil Moisture Levels (from 3 sensors)
🔹 Humidity & Temperature Data

🚀 Trained with a Random Forest Classifier, achieving an impressive 99.92% accuracy!

Our Smart Agriculture System integrates IoT, AI, and cloud-based analytics to enhance productivity, reduce water wastage, and ensure optimal crop growth. 🌱💧📡









## Backend 
Server is Divided into two parts.
1) SpringBoot Server
2) LLM model link with Python Server(Fast API).





## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
