import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeProvider extends ChangeNotifier {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  bool motorStatus = false;
  Map<String, dynamic> sensorData = {
    "humidity": 0,
    "soil_moisture_1": 0,
    "soil_moisture_2": 0,
    "temperature": 0.0,
  };

  Future<void> fetchRealtimeData() async {
    print("fetch data");
    _database.child("sensor").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      if (data != null) {
        sensorData = {
          "humidity": data["humidity"] ?? 0,
          "soil_moisture_1": data["soil_moisture_1"] ?? 0,
          "soil_moisture_2": data["soil_moisture_2"] ?? 0,
          "temperature": data["temperature"] ?? 0.0,
        };
        notifyListeners();
      }
    });

    _database.child("Motor").onValue.listen((event) {
      motorStatus = event.snapshot.value as bool;
      notifyListeners();
    });
  }

  Future<void> updateMotorStatus(bool status) async {
    await _database.child("Motor").set(status);
  }
}
