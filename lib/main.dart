import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_themes.dart';
import 'package:frontend/core/constants/value_constants.dart';
import 'package:frontend/core/loaded_widget.dart';
import 'package:frontend/core/utils/screen_utils.dart';
import 'package:frontend/features/onboarding/data/onboarding_provider.dart';
import 'package:frontend/features/onboarding/screens/splash_screen.dart';
import 'package:frontend/route/custom_navigator.dart';

import 'package:provider/provider.dart';

import 'features/home/data/home_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(), 
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(), 
        ),
      ],
      child: ScreenUtilInit(
        designSize:
            const Size(VALUE_FIGMA_DESIGN_WIDTH, VALUE_FIGMA_DESIGN_HEIGHT),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'agroSmart',
          initialRoute: '/',
          onGenerateRoute: CustomNavigator.controller,
          themeMode: ThemeMode.light,
          builder: OverlayManager.transitionBuilder(),
          theme: AppThemes.light,
          home: SplashScreen(),
        ),
      ),
    );
  }
}




// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:frontend/features/onboarding/screens/splash_screen.dart';
// import 'package:http/http.dart' as http;
// // import 'package:gallery_saver/gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ESP32-CAM Controller',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: SplashScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final String esp32IP = 'http://192.168.137.149'; // Replace with your ESP32-CAM IP
//   double pan = 90;
//   double tilt = 90;

//   late final WebViewController _webViewController;

//   @override
//   void initState() {
//     super.initState();

//     // Modern WebView controller setup
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(esp32IP)); // should be MJPEG HTML like ESP32's root
//   }

//   Future<void> setServo() async {
//     final url = Uri.parse('$esp32IP/servo?pan=${pan.toInt()}&tilt=${tilt.toInt()}');
//     try {
//       await http.get(url);
//     } catch (e) {
//       debugPrint("Error setting servo: $e");
//     }
//   }

//   Future<void> captureImage() async {
//     try {
//       final response = await http.get(Uri.parse('$esp32IP/capture'));
//       if (response.statusCode == 200) {
//         final tempDir = await getTemporaryDirectory();
//         final filePath = '${tempDir.path}/esp32_capture_${DateTime.now().millisecondsSinceEpoch}.jpg';
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         // await GallerySaver.saveImage(file.path);
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Image saved to gallery')),
//         );
//       } else {
//         debugPrint("Capture failed with code ${response.statusCode}");
//       }
//     } catch (e) {
//       debugPrint("Image capture error: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("ESP32-CAM Controller"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // LIVE STREAM
//           SizedBox(
//             height: 300,
//             child: WebViewWidget(controller: _webViewController),
//           ),
//           const SizedBox(height: 10),

//           // CAPTURE BUTTON
//           ElevatedButton.icon(
//             icon: const Icon(Icons.camera),
//             label: const Text("Capture Image"),
//             onPressed: captureImage,
//           ),
//           const SizedBox(height: 10),

//           // PAN SLIDER
//           Text("Pan: ${pan.toInt()}"),
//           Slider(
//             value: pan,
//             min: 0,
//             max: 180,
//             onChanged: (value) {
//               setState(() => pan = value);
//               setServo();
//             },
//           ),

//           // TILT SLIDER
//           Text("Tilt: ${tilt.toInt()}"),
//           Slider(
//             value: tilt,
//             min: 0,
//             max: 180,
//             onChanged: (value) {
//               setState(() => tilt = value);
//               setServo();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
