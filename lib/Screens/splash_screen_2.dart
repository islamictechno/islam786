import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamm786/AppPrefs.dart';
import 'package:islamm786/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'bottom_bar.dart';
import 'home_screen.dart';
import 'on_boarding.dart';


class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
var st;
  @override
  void initState() {
    super.initState();
    print(AppPrefs.getPhoneNumber());
    Timer(
        const Duration(seconds: 3),
            () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => (AppPrefs.getPhoneNumber()=='true')?OnboardingScreen():BottomBarNavigate())));
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/background.svg", fit: BoxFit.fill,),
            ),
            Container(
              margin: EdgeInsets.only(left: width*0.25,top: height*0.05),

              alignment: Alignment.center,
              child: Image.asset("assets/islam786.png",height: 50,),
            ),
            Positioned(
              top: height*0.8,
              left: width*0.44,
              child: Container(

                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: whiteColor,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 80.0,
            //   child: Container(
            //     width: width,
            //     child: SpinKitRing(
            //       color: Colors.black,
            //       size: 50.0,
            //       lineWidth: 1.5,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}