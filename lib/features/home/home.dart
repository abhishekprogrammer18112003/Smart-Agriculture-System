import 'package:flutter/material.dart';
import 'package:frontend/features/home/data/home_provider.dart';
import 'package:frontend/ui/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animations/animations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = "user123";

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).fetchRealtimeData(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Irrigation',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
        centerTitle: false,
        backgroundColor: Colors.teal,
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () => homeProvider.fetchRealtimeData(apiKey),
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (homeProvider.sensorsList.isNotEmpty)
            _buildSensorSelector(homeProvider),
          SizedBox(height: 10),
          Divider(thickness: 2, color: Colors.teal.shade300),
          homeProvider.sensorsList.isEmpty
              ? Center(
                  child: Text("No sensors available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
              : PageTransitionSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder:
                      (child, primaryAnimation, secondaryAnimation) =>
                          SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  ),
                  child: SensorDataWidget(),
                ),
        ],
      ),
    );
  }

  Widget _buildSensorSelector(HomeProvider homeProvider) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeProvider.sensorsList.length,
        itemBuilder: (context, index) {
          final sensor = homeProvider.sensorsList[index]["sensor_name"];
          final isSelected = homeProvider.selectedSensor == sensor;
          return GestureDetector(
            onTap: () => homeProvider.setSelectedSensor(sensor),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: isSelected ? Colors.teal : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  sensor,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SensorDataWidget extends StatefulWidget {
  @override
  _SensorDataWidgetState createState() => _SensorDataWidgetState();
}

class _SensorDataWidgetState extends State<SensorDataWidget> {
  final TextEditingController _passKeyController = TextEditingController();
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    final sensor = homeProvider.sensorsList.firstWhere(
      (s) => s["sensor_name"] == homeProvider.selectedSensor,
      orElse: () => {},
    );

    if (sensor.isEmpty) return Center(child: Text("No data available"));

    return sensor["pending"] == true
        ? _buildPassKeyInput(homeProvider)
        : _buildSensorDataCard(sensor, homeProvider);
  }

  Widget _buildSensorDataCard(
      Map<String, dynamic> sensor, HomeProvider homeProvider) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "${sensor["sensor_name"]} Data",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: Colors.amber.shade100,
            elevation: 3,
            child: Container(
              height: 400,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSensorDataRow(
                          "Moisture1",
                          sensor["moisture1"].toString(),
                          FontAwesomeIcons.tint),
                      _buildSensorDataRow(
                          "Moisture2",
                          sensor["moisture2"].toString(),
                          FontAwesomeIcons.tint),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSensorDataRow(
                          "Humidity",
                          sensor["humidity"].toString(),
                          FontAwesomeIcons.cloudSun),
                      _buildSensorDataRow(
                          "Temperature",
                          sensor["temp"].toString(),
                          FontAwesomeIcons.thermometerHalf),
                    ],
                  ),
                  Spacer(),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Container(
                        child: Row(
                          children: [
                            Text("Motor: ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Switch(
                              value: sensor["isMotorOn"] == true,
                              activeColor: Colors.green,
                              onChanged: (value) =>
                                  homeProvider.toggleMotorState("user123"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSensorDataRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.brown,
              size: 35,
            ),
            SizedBox(height: 10),
            Text(value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPassKeyInput(HomeProvider homeProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Text("Enter pass key to access data",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 10),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: TextField(
          //     controller: _passKeyController,
          //     decoration: InputDecoration(
          //       labelText: "Pass Key",
          //       border: OutlineInputBorder(),
          //       errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              controller: _passKeyController,
              hintText: "Enter Pass key",
              icon: Icons.lock,
              isPassword: true,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              bool isValid = await homeProvider.verifyPassKey(
                  "user123", _passKeyController.text.trim());
              setState(() {
                _errorMessage = isValid ? "" : "Incorrect pass key!";
                _passKeyController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(205, 0, 150, 135), // Button background color
  ),
            child: Text("Verify" , style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
