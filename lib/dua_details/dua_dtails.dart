import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
import 'package:share_plus/share_plus.dart';
class DuaDetails extends StatefulWidget {
  int? id;
  String? title;
  String? textArab;
  String? textUrdu;
  String? textProof;
  DuaDetails( {required this.id,required this.title,required this.textArab,required this.textUrdu,required this.textProof});

  @override
  State<DuaDetails> createState() => _DuaDetailsState();
}

class _DuaDetailsState extends State<DuaDetails> {
  void shareText() {
    Share.share(widget.title.toString()+"\n\n""  "+

   widget.textArab.toString()+"\n"+
    widget.textUrdu.toString(),);
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:  const BoxDecoration(
          image: DecorationImage(
            opacity: 0.90,
            // colorFilter:
            // ColorFilter.mode(Colors.white.withOpacity(0.2),
            //     BlendMode.dstATop),
            image: AssetImage(
              "assets/checkImage.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    Center(
                      child:
                      Text(
                        widget.textArab.toString(),
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
                      child: Text(
                        widget.textUrdu.toString(),
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
                        child: Text(
                        widget.textProof.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Jameelnoori",
                              color: black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
         flex: 7,
         child: InkWell(
           onTap: (){
             shareText();
           },
           child: Center(
             child: Container(
               height: 40,
               width: 90,
               decoration: BoxDecoration(
                 color: whiteColor,
                 borderRadius: BorderRadius.circular(10),

               ),
               child: const Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [

                   Text("Share",style: TextStyle(color: black,fontWeight:FontWeight.w700),),
                   // Icon(Icons.)
                 ],
               ),
             ),
           ),
         ),
       ),
            ],
          ),
        ),
      ),

    );

  }
}
