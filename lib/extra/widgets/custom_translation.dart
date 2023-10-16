import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/app_utils/text_utils.dart';

import '../constants/constants.dart';
import '../models/translation.dart';

class TranslationTile extends StatelessWidget {
  final int index;
  final SurahTranslation surahTranslation;

  TranslationTile({required this.index,required this.surahTranslation});
  TextUtils _textUtils =TextUtils();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              blurRadius: 1
            ),
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                     color: buttonColor.withOpacity(0.1),
                    //color: Color(0xffA5D2D6),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                  ),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                ),
                Positioned(
                  top: .5,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: arabicColor
                    ),
                    child:
                    Center(
                      child: SelectableText(
                        surahTranslation.aya!,
                        style: TextStyle(color: Colors.white,fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                  ),
                ),
                Positioned(
                  top: 3,
                  right: 8,
                  child: InkWell(
                    onTap:(){
                      Fluttertoast.showToast(
                          msg: "Coming Soon",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.purple.shade900,
                          fontSize: 16.0
                      );
                    },
                    child: Container(
                      height:22,
                      width: 50,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: arabicColor)
                      ),
                      child: Center(child: _textUtils.normal("Tafseer", arabicColor, 10.0, TextAlign.center)),
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 64,
                  child: InkWell(
                    onTap:(){
                      Fluttertoast.showToast(
                          msg: "Coming Soon",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.purple.shade900,
                          fontSize: 16.0
                      );
                    },
                    child: Container(
                      height:22,
                      width: 50,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: arabicColor)
                      ),
                      child: Center(child: _textUtils.normal("Translation", arabicColor, 8.0, TextAlign.center)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  SizedBox(
                    width: double.infinity,
                    child:
                    SelectableText(
                      surahTranslation.arabic_text!,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontFamily: "Noorehira",
                          color: arabicColor,
                          fontSize: 20),
                    ),

                  ),
                  SizedBox(
                    width: double.infinity,
                    child:
                    SelectableText(
                      surahTranslation.translation!,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: arabicColor, fontSize: 18),
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
