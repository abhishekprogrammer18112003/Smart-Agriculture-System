package com.abhion.smart_agriculture_system_backend.controller;

import com.abhion.smart_agriculture_system_backend.util.JwtUtil;
import com.google.firebase.database.*;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.JwtException;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/sensor")
public class SensorController {

    private final DatabaseReference databaseReference;
    private final JwtUtil jwtUtil;

    public SensorController(DatabaseReference databaseReference, JwtUtil jwtUtil) {
        this.databaseReference = databaseReference;
        this.jwtUtil = jwtUtil;
    }

    @PostMapping("/sensor-data")
    public CompletableFuture<Map<String, Object>> receiveSensorData(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestBody Map<String, Object> sensorData) {

        CompletableFuture<Map<String, Object>> future = new CompletableFuture<>();
        Map<String, Object> response = new HashMap<>();

        if (token == null || !token.startsWith("Bearer ")) {
            response.put("error", "Missing or invalid Authorization header");
            future.complete(response);
            return future;
        }

        String jwt = token.replace("Bearer ", "");
        String email = "";
        String apiKey = sensorData.get("apiKey").toString();

        try {
            email = jwtUtil.extractEmail(jwt);
        } catch (ExpiredJwtException e) {
            System.out.println("JWT expired. Regenerating...");
            jwt = jwtUtil.refreshJwtIfExpired(jwt, email, apiKey);
            response.put("newJwtToken", jwt);
        } catch (JwtException e) {
            response.put("error", "Invalid JWT token.");
            future.complete(response);
            return future;
        }

        String sensorName = sensorData.get("sensor_name").toString();
        DatabaseReference sensorRef = databaseReference.child("users").child(apiKey).child("sensor").child(sensorName);

        // ✅ Only update these fields instead of replacing entire sensor data
        Map<String, Object> updateData = new HashMap<>();
        if (sensorData.containsKey("moisture1")) {
            updateData.put("moisture1", sensorData.get("moisture1"));
        }
        if (sensorData.containsKey("moisture2")) {
            updateData.put("moisture2", sensorData.get("moisture2"));
        }
        if (sensorData.containsKey("humidity")) {
            updateData.put("humidity", sensorData.get("humidity"));
        }
        if (sensorData.containsKey("temp")) {
            updateData.put("temp", sensorData.get("temp"));
        }

        // ✅ Update only the specified fields (merge update instead of full replacement)
        sensorRef.updateChildrenAsync(updateData);

        // ✅ Read `isMotorOn` without modifying it
        sensorRef.child("isMotorOn").addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                boolean isMotorOn = snapshot.exists() && snapshot.getValue(Boolean.class);
                response.put("isMotorOn", isMotorOn);
                future.complete(response);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                response.put("error", "Firebase Error: " + error.getMessage());
                future.complete(response);
            }
        });

        return future;
    }
}
