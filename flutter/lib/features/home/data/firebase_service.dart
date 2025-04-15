import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  Future<List<String>> fetchSensorNames(String apiKey) async {
    final snapshot = await _dbRef.child("users/$apiKey/sensor").get();
    if (snapshot.exists) {
      return (snapshot.value as Map).keys.toList().cast<String>();
    }
    return [];
  }

  Stream<Map<String, dynamic>> sensorDataStream(String apiKey, String sensorName) {
    return _dbRef.child("users/$apiKey/sensor/$sensorName").onValue.map((event) {
      return Map<String, dynamic>.from(event.snapshot.value as Map);
    });
  }

  Future<void> toggleMotorState(String apiKey, String sensorName, bool newState) async {
    await _dbRef.child("users/$apiKey/sensor/$sensorName/isMotorOn").set(newState);
  }
}
