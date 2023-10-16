import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
class AwardScreen extends StatefulWidget {


  @override
  State<AwardScreen> createState() => _AwardScreenState();
}

class _AwardScreenState extends State<AwardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: arabicColor,
            leading: InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
            title: Text("Award",style: TextStyle(color: Colors.white,fontSize: 18),),
            centerTitle: true,
          )),
      body:Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: new DecorationImage(
               opacity: .25,
              image: new AssetImage("assets/check.png"),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: BoxDecoration(
                color: arabicColor,
                  image: new DecorationImage(
                    image: new AssetImage("assets/tahreer_page-0001.jpg"),
                    fit: BoxFit.fill,
                  )
              ),
            ),
          ],
        ),
      ),

    );
  }
}
