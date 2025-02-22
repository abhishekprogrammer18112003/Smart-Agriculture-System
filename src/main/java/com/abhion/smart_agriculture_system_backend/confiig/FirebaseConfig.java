package com.abhion.smart_agriculture_system_backend.confiig;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

@Configuration
public class FirebaseConfig {

    @Bean
    public FirebaseApp firebaseApp() throws IOException {
        System.out.println("Initializing Firebase...");

        // ✅ Get Firebase Config JSON from environment variable
        String firebaseConfigJson = System.getenv("FIREBASE_CONFIG");
        if (firebaseConfigJson == null) {
            throw new RuntimeException("❌ Missing FIREBASE_CONFIG environment variable.");
        }

        ByteArrayInputStream serviceAccount = new ByteArrayInputStream(
                firebaseConfigJson.getBytes(StandardCharsets.UTF_8));

        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://smart-agriculture-3816e-default-rtdb.asia-southeast1.firebasedatabase.app/")
                .build();

        if (FirebaseApp.getApps().isEmpty()) {
            return FirebaseApp.initializeApp(options);
        } else {
            return FirebaseApp.getInstance();
        }
    }

    @Bean
    public FirebaseAuth firebaseAuth(FirebaseApp firebaseApp) {
        return FirebaseAuth.getInstance(firebaseApp);
    }

    @Bean
    public FirebaseDatabase firebaseDatabase(FirebaseApp firebaseApp) {
        return FirebaseDatabase.getInstance(firebaseApp);
    }

    @Bean
    public DatabaseReference firebaseDatabaseReference(FirebaseDatabase firebaseDatabase) {
        return firebaseDatabase.getReference();
    }
}

// @Configuration
// public class FirebaseConfig {

//     @Bean
//     public FirebaseApp firebaseApp() throws IOException {
//         if (FirebaseApp.getApps().isEmpty()) {
//             FileInputStream serviceAccount = new FileInputStream("src/main/resources/serviceAccountKey.json");

//             FirebaseOptions options = FirebaseOptions.builder()
//                     .setCredentials(GoogleCredentials.fromStream(serviceAccount))
//                     .setDatabaseUrl(
//                             "https://smart-agriculture-3816e-default-rtdb.asia-southeast1.firebasedatabase.app/")
//                     .build();
//             System.out.println(FirebaseApp.getApps().size());
//             return FirebaseApp.initializeApp(options);
//         } else {
//             return FirebaseApp.getInstance();
//         }
//     }

//     @Bean
//     public FirebaseAuth firebaseAuth(FirebaseApp firebaseApp) {
//         return FirebaseAuth.getInstance(firebaseApp);
//     }

//     @Bean
//     public FirebaseDatabase firebaseDatabase(FirebaseApp firebaseApp) {
//         return FirebaseDatabase.getInstance(firebaseApp);
//     }
// }
