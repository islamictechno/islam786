

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

BukhariData(babArab,babUrdu,firstArab,firstUrdu,secArab,secUrdu,thirdArab,thirdUrdu) {
  return Column(
    children: [
      Container(

        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade300,

        ),
        child: Column(
          children: [
            Text(babArab,textAlign:TextAlign.center,style: const TextStyle(color: arabicColor,fontFamily: "noorehuda",
                fontWeight: FontWeight.w500,fontSize: 20),),
            Text(babUrdu,
              textAlign:TextAlign.center,style: const TextStyle(color: black,fontFamily: "Jameelnoorikasheeda",
                fontWeight: FontWeight.w500,fontSize: 17),),
          ],
        ),
      ),
      const SizedBox(height: 10,),
      Text(firstArab,
        textAlign:TextAlign.center,style: const TextStyle(color: arabicColor,fontFamily: "noorehuda",
          fontWeight: FontWeight.w500,fontSize: 19),),
      Text(firstUrdu,
        textAlign:TextAlign.center,style: const TextStyle(color: black,fontFamily: "Jameelnoori",
          fontWeight: FontWeight.w500,fontSize: 19),),
      const SizedBox(height: 10,),
      Text(secArab,
        textAlign:TextAlign.center,
        style: const TextStyle(color: arabicColor,fontFamily: "noorehuda",
          fontWeight: FontWeight.w500,fontSize: 19),),
      Text(secUrdu,
        textAlign:TextAlign.center,style: const TextStyle(color: black,fontFamily: "Jameelnoori",
          fontWeight: FontWeight.w500,fontSize: 19),),

      Text(thirdArab,
        textAlign:TextAlign.center,style: const TextStyle(color: arabicColor,fontFamily: "noorehuda",
          fontWeight: FontWeight.w500,fontSize: 19),),
      Text(thirdUrdu,
        textAlign:TextAlign.center,style: const TextStyle(color: black,fontFamily: "Jameelnoori",
          fontWeight: FontWeight.w500,fontSize: 19),),
      const SizedBox(height: 40,),
    ],
  );
}