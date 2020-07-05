import 'package:firebase_auth/firebase_auth.dart';

class SplashController {
  Future<bool> loading() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    return firebaseUser != null;
  }
}
