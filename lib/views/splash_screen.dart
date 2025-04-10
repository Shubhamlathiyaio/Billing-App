// views/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Delay 2 seconds and navigate to HomePage
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/');
    });

    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child:
          Image.asset(
            'assets/logo.png',
            width: 300,
            height: 300,
          ),
        ),
    );
  }
}
