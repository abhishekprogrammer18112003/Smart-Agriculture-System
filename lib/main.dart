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

