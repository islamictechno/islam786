import 'dart:async';

import 'package:colorful_progress_indicators/colorful_progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:lamsz_quran_api/api/quran_api.dart';
import 'package:show_up_animation/show_up_animation.dart';
import '../AppPrefs.dart';
import '../Constants.dart';
import 'bottom_bar.dart';
import 'home_screen.dart';
import 'on_boarding.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
var val=false;
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Timer(
        const Duration(seconds: 3),
            () {
          {
            Get.to(()=>(AppPrefs.getPhoneNumber()=='true')?OnboardingScreen():BottomBarNavigate());
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => (AppPrefs.getPhoneNumber()=='true')?OnboardingScreen():BottomBarNavigate()));
          }

        });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/check.png"
                ),
                fit: BoxFit.cover
            )
        ),
        // alignment: Alignment.topCenter,
        // child: SvgPicture.asset("assets/background.svg", fit: BoxFit.fill,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: ShowUpAnimation(
                delayStart: Duration(microseconds: 400),
                animationDuration: Duration(seconds: 2),
                curve: Curves.easeInToLinear,
                direction: Direction.vertical,
                offset: 4,
                child: Container(
                  padding: EdgeInsets.only(top: 50,),

                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  child: Center(child: Image.asset("assets/islam786.png")),
                ),
              ),
            ),
             SizedBox(height: MediaQuery.of(context).size.height*.6,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                ShowUpAnimation(
                  delayStart: Duration(microseconds: 400),
                  animationDuration: Duration(seconds: 1),
                  curve: Curves.easeInToLinear,
                  direction: Direction.horizontal,
                  offset: 0.2,
                  child: Center(child: Text('Powered By Islamic\nTechnologies',
                    selectionColor: Colors.grey.shade300,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12,fontFamily: 'Lato',color: Colors.grey.shade700,fontWeight: FontWeight.w300),)
                  ),
                ),
                const SizedBox(height: 30,),
                // Container(
                //
                //   child: SpinKitThreeBounce(
                //     duration: Duration(seconds: 2),
                //     color:Colors.white,
                //     size: 40.0,
                //   ),
                // ),
                ShowUpAnimation(
                  delayStart: Duration(microseconds: 400),
                  animationDuration: Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(left:130.0,right: 130),
                    child: ColorfulLinearProgressIndicator(
                      minHeight: 1.5,
                      colors: [
                        Colors.purpleAccent.shade200,
                        Colors.purple.shade50,
                        Colors.purple,
                        Colors.purple.shade100,
                        Colors.brown,
                      ],
                      duration:Duration(seconds: 2),
                      initialColor: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
              ],
            ),
          ],
        ),

      ),
    );
  }
}