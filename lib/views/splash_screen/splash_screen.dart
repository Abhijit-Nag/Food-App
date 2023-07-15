import 'package:flutter/material.dart';
import 'package:food_app_assignment/views/home_screen/home_screen.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen1.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen2.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 5), () {
      // Get.offAll(()=>  LoginScreen());
      Get.offAll(() => StarterScreen());
    });
  }

  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Image.asset('assets/images/logo.png'),
        child: PageView(
          children: [
            SplashScreen1(),
            SplashScreen2(),
          ],
        ),
      ),
    );
  }
}
