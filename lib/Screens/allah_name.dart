import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamm786/Data/Allah_names.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';

class AllahName extends StatefulWidget {
  const AllahName({Key? key}) : super(key: key);

  @override
  State<AllahName> createState() => _AllahNameState();
}

class _AllahNameState extends State<AllahName> {
  PageController? controller;
  int currentIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

var data=jsonDecode(jsonData);
  @override
  void initState() {
    print(data[0].length);
    PageController();
    super.initState();
    Timer.periodic( const Duration(milliseconds: 4200), (Timer timer) {
      if (currentIndex < 100) {
        currentIndex++;
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(seconds: 3),
          curve: Curves.ease,
        );
      } else {
        currentIndex = 2;
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: arabicColor,
        elevation: 0,
        title: Text("Names of Allah", style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w400, fontFamily: "Lato"),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,))

            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/check.png"),fit: BoxFit.fill,
            )
        ),
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (index){
                currentIndex=index;
                setState(() {

                });
              },
              itemCount: data.length,
              controller: _pageController,
              itemBuilder: (ctx, i) {
                var details=data[i];
                print(details);
                return Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: displayHeight * 0.35,
                        ),
                        Container(
                          width:displayWidth*0.4,

                          child: Text(details[1],textAlign: TextAlign.center,style: TextStyle(color: whiteColor,
                              fontSize: displayWidth*0.08,

                              fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(
                          height: displayHeight * 0.02,
                        ),
                        Text(details[3], style: TextStyle(color: whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),),
                        SizedBox(
                          height: displayHeight * 0.06,
                        ),
    //                     InkWell(
    //                         onTap:()async{
    //                           var audio = AudioPlayer();
    //                           audio.play(
    // '${details[5]}');
    //
    //
    //                 },
    //                         child: SvgPicture.asset("assets/icons/volume.svg", width: 40,)),
    //                     SizedBox(
    //                       height: displayHeight * 0.06,
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.only(left: 20, right: 20),
    //                       child: Text(details[4],
    //                         textAlign: TextAlign.center,
    //                         style: TextStyle(color: whiteColor.withOpacity(0.6),
    //                             fontSize: 18,
    //                             fontWeight: FontWeight.w300),),
    //                     ),

                      ],

                    ),
                  ],
                );

              }

            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text('${currentIndex+1} - 99', style: TextStyle(color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
  onchahged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
