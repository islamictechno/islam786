import 'package:flutter/material.dart';
class AyaOfDay{
  final String? arText;
  final String? enText;
  final String? surahEnName;
  final int? surNum;
  final String? arText2;
  final String? enText2;
  final String? surahEnName2;
  final int? surNum2;
  const AyaOfDay({this.arText2,this.surahEnName2,this.enText2,this.surNum2,this.arText,this.enText,this.surahEnName,this.surNum});
  factory AyaOfDay.fromJSON(Map<String,dynamic> json){
    return AyaOfDay(
      arText: json['data'][0]['text'],
      enText: json['data'][2]['text'],
      surahEnName: json['data'][2]['surah']['englishName'],
      surNum: json['data'][2]['numberInSurah'],
      arText2: json['data'][2]['text'],
      enText2: json['data'][1]['text'],
      surahEnName2: json['data'][1]['surah']['englishName'],
      surNum2: json['data'][1]['numberInSurah'],

    );
  }
}
