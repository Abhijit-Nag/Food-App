import 'package:food_app_assignment/constants/firebase_constants.dart';

class FirebaseServices {
  static getUser() {
    return fireStore
        .collection(userCollection)
        .doc(auth.currentUser!.uid)
        .snapshots();
  }
}
