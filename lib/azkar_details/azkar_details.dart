import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:islamm786/Constants.dart';
import 'package:share_plus/share_plus.dart';
class AzkarDetail extends StatefulWidget {
  // const AzkarDetail({super.key});
  int? id;
  String? title;
  String? textArab;
  String? textUrdu;
  String? textProof;
  String? textArab2;
  String? textUrdu2;
  String? textProof2;
  String? textArab3;
  String? textUrdu3;
  String? textProof3;
  AzkarDetail( {required this.id,required this.title,required this.textArab,required this.textUrdu,required this.textProof,required this.textArab2,required this.textUrdu2,required this.textProof2,required this.textArab3,required this.textUrdu3,required this.textProof3});


  @override
  State<AzkarDetail> createState() => _AzkarDetailState();
}

class _AzkarDetailState extends State<AzkarDetail> {
  void shareText() {
    Share.share(widget.title.toString()+"\n\n""  "+

        widget.textArab.toString()+"\n"+
        widget.textUrdu.toString()+"\n"+widget.textProof.toString(),);
  }
  void shareData() {
    Share.share(widget.title.toString()+"\n\n""  "+

        widget.textArab2.toString()+"\n"+
        widget.textUrdu2.toString()+"\n"+widget.textProof2.toString(),);
  }
  void shareDataThird() {
    Share.share(widget.title.toString()+"\n\n""  "+

        widget.textArab3.toString()+"\n"+
        widget.textUrdu3.toString()+"\n"+widget.textProof3.toString(),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: arabicColor,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child:
          const Icon(Icons.arrow_back_ios,
            size: 18,
            color: Colors.white,)
          ,
        ),

        title: Text(
          widget.title.toString(),
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              fontFamily: "Jameelnoori",
              color: Colors.white),
        ),
        centerTitle: true,

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            azkarDetail(widget.textArab2.toString(),widget.textUrdu2.toString(),widget.textProof2.toString(),(){shareData();}),
            azkarDetail(widget.textArab.toString(),widget.textUrdu.toString(),widget.textProof.toString(),(){shareText();}),
            azkarDetail(widget.textArab3.toString(),widget.textUrdu3.toString(),widget.textProof3.toString(),(){shareDataThird();}),

          ],
        ),
      ),

    );
  }

  azkarDetail(textArab,textUrdu,textProof,press) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration:   BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: buttonColor.withOpacity(0.2),
            blurRadius: 3,
            spreadRadius: 0.5,
            // offset: Offset(0, 0),
          ),
        ],// image: DecorationImage(
        //   opacity: 0.90,
        //   // colorFilter:
        //   // ColorFilter.mode(Colors.white.withOpacity(0.2),
        //   //     BlendMode.dstATop),
        //   image: AssetImage(
        //     "assets/checkImage.png",
        //   ),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child:
                  Text(textArab,
                    // widget.textArab.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.0,

                        fontWeight: FontWeight.w500,
                        fontFamily: "noorehuda",
                        color: arabicColor),
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: Text(textUrdu,
                    // widget.textUrdu.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(

                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Jameelnoori",
                        color: black),
                  ),
                ),
                const SizedBox(height: 10,),
                Center(
                  child: Opacity(
                    opacity: .5,
                    child: Text(textProof,
                      // widget.textProof.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: "noorehuda",
                          color: black),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap:press,
                      //     (){
                      //   shareText();
                      // },
                      child: Center(
                        child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                            color: arabicColor,
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Share",style: TextStyle(color: Colors.white,fontSize:13,fontWeight:FontWeight.w500),),
                              // Icon(Icons.)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
