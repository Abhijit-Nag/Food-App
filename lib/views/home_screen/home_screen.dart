import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_assignment/common_widgets/card_widgets.dart';
import 'package:food_app_assignment/constants/firebase_constants.dart';
import 'package:food_app_assignment/constants/home_constants.dart';
import 'package:food_app_assignment/controllers/home_controller.dart';
import 'package:food_app_assignment/services/firebase_services.dart';
import 'package:food_app_assignment/views/starter_screen/starter_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseServices.getUser(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          var data = snapshot.data!.data() as Map<String, dynamic>?;
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.width * 0.3,
              automaticallyImplyLeading: false,
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi,',
                            style: GoogleFonts.firaSans(
                                color: const Color(0xFF6318AF),
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Text(
                            '${data!['username']}!',
                            style: GoogleFonts.firaSans(
                                color: const Color(0xFF6318AF),
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.065),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          if (auth.currentUser!.providerData[0].providerId ==
                              "google.com") {
                            await GoogleSignIn().disconnect();
                            await auth.signOut();
                            Get.offAll(() => StarterScreen());
                            VxToast.show(context, msg: "User logged out.");
                          } else {
                            await auth.signOut();
                            VxToast.show(context, msg: "User logged out.");
                            Get.offAll(() => StarterScreen());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.015)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.power_settings_new_rounded,
                                color: const Color(0xFF6318AF),
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                'LogOut',
                                style: GoogleFonts.openSans(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.041,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current location',
                            style: GoogleFonts.firaSans(
                                color: const Color(0xFF7B7B7B),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.043,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.008,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                                size: MediaQuery.of(context).size.width * 0.07,
                              ),
                              Text(
                                data!['location'],
                                style: GoogleFonts.firaSans(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.043,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.6),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: Colors.blue,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                          3.heightBox,
                          Text(
                            'How it works?',
                            style: GoogleFonts.openSans(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.045,
                    ),

                    // first slider view
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          15.widthBox,
                          Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.025),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width *
                                          0.025),
                                  child: Image.asset(
                                    'assets/images/top_view_food_frame1.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.06,
                              left: MediaQuery.of(context).size.width * 0.06,
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Text(
                                'Enjoy your first order, the taste of our delicious food!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.043,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.width * 0.071,
                              left: MediaQuery.of(context).size.width * 0.061,
                              child: DottedBorder(
                                dashPattern: const [
                                  5,
                                  5
                                ], // Set dash length and spacing
                                strokeWidth: 1,
                                color: Colors.grey,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.005),
                                  child: Text('FIRSTPLATE01',
                                      style: TextStyle(
                                          color: Color(0xFFF7E5B7),
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04)),
                                ),
                              ),
                            )
                          ]),
                          Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              margin: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width *
                                          0.025),
                                  child: Image.asset(
                                    'assets/images/top_view_food_frame1.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.width * 0.06,
                              left: MediaQuery.of(context).size.width * 0.06,
                              width: MediaQuery.of(context).size.width * 0.40,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delicious food',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.051,
                                    ),
                                  ),
                                  Text(
                                    'for happy life',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.width * 0.071,
                              left: MediaQuery.of(context).size.width * 0.061,
                              child: DottedBorder(
                                dashPattern: const [
                                  5,
                                  5
                                ], // Set dash length and spacing
                                strokeWidth: 1,
                                color: Colors.grey,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.005),
                                  child: Text('FIRSTPLATE01',
                                      style: TextStyle(
                                          color: Color(0xFFF7E5B7),
                                          fontWeight: FontWeight.w600,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04)),
                                ),
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.07,
                    ),

                    // Search Bar View
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      // height: 50,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.07,
                          vertical: MediaQuery.of(context).size.width * 0.025),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width * 0.023),
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.23),
                            offset: Offset(1, 2),
                            blurRadius: 5,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.045),
                        decoration: InputDecoration(
                          hintText: 'Search food or events',
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.blue,
                            size: MediaQuery.of(context).size.width * 0.06,
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),

                    // Crafting view
                    Text(
                      'Start crafting',
                      style: GoogleFonts.firaSans(
                          color: const Color(0xFF6318AF),
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.065),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.025,
                    ),
                    Row(
                      children: [
                        cardWidget(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.width * 0.325,
                            context: context,
                            image: 'assets/images/default_platters.png',
                            text: "Default Platters"),
                        cardWidget(
                            width: MediaQuery.of(context).size.width * 0.41,
                            height: MediaQuery.of(context).size.width * 0.325,
                            context: context,
                            image: 'assets/images/default_2.png',
                            text: "Craft your own"),
                      ],
                    ).marginSymmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.045),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.061,
                    ),

                    //  Default menu view

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            5,
                            (index) => Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.52,
                                        margin: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.045),
                                        decoration: BoxDecoration(
                                            // color: Colors.orange,
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.23),
                                                offset: Offset(1, 2),
                                                blurRadius: 5,
                                                spreadRadius: 3,
                                              ),
                                            ]),
                                        child: Text(
                                          'Default Menu ${index + 1}',
                                          style: GoogleFonts.firaSans(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.left,
                                        ).marginOnly(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.008),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.11,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // const CircleAvatar(
                                              //   radius:50,
                                              //   backgroundImage: AssetImage('assets/images/default.png'),),

                                              Image.asset(
                                                'assets/images/default.png',
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                fit: BoxFit.cover,
                                              ),

                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.032,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '3 starters',
                                                    style: GoogleFonts.openSans(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    '3 maincourse',
                                                    style: GoogleFonts.openSans(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    '3 desserts',
                                                    style: GoogleFonts.openSans(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                    ),
                                                  ),
                                                  Text(
                                                    '3 drinks',
                                                    style: GoogleFonts.openSans(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                      Positioned(
                                        bottom:
                                            MediaQuery.of(context).size.width *
                                                0.125,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.048,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.045,
                                            ),
                                            Text(
                                              'Min 800',
                                              style: GoogleFonts.firaSans(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.055,
                                          child: Text(
                                            'Starts at ₹ 777',
                                            style: GoogleFonts.firaSans(
                                                color: Colors.blue,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.045,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                )),
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.045),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),

                    //  Top categories view
                    Text(
                      'Top Categories',
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.07),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            topCategories.length,
                            (index) => Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.27,
                                  margin: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        topCategories[index]['image']
                                            .toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.145,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        topCategories[index]['name'].toString(),
                                        style: GoogleFonts.firaSans(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                )),
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.043,
                        bottom: MediaQuery.of(context).size.width * 0.045,
                        top: MediaQuery.of(context).size.width * 0.045),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Starters',
                          style: GoogleFonts.firaSans(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ).marginOnly(
                            left: MediaQuery.of(context).size.width * 0.07),
                        Text(
                          'More Starters',
                          style: GoogleFonts.firaSans(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.043,
                              color: Colors.blue),
                        ).marginOnly(
                            right: MediaQuery.of(context).size.width * 0.06)
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.027,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            starters.length,
                            (index) => Column(
                                  children: [
                                    cardWidget(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        context: context,
                                        image:
                                            starters[index]['image'].toString(),
                                        text:
                                            starters[index]['name'].toString())
                                  ],
                                )),
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.045),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.07,
                    ),

                    // main course view
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Main Course',
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w500,
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                          ),
                        ).marginOnly(
                            left: MediaQuery.of(context).size.width * 0.07),
                        Text(
                          'More Main Courses',
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: Colors.blue),
                        ).marginOnly(
                            right: MediaQuery.of(context).size.width * 0.06)
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.021,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            mainCourses.length,
                            (index) => Column(
                                  children: [
                                    cardWidget(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        context: context,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        image: mainCourses[index]['image']
                                            .toString(),
                                        text: mainCourses[index]['name']
                                            .toString())
                                  ],
                                )),
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.045),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.065,
                    ),

                    //  services view

                    Text(
                      'Services',
                      style: GoogleFonts.firaSans(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                      ),
                    ).marginOnly(
                        left: MediaQuery.of(context).size.width * 0.07),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(services.length, (index) {
                          var description = services[index]['desc'] as List;
                          return Stack(children: [
                            Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.025),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.05),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.03),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.23),
                                    offset: Offset(1, 2),
                                    blurRadius: 5,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.03),
                                      child: Image.asset(
                                        services[index]['image'].toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        services[index]['symbol'].toString(),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      Text(
                                        services[index]['title'].toString(),
                                        style: GoogleFonts.firaSans(
                                            color: Color(0xFF6318AF),
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.052,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/icon.png',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.055,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          Text(
                                            description[0],
                                            style: GoogleFonts.firaSans(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/icon.png',
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          Text(
                                            description[1],
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/icon.png',
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          Text(
                                            description[2],
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/icon.png',
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                          ),
                                          Text(
                                            description[3],
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).marginOnly(
                                      left: MediaQuery.of(context).size.width *
                                          0.025),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.06,
                                  ),
                                  Text(
                                    'Know more',
                                    style: GoogleFonts.firaSans(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Color(0xFF6318AF),
                                        fontWeight: FontWeight.w500),
                                  ).marginOnly(
                                      left: MediaQuery.of(context).size.width *
                                          0.3)
                                ],
                              ),
                            ),
                            services[index]['recommended'].toString() == "true"
                                ? Positioned(
                                    top: MediaQuery.of(context).size.width *
                                        0.024,
                                    right: MediaQuery.of(context).size.width *
                                        0.024,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF6318AF),
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.024),
                                              bottomLeft: Radius.circular(10))),
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                      child: Text(
                                        'Recommended',
                                        style: GoogleFonts.firaSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.043),
                                      ).marginAll(
                                          MediaQuery.of(context).size.width *
                                              0.012),
                                    ),
                                  )
                                : Container(),
                          ]);
                        }),
                      ),
                    ).scale(scaleValue: 0.9),

                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.048,
                    ),

                    Text('How does it work?',
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.055,
                            ))
                        .marginOnly(
                            left: MediaQuery.of(context).size.width * 0.07),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.065,
                    ),

                    Column(
                      children: List.generate(workProcedure.length, (index) {
                        if (index % 2 == 1) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workProcedure[index]['title'].toString(),
                                      style: GoogleFonts.firaSans(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.048,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF6318AF)),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                    Text(
                                      workProcedure[index]['desc'].toString(),
                                      style: GoogleFonts.firaSans(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                workProcedure[index]['image'].toString(),
                                width: MediaQuery.of(context).size.width * 0.35,
                                fit: BoxFit.cover,
                              )
                            ],
                          ).marginSymmetric(
                              vertical:
                                  MediaQuery.of(context).size.width * 0.02);
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                workProcedure[index]['image'].toString(),
                                width: MediaQuery.of(context).size.width * 0.35,
                                fit: BoxFit.cover,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workProcedure[index]['title'].toString(),
                                      style: GoogleFonts.firaSans(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.048,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF6318AF)),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                    Text(
                                      workProcedure[index]['desc'].toString(),
                                      style: GoogleFonts.firaSans(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                      }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.048,
                    ),

                    Container(
                      color: Colors.grey.withOpacity(0.1),
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.06,
                          top: MediaQuery.of(context).size.width * 0.06,
                          bottom: MediaQuery.of(context).size.width * 0.12),
                      child: Text(
                        'Delicious food with professional service !',
                        style: GoogleFonts.openSans(
                            fontSize: MediaQuery.of(context).size.width * 0.065,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //     showSelectedLabels: true,
            //     showUnselectedLabels: true,
            //     items: const [
            //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //   BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: 'Wishlist'),
            //   BottomNavigationBarItem(icon: Icon(Icons.emoji_food_beverage), label: 'Orders'),
            //   BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            // ]),
            // floatingActionButton: FloatingActionButton(
            //     backgroundColor: Colors.white,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.5), ),
            //     onPressed: (){},
            //     child: Image.asset('assets/images/logo.png', width: MediaQuery.of(context).size.width*0.72,)),

            floatingActionButton: Container(
              width: MediaQuery.of(context).size.width * 0.135,
              height: MediaQuery.of(context).size.width * 0.135,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.72)),
              child: FloatingActionButton(
                backgroundColor: Colors.orange.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.072)),
                onPressed: () {},
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                height: MediaQuery.of(context).size.width * 0.192,
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.bottomNavigationBarSelectedIndex(0);
                        },
                        child: Column(
                          children: [
                            // Image.asset('assets/images/home.png', width: 35,),
                            controller.bottomNavigationBarSelectedIndex.value ==
                                    0
                                ? Icon(
                                    Icons.home,
                                    color: Color(0xFF6318AF),
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                  )
                                : Icon(
                                    Icons.home_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                    color: Colors.grey,
                                  ),
                            Text('Home',
                                style: GoogleFonts.openSans(
                                    color: controller
                                                .bottomNavigationBarSelectedIndex
                                                .value ==
                                            0
                                        ? const Color(0xFF6318AF)
                                        : Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.bottomNavigationBarSelectedIndex(1);
                        },
                        child: Column(
                          children: [
                            controller.bottomNavigationBarSelectedIndex.value ==
                                    1
                                ? Icon(
                                    Icons.favorite,
                                    color: Color(0xFF6318AF),
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                  )
                                : Icon(
                                    Icons.favorite_outline,
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                    color: Colors.grey,
                                  ),
                            Text('Wishlist',
                                style: GoogleFonts.openSans(
                                    color: controller
                                                .bottomNavigationBarSelectedIndex
                                                .value ==
                                            1
                                        ? const Color(0xFF6318AF)
                                        : Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.bottomNavigationBarSelectedIndex(2);
                        },
                        child: Column(
                          children: [
                            controller.bottomNavigationBarSelectedIndex.value ==
                                    2
                                ? Icon(
                                    Icons.dining,
                                    color: Color(0xFF6318AF),
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                  )
                                : Icon(
                                    Icons.dining_outlined,
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                    color: Colors.grey,
                                  ),
                            Text('Orders',
                                style: GoogleFonts.openSans(
                                    color: controller
                                                .bottomNavigationBarSelectedIndex
                                                .value ==
                                            2
                                        ? const Color(0xFF6318AF)
                                        : Colors.grey,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035))
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.bottomNavigationBarSelectedIndex(3);
                        },
                        child: Column(
                          children: [
                            controller.bottomNavigationBarSelectedIndex.value ==
                                    3
                                ? Icon(
                                    Icons.person,
                                    color: Color(0xFF6318AF),
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                  )
                                : Icon(
                                    Icons.person_outline,
                                    size: MediaQuery.of(context).size.width *
                                        0.072,
                                    color: Colors.grey,
                                  ),
                            Text(
                              'Profile',
                              style: GoogleFonts.openSans(
                                  color: controller
                                              .bottomNavigationBarSelectedIndex
                                              .value ==
                                          3
                                      ? const Color(0xFF6318AF)
                                      : Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        });
  }
}
