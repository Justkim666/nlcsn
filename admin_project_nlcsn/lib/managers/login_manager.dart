
import 'package:firebase_auth/firebase_auth.dart';

class LoginManger {
  Future<bool> loginWithEmailPassWord({required String email, required String pass}) async {
    bool isSuccess = false;
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass)
        .then((value) => {isSuccess = true})
        .onError((error, stackTrace) => {isSuccess = false});
    return isSuccess;
  }
}