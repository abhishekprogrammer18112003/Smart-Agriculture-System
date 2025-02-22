// package com.abhion.smart_agriculture_system_backend;



// import com.google.firebase.database.*;
// import org.springframework.boot.CommandLineRunner;
// import org.springframework.stereotype.Component;

// @Component
// public class FirebaseTestRunner implements CommandLineRunner {
//     private final FirebaseDatabase firebaseDatabase;

//     public FirebaseTestRunner(FirebaseDatabase firebaseDatabase) {
//         this.firebaseDatabase = firebaseDatabase;
//     }

//     @Override
//     public void run(String... args) {
//         System.out.println("🔥 Testing Firebase connection...");

//         DatabaseReference usersRef = firebaseDatabase.getReference("users");

//         usersRef.addListenerForSingleValueEvent(new ValueEventListener() {
//             @Override
//             public void onDataChange(DataSnapshot snapshot) {
//                 if (snapshot.exists()) {
//                     System.out.println("✅ Firebase Users: " + snapshot.getValue());
//                 } else {
//                     System.out.println("🚨 No users found in Firebase!");
//                 }
//             }

//             @Override
//             public void onCancelled(DatabaseError error) {
//                 System.err.println("🚨 Firebase read failed: " + error.getMessage());
//             }
//         });
//     }
// }
