import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app_assignment/constants/firebase_constants.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var locationController = TextEditingController();
  var isPasswordVisible = false.obs;
  var googleLoading = false.obs;

  //Function for signing up new user using email and password
  signUpWithEmail({required email, required password, required context}) async {
    //loading starts
    loading(true);
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(credential);

      //Creating and storing user data in cloud-firestore in firebase
      await fireStore.collection(userCollection).doc(credential.user!.uid).set({
        "username": "",
        "email": email,
        "password": password,
        "userPhoto": "",
        "auth_provider": auth.currentUser!.providerData[0].providerId,
        "location": ""
      });
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    //loading stops
    loading(false);
  }

  //Function for logging the user in using email and password
  loginWithEmail({required email, required password, required context}) async {
    //loading starts
    loading(true);
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        VxToast.show(context, msg: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        VxToast.show(context, msg: "Wrong password provided for that user.");
      } else {
        VxToast.show(context, msg: e.toString());
      }
    }

    //loading stops
    loading(false);
  }

  //Function for calling google authentication for the user
  signInWithGoogle() async {
    // loading start
    googleLoading(true);

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    print('user after google login: ${auth.currentUser!.uid}');

    var result = await fireStore
        .collection(userCollection)
        .doc(auth.currentUser!.uid)
        .get();
    print('result from database: ${result.data()}');
    if (result.exists) {
    } else {
      await fireStore
          .collection(userCollection)
          .doc(auth.currentUser!.uid)
          .set({
        "username": auth.currentUser!.displayName,
        "password": "",
        "email": auth.currentUser!.email,
        "auth_provider": auth.currentUser!.providerData[0].providerId,
        "userPhoto": auth.currentUser!.providerData[0].photoURL,
        "location": ""
      });
    }

    //  loading stops
    googleLoading(false);
  }

  //Function for saving username and location after successful logging in or signing up
  saveUsernameAndLocation(
      {required username, required location, required context}) async {
    loading(true);
    try {
      await fireStore.collection(userCollection).doc(auth.currentUser!.uid).set(
          {"username": username, "location": location},
          SetOptions(merge: true));
      await auth.currentUser!.updateDisplayName(username);
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    loading(false);
  }
}
