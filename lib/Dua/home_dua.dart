import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/Dua/bukhari_widget/bukhari_data.dart';
import 'package:islamm786/Dua/home_dua_model.dart';
import 'package:islamm786/app_utils/common.dart';

import 'bukhari_model/bukhari_model.dart';
class HomeDua extends StatefulWidget {


  @override
  State<HomeDua> createState() => _HomeDuaState();
}

class _HomeDuaState extends State<HomeDua> {
  int currentIndex = 5;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: Get.back,
            child: Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,)),
       // leading: Image.asset("assets/pngtree-illustration-of-hands-praying-using-tasbih-png-image_8929494.png",height: 20,width: 20,),
        backgroundColor: arabicColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child:
          Text("دعاؤں کا بیان ",
            textAlign: TextAlign.center,

            style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: "Jameelnoorikasheeda"),),
        ),
        // ListTile(
        //   title:
        //   Text("كِتَاب الدَّعَوَاتِ",
        //     textAlign: TextAlign.center,
        //
        //     style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w500,fontFamily: "noorehuda"),),
        //   subtitle:
        //   Text("دعاؤں کا بیانِ",
        //     textAlign: TextAlign.center,
        //
        //     style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500,fontFamily: "Jameelnoorikasheeda"),)
        //
        // )



      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 10,left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0; i < homeDuaModel.length; i++)
                    textField(
                        i == currentIndex
                            ? arabicColor
                            : Colors.grey,
                        homeDuaModel[i].title, () {
                      setState(() {
                        currentIndex = i;
                      });
                    }),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              if(currentIndex==5)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade100,
                        ),
                        child: const Column(
                          children: [
                            Text("كِتَاب الدَّعَوَاتِ",style: TextStyle(color: arabicColor,fontFamily: "noorehuda",
                                fontWeight: FontWeight.w500,fontSize: 20),),
                            Text("دعاؤں کے بیان میں",style: TextStyle(color: black,fontFamily: "Jameelnoorikasheeda",
                                fontWeight: FontWeight.w500,fontSize: 17),),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics:  const NeverScrollableScrollPhysics(),
                              itemCount: bukhariModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                BukhariModel  bukhariModelData =
                                bukhariModel[index];
                                return BukhariData(bukhariModelData.babArab.toString(),bukhariModelData.babUrdu.toString(),
                                bukhariModelData.firstArab.toString(),bukhariModelData.firstUrdu.toString(),
                                bukhariModelData.secArab.toString(),bukhariModelData.secUrdu.toString(),
                                bukhariModelData.thirdArab.toString(),bukhariModelData.thirdUdu.toString());
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                if(currentIndex==4)
                  ComingSoon(MediaQuery.of(context).size.height/1.3, MediaQuery.of(context).size.width),
              if(currentIndex==3)
                ComingSoon(MediaQuery.of(context).size.height/1.3, MediaQuery.of(context).size.width),
              if(currentIndex==2)
                   ComingSoon(MediaQuery.of(context).size.height/1.3, MediaQuery.of(context).size.width),
              if(currentIndex==1)
                     ComingSoon(MediaQuery.of(context).size.height/1.3, MediaQuery.of(context).size.width),
              if(currentIndex==0)
                   ComingSoon(MediaQuery.of(context).size.height/1.3, MediaQuery.of(context).size.width),



            ],
          ),
        ),
      ),
    );
  }
  Widget textField(bcolor, string, onTap) {
    return InkWell(onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 7),
        height: 35,
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: bcolor),
              borderRadius: BorderRadius.circular(10)
        ),
        child:Center(
          child: Text( string,
            textAlign: TextAlign.center,

            style: TextStyle(color: bcolor,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "Jameelnoori"),),
        ) ,
      ),
    );


  }


}


