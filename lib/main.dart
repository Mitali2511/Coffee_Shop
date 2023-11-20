import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kenmark_itan_assignment/View/home_screen.dart';
import 'package:kenmark_itan_assignment/View/login_screen.dart';
import 'package:kenmark_itan_assignment/View/onboarding_screen.dart';
import 'package:kenmark_itan_assignment/View/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: [
          GetPage(name: "/", page: () => const SplashScreen()),
          GetPage(name: "/home", page: () => HomeScreen()),
          GetPage(name: "/login", page: () => LoginScreen()),
          GetPage(name: "/onboard", page: () => OnBoardingScreen())
        ],
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: const TextTheme(
                titleLarge: TextStyle(
                    color: Color.fromARGB(255, 144, 103, 69), fontSize: 28),
                titleSmall:
                    TextStyle(color: Color.fromARGB(255, 212, 135, 45))),
            buttonTheme: const ButtonThemeData(
                buttonColor: Color.fromARGB(255, 117, 74, 29)),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 117, 74, 29)),
            iconTheme:
                const IconThemeData(color: Color.fromARGB(255, 117, 74, 29))),
        home: SplashScreen());
  }
}
