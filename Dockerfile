# Step 1: Use an official Java runtime as a base image
FROM openjdk:17-jdk-slim

# Step 2: Set the working directory inside the container


WORKDIR /app

# Step 3: Copy the built JAR file into the container
COPY target/smart_agriculture_system_backend-0.0.1-SNAPSHOT.jar app.jar



# Step 4: Expose port 8080 (Spring Boot default)
EXPOSE 8080

# Step 5: Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]


