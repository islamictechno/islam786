import 'package:flutter/material.dart';
import 'package:islamm786/Constants.dart';

import 'package:islamm786/extra/widgets/custom_translation.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';


import 'api_services.dart';
import 'constants/constants.dart';
import 'models/translation.dart';



enum Translation { hindi,english, spanish,urdu }

class Surahdetail extends StatefulWidget {
  const Surahdetail({Key? key}) : super(key: key);

  static const String id = 'surahDetail_screen';

  @override
  _SurahdetailState createState() => _SurahdetailState();
}

class _SurahdetailState extends State<Surahdetail> {

  ApiServices _apiServices = ApiServices();
  //SolidController _controller = SolidController();
  Translation? _translation = Translation.urdu;


  @override
  Widget build(BuildContext context) {
    print(_translation!.index);

    return Scaffold(
      
      body: SafeArea(
        child: FutureBuilder(
          future: _apiServices.getTranslation(Constants.surahIndex!,_translation!.index),
          builder: (BuildContext context, AsyncSnapshot<SurahTranslationList> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.hasData){
              return Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ListView.builder(
                  itemCount: snapshot.data!.translationList.length,
                  itemBuilder: (context,index){
                    return TranslationTile(index: index,
                        surahTranslation: snapshot.data!.translationList[index],
                    );
                  },
                ),
              );
            }
            else return Center(child: Text('Translation Not found'),);
          },
        ),
      ),
      // bottomSheet:
      // SolidBottomSheet(
      //   toggleVisibilityOnTap: true,
      //   headerBar: Container(
      //     color: arabicColor,
      //     height: 50,
      //     child: const Center(
      //       child: Text("Swipe me!",style: TextStyle(color: Colors.white),),
      //     ),
      //   ),
      //   body: Container(
      //     color: Colors.white,
      //     height: 350,
      //     child: SingleChildScrollView(
      //       child: Center(
      //         child: Column(
      //           children: <Widget>[
      //
      //             ListTile(
      //               title: const Text('Hindi'),
      //               leading: Radio<Translation>(
      //                 activeColor: arabicColor,
      //                 value: Translation.hindi,
      //                 groupValue: _translation,
      //                 onChanged: (Translation? value) {
      //                   setState(() {
      //                     _translation = value;
      //                   });
      //                 },
      //               ),
      //             ),
      //             ListTile(
      //               title: const Text('English'),
      //               leading: Radio<Translation>(
      //                 activeColor: arabicColor,
      //                 value: Translation.english,
      //                 groupValue: _translation,
      //                 onChanged: (Translation? value) {
      //                   setState(() {
      //                     _translation = value;
      //                   });
      //                 },
      //               ),
      //             ),
      //             ListTile(
      //               title: const Text('Spanish'),
      //               leading: Radio<Translation>(
      //                 activeColor: arabicColor,
      //                 value: Translation.spanish,
      //                 groupValue: _translation,
      //                 onChanged: (Translation? value) {
      //                   setState(() {
      //                     _translation = value;
      //                   });
      //                 },
      //               ),
      //             ),
      //             ListTile(
      //               title: const Text('Urdu'),
      //               leading: Radio<Translation>(
      //                 activeColor: arabicColor,
      //                 value: Translation.urdu,
      //                 groupValue: _translation,
      //                 onChanged: (Translation? value) {
      //                   setState(() {
      //                     _translation = value;
      //                   });
      //                 },
      //               ),
      //             ),
      //
      //           ],
      //         )
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
