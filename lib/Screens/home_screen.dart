import 'dart:developer';
import 'package:google_mobile_ads/google_mobile_ads.dart';


import 'package:adhan/adhan.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/Models/aya_model.dart';
import 'package:islamm786/Screens/allah_name.dart';
import 'package:islamm786/Screens/developerinfo.dart';

import 'package:islamm786/Screens/muhammad_name.dart';
import 'package:islamm786/Screens/tasbee_counter.dart';
import 'package:islamm786/Services/NameOfTheDayScreen.dart';
import 'package:islamm786/Services/api_service.dart';
import 'package:islamm786/Services/nameofDay.dart';
import 'package:islamm786/Services/text.dart';
import 'package:islamm786/app_utils/common.dart';
import 'package:islamm786/drawer_screen/about_us.dart';

import 'package:islamm786/extra/prayer_time/views/prayer_time_page.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Services/AdHelper.dart';
import '../extra/prayer_time/controllers/prayer_time_controller.dart';

import '../qibla/qibla.dart';
import 'dua_screen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannerAd _BannerAd;
  late InterstitialAd _interstialAd;
  bool _isInterstitialAdReady = false;
  bool _isBannerAdReady = false;

  @override
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _BannerAd.dispose();
    // _interstialAd.dispose();
  }

  @override
  void initState() {
    _BannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(
            onAdLoaded: (_) {
              setState(() {
                _isBannerAdReady = true;
              });
            },
            onAdFailedToLoad: (ad, error) {
              print('Failed to Load Ad${error.message}');
              _isBannerAdReady = false;
              ad.dispose();
            }
        ),
        request: AdRequest())
      ..load();
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (ad) {
              this._interstialAd = ad;
              _isInterstitialAdReady = true;
            },
            onAdFailedToLoad: (error) {
              print('Failed to Load Interstitial Ad ${error.message}');
            }));
    Permission.location.request();
    Permission.reminders.request();
    Permission.notification.request();
    getHomeData();
    getAya();
    super.initState();
  }


  var duration = 0;
  int initDuration = 0;
  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  ApiService apiService = ApiService();
  AyaOfDay? data = null;

  Future<void> share(title, link) async {
    await FlutterShare.share(
      title: '$title',
      text: 'Please read it.',
      linkUrl: '$link',
    );
  }

  var hadis;

  var dua;

  var flash;

  void getHomeData() async {
    FirebaseFirestore.instance.collection("Hadis").get().then((value) {
      print(value.docs[0]['link']);
      hadis = value.docs[0]['link'];
    });

    FirebaseFirestore.instance.collection("Dua").get().then((value) {
      print(value.docs[0]['link']);
      dua = value.docs[0]['link'];
    });

    FirebaseFirestore.instance.collection("Flashes").get().then((value) {
      print(value.docs[0]['link']);
      flash = value.docs[0]['link'];
    });
  }

  var live = 'verse';
  var image1 = "assets/morning.jpg";
  var image2 = "assets/eve.jpg";
  var image3 = "assets/night.jpg";
  String? _currentAddress;
  Position? _currentPosition;

  var image;
  var loader = true;

  void getAya() async {
    await apiService.getAya().then((value) => data = value);
    loader = false;
    setState(() {

    });
  }


  HijriCalendar _today = HijriCalendar.now();
  var _todayEnglish = DateTime.now();

  _launchWhatsapp(context) async {
    var whatsapp = "+923044747104";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=hello");
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


// generates a new Random object


  getImage() {
    var hour = DateTime
        .now()
        .hour;

    if (hour < 12) {
      image = image1;
    } else if (hour < 17) {
      image = image2;
    } else {
      image = image3;
    }
    print(image);
    return image;
  }


// generate a random index based on the list length
// and use it to retrieve the element

  GlobalKey<ScaffoldState>_globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery
        .of(context)
        .size
        .width;
    var displayHeight = MediaQuery
        .of(context)
        .size
        .height;
    final myCoordinates = Coordinates(31.430396637646854,
        74.2845230327133); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    print(_today.hDay);

    return Scaffold(
      drawer: Drawer(
        width: 250,

        child: Column(
          children: [
            Container(
                height: 200,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(getImage())

                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/islam786.png', height: 70,),
                  ],
                )
            ),
            Container(
                height: 600,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration:  const BoxDecoration(

                  image: DecorationImage(
                    opacity: 0.25,
                    // colorFilter:
                    // ColorFilter.mode(Colors.white.withOpacity(0.2),
                    //     BlendMode.dstATop),
                    image: AssetImage(
                      "assets/check.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14,),
                      drawer((){
                        Get.to(()=>AboutUsScreen());
                      }, Icons.privacy_tip_outlined, "About us"),
                      // const SizedBox(height: 9,),
                      // drawer((){}, Icons.person, "Contact Us"),
                      const SizedBox(height: 9,),
                      drawer((){}, Icons.settings, "Setting"),
                      const SizedBox(height: 9,),
                      drawer((){}, Icons.card_membership, "Award"),
                      const SizedBox(height: 9,),
                      drawer((){}, Icons.feedback, "Feedback"),
                      const SizedBox(height: 9,),
                      drawer((){
                        _launchURLPrivacy();
                      }, Icons.privacy_tip, "Privacy Polcy"),
                      const SizedBox(height: 9,),
                      drawer((){
                        rateusUrl();
                      }, Icons.star_rate_rounded, "Rate Us"),
                      const SizedBox(height: 9,),
                      drawer((){
                        sharePress();
                      }

                          , Icons.share, "Share Islam786"),
                      const SizedBox(height: 10,),
                      //
                      // // const SizedBox(
                      // //   height:30,
                      // //   child: ListTile(
                      // //     minVerticalPadding: -10,
                      // //     leading: Icon(Icons.privacy_tip_outlined, color: arabicColor,),
                      // //     title: Text('About us',
                      // //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      // //   ),
                      // // ),
                      // SizedBox(height: 7,),
                      // const Divider(),
                      // const SizedBox(height: 9,),
                      // Row(
                      //
                      //   children: [
                      //
                      //     Expanded(
                      //         flex:2,
                      //         child: Icon(Icons.person, color: arabicColor,)),
                      //     Expanded(
                      //       flex: 8,
                      //       child: Text('Contact Us',
                      //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      //     ),
                      //   ],
                      // ),
                      // //  Container(
                      // //   height:20,
                      // //   child: ListTile(
                      // //     minVerticalPadding: 0,
                      // //     leading: Icon(Icons.person, color: arabicColor,),
                      // //     title: Text('Contact Us',
                      // //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      // //   ),
                      // // ),
                      // SizedBox(height: 7,),
                      // const Divider(),
                      // const SizedBox(height: 9,),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         flex:2,
                      //         child: Icon(Icons.person, color: arabicColor,)),
                      //     Expanded(
                      //       flex: 8,
                      //       child: Text('Contact Us',
                      //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height:25,
                      //   child: ListTile(
                      //     minVerticalPadding: 0,
                      //     leading: Icon(Icons.settings, color: arabicColor,),
                      //     title: Text('Setting',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // const Divider(),
                      //
                      // SizedBox(
                      //   height:25,
                      //   child: ListTile(
                      //     minVerticalPadding: 0,
                      //     leading: Icon(Icons.card_membership, color: arabicColor,),
                      //     title: Text('Award',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // const Divider(),
                      // SizedBox(
                      //   height:25,
                      //   child: const ListTile(
                      //     minVerticalPadding: 0,
                      //     leading: Icon(Icons.feedback, color: arabicColor,),
                      //     title: Text('Feedback',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // const Divider(),
                      //
                      // SizedBox(
                      //   height:25,
                      //   child: ListTile(
                      //     minVerticalPadding: 0,
                      //     onTap: () {
                      //       _launchURLPrivacy();
                      //     },
                      //     leading: const Icon(Icons.privacy_tip, color: arabicColor,),
                      //     title: const Text('Privacy Polcy',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // // ListTile(
                      // //   onTap: () {
                      // //     Navigator.push(context,
                      // //         MaterialPageRoute(builder: (context) => DeveloperInfo()));
                      // //   },
                      // //   leading: Icon(Icons.verified, color: arabicColor,),
                      // //   title: const Text('Developer',
                      // //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                      // // ),
                      // const Divider(),
                      // SizedBox(
                      //   height:25,
                      //   child: ListTile(
                      //     minVerticalPadding: 0,
                      //     leading: Icon(Icons.star_rate_rounded, color: arabicColor,),
                      //     title: Text('Rate Us',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // const Divider(),
                      // SizedBox(
                      //   height:25,
                      //   child: const ListTile(
                      //     minVerticalPadding: 0,
                      //     leading: Icon(Icons.share, color: arabicColor,),
                      //     title: Text('Share Islam786',
                      //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
                      //   ),
                      // ),
                      // SizedBox(height: 20,),
                      // const Divider(),
                      // // Center(child: Text(
                      // //   'Powered  By\nIslamic  Technologies', textAlign: TextAlign.center,
                      // //   style: TextStyle(fontSize: 14,
                      // //       fontFamily: 'AlQalamQuran',
                      // //       color: arabicColor,
                      // //       fontWeight: FontWeight.bold),)
                      // // ),
                    ],
                  ),
                )
            ),



          ],
        ),
      ),
      key: _globalKey,
      backgroundColor: whiteColor,
      body: Obx(() {
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
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: Stack(
                      children: [
                        Container(
                          height: displayHeight * 0.28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(getImage())
                            ),
                          ),
                          child: Container(

                            color: const Color(0xff3A1660).withOpacity(0.40),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.menu_outlined),
                                      onPressed: () {
                                        _globalKey.currentState!.openDrawer();
                                      },
                                      color: whiteColor,
                                    ),
                                    // Spacer(),
                                    Row(
                                     mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            _launchWhatsapp(context);
                                          },
                                            child: Image.asset("assets/icons8-whatsapp-24.png",height: 22,width: 22,color: Colors.white,)),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                          onTap: (){

                                          },
                                            child: Icon(Icons.search,color: Colors.white,)),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Get.to(PrayerTimePage());
                                          },
                                            child: Icon(Icons.notifications,color: Colors.white,)),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        // IconButton(
                                        //   icon: Icon(Icons.whatshot),
                                        //   onPressed: () {
                                        //
                                        //   },
                                        //   color: whiteColor,
                                        // ),
                                        // SizedBox(
                                        //   width: 10,
                                        // ),
                                        // IconButton(
                                        //   padding: new EdgeInsets.all(0.0),
                                        //   icon:  Icon(Icons.search,color: Colors.white,),
                                        //   onPressed: () {},
                                        // ),
                                        // IconButton(
                                        //   padding: new EdgeInsets.all(0.0),
                                        //   icon: const Icon(Icons.notifications),
                                        //   onPressed: () =>
                                        //       Get.to(
                                        //         PrayerTimePage(),),
                                        //   color: whiteColor,
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: displayHeight * 0.060,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 11, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          const Text("Now", style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                              fontFamily: "Lato",
                                              letterSpacing: 1.0),),
                                          const SizedBox(height: 0.0,),
                                          Text("${prayerTimes
                                              .currentPrayer()
                                              .name
                                              .toUpperCase()}",
                                            style: const TextStyle(color: whiteColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                fontFamily: "Lato",
                                                letterSpacing: 1.0),),
                                          const SizedBox(height: 10.0,),
                                          const Text("upcoming",
                                            style: TextStyle(color: whiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                fontFamily: "Lato",
                                                letterSpacing: 1.0),),
                                          SizedBox(height: 0.0,),
                                          Text((prayerTimes
                                              .currentPrayer()
                                              .name == "isha")
                                              ? "FAJR"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "fajr")
                                              ? "DHUHR"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "dhuhr")
                                              ? "ASR"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "asr")
                                              ? "MAGHRIB"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "maghrib")
                                              ? "ISHA"
                                              : prayerTimes
                                              .nextPrayer()
                                              .name
                                              .toUpperCase(), style: const TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                              fontFamily: "Lato",
                                              letterSpacing: 1.0),),
                                          Text((prayerTimes
                                              .currentPrayer()
                                              .name == "isha")
                                              ? "${DateFormat.jm().format(
                                              prayerTimes.fajr)}"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "fajr")
                                              ? "${DateFormat.jm().format(
                                              prayerTimes.dhuhr)}"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "dhuhr")
                                              ? "${DateFormat.jm().format(
                                              prayerTimes.asr)}"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "asr")
                                              ? "${DateFormat.jm().format(
                                              prayerTimes.maghrib)}"
                                              : (prayerTimes
                                              .currentPrayer()
                                              .name == "maghrib")
                                              ? "${DateFormat.jm().format(
                                              prayerTimes.isha)}"
                                              : "${DateFormat.jm().format(
                                              prayerTimes.fajr)}",
                                            style: TextStyle(color: whiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                                fontFamily: "Lato",
                                                letterSpacing: 1.0),),

                                        ],
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          Image.asset(
                                            'assets/icons/moon-outlined_1.png',
                                            height: 25, color: Colors.white,),
                                          SizedBox(height: 5,),
                                          Text("${_today.hDay}",
                                            style: TextStyle(color: whiteColor,
                                                fontWeight:
                                                FontWeight.w700,
                                                fontSize: 19,
                                                fontFamily: "Lato",
                                                letterSpacing: 1.0),),
                                          Text(
                                            "${_today.longMonthName}, ${_today
                                                .hYear}", style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                              fontFamily: "Lato",
                                              letterSpacing: 1.0),),
                                          SizedBox(height: 5.0,),
                                          Text(
                                            "${DateFormat('EEEE, d MMM, yyyy')
                                                .format
                                              (_todayEnglish)}",
                                            style: TextStyle(color: whiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                                fontFamily: "Lato",
                                                letterSpacing: 1.0),),


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
                      Positioned(
                         left: 80,
                       top: 40,
                        child: Container(
                            height: 60,
                            width: 320,
                            child: Lottie.asset("assets/animation/Animation - 1697094018761.json",fit: BoxFit.fill,

                            ),
                      )
                      )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: displayHeight * 0.07,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: realTime(
                                      color: (live == 'verse') ? buttonColor
                                          .withOpacity(0.1) : darkWhiteColor,
                                      text: "Verse",
                                      img: "assets/icons/verse.svg",
                                      width: 13),
                                  onTap: () {
                                    live = 'verse';
                                    setState(() {

                                    });
                                  },
                                ),

                                GestureDetector(
                                  child: realTime(
                                      color: (live == 'hadith') ? buttonColor
                                          .withOpacity(0.1) : darkWhiteColor,
                                      text: "Hadith",
                                      img: "assets/icons/hadith.svg",
                                      width: 17),
                                  onTap: () {
                                    live = 'hadis';
                                    setState(() {

                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: realTime(
                                      color: (live == 'flashes') ? buttonColor
                                          .withOpacity(0.1) : darkWhiteColor,
                                      text: "Flashes",
                                      img: "assets/icons/quranword.svg",
                                      width: 20),
                                  onTap: () {
                                    live = 'flashes';
                                    setState(() {

                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: realTime(
                                      color: (live == 'dua') ? buttonColor
                                          .withOpacity(0.1) : darkWhiteColor,
                                      text: "Dua",
                                      img: "assets/icons/quranword.svg",
                                      width: 20),
                                  onTap: () {
                                    live = 'dua';
                                    setState(() {

                                    });
                                  },
                                ),
                                GestureDetector(
                                  child: realTime(
                                      color: (live == 'live') ? buttonColor
                                          .withOpacity(0.1) : darkWhiteColor,
                                      text: "Live",
                                      img: "assets/icons/quranword.svg",
                                      width: 20),
                                  onTap: () {
                                    live = 'live';
                                    setState(() {

                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight * 0.028,
                        ),
                        (live == 'verse') ? (loader == true)
                            ? SpinKitFadingCircle(
                          color: Colors.blueAccent,
                          size: displayHeight * 0.08,
                        )
                            : Column(
                          children: [

                            verseDay("${data?.surahEnName}(${data?.surNum})",
                              data?.arText, data?.enText,),
                            SizedBox(
                              height: displayHeight * 0.02,
                            ),
                            if(_isBannerAdReady)
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height:displayHeight * 0.32,
                                  width: displayWidth * 0.9,
                                  child: AdWidget(ad: _BannerAd!,),
                                ),
                              ),
                            Hadith(),
                            SizedBox(
                              height: displayHeight * 0.02,
                            ),
                            SizedBox(
                              height: displayHeight * 0.02,
                            ),
                            AllahNames(),
                            SizedBox(
                              height: displayHeight * 0.02,
                            ),


                          ],
                        ) : (live == 'flashes') ? Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          child: Container(
                              height: displayHeight * 0.5,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection(
                                    'Flashes').limit(1).snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc = snapshot.data!
                                              .docs[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: displayHeight * 0.02),
                                            child: Container(
                                              width: displayWidth * 0.8,
                                              height: displayHeight * 0.31,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius: const BorderRadius
                                                    .all(Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.8),
                                                    blurRadius: 2,
                                                    spreadRadius: 0.3,
                                                    // offset: Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/quranword.svg",
                                                              height: displayHeight *
                                                                  0.041,),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: const [
                                                                Text("Flashes",
                                                                  style: TextStyle(
                                                                      color: arabicTextColor,
                                                                      fontSize: 16,
                                                                      fontFamily: "Lato",
                                                                      fontWeight: FontWeight
                                                                          .w500),),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            print('cliek');
                                                            await share(
                                                                "Flashes",
                                                                doc['link']);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/icons/share.svg",
                                                                width: 20,
                                                                color: arabicColor,),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              const Text(
                                                                "Share",
                                                                style: TextStyle(
                                                                    color: arabicColor,
                                                                    fontSize: 13,
                                                                    fontFamily: "Lato",
                                                                    fontWeight: FontWeight
                                                                        .w400),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20.0),
                                                      child: Container(
                                                        height: 150,
                                                        width: 300,
                                                        child: CachedNetworkImage(
                                                          imageUrl: doc['link'],
                                                          placeholder: (context,
                                                              url) =>
                                                              SpinKitThreeBounce(
                                                                color: Colors
                                                                    .purple,
                                                                size: 20.0,
                                                              ),
                                                          errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(Icons.error),
                                                        ),)),
                                                  SizedBox(
                                                    height: displayHeight *
                                                        0.02,
                                                  ),


                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Text("No data");
                                  }
                                },
                              )

                          ),
                        ) : (live == 'hadis') ? Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 14.0),
                          child: Container(
                              height: displayHeight * 0.5,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection(
                                    'Hadis').limit(1).snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc = snapshot.data!
                                              .docs[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: displayHeight * 0.02),
                                            child: Container(
                                              width: displayWidth * 0.8,
                                              height: displayHeight * 0.31,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius: const BorderRadius
                                                    .all(Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: buttonColor
                                                        .withOpacity(0.1),
                                                    blurRadius: 2,
                                                    spreadRadius: 0.3,
                                                    // offset: Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(
                                                        5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(

                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/quranword.svg",
                                                              height: displayHeight *
                                                                  0.041,),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            const Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text("Hadith",
                                                                  style: TextStyle(
                                                                      color: arabicTextColor,
                                                                      fontSize: 16,
                                                                      fontFamily: "Lato",
                                                                      fontWeight: FontWeight
                                                                          .w500),),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            await share(
                                                                "Hadith",
                                                                doc['link']);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/icons/share.svg",
                                                                width: 20,
                                                                color: arabicColor,),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              const Text(
                                                                "Share",
                                                                style: TextStyle(
                                                                    color: arabicColor,
                                                                    fontSize: 13,
                                                                    fontFamily: "Lato",
                                                                    fontWeight: FontWeight
                                                                        .w400),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20.0),
                                                      child: Container(
                                                        height: 150,
                                                        width: 300,
                                                        child: CachedNetworkImage(

                                                          imageUrl: doc['link'],
                                                          fit: BoxFit.fill,

                                                          placeholder: (context,
                                                              url) =>
                                                              SpinKitThreeBounce(
                                                                color: Colors
                                                                    .purple,
                                                                size: 20.0,
                                                              ),
                                                          errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(Icons.error),
                                                        ),)),


                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Text("No data");
                                  }
                                },
                              )

                          ),
                        ) : (live == 'dua') ? Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 10, bottom: 14.0),
                          child: Container(
                              height: displayHeight * 0.5,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection(
                                    'Dua').limit(1).snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          DocumentSnapshot doc = snapshot.data!
                                              .docs[index];
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                bottom: displayHeight * 0.02),
                                            child: Container(
                                              width: displayWidth * 0.8,
                                              height: displayHeight * 0.31,
                                              decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius: const BorderRadius
                                                    .all(Radius.circular(20)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: buttonColor
                                                        .withOpacity(0.1),
                                                    blurRadius: 2,
                                                    spreadRadius: 0.3,
                                                    // offset: Offset(0, 0),
                                                  ),
                                                ],
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            SvgPicture.asset(
                                                              "assets/icons/quranword.svg",
                                                              height: displayHeight *
                                                                  0.041,),
                                                            const SizedBox(
                                                              width: 5,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment
                                                                  .start,
                                                              children: const [
                                                                Text("Dua",
                                                                  style: TextStyle(
                                                                      color: arabicTextColor,
                                                                      fontSize: 16,
                                                                      fontFamily: "Lato",
                                                                      fontWeight: FontWeight
                                                                          .w500),),
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            print('cliek');
                                                            await share("Dua",
                                                                doc['link']);
                                                          },
                                                          child: Row(

                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/icons/share.svg",
                                                                width: 20,
                                                                color: arabicColor,),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              const Text(
                                                                "Share",
                                                                style: TextStyle(
                                                                    color: arabicColor,
                                                                    fontSize: 13,
                                                                    fontFamily: "Lato",
                                                                    fontWeight: FontWeight
                                                                        .w400),),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(20.0),
                                                      child: Container(
                                                        height: 150,
                                                        child: CachedNetworkImage(

                                                          imageUrl: doc['link'],
                                                          placeholder: (context,
                                                              url) =>
                                                              SpinKitThreeBounce(
                                                                color: Colors
                                                                    .purple,
                                                                size: 20.0,
                                                              ),
                                                          errorWidget: (context,
                                                              url, error) =>
                                                          new Icon(Icons.error),
                                                        ),)),

                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return Text("No data");
                                  }
                                },
                              )

                          ),
                        ) : (live == 'live') ? Padding(
                          padding: EdgeInsets.only(left: 15,
                              right: 15,
                              top: displayHeight * 0.1,
                              bottom: 14.0),
                          child: GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/Live.svg", width: 100,
                                  height: 100,),
                                SizedBox(
                                  height: displayHeight * 0.02,
                                ),
                                const Text("Live")
                              ],
                            ),
                            onTap: () {
                              _launchWhatsapp(context);
                              // Navigator.push(context, MaterialPageRoute(
                              //     builder: (context) => Tasbee()));
                            },
                          ),

                        ) : SizedBox()
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              top: displayHeight * 0.275,
              left: displayWidth * 0.08,
              child: Container(
                width: displayWidth * 0.85,
                height: displayHeight * 0.08,
                // padding: EdgeInsets.only(
                //     top: displayHeight * 0.007, bottom: displayHeight * 0.009),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      blurRadius: 1,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Image.asset("assets/icons/dua1.png",
                          width:45,),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const Dua()));
                        },
                      ),
                      GestureDetector(
                        child: Image.asset("assets/icons/mname.png",
                          width: 50),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const MuhammadName()));
                        },
                      ),
                      GestureDetector(
                        child: Image.asset("assets/icons/aname.png",
                          width: 45),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const AllahName()));
                        },
                      ),
                      GestureDetector(
                        child: Image.asset("assets/icons/tasbeeh1.png",
                          height: 48,
                          width: 48),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const Tasbee()));
                        },
                      ),
                      Column(

        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 43,
                              width: 43,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/icons/qiblanew.png',),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),

                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const QiblaScreen()));
                            },
                          ),
                          Text('Qibla',
                            style: TextStyle(fontSize: 5,
                                fontWeight: FontWeight.bold,
                                color: arabicColor),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }
      ),
    );
  }
  rateusUrl()async{
    const url = 'https://play.google.com/store/apps/details?id=com.ito.islam786';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURLPrivacy() async {
    const url = 'https://www.softwebtuts.com/p/privacy-policy.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget realTime(
      {required Color color, required String text, required String img, required double width}) {
    var displayWidth = MediaQuery
        .of(context)
        .size
        .width;
    var displayHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Container(
      margin: EdgeInsets.only(left: 4.0, right: 4.0),
      width: displayWidth * 0.28,
      height: displayHeight * 0.05,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(img, width: width,),
            Text(text,
              style: const TextStyle(fontSize: 10, fontFamily: "Noorehira"),),
          ],
        ),
      ),
    );
  }

  Widget verseDay(surah, arabicAya, engAya) {
    var displayWidth = MediaQuery
        .of(context)
        .size
        .width;
    var displayHeight = MediaQuery
        .of(context)
        .size
        .height;
    print(_today);

    return Container(
      width: displayWidth * 0.9,
      height: displayHeight * 0.32,
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
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/icons/verse.svg", height: 25,),
                    SizedBox(width: 5,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Verse of the Day", style: TextStyle(
                            color: arabicTextColor,
                            fontSize: 16,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.w500),),
                        Text("$surah", style:
                        TextStyle(color: greenColor, fontSize: 13,
                            fontFamily: "Lato", fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [
                    SvgPicture.asset("assets/icons/share.svg", width: 20,
                        color: arabicColor),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Share", style: TextStyle(color: arabicColor,
                        fontSize: 14,
                        fontFamily: "Noorehira",
                        fontWeight: FontWeight.w400),),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: SelectableText(
                "$arabicAya", textAlign: TextAlign.center,

                style: TextStyle(color: arabicColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Noorehira",
                    overflow: TextOverflow.ellipsis),
              ),

            ),

            Flexible(
              child: SelectableText(
                "$engAya", textAlign: TextAlign.justify,
                style: TextStyle(color: blackColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: "AlQalamQuran",
                    overflow: TextOverflow.ellipsis),

              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget imageDialog(text, path, context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          '$text',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      // backgroundColor: Colors.transparent,
      // elevation: 0,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            width: 220,
            height: MediaQuery
                .of(context)
                .size
                .height * 0.6,
            child: Image.network(

              '$path',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  drawer(onPress,icon,text) {
    return
      Column(
        children: [
          InkWell(
            onTap: onPress,
            child: Row(
              children: [
                Expanded(
                    flex:2,
                    child: Icon(icon, color: arabicColor,)),
                Expanded(
                  flex: 8,
                  child: Text(text,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300,)),
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
          const Divider(),

        ],
      );

  }
  sharePress() async{
   // Share.share('check out my Application https://play.google.com/store/apps/details?id=com.ito.islam786');
    Share.share('check out my Application : https://play.google.com/store/apps/details?id=com.ito.islam786', subject: 'Look what I made!');
    // final result = await Share.shareWithResult('check out my website https://example.com');
    //
    // if (result.status == ShareResultStatus.success) {
    //   print('Thank you for sharing my Application!');
    // }
    // final results = await Share.shareXFiles([XFile('${directory.path}/image1.jpg'), XFile('${directory.path}/image2.jpg')]);
    //
    // if (results.status == ShareResultStatus.dismissed) {
    //   print('Did you not like the pictures?');
    // }


  }
}
