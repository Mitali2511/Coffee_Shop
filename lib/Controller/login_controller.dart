import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var obscure = true;

//Password 
  togglepassword() {
    obscure = !obscure;
    update();
  }

//Firebase login
  loginwithEmiailAndPassword(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed("/home");
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "Invalid email or password",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
