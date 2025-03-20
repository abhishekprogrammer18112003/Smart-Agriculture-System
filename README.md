# Smart Agriculture System Using IoT & AI

We have developed an advanced Smart Agriculture System that leverages IoT and AI to revolutionize modern farming. Our system offers features like real-time crop monitoring, crop health analysis, and an intelligent irrigation mechanism that operates both manually and automatically.

### 🚀 Key Features

✅ Real-Time Crop Monitoring – Track field conditions remotely through a mobile app.<br />
✅ AI-Powered Smart Irrigation – Automatic watering based on sensor data and machine learning.<br />
✅ Wireless Sensor Network – Efficiently collects and transmits field data.<br />
✅ Live Camera Surveillance – ESP32 Cam for real-time field monitoring.

### 🔧 System Architecture

Our system is built around a Wireless Sensor Network (WSN), with each sensor node comprising:

1️⃣ Sensing Unit<br />
📌 3 Soil Moisture Sensors – Measure water content in soil.<br />
📌 DHT11 Sensor – Monitors humidity & temperature.<br />
📌 Ultrasonic Sensor – Assesses field conditions.<br />
📌 ESP32 Cam – Provides live field visuals.<br />
📌 Water Pumping Kit – Controls irrigation.<br />

2️⃣ Processing Unit<br />
🔹 ESP32 WiFi Module – Processes sensor data and transmits it wirelessly.

3️⃣ Power Unit<br />
⚡ Arduino Uno – Supplies power and enables debugging.

### 🔗 Data Flow & Communication

1️⃣ Sensors collect real-time data on soil moisture, humidity, and temperature.<br />
2️⃣ Data is transmitted to the Base Station, built using Spring Boot, which processes and stores it in Firebase Realtime Database.<br />
3️⃣ A Flutter mobile application allows farmers to monitor field conditions and manually control irrigation.<br />
4️⃣ AI-Powered Automatic Irrigation – A machine learning model predicts whether to turn the water pump ON/OFF based on real-time sensor readings.<br />

### 🧠 AI-Powered Decision Making

We developed a custom Large Language Model (LLM) trained with 100K+ data points to optimize irrigation decisions. The model uses input parameters such as:<br />
🔹 Plant Type<br />
🔹 Soil Moisture Levels (from 3 sensors)<br />
🔹 Humidity & Temperature Data

🚀 Trained with a Random Forest Classifier, achieving an impressive 99.92% accuracy!

Our Smart Agriculture System integrates IoT, AI, and cloud-based analytics to enhance productivity, reduce water wastage, and ensure optimal crop growth. 🌱💧📡

# Backend SpringBoot Server

This repository contains the Spring Boot backend for our Smart Agriculture System, acting as the Base Station for IoT-based crop monitoring and automated irrigation. The backend is responsible for handling authentication, processing sensor data, managing user requests, and integrating with Firebase for real-time database updates.

### 🚀 Tech Stack & Tools Used

✅ Spring Boot – Backend framework<br />
✅ Spring Security – Secure authentication & authorization<br />
✅ Java Mail API – Email services for OTP verification<br />
✅ Bcrypt – Secure password hashing<br />
✅ Firebase – Real-time database for sensor data<br />
✅ JJWT – JSON Web Token-based authentication<br />
✅ Lombok – Reducing boilerplate code<br />
✅ Docker – Containerization for seamless deployment<br />
✅ Render – Cloud hosting platform

### 🌐 Deployment & Hosting

The backend is hosted on Render using a Docker image for efficient server rendering.

🔗 Base URL: https://fyp-54rw.onrender.com

### 🛠 Deploying the Server using Docker

Follow these steps to build and deploy the server using Docker:

1️⃣ Build Your Application<br />
Run the following command to build the Spring Boot project:<br />
    command -> mvn clean package

2️⃣ Build the Docker Image<br />
    command -> docker build -t my-spring-app .

3️⃣ Tag and Push the Updated Image to Docker Hub<br />
    command -> docker tag my-spring-app your-dockerhub-username/my-spring-app<br />
    command -> docker push your-dockerhub-username/my-spring-app

4️⃣ Deploy on Render

✅ Create a New Web Service

Click "New +" → "Web Service"<br />
Select "Deploy an existing image from Docker Hub"

✅ Enter Docker Image Name<br />
In the "Public Docker Image" field, enter:<br />
    command -> your-dockerhub-username/my-spring-app

✅ Set Environment Variables<br />
Render does not support .env files, so environment variables must be added manually:

Key Value (Example)<br />
FIREBASE_CONFIG Paste your entire Firebase JSON here<br />
PORT 8080 (Render requires this)

### 🔥 API Endpoints

1️⃣ Send OTP – /auth/send-otp (POST)<br />
    📌 Request:<br />
        {<br />
            "email": "abhishekprogrammer18112003@gmail.com"<br />
        }

2️⃣ Verify OTP – /auth/verify-otp (POST)<br />
    📌 Request:<br />
        {<br />
            "apiKey": "user123",<br />
            "userName": "Abhion",<br />
            "email": "abhishekprogrammer18112003@gmail.com",<br />
            "password": "12345",<br />
            "otp": "7980"<br />
        }

3️⃣ Login – /auth/login (POST)<br />
    📌 Request:<br />
        {<br />
            "email": "tech.abhishekchauhan@gmail.com",<br />
            "password": "12345"<br />
        }


# AI/ML Integration
We have integrated Artificial Intelligence & Machine Learning to optimize irrigation decisions in our Smart Agriculture System. By leveraging 100K+ data points and a Random Forest Classifier with SMOTE (Synthetic Minority Over-sampling Technique), our model achieves an impressive 99.92% accuracy in predicting when to activate irrigation.

### 📊 Model Inputs & Outputs
🔹 Input Features<br />
    1️⃣ Plant Type – Type of crop being monitored<br />
    2️⃣ Soil Moisture Sensor 1 – Dry / Moist / Wet<br />
    3️⃣ Soil Moisture Sensor 2 – Dry / Moist / Wet<br />
    4️⃣ Soil Moisture Sensor 3 – Dry / Moist / Wet<br />
    5️⃣ Humidity (%) – Air moisture level<br />
    6️⃣ Temperature (°C) – Current environmental temperature

🔹 Model Output<br />
    🔴 0 → Turn OFF the motor (No irrigation required)<br />
    🟢 1 → Turn ON the motor (Irrigation required)

### 🔄 ML Model Development Workflow
🔍 Phase 1: Data Collection<br />
Gathered real-time & historical sensor data (100K+ entries)

🛠 Phase 2: Data Preprocessing<br />
Removed duplicates and eliminated redundancy for better accuracy

📈 Phase 3: Model Training<br />
Trained a Random Forest Classifier using SMOTE to handle class imbalance.Achieved a 99.92% accuracy in irrigation predictions.

🌐 Phase 4: API Development<br />
Built a FastAPI service to expose the ML model via REST API

🚀 Phase 5: Deployment<br />
Deployed the model as an API endpoint for real-time predictions.

### 🔗 API Access via FastAPI
📍 Endpoint: http://127.0.0.1:8000/predict
    📨 Request :
        {
            "plant_type": "Money Plant",
            "moisture_1": "Dry",
            "moisture_2": "Moist",
            "moisture_3": "Moist",
            "humidity": 50.5,
            "temperature": 25.0
        }


# Frontend
# Database