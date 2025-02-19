package com.abhion.smart_agriculture_system_backend.controller;

import com.abhion.smart_agriculture_system_backend.service.EmailService;
import com.abhion.smart_agriculture_system_backend.util.JwtUtil;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final EmailService emailService;
    private final JwtUtil jwtUtil;
    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    private final DatabaseReference databaseReference;
    private final DatabaseReference otpReference;

    public AuthController(EmailService emailService, FirebaseDatabase firebaseDatabase, JwtUtil jwtUtil) {
        this.emailService = emailService;
        this.jwtUtil = jwtUtil;
        this.databaseReference = firebaseDatabase.getReference("users");
        this.otpReference = firebaseDatabase.getReference("otp_verifications");
    }

    /**
     * Step 1: Generate and Send OTP via Email
     */
    @PostMapping("/send-otp")
    public CompletableFuture<Map<String, String>> sendOtp(@RequestBody Map<String, String> userMap) {
        String email = userMap.get("email");
        Map<String, String> response = new HashMap<>();
        CompletableFuture<Map<String, String>> future = new CompletableFuture<>();

        DatabaseReference userRef = databaseReference.orderByChild("email").equalTo(email).getRef();

        userRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (snapshot.exists()) {
                    response.put("message", "User already exists. Please login.");
                    future.complete(response);
                    return;
                }

                // Generate a 4-digit random OTP
                Random random = new Random();
                int otp = 1000 + random.nextInt(9000);

                // Store OTP in Firebase with expiry time (5 minutes)
                Map<String, Object> otpData = new HashMap<>();
                otpData.put("otp", otp);
                otpData.put("expiry", System.currentTimeMillis() + 5 * 60 * 1000);

                otpReference.child(email.replace(".", ",")).setValueAsync(otpData); // Store OTP in Firebase

                // Send OTP via Email
                CompletableFuture.runAsync(() -> emailService.sendOtpEmail(email, otp));

                response.put("message", "OTP sent to email.");
                future.complete(response);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                response.put("error", "Failed to check user existence: " + error.getMessage());
                future.complete(response);
            }
        });

        return future;
    }

    /**
     * Step 2: Verify OTP and Register User
     */
    @PostMapping("/verify-otp")
    public CompletableFuture<Map<String, String>> verifyOtpAndRegister(@RequestBody Map<String, String> userMap) {
        String email = userMap.get("email");
        String userName = userMap.get("userName");
        String password = userMap.get("password");
        String apiKey = userMap.get("apiKey");
        int enteredOtp = Integer.parseInt(userMap.get("otp"));

        Map<String, String> response = new HashMap<>();
        CompletableFuture<Map<String, String>> future = new CompletableFuture<>();

        // Get OTP reference from Firebase
        DatabaseReference emailRef = otpReference.child(email.replace(".", ","));

        emailRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (!snapshot.exists()) {
                    response.put("message", "Invalid or expired OTP.");
                    future.complete(response);
                    return;
                }

                // Extract OTP data
                Integer storedOtp = snapshot.child("otp").getValue(Integer.class);
                Long expiry = snapshot.child("expiry").getValue(Long.class);

                if (storedOtp == null || expiry == null) {
                    response.put("message", "OTP data is missing. Try again.");
                    future.complete(response);
                    return;
                }

                if (System.currentTimeMillis() > expiry) {
                    response.put("message", "OTP expired. Request a new one.");
                    future.complete(response);
                    return;
                }

                if (enteredOtp != storedOtp) {
                    response.put("message", "Incorrect OTP. Please try again.");
                    future.complete(response);
                    return;
                }

                // Encrypt password and generate JWT token
                String hashedPassword = encoder.encode(password);
                String jwtToken = jwtUtil.generateToken(email);

                // Store user in Firebase Realtime Database
                Map<String, Object> userData = new HashMap<>();
                userData.put("userName", userName);
                userData.put("email", email);
                userData.put("password", hashedPassword);
                userData.put("JWT_Token", jwtToken);
                userData.put("date_timestamp", LocalDateTime.now().toString());

                databaseReference.child(apiKey).setValueAsync(userData);

                // Delete OTP after successful verification
                emailRef.removeValueAsync();

                response.put("message", "User registered successfully.");
                response.put("jwtToken", jwtToken);
                future.complete(response);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                response.put("error", "Failed to retrieve OTP: " + error.getMessage());
                future.complete(response);
            }
        });

        return future;
    }

    /*
     * Login user
     */

    @PostMapping("/login")
    public CompletableFuture<Map<String, String>> loginUser(@RequestBody Map<String, String> userMap) {
        String email = userMap.get("email");
        String password = userMap.get("password");

        Map<String, String> response = new HashMap<>();
        CompletableFuture<Map<String, String>> future = new CompletableFuture<>();

        DatabaseReference userRef = databaseReference.orderByChild("email").equalTo(email).getRef();

        userRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (!snapshot.exists()) {
                    response.put("message", "User not found. Please register first.");
                    future.complete(response);
                    return;
                }

                // Extract stored data
                String storedHashedPassword = null;
                String storedUserName = null;
                String apiKey = null;
                for (DataSnapshot childSnapshot : snapshot.getChildren()) {
                    storedUserName = childSnapshot.child("userName").getValue(String.class);
                    storedHashedPassword = childSnapshot.child("password").getValue(String.class);
                    apiKey = childSnapshot.getKey();
                    break;
                }

                if (storedHashedPassword == null || storedUserName == null) {
                    response.put("message", "Error retrieving user data.");
                    future.complete(response);
                    return;
                }

                // Validate Password
                if (!encoder.matches(password, storedHashedPassword)) {
                    response.put("message", "Invalid credentials. Please try again.");
                    future.complete(response);
                    return;
                }

                // Generate JWT Token and store it
                String jwtToken = jwtUtil.generateToken(email);
                databaseReference.child(apiKey).child("JWT_Token").setValueAsync(jwtToken);

                response.put("message", "Login successful.");
                response.put("jwtToken", jwtToken);
                response.put("userName", storedUserName);
                future.complete(response);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                response.put("error", "Failed to retrieve user data: " + error.getMessage());
                future.complete(response);
            }
        });

        return future;
    }

}
