import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:food_app_assignment/constants/firebase_constants.dart';
import 'package:food_app_assignment/controllers/auth_controller.dart';
import 'package:food_app_assignment/views/auth_screen/additional_screen.dart';
import 'package:food_app_assignment/views/auth_screen/signup_screen.dart';
import 'package:food_app_assignment/views/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
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
                          50.heightBox,
                          Image.asset(
                            'assets/images/logo.png',
                            height: MediaQuery.of(context).size.width * 0.4,
                          ),
                          Text(
                            'Craft My Plate',
                            style: GoogleFonts.openSans(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.09,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //email Input
                  TextFormField(
                    controller: controller.emailController,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.021),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.green,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ).marginOnly(
                            left: MediaQuery.of(context).size.height * 0.015,
                            right: MediaQuery.of(context).size.height * 0.02),
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 0.021),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.01),
                            borderSide: const BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.01),
                            borderSide: const BorderSide(color: Colors.grey))),
                  )
                      .box
                      .color(Colors.white.withOpacity(0.9))
                      .margin(EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1))
                      .roundedSM
                      .height(58)
                      .make(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),

                  //password Input
                  Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.021),
                      obscureText:
                          controller.isPasswordVisible.value ? false : true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: MediaQuery.of(context).size.height * 0.03,
                          ).marginOnly(
                              left: MediaQuery.of(context).size.height * 0.015,
                              right: MediaQuery.of(context).size.height * 0.02),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.021),
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordVisible(
                                    !controller.isPasswordVisible.value);
                              },
                              icon: controller.isPasswordVisible.value
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.01),
                              borderSide: const BorderSide(color: Colors.grey)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.01),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    )
                        .box
                        .color(Colors.white.withOpacity(0.9))
                        .margin(EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.1))
                        .roundedSM
                        .height(58)
                        .make(),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),

                  //login Button
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.01)),
                      width: MediaQuery.of(context).size.width * 0.31,
                      height: MediaQuery.of(context).size.height * 0.063,
                      child: controller.loading.value
                          ? Center(
                              child: const CircularProgressIndicator(
                              color: Colors.white,
                            ))
                          : TextButton(
                              onPressed: () async {
                                await controller.loginWithEmail(
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text,
                                    context: context);
                                print(auth.currentUser);
                                if (auth.currentUser != null) {
                                  VxToast.show(context,
                                      msg: "User logged in successfully.");
                                  Get.offAll(() => HomeScreen());
                                }
                                controller.loading(false);
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.firaSans(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              )),
                    );
                  }),

                  Text(
                    'Or you can login with another method',
                    style: GoogleFonts.firaSans(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),

                  // or widget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.2,
                        // width: MediaQuery.of(context).size.width*0.8,
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      CircleAvatar(
                        // backgroundColor: Colors.white,
                        radius: MediaQuery.of(context).size.width * 0.065,
                        child: Text(
                          'OR',
                          style: GoogleFonts.openSans(
                              color: const Color(0xFF6318AF),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.041),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Container(
                        height: 1.2,
                        // width: MediaQuery.of(context).size.width*0.8,
                        width: MediaQuery.of(context).size.width * 0.25,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.025,
                  ),

                  //Google login button
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.025),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.025),
                        color: Colors.orange.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('assets/images/google_icon.png',
                            width: MediaQuery.of(context).size.width * 0.1),
                        controller.googleLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                'Sign In With Google',
                                style: GoogleFonts.firaSans(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                      ],
                    ),
                  ).centered().onTap(() async {
                    await controller.signInWithGoogle();

                    //If user-authentication user can't go to homepage
                    if (auth.currentUser!.uid != null) {
                      Get.offAll(() => AdditionalScreen());
                    }
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.04,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                        print(auth.currentUser);
                      },
                      child: Text(
                        'Create new account?',
                        style: GoogleFonts.firaSans(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                      ),
                    ),
                  ).marginOnly(right: MediaQuery.of(context).size.width * 0.04),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                'By continuing, you agree to our Terms of Service   Privacy Policy',
                style: GoogleFonts.openSans(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: MediaQuery.of(context).size.width * 0.035),
              )
                  .marginSymmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2)
                  .marginOnly(bottom: 25)
            ],
          ),
        ),
      ),
    );
  }
}
