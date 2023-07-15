import 'package:flutter/material.dart';
import 'package:food_app_assignment/constants/firebase_constants.dart';
import 'package:food_app_assignment/controllers/auth_controller.dart';
import 'package:food_app_assignment/views/home_screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AdditionalScreen extends StatelessWidget {
  AdditionalScreen({Key? key}) : super(key: key);
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser!.providerData[0].providerId == "google.com") {
      controller.usernameController.text = auth.currentUser!.displayName ?? "";
    }
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.width * 0.2,
          actions: [
            Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.width * 0.08,
            )
                .marginOnly(right: MediaQuery.of(context).size.width * 0.05)
                .onTap(() {
              print(auth.currentUser);
            })
          ]),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(
                    'Just a step away !',
                    style: GoogleFonts.openSans(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),

                  // Text Input for username
                  TextFormField(
                    controller: controller.usernameController,
                    enabled: auth.currentUser!.providerData[0].providerId ==
                            "google.com"
                        ? false
                        : true,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.021),
                    decoration: InputDecoration(
                        hintText: "Username",
                        prefixIcon: CircleAvatar(
                                radius: MediaQuery.of(context).size.height * 0.025,
                                child: Icon(
                                  Icons.person,
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                ))
                            .marginOnly(
                                left: MediaQuery.of(context).size.height * 0.01,
                                right:
                                    MediaQuery.of(context).size.height * 0.02),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0))),
                  ).marginSymmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.01),

                  //Text Input for location
                  TextFormField(
                    controller: controller.locationController,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.021),
                    decoration: InputDecoration(
                        hintText: "Location",
                        prefixIcon: Icon(
                          Icons.location_on,
                          size: MediaQuery.of(context).size.height * 0.03,
                        ).marginOnly(
                            left: MediaQuery.of(context).size.height * 0.01,
                            right: MediaQuery.of(context).size.height * 0.02),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0))),
                  ).marginSymmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1,
                      vertical: MediaQuery.of(context).size.height * 0.01),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  //Save button
                  Obx(
                    () => Container(
                            margin: const EdgeInsets.only(top: 50),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.height * 0.02,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02),
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: const Color(0xFF6318AF),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                                : Text(
                                    "Let's Start",
                                    style: GoogleFonts.firaSans(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    textAlign: TextAlign.center,
                                  ))
                        .onTap(() async {
                      //If any of the field remains empty function won't be called
                      if (controller.usernameController.text.isNotEmpty &&
                          controller.locationController.text.isNotEmpty) {
                        await controller.saveUsernameAndLocation(
                            username: controller.usernameController.text,
                            location: controller.locationController.text,
                            context: context);
                        VxToast.show(context, msg: "User Saved.");
                        if (auth.currentUser!.displayName != null) {
                          Get.offAll(() => HomeScreen());
                        }
                      } else {
                        VxToast.show(context,
                            msg: "Please fill all the data first.");
                      }
                    }),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  // If user logs in through google auth provider then the user can't
                  // change the username manually in the app. Only user creates new account using
                  //email-password the user can change username otherwise not.
                  auth.currentUser!.providerData[0].providerId == "google.com"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              child: Icon(Icons.info_outline_rounded),
                            ),
                            15.widthBox,
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.6),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5)),
                                child: Text(
                                  'You cannot change username when you are logging in using google auth provider',
                                  style: GoogleFonts.firaSans(fontSize: 13.71),
                                ),
                              ),
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
