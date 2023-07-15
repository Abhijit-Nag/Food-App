import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

Widget cardWidget({required width, required height, required image, required text, required context}){
  return Container(
    margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.021),
    width: width,
    height: height,
    // height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.024),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.23),
          offset: Offset(1, 4),
          blurRadius: 5,
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width*0.024), topRight: Radius.circular(MediaQuery.of(context).size.width*0.024)),
          child: Image.asset(image, width: width, height: height*0.6875, fit: BoxFit.cover,),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.width*0.021,
      ),
      Center(
        child: Text(text, style: GoogleFonts.firaSans(
          fontWeight: FontWeight.w600,
          fontSize: MediaQuery.of(context).size.width*0.03
        ),),
      )
    ],),
  );
}