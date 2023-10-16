import 'package:flutter/material.dart';
import '../../Constants.dart';
import '../models/juz.dart';

class JuzCustomTile extends StatelessWidget {
  final List<JuzAyahs> list;
  final int index;

  JuzCustomTile({required this.list,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: buttonColor.withOpacity(0.1)
            ),
            child: Column(

              children: [
                SelectableText(
                  list[index].ayahNumber.toString(),
                  style: TextStyle(color: arabicColor,fontWeight: FontWeight.bold),
                ),
                SelectableText(
                  list[index].ayahsText,
                  style: TextStyle(fontFamily: "Noorehira",fontSize: 16,color: arabicColor),
                  textAlign: TextAlign.end,
                ),
                SelectableText(

                  list[index].surahName,
                  textAlign: TextAlign.end,style: TextStyle(color: arabicColor),
                  cursorColor: arabicColor,

                ),

              ],
            ),
          ),
         
        ],
      ),
    );
  }
}
