import 'package:flutter/material.dart';
import 'package:food_app_assignment/controllers/animation_controller.dart';
import 'package:food_app_assignment/views/auth_screen/login_screen.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen1.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen2.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen3.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';

class StarterScreen extends StatelessWidget {
  StarterScreen({Key? key}) : super(key: key);

  var controller = Get.put(CustomAnimationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller.animationController,
          children: [StarterScreen1(), StarterScreen2(), StarterScreen3()],
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.035,
          left: controller.pageIndex.value < 2
              ? MediaQuery.of(context).size.width * 0.43
              : MediaQuery.of(context).size.width * 0.25,
          child: Container(
            alignment: const Alignment(0, 0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                    controller: controller.animationController, count: 3),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.04,
                ),
                Obx(() => InkWell(
                    onTap: () {
                      if (controller.pageIndex.value < 2) {
                        controller.pageIndex.value++;
                        controller.animationController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn);
                      } else {
                        Get.to(() => LoginScreen());
                      }
                    },
                    child: controller.pageIndex.value < 2
                        ? CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.081,
                            child: Icon(
                              Icons.keyboard_double_arrow_right_rounded,
                              size: MediaQuery.of(context).size.width * 0.081,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.04),
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * 0.02,
                                bottom:
                                    MediaQuery.of(context).size.width * 0.02,
                                left: MediaQuery.of(context).size.width * 0.05,
                                right:
                                    MediaQuery.of(context).size.width * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.15)),
                            child: Row(
                              children: [
                                Text(
                                  'Get Started',
                                  style: GoogleFonts.openSans(
                                      color: Colors.purple,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.07,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                CircleAvatar(
                                    radius: MediaQuery.of(context).size.width *
                                        0.06,
                                    backgroundColor: const Color(0xFF6318AF),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: MediaQuery.of(context).size.width *
                                          0.06,
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
