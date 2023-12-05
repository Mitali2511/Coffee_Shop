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
                       
                                   Image.network("https://firebasestorage.googleapis.com/v0/b/kenmark-itan-assignment.appspot.com/o/logo.png?alt=media&token=909765eb-3c79-4619-9b57-5d1bc4ec294c",height: MediaQuery.sizeOf(context).height*0.2,),

                      ],
                    ))
                  ]);
            }));
  }
}
