import 'package:flutter/material.dart';
import 'package:food_app_assignment/controllers/animation_controller.dart';
import 'package:food_app_assignment/views/auth_screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

class StarterScreen1 extends StatelessWidget {
  StarterScreen1({Key? key}) : super(key: key);
  var controller = Get.put(CustomAnimationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.04),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.width * 0.02),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.02)),
              child: Text(
                'Skip',
                style: GoogleFonts.openSans(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple),
              ).onTap(() {
                Get.to(() => LoginScreen());
              }),
            ),
          ),
          Center(
            child: Lottie.asset('assets/animations/starter_animation1.json',
                height: MediaQuery.of(context).size.height * 0.4),
          ),
          Text(
            'Create Your Own Plate',
            style: GoogleFonts.openSans(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          10.heightBox,
          Text(
            'Create unforgettable memories with our unique feature to curate your favorite cuisines and food, tailored to your special occasion.',
            style: GoogleFonts.openSans(
                fontSize: MediaQuery.of(context).size.width * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.51)),
            textAlign: TextAlign.center,
          ).marginSymmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.width * 0.02)
        ],
      ),
    );
  }
}
