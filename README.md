# FYP - Smart Agriculture System

## Backend

Backend system is build using Java and Springboot.This project contains security uses Spring Security and generate JWT Tokens automatically when user registers and when Token expired.
Deployed on Render. Used Docker method to deployed.


### How to deploy on render

step 1 - Download Docker Desktop application and create account.

step 2 - build Your Spring Application.
              command -  mvn clean package
              
step 3 - build the Docker Image
              command - docker build -t my-spring-app-name .
              
step 4 - Tag and Push the Updated Image to Docker Hub
              command - docker tag my-spring-app-name your-dockerhub-usernam/my-spring-app-name
              command - docker push your-dockerhub-username/my-spring-app-name

setp 5 - Now, go to Render.com and log in.
            1️⃣ Create a New Web Service
                  Click "New +" → "Web Service".
                  Select "Deploy an existing image from Docker Hub".
                  Enter Docker Image Name
                            command - your-dockerhub-username/my-spring-app-name

step 6 - Set Environment Variables
            In the "Environment Variables" section, click "Add Environment Variable".
            key - FIREBASE_CONFIG
            value - Paste your entire Firebase JSON here

step 7 - Deploy the Application



### API END POINTS

BASE URL - https://fyp-v7p2.onrender.com

1) SEND OTP - /auth/send-otp
   
     Request -
         {
            "email": "abhishekprogrammer18112003@gmail.com"
         }

    Response - 
        {
            "message": "OTP sent to email."
        }


2) VERIFY OTP - /auth/verify-otp
   
     Request - 
       {
          "apiKey": "user456",
          "userName": "Abhion",
          "email": "abhishekprogrammer18112003@gmail.com",
          "password": "12345",
          "otp": "7980"
      }

   Response - 
     {
        "jwtToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYmhpc2hla3Byb2dyYW1tZXIxODExMjAwM0BnbWFpbC5jb20iLCJpYXQiOjE3NDAyNDY2ODEsImV4cCI6MTc0MDI4MjY4MX0.Bzc2FphymgO5uO-DZSqu-FvDuqb6BgbwALLtdI7n-d0",
        "message": "User registered successfully."
     }

5) LOGIN USER - auth/login
   
    Request -
       {
          "email": "tech.abhishekchauhan@gmail.com",
          "password": "12345"
       }

   Response - 
       {
          "jwtToken": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ0ZWNoLmFiaGlzaGVrY2hhdWhhbkBnbWFpbC5jb20iLCJpYXQiOjE3NDAyNDAwNzEsImV4cCI6MTc0MDI3NjA3MX0.drxtg36onyB-Nte_r5zlSyqXg2tRYPcje02hxMl9JgY",
          "message": "Login successful.",
          "userName": "Abhion"
       }
