import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../models/surah.dart';

Widget SurahCustomListTile({
     required Surah surah ,
     required BuildContext context ,
     required VoidCallback ontap})
{
  return GestureDetector(
     onTap: ontap,
     child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 35,
                width: 40,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: buttonColor.withOpacity(0.1)
                ),
                child: Center(
                  child: Text((surah.number).toString(),
                    style: TextStyle(color:arabicColor ,fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    surah.englishName!,
                    style: TextStyle(color:arabicColor,fontWeight: FontWeight.bold),
                  ),
                  SelectableText(
                    surah.englishNameTranslation!,
                    style: TextStyle( color:arabicColor,fontFamily: "AlQalamQuran", ),
                  ),

                ],
              ),
              Spacer(),
              Text(surah.name!,style: TextStyle(color:arabicColor,
                  fontSize: 20,fontFamily: "Noorehira",),),
            ],
          ),
        ],
      ),
    ),
  );
}


