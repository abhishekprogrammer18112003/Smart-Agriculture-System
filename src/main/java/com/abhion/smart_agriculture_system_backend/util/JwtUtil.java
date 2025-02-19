package com.abhion.smart_agriculture_system_backend.util;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.stereotype.Component;
import com.google.firebase.database.*;

import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {
    private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 10; // 10 hours
    private static final Key SIGNING_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);
    private final DatabaseReference databaseReference;

    public JwtUtil(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("users");
    }

    public String generateToken(String email) {
        return Jwts.builder()
                .setSubject(email)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SIGNING_KEY, SignatureAlgorithm.HS256)
                .compact();
    }

    public String extractEmail(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(SIGNING_KEY)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public boolean validateToken(String token, String email) {
        try {
            return email.equals(extractEmail(token));
        } catch (ExpiredJwtException e) {
            return false;
        }
    }

    public String refreshJwtIfExpired(String token, String email, String apiKey) {
        try {
            Jwts.parserBuilder().setSigningKey(SIGNING_KEY).build().parseClaimsJws(token);
            return token; // Token is still valid
        } catch (ExpiredJwtException e) {
            System.out.println("JWT expired. Regenerating token...");

            String newToken = generateToken(email);
            databaseReference.child(apiKey).child("JWT_Token").setValueAsync(newToken);
            return newToken;
        }
    }
}
