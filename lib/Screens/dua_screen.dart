import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamm786/app_utils/text_utils.dart';
import 'package:islamm786/dua_details/dua_model_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import '../dua_details/dua_dtails.dart';

class Dua extends StatefulWidget {
  const Dua({Key? key}) : super(key: key);

  @override
  State<Dua> createState() => _DuaState();
}

class _DuaState extends State<Dua> {
  Future<void> share(title, link) async {
    await FlutterShare.share(
      title: '$title',
      text: 'Please read it.',
      linkUrl: '$link',
    );
  }

  _launchWhatsapp(context) async {
    var whatsapp = "+923045653887";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  TextUtils _textUtils = TextUtils();

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: arabicColor,
          elevation: 0.0,
          leadingWidth: 40,
          leading:InkWell(
              onTap:(){
                Get.back();
              },child: Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
          title: _textUtils.semiBold("DUA'S", whiteColor, 15.0, TextAlign.center),
          centerTitle: true,
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 15.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 105),
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        //physics:  NeverScrollableScrollPhysics(),
                        itemCount: duaModelDetail.length,
                        itemBuilder: (BuildContext context, int index) {
                          DuaModelDetails  duaDetail =
                          duaModelDetail[index];
                          return duaDtailsData(
                            duaDetail.id.toString(),duaDetail.title.toString(),index
                          );


                        }),
                  ),
                ],
              ),
            )
            // Container(
            //
            //     child:StreamBuilder<QuerySnapshot>(
            //       stream: FirebaseFirestore.instance.collection('Dua').snapshots(),
            //       builder: (context, snapshot) {
            //         if (snapshot.hasData) {
            //           return ListView.builder(
            //               itemCount: snapshot.data!.docs.length,
            //               itemBuilder: (context, index) {
            //                 DocumentSnapshot doc = snapshot.data!.docs[index];
            //                 return Padding(
            //                   padding:  EdgeInsets.only(bottom: displayHeight*0.02),
            //                   child: Container(
            //                     width: displayWidth * 0.9,
            //                     height: displayHeight * 0.31,
            //                     decoration: BoxDecoration(
            //                       color: whiteColor,
            //                       borderRadius: const BorderRadius.all(Radius.circular(20)),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.grey.withOpacity(0.8),
            //                           blurRadius: 3,
            //                           spreadRadius: 0.5,
            //                           // offset: Offset(0, 0),
            //                         ),
            //                       ],
            //                     ),
            //                     child: Column(
            //                       children: [
            //                         Padding(
            //                           padding:  EdgeInsets.all(5.0),
            //                           child: Row(
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             children: [
            //                               SvgPicture.asset("assets/icons/quranword.svg",height: displayHeight*0.041,),
            //                               const SizedBox(
            //                                 width: 5,
            //                               ),
            //                               Column(
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: const [
            //                                   Text("Dua",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
            //                                 ],
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                         ClipRRect(
            //                             borderRadius: BorderRadius.circular(20.0),
            //                             child: Container(
            //                                 height: displayHeight*0.2,
            //                                 child: Image.network(doc['link'],fit: BoxFit.fitWidth,))),
            //                         SizedBox(
            //                           height: 10,
            //                         ),
            //                         Row(
            //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //                           children: [
            //
            //                             InkWell(
            //                               onTap: ()async{
            //                                 print('cliek');
            //                                 await share("Dua", doc['link']);
            //                               },
            //                               child: Row(
            //                                 children: [
            //                                   SvgPicture.asset("assets/icons/share.svg",width: 20,),
            //                                   const SizedBox(
            //                                     width: 5,
            //                                   ),
            //                                   const Text("Share",style: TextStyle(color: blackColor, fontSize: 13, fontFamily: "Lato", fontWeight: FontWeight.w400),),
            //                                 ],
            //                               ),
            //                             ),
            //                             Row(
            //                               children: [
            //                                 SvgPicture.asset("assets/icons/views.svg",width: 20,),
            //                                 const SizedBox(
            //                                   width: 5,
            //                                 ),
            //                                 const Text("View",style: TextStyle(color: blackColor, fontSize: 13, fontFamily: "Lato", fontWeight: FontWeight.w400),),
            //
            //                               ],
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               });
            //         } else {
            //           return Text("No data");
            //         }
            //       },
            //     )
            //
            // ),
            ));
  }
  //
  // Widget duaList({
  //   required String text,
  //   required String text1,
  //   required String text2,
  //   required String text3,
  // }) {
  //   var displayWidth = MediaQuery.of(context).size.width;
  //   var displayHeight = MediaQuery.of(context).size.height;
  //   return Container(
  //       width: displayWidth * 0.9,
  //       height: displayHeight * 0.11,
  //       decoration: BoxDecoration(
  //         color: whiteColor,
  //         borderRadius: BorderRadius.all(Radius.circular(5)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.3),
  //             blurRadius: 1,
  //             spreadRadius: 1,
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Container(
  //                   width: displayWidth * 0.09,
  //                   height: displayHeight * 0.04,
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.all(Radius.circular(35)),
  //                     color: Color(0xffF6EFFB),
  //                   ),
  //                   child: Text(text),
  //                 ),
  //                 SizedBox(
  //                   width: 10,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       text1,
  //                       maxLines: 2,
  //                       style: TextStyle(
  //                           color: blackColor,
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                           fontFamily: "Lato",
  //                           overflow: TextOverflow.ellipsis),
  //                     ),
  //                     Text(
  //                       text2,
  //                       style: TextStyle(
  //                           color: blackColor,
  //                           fontSize: 13,
  //                           fontWeight: FontWeight.w400,
  //                           fontFamily: "Lato"),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Text(
  //                   text3,
  //                   textDirection: TextDirection.rtl,
  //                   maxLines: 1,
  //                   style: TextStyle(
  //                       color: arabicColor, fontSize: 18, fontFamily: "Lato"),
  //                 )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ));
  // }

  Widget duaDtailsData(idText,titalText,index) {
    DuaModelDetails  duaDetail =
    duaModelDetail[index];
    return    InkWell(
      onTap: (){
      //  Get.to(()=>DuaDetails(id:duaDetail.id,title:duaDetail.title,textArab:duaDetail.textArab,textUrdu:duaDetail.textUrdu,textProof:duaDetail.textProof));
      // //
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        //padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],

        ),


        child:  ListTile(
          leading: Image.asset("assets/84660.png",height: 25,width: 25,color: arabicColor,),

          title: Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              titalText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Jameelnoori",
                  color: arabicColor),
            ),
          ),
          trailing:Text(
            idText,
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                fontFamily: "Jameelnoorikasheeda",
                color: arabicColor),
          ),
          onTap: (){
            Get.to(()=>DuaDetails(id:duaDetail.id,title:duaDetail.title,textArab:duaDetail.textArab,textUrdu:duaDetail.textUrdu,textProof:duaDetail.textProof.toString()));

          },
          // _textUtils.medium("کھانے سے پہلے کی دعا",blackColor, 18.0, TextAlign.center),
        ),

      ),
    );
  }
}
