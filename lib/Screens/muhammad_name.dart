import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';

class MuhammadName extends StatelessWidget {
  const MuhammadName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Names of Prophet", style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w400, fontFamily: "Lato"),),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              GestureDetector(
                child: SvgPicture.asset("assets/icons/crosss.svg",width: 30,),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: displayHeight * 0.35,
                ),
                Text("Muhammad", style: TextStyle(color: whiteColor, fontSize: 35, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: displayHeight * 0.02,
                ),
                Text("(Highly Praised)", style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w300),),
                SizedBox(
                  height: displayHeight * 0.06,
                ),
                SvgPicture.asset("assets/icons/volume.svg", width: 40,),
                SizedBox(
                  height: displayHeight * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text("The One who has plenty of mercy for the"
                      "believers and the blasphemers in this world"
                      "and especially for the believers in the"
                      "hereafter. The most merciful.",textAlign: TextAlign.center, style: TextStyle(color: whiteColor.withOpacity(0.6), fontSize: 18, fontWeight: FontWeight.w300),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Text("1-99",style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.w400),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
