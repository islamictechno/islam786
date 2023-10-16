import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:islamm786/Screens/splash_screen.dart';
class LogoScreen extends StatefulWidget {
  // const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  void initState() {
    Timer(const Duration(seconds: 2), () async{
      // var box=await Hive.openBox('myBox');
      // final response=box.get('firstTimeCheck');
      // print('response ${response}');
      Get.to(()=> SplashScreen());
      // Get.to(()=> Onboarding(screenHeight: Get.height));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: size.height,
        width: size.width,

        decoration:  BoxDecoration(

          image: DecorationImage(
            opacity: 0.25,
            // colorFilter:
            // ColorFilter.mode(Colors.white.withOpacity(0.2),
            //     BlendMode.dstATop),
            image: AssetImage(
              "assets/check.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child:
          Image.asset(
            "assets/islam786.png",
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
