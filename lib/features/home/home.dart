import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontend/features/home/data/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await Provider.of<HomeProvider>(context, listen: false)
            .fetchRealtimeData();
     
      });
  }
  @override
  Widget build(BuildContext context) {
    final firebaseProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Irrigation System"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sensor Data Display
            SensorCard(title: "Humidity", value: "${firebaseProvider.sensorData["humidity"]}%"),
            SensorCard(title: "Soil Moisture 1", value: "${firebaseProvider.sensorData["soil_moisture_1"]}"),
            SensorCard(title: "Soil Moisture 2", value: "${firebaseProvider.sensorData["soil_moisture_2"]}"),
            SensorCard(title: "Temperature", value: "${firebaseProvider.sensorData["temperature"]}°C"),

            const SizedBox(height: 10),

            // Pie Chart for Visualization
            const Text(
              "Sensor Data Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 250,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))],
              ),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(value: firebaseProvider.sensorData["humidity"].toDouble(), title: "Humidity"),
                    PieChartSectionData(value: firebaseProvider.sensorData["soil_moisture_1"].toDouble(), title: "Soil Moist 1"),
                    PieChartSectionData(value: firebaseProvider.sensorData["soil_moisture_2"].toDouble(), title: "Soil Moist 2"),
                    PieChartSectionData(value: firebaseProvider.sensorData["temperature"].toDouble(), title: "Temperature"),
                  ],
                  centerSpaceRadius: 50,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Irrigation System Controls
            const Text(
              "Irrigation System Controls",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Irrigation Status:", style: TextStyle(fontSize: 16)),
                Switch(
                  value: firebaseProvider.motorStatus,
                  onChanged: (value) => firebaseProvider.updateMotorStatus(value),
                  activeColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SensorCard extends StatelessWidget {
  final String title;
  final String value;

  const SensorCard({required this.title, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
