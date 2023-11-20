import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //SplashGetController s = Get.put(SplashGetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: GetBuilder<SplashGetController>(
            init: SplashGetController(),
            dispose: (state) => SplashGetController(),
          
            builder: (controller) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       
                        Image.asset(
                          "assets/logo.png",
                          height: MediaQuery.sizeOf(context).height*0.5,

                          width: MediaQuery.sizeOf(context).width*0.5,
                        )
                      ],
                    ))
                  ]);
            }));
  }
}
