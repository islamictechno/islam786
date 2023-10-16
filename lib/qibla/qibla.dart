import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:get/get.dart';
import 'package:islamm786/qibla/qibla_compus.dart';

import '../Constants.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  static const imageBackgroundLight = "assets/blight.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: arabicColor,
        elevation: 0.3,
        title: Text("Qibla Direction", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onTap: (){
           Get.back();
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(arabicColor.withOpacity(0.3), BlendMode.dstATop),
              image: AssetImage(imageBackgroundLight,),
              // opacity: 0.4,
              fit: BoxFit.cover),
        ),
        child: FutureBuilder(
          future: _deviceSupport,
          builder: (_, AsyncSnapshot<bool?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error.toString()}"),
              );
            }

            if (snapshot.data!) {
              return const QiblahCompass();
            } else {
              return const Center(child: Text("UnExpected Error!!"));
            }
          },
        ),
      ),
    );
  }
}
