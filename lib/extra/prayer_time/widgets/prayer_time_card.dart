import 'dart:developer';


import 'package:adhan/adhan.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/extra/alaram/app/data/theme_data.dart';

import 'package:unicons/unicons.dart';

import '../controllers/prayer_time_controller.dart';
import 'app_card.dart';

class PrayerTimeCard extends StatelessWidget {
  const PrayerTimeCard({Key? key, required this.prayerTimeC}) : super(key: key);
  final PrayerTimeControllerImpl prayerTimeC;

  @override
  Widget build(BuildContext context) {
    return Material(
      //color: buttonColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(25),
      child: Obx(() {
        var prayer = prayerTimeC.nextPrayer.value;
        var time = prayerTimeC.prayerTimesToday;
        var address = prayerTimeC.currentAddress;
        int? nextH, nextM;
        var leftOver = 0;
        var duration = 0;
        int initDuration = 0;

        switch (prayer) {
          case Prayer.fajr:
            nextH = time.value.shubuh?.hour;
            nextM = time.value.shubuh?.minute;
            leftOver = time.value.shubuh!.difference(DateTime.now()).inSeconds;
            duration = time.value.lastThirdOfTheNight!
                .difference(time.value.shubuh!)
                .inSeconds;
            break;
          case Prayer.dhuhr:
            nextH = time.value.dhuhur?.hour;
            nextM = time.value.dhuhur?.minute;
            leftOver = time.value.dhuhur!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.sunrise!.difference(time.value.dhuhur!).inSeconds;

            break;
          case Prayer.asr:
            nextH = time.value.ashar?.hour;
            nextM = time.value.ashar?.minute;
            leftOver = time.value.ashar!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.dhuhur!.difference(time.value.ashar!).inSeconds;

            break;
          case Prayer.maghrib:
            nextH = time.value.maghrib?.hour;
            nextM = time.value.maghrib?.minute;
            leftOver = time.value.maghrib!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.ashar!.difference(time.value.maghrib!).inSeconds;

            break;
          case Prayer.isha:
            nextH = time.value.isya?.hour;
            nextM = time.value.isya?.minute;
            leftOver = time.value.isya!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.maghrib!.difference(time.value.isya!).inSeconds;

            break;
          case Prayer.sunrise:
            nextH = time.value.sunrise?.hour;
            nextM = time.value.sunrise?.minute;
            leftOver = time.value.sunrise!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.shubuh!.difference(time.value.sunrise!).inSeconds;

            break;
          case Prayer.none:
            nextH = time.value.lastThirdOfTheNight?.hour;
            nextM = time.value.lastThirdOfTheNight?.minute;
            if (time.value.lastThirdOfTheNight != null) {
              leftOver = time.value.lastThirdOfTheNight!
                  .difference(DateTime.now())
                  .inSeconds;
              duration = time.value.isya!
                  .difference(time.value.lastThirdOfTheNight!)
                  .inSeconds;
            }
            break;
          default:
        }

        if (prayerTimeC.leftOver.value == 0) {
          prayerTimeC.leftOver.value = leftOver;
        }

        // convert negative value to positive
        if (duration.isNegative) duration = duration * -1;

        if (initDuration < duration) {
          initDuration = duration - (leftOver - 0);
        }

        if (initDuration > duration) initDuration = duration;

        if (initDuration == duration) {
          initDuration = duration - leftOver;
        }

        log("Duration: $duration $prayer");
        log("LeftOver Value: ${prayerTimeC.leftOver.value}");
        log("InitDuration: $initDuration");

        String hour = nextH != null ? nextH.toString().padLeft(2, '0') : "--";
        String minute = nextM != null ? nextM.toString().padLeft(2, '0') : "--";

        return Container(
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [

                arabicColor,
                 arabicColor,
                Color(0xff4F1C74),
                Color(0xff5b2886),
                Color(0xff5A2A91),
                Color(0xff8650Bd),
                Color(0xff8a51d1),
                 Color(0xff9662d6),
                 Color(0xff9662d6),
                 // Color(0xffd0b9ed),
                 // Color(0xffe8dcf6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
            // boxShadow: [
            //
            //   BoxShadow(
            //     color: arabicColor,
            //     blurRadius: 1,
            //     spreadRadius: 2,
            //     offset: Offset(1, 1),
            //   ),
            // ],
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          // height: 100,
          padding: EdgeInsets.all(15),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  // // mainAxisAlignment: MainAxisAlignment.spaceAround,
                   //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Time: ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Uthmani",
                                fontWeight: FontWeight.bold),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: Text(
                              "$hour:$minute",style:
                            TextStyle(
                                fontSize: 15,
                                fontFamily: "Uthmani",
                                color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Text.rich(
                        TextSpan(

                          text: (nextH != null &&
                                  prayerTimeC.nextPrayer.value.name == "none")
                              ? "Qiyam"
                              : (nextH == null)
                                  ? ""
                                  : prayerTimeC
                                      .nextPrayer.value.name.capitalizeFirst,

                         style: TextStyle(
                          
                           height: 1,
                              fontSize: 15,
                              fontFamily: "Uthmani",
                              color: Colors.white,fontWeight: FontWeight.w500,),

                          children: [
                            const TextSpan(text: " - "),
                            TextSpan(
                              text: address.isBlank! ? "" : address.value.country,
                            ),
                          ],
                        ),
                      ),
                    ),
                     const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //  Icon(
                        //   Icons.location_on,
                        //   size: 30,
                        //   color: Colors.red.shade400,
                        // ),
                        // const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   address.value.street ?? "--",
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                            Text(
                              address.value.locality ?? "--",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CircularCountDownTimer(
                  textStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  width: MediaQuery.of(context).size.width * 0.22,
                  height: MediaQuery.of(context).size.width * 0.22,
                  duration: duration,
                  initialDuration: initDuration,
                  controller: prayerTimeC.cT,
                  fillColor: Colors.white,
                  backgroundColor:
                      buttonColor.withOpacity(0.8),
                  ringColor:  buttonColor.withOpacity(0.6),
                  // strokeWidth: 20.0,
                  strokeCap: StrokeCap.round,

                  isReverse: true,
                  onComplete: () async {
                    prayerTimeC.leftOver.value = 0;
                    log("--- Now is ${prayerTimeC.nextPrayer} time ---");

                    await Future.delayed(2.seconds);

                    // to Next Prayer
                    prayerTimeC.getLocation().then((_) {
                      prayerTimeC.cT
                          .restart(duration: prayerTimeC.leftOver.value);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
