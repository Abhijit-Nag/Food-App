import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_assignment/views/auth_screen/login_screen.dart';
import 'package:food_app_assignment/views/home_screen/home_screen.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen1.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen2.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Firebase is connected to the app.');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen1(),
    );
  }
}
