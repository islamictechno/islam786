
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';
Widget AllahNames(){
  Widget listAllahEng(){
    final listArb=[
      'ٱلْرَّحِيْمُ',
      'ٱلْرَّحْمَـانُ',

    ];
    final listEng=[
      'The Bestower of Mercy',
      'The Most or Entirely Merciful',

    ];
    var elementArb = listArb.first;
    var elementEng = listEng.first;


    var hour=DateTime.now().hour;

    if (hour < 24) {
      return  Column(

        children: [

          SelectableText(
            elementArb,
            textAlign: TextAlign.center,

            style: TextStyle(color: arabicColor, fontSize: 20, fontWeight: FontWeight.w500,
                fontFamily: "Noorehira", overflow: TextOverflow.ellipsis),
          ),
          SelectableText(
            elementEng,
            textAlign: TextAlign.justify,
            maxLines: 3,
            style: TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.w500,
                fontFamily: "AlQalamQuran", overflow: TextOverflow.ellipsis),
          ),



        ],
      );


    }
    return Column(
      children: [
        Text(elementEng),
        Text(elementArb),
      ],
    );
  }
  return Container(
    width:  330,
    height: 230,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10,bottom: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Name of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),

                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 20,color: arabicColor),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Share",style: TextStyle(color: arabicColor, fontSize: 14, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          listAllahEng()



        ],
      ),
    ),
  );
}
Widget Hadith(){

  Widget hadithEng() {

    var listEng = [
      'Beware of suspicion for it is the most untruthful type of speech',
      'A slave [of Allah] may utter a word without giving it much thought by which he slips into the fire a distance further than that between east and west.',
      'Allah becomes jealous [of His honor] and that is when the believer does something He has forbidden.',
      'One Umrah to the next is an expiation for whatever happened between them and the only reward for an accepted Hajj is paradise.',
      'Yawning is from the devil so whenever one of you yawns, then let him try to suppress it as much as possible.',
      'No fatigue, illness, worry, sorrow, harm, grief, or even the prick of a thorn afflicts a Muslim except that Allah expiates some of his sins by it.',
      'The Prophet (ﷺ) would never find fault with food. If he desired it, he would eat. If he disliked it, he would leave it.',
      'The fire is surrounded by [unlawful] desires and paradise by difficulties.',
      'If you said to your companion on Friday [during Jumu’ah prayer], “Listen!”, while the imaam is giving the sermon, then you’ve erred [by engaging in idle talk].',
      'If I did not fear difficulty for my nation, then I would have commanded them to use the siwaak before every prayer.',
      'The Prophet (ﷺ) saw a man who did not wash his heel [during ablution], so he (ﷺ) said, “Save the heels from the fire!”',
      'Isn’t the one who raises his head before the imaam [during prayer] afraid that Allah may change his head to that of a donkey?',
      'Whenever someone goes to the mosque in the morning or evening, Allah prepares for him a place in paradise.',

    ];
    final listarb = [
      'إِيَّاكُمْ وَالظَّنَّ, فَإِنَّ اَلظَّنَّ أَكْذَبُ اَلْحَدِيثِ',
      'إِنَّ الْعَبْدَ لَيَتَكَلَّمُ بِالْكَلِمَةِ مَا يَتَبَيَّنُ فِيهَا، يَزِلُّ بِهَا فِي النَّارِ أَبْعَدَ مِمَّا بَيْنَ الْمَشْرِقِ وَ الْمَغْرِبِ',
      'إِنَّ اللَّهَ يَغَارُ وَغَيْرَةُ اللهِ أَنْ يَأْتِيَ الْمُؤْمِنُ مَا حَرَّمَ اللهُ',
      'الْعُمْرَةُ إِلَى الْعُمْرَةِ كَفَّارَةٌ لِمَا بَيْنَهُمَا وَالْحَجُّ الْمَبْرُورُ لَيْسَ لَهُ جَزاءٌ إِلا الجنَّةُ',
      'التَّثَاؤُبُ مِنَ الشَّيْطَانِ فَإِذَا تَثَاءَبَ أَحَدُكُمْ فَلْيَكْظِمْ مَا اسْتَطَاعَ',
      'مَا يُصِيبُ الْمُسْلِمَ مِنْ نَصَبٍ وَلاَ وَصَبٍ وَلاَ هَمٍّ وَلاَ حُزْنٍ وَلاَ أَذًى وَلاَ غَمٍّ حَتَّى الشَّوْكَةِ يُشَاكُهَا، إِلاَّ كَفَّرَ اللَّهُ بِهَا مِنْ خَطَايَاهُ',
      'مَا عَابَ النَّبِيُّ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ طَعَامًا قَطُّ إِنِ اشْتَهَاهُ أَكَلَهُ وَإِنْ كَرِهَهُ تَرَكَهُ',
      'حُجِبَتِ النَّارُ بِالشَّهَوَاتِ، وَحُجِبَتِ الْجَنَّةُ بِالْمَكَارِهِ',
      'إِذَا قُلْتَ لِصَاحِبِكَ أَنْصِتْ وَالإِمَامُ يَخْطُبُ فَقَدْ لَغَوْتَ',
      'لَوْلاَ أَنْ أَشُقَّ عَلَى أُمَّتِي لأَمَرْتُهُمْ بِالسِّوَاكِ عِنْدَ كُلِّ صَلاَةٍ',
      'النَّبِي صلى الله عليه وسلم رَأَى رَجُلاً لَمْ يَغْسِلْ عَقِبَيْهِ فَقَالَ:“وَيْلٌ لِلأَعْقَابِ مِنَ النَّارِ',
          'أَمَا يَخْشَى الَّذِي يَرْفَعُ رَأْسَهُ قَبْلَ الإِمَامِ أَنْ يُحَوِّلَ اللهُ رَأْسَهُ رَأْسَ حِمَارٍ',
      'مَنْ غَدَا إِلَى الْمَسْجِدِ أَوْ رَاحَ أَعَدَّ اللهُ لَهُ فِي الْجَنَّةِ نُزُلاً كُلَّمَا غَدَا أَوْ رَاحَ',
    ];
    random(min,max){
      var rn=new Random();
      return min+rn.nextInt(max-min);
    }

    var elementEng = listEng.first;
    var elementarb = listarb.first;

    var hour=DateTime.now().hour;

    if (hour < 24) {
      return  Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            elementarb,
            textAlign: TextAlign.center,
            style: const TextStyle(color: arabicColor, fontSize: 20, fontWeight: FontWeight.w500,
                fontFamily: "Noorehira", overflow: TextOverflow.ellipsis),
          ),
          SelectableText(
            elementEng,
            textAlign: TextAlign.justify,
            maxLines: 3,
            style: const TextStyle(color: blackColor, fontSize: 13, fontWeight: FontWeight.w500,
                fontFamily: "AlQalamQuran", overflow: TextOverflow.ellipsis),
          ),
        ],
      );
    }

    return Column(
      children: [
        Text(elementEng),
        Text(elementarb),
      ],
    );
  }

  return Container(
    margin: EdgeInsets.only(left: 4.0,right: 4.0),
    width: 330,
    height: 240,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: buttonColor.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 0.5,
          // offset: Offset(0, 0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10,bottom: 14.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/verse.svg",height:25,),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("Hadith of the Day",style: TextStyle(color: arabicTextColor, fontSize: 16, fontFamily: "Lato", fontWeight: FontWeight.w500),),
                      Text("Bukhari Muslim",style:
                      TextStyle(color: greenColor, fontSize: 13,
                          fontFamily: "Lato", fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset("assets/icons/share.svg",width: 20,color: arabicColor),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Share",style: TextStyle(color: arabicColor, fontSize: 14, fontFamily: "Noorehira", fontWeight: FontWeight.w400),),
                ],
              ),
            ],
          ),
          SizedBox(width: 10,),
          hadithEng(),

        ],
      ),
    ),
  );
}