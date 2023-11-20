import 'dart:async';
import 'package:get/get.dart';

class SplashGetController extends GetxController {
  Timer? time;

  @override
  void onInit() {
    splashTimer();
    super.onInit();
  }

  splashTimer() {
    time = Timer(Duration(seconds: 3), () {
      Get.offAndToNamed("/onboard");
    });

    update();
  }

  @override
  void onClose() {
    time!.cancel();

    // TODO: implement onClose
    super.onClose();
  }
}
