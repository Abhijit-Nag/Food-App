import 'package:flutter/material.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3500), () {
      Get.offAll(() => StarterScreen());
    });
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely

    animation = Tween<double>(begin: -20, end: 20).animate(controller);

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6318AF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, animation.value),
              child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Text(
              'Craft My Plate',
              style: GoogleFonts.openSans(
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  color: const Color(0xFFF7E5B7),
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'You customise, We cater',
              style: GoogleFonts.notoSansOldItalic(
                  color: const Color(0xFFD5B67D),
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            )
          ],
        ),
      ),
    );
  }
}
