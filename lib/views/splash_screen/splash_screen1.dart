import 'package:flutter/material.dart';
import 'package:food_app_assignment/views/splash_screen/splash_screen2.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Get.offAll(() => SplashScreen2());
    });
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6318AF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(controller.value * 2 * 3.14),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width * 0.35,
                      // height: MediaQuery.of(context).size.height*0.2,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.035,
            ),
            Text(
              'Welcome',
              style: GoogleFonts.openSans(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: const Color(0xFFF7E5B7),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
