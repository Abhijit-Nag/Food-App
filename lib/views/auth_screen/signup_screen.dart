import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:food_app_assignment/constants/firebase_constants.dart';
import 'package:food_app_assignment/controllers/auth_controller.dart';
import 'package:food_app_assignment/views/auth_screen/additional_screen.dart';
import 'package:food_app_assignment/views/auth_screen/login_screen.dart';
import 'package:food_app_assignment/views/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipPath(
                    clipper: WaveClipperOne(),
                    child: Container(
                      color: const Color(0xFF6318AF),
                      width: MediaQuery.of(context).size.width * 1,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.062,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Text(
                            'Craft My Plate',
                            style: GoogleFonts.openSans(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.088,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //email textInput
                  TextFormField(
                    controller: controller.emailController,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.021),
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ).marginOnly(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.02),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.02)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.02))),
                  ).marginSymmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.width * 0.025),

                  //password textInput
                  Obx(() => TextFormField(
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021),
                        controller: controller.passwordController,
                        obscureText:
                            controller.isPasswordVisible.value ? false : true,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.021),
                            hintText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: MediaQuery.of(context).size.height * 0.03,
                            ).marginOnly(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.02),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  controller.isPasswordVisible(
                                      !controller.isPasswordVisible.value);
                                },
                                icon: controller.isPasswordVisible.value
                                    ? Icon(
                                        Icons.visibility,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      )),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.02)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.02))),
                      ).marginSymmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.width * 0.025)),

                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.021,
                  ),
                  //Sign Up Button
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.02)),
                      width: MediaQuery.of(context).size.width * 0.31,
                      height: MediaQuery.of(context).size.height * 0.052,
                      child: controller.loading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : TextButton(
                              onPressed: () async {
                                if (controller
                                        .emailController.text.isNotEmpty &&
                                    controller
                                        .passwordController.text.isNotEmpty) {
                                  await controller.signUpWithEmail(
                                      email: controller.emailController.text,
                                      password:
                                          controller.passwordController.text,
                                      context: context);
                                  print(auth.currentUser);
                                  if (auth.currentUser != null) {
                                    VxToast.show(context,
                                        msg: "User Signed Up successfully.");
                                    Get.offAll(() => AdditionalScreen());
                                  }
                                  controller.loading(false);
                                } else {
                                  VxToast.show(context,
                                      msg: "Please fill all fields.");
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.firaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              )),
                    );
                  }),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                      child: Text(
                        'Login?',
                        style: GoogleFonts.firaSans(
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ),
                  ).marginOnly(right: MediaQuery.of(context).size.width * 0.08),
                ],
              ),
              Text(
                'By continuing, you agree to our Terms of Service   Privacy Policy',
                style: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: MediaQuery.of(context).size.width * 0.036),
              )
                  .marginSymmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2)
                  .marginOnly(bottom: MediaQuery.of(context).size.height * 0.05)
            ],
          ),
        ),
      ),
    );
  }
}
