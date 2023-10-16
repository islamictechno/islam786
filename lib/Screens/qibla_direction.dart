import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';

class Qibla extends StatelessWidget {
  const Qibla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.3,
        title: Text("Qibla Direction", style: TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: blackColor,),
          onTap: (){
            Navigator.maybePop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: FractionalOffset.bottomCenter,
              child: Image.asset("assets/icons/qiblabg.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Center(
              child: SvgPicture.asset("assets/icons/compass.svg"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text("212 Clockwise from North \nDistance fom Mecca 3600.4 KM",textAlign: TextAlign.center,)),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
