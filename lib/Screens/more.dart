import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Screens/qibla_direction.dart';
import 'package:islamm786/qibla/qibla.dart';
import 'package:islamm786/qibla/qibla_compus.dart';
import 'package:url_launcher/url_launcher.dart';


import '../Constants.dart';
import '../extra/prayer_time/controllers/prayer_time_controller.dart';
import '../extra/prayer_time/views/prayer_time_page.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  var image1="assets/morning.jpg";
  var image2="assets/eve.jpg";
  var image3="assets/night.jpg";
  var image;
  _launchWhatsapp(context) async {
    var whatsapp = "+923044747104";
    var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
  getImage(){
    var hour=DateTime.now().hour;
    if(hour<12){
      image=image1;

    }else if(hour<17){
      image=image2;
    }else {
      image=image3;
    }
    print(image);
    return image;
  }
  var _todayEnglish = DateTime.now();
  var duration = 0;
  int initDuration = 0;
  HijriCalendar _today = HijriCalendar.now();
  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  GlobalKey<ScaffoldState>_globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;

    final myCoordinates = Coordinates(31.430396637646854,74.2845230327133); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);    print(_today.hDay);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Obx((){
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
        return Stack(
          children: [
            SafeArea(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    child: Stack(
                      children: [
                        Container(
                          height: displayHeight*0.28,
                          decoration:  BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(getImage())
                            ),
                          ),
                          child: Container(

                            color: const Color(0xff3A1660).withOpacity(0.40),
                            child: Column(
                              children:[
                                Row(
                                  children:[
                                    IconButton(
                                      icon: const Icon(Icons.menu),
                                      onPressed: () {
                                        _globalKey.currentState!.openDrawer();
                                      },
                                      color: whiteColor,
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon:  Icon(Icons.whatshot),
                                          onPressed: () {
                                            _launchWhatsapp(context);


                                          },
                                          color: whiteColor,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: () {
                                            // Navigator.push(context,
                                            //     MaterialPageRoute(builder: (context)=> PrayerTimePage()));
                                          },
                                          color: whiteColor,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.notifications),
                                          onPressed:   () => Get.to(
                                            PrayerTimePage(),),
                                          color: whiteColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: displayHeight*0.012,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text("Now",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 15,fontFamily: "Lato",letterSpacing: 1.0),),
                                          SizedBox(height: 5.0,),
                                          Text("${prayerTimes.currentPrayer().name.toUpperCase()}",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500, fontSize: 19,fontFamily: "Lato",letterSpacing: 1.0),),
                                          const Text("upcoming",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 15,fontFamily: "Lato",letterSpacing: 1.0),),
                                          SizedBox(height: 5.0,),
                                          Text((prayerTimes.currentPrayer().name=="isha")?"FAJR":(prayerTimes.currentPrayer().name=="fajr")?"DHUHR":(prayerTimes.currentPrayer().name=="dhuhr")?"ASR":(prayerTimes.currentPrayer().name=="asr")?"MAGHRIB":(prayerTimes.currentPrayer().name=="maghrib")?"ISHA":prayerTimes.nextPrayer().name.toUpperCase(),style: TextStyle(color: whiteColor, fontWeight: FontWeight.w500, fontSize: 19,fontFamily: "Lato",letterSpacing: 1.0),),
                                          Text((prayerTimes.currentPrayer().name=="isha")?"${DateFormat.jm().format(prayerTimes.fajr)}":(prayerTimes.currentPrayer().name=="fajr")?"${DateFormat.jm().format(prayerTimes.dhuhr)}":(prayerTimes.currentPrayer().name=="dhuhr")?"${DateFormat.jm().format(prayerTimes.asr)}":(prayerTimes.currentPrayer().name=="asr")?"${DateFormat.jm().format(prayerTimes.maghrib)}":(prayerTimes.currentPrayer().name=="maghrib")?"${DateFormat.jm().format(prayerTimes.isha)}":"${DateFormat.jm().format(prayerTimes.fajr)}",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 15,fontFamily: "Lato",letterSpacing: 1.0),),

                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,

                                        children: [
                                          Image.asset('assets/icons/moon-outlined_1.png',height: 25,color: Colors.white,),
                                          SizedBox(height: 5,),
                                          Text("${_today.hDay}",
                                            style: TextStyle(color: whiteColor, fontWeight:
                                            FontWeight.w700, fontSize: 23,fontFamily: "Lato",letterSpacing: 1.0),),
                                          Text("${_today.longMonthName}, ${_today.hYear}",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 15,fontFamily: "Lato",letterSpacing: 1.0),),
                                          SizedBox(height: 5.0,),
                                          Text("${DateFormat('EEEE, d MMM, yyyy').format
                                            (_todayEnglish)}",style: TextStyle(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 15,fontFamily: "Lato",letterSpacing: 1.0),),



                                        ],
                                      )



                                    ],
                                  ),
                                ),
                                const Text(
                                  "",
                                  // style: TextStyle(fontSize: 10, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 40,),
                          child: Row(
                            children: [
                              GestureDetector(
                                child: Column(
                                  children: [
                                    SvgPicture.asset("assets/icons/QiblahDirection.svg",width: 100, height: 100,),
                                    SizedBox(
                                      height: displayHeight * 0.02,
                                    ),
                                    const Text("Qiblah Direction")
                                  ],
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const QiblaScreen()));
                                },
                              ),
                              SizedBox(
                                width: displayWidth * 0.1,
                              ),
                              GestureDetector(
                                child: Column(
                                  children: [
                                    SvgPicture.asset("assets/icons/Live.svg",width: 100, height: 100,),
                                    SizedBox(
                                      height: displayHeight * 0.02,
                                    ),
                                    const Text("Live")
                                  ],
                                ),
                                onTap: (){
                                  _launchWhatsapp(context);
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context) => Tasbee()));
                                },
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );}
      ),
    );
  }
}
_launchWhatsapp(context) async {
  var whatsapp = "+923045653887";
  var whatsappAndroid = Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
  if (await canLaunchUrl(whatsappAndroid)) {
    await launchUrl(whatsappAndroid);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("WhatsApp is not installed on the device"),
      ),
    );
  }
}