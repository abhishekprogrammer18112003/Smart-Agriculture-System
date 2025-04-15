import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

// class HomeProvider extends ChangeNotifier {
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   bool motorStatus = false;
//   Map<String, dynamic> sensorData = {
//     "humidity": 0,
//     "soil_moisture_1": 0,
//     "soil_moisture_2": 0,
//     "temperature": 0.0,
//   };

//   Future<void> fetchRealtimeData() async {
//     print("fetch data");
//     _database.child("sensor").onValue.listen((event) {
//       final data = event.snapshot.value as Map<dynamic, dynamic>;
//       if (data != null) {
//         sensorData = {
//           "humidity": data["humidity"] ?? 0,
//           "soil_moisture_1": data["soil_moisture_1"] ?? 0,
//           "soil_moisture_2": data["soil_moisture_2"] ?? 0,
//           "temperature": data["temperature"] ?? 0.0,
//         };
//         notifyListeners();
//       }
//     });

//     _database.child("Motor").onValue.listen((event) {
//       motorStatus = event.snapshot.value as bool;
//       notifyListeners();
//     });
//   }

//   Future<void> updateMotorStatus(bool status) async {
//     await _database.child("Motor").set(status);
//   }
// }

class HomeProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> sensorsList = [];
  String selectedSensor = "";
  bool motorStatus = false;
  String correctPassKey = "";

  Future<void> fetchRealtimeData(String apiKey) async {
    print("Fetching real-time sensor data...");

    _database.child("users/$apiKey/sensor").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        sensorsList = data.entries.map((entry) {
          return {
            "sensor_name": entry.key,
            "pending": entry.value["pending"] ?? false,
            "moisture1": entry.value["moisture1"] ?? 0,
            "moisture2": entry.value["moisture2"] ?? 0,
            "humidity": entry.value["humidity"] ?? 0,
            "temp": entry.value["temp"] ?? 0.0,
            "isMotorOn": entry.value["isMotorOn"] ?? false,
          };
        }).toList();

        if (selectedSensor.isEmpty && sensorsList.isNotEmpty) {
          selectedSensor = sensorsList.first["sensor_name"];
        }

        notifyListeners();
      }
    });

    /// Fetch the username for passkey validation
    _database.child("users/$apiKey/userName").get().then((snapshot) {
      if (snapshot.exists) {
        correctPassKey = snapshot.value.toString();
        print(correctPassKey);
      }
    });
  }

  /// Verify passkey and update pending status
  Future<bool> verifyPassKey(String apiKey, String enteredKey) async {
    if (enteredKey == correctPassKey) {
      await _database
          .child("users/$apiKey/sensor/$selectedSensor/pending")
          .set(false);

      return true;
    }
    return false;
  }

  /// Selects a sensor
  void setSelectedSensor(String sensorName) {
    selectedSensor = sensorName;
    notifyListeners();
  }

  /// Toggles motor state
  Future<void> toggleMotorState(String apiKey) async {
    final sensor = sensorsList.firstWhere(
        (s) => s["sensor_name"] == selectedSensor,
        orElse: () => {});

    if (sensor.isNotEmpty) {
      bool newState = !(sensor["isMotorOn"] ?? false);
      await _database
          .child("users/$apiKey/sensor/$selectedSensor/isMotorOn")
          .set(newState);
    }
  }
}
