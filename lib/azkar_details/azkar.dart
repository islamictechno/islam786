import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Constants.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/award.dart';
import '../app_utils/text_utils.dart';
import '../drawer_screen/about_us.dart';
import '../extra/prayer_time/controllers/prayer_time_controller.dart';
import '../extra/prayer_time/views/prayer_time_page.dart';
import 'azkar_data.dart';
class AzkarPage extends StatefulWidget {


  @override
  State<AzkarPage> createState() => _AzkarPageState();
}

class _AzkarPageState extends State<AzkarPage> {
  var image1="assets/morning.jpg";
  var image2="assets/eve.jpg";
  var image3="assets/night.jpg";
  var image;

  TextUtils _textUtils= TextUtils();
  _launchWhatsapp() async {
    var whatsapp = "+923044747104";
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
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
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    return Scaffold(
      backgroundColor: Colors.white,
      body:Obx((){
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
        return Scaffold(
          key: _globalKey,
          drawer: Drawer(
            width: 200,
            child: SingleChildScrollView(
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
                            fit: BoxFit.cover, image: AssetImage(getImage())),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/islam786.png',
                            height: 70,
                          ),
                        ],
                      )),
                  Container(
                      height: 600,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: const BoxDecoration(
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
                            const SizedBox(
                              height: 14,
                            ),
                            drawer(() {
                              Get.to(() => AboutUsScreen());
                            }, Icons.privacy_tip_outlined, "About us"),
                            // const SizedBox(height: 9,),
                            // drawer((){}, Icons.person, "Contact Us"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {}, Icons.settings, "Setting"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {
                              Get.to(()=>AwardScreen());
                            }, Icons.card_membership, "Award"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {}, Icons.feedback, "Feedback"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {
                              _launchURLPrivacy();
                            }, Icons.privacy_tip, "Privacy Policy"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {
                              rateusUrl();
                            }, Icons.star_rate_rounded, "Rate Us"),
                            const SizedBox(
                              height: 9,
                            ),
                            drawer(() {
                              sharePress();
                            }, Icons.share, "Share Islam786"),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
          backgroundColor: whiteColor,
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*.28,
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
                                const SizedBox(height: 20,),
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
                                    const Text("Azkar",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white),),
                                    // Spacer(),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              _launchWhatsapp();
                                            },
                                            child: Image.asset("assets/icons8-whatsapp-24.png",height: 22,width: 22,color: Colors.white,)),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                            onTap: (){

                                            },
                                            child: const Icon(Icons.search,color: Colors.white,)),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                            onTap: (){
                                              Get.to(PrayerTimePage());
                                              //Get.to(()=>PrayerNotification());
                                            },
                                            child: const Icon(Icons.notifications,color: Colors.white,)),
                                        const SizedBox(
                                          width: 15,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 0,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 11, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          Get.to(PrayerTimePage());
                                        },
                                        child: Column(
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
                                            const SizedBox(height: 5.0,),
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
                                      ),

                                      InkWell(
                                        onTap: ()async{
                                          final dateTime = await showGlobalDatePicker(
                                            context: context,
                                            startDate: JDateModel(dateTime: DateTime.parse("1984-12-24")),
                                            selectedDate: JDateModel(dateTime: DateTime.now()),
                                            endDate: JDateModel(dateTime: DateTime.parse("2035-09-20")),
                                            pickerMode: DatePickerMode.day,
                                            pickerTheme: Theme.of(context),
                                            // textDirection: TextDirection.rtl,
                                            //locale: const Locale("ar", "SA"),
                                            okButtonText: "OK",
                                            cancelButtonText: "Cancel",
                                            onOk: (value) {
                                              Get.back();
                                              // debugPrint(value.toString());
                                              // Navigator.pop(context);
                                            },
                                            onCancel: () {
                                              Get.back();
                                            },
                                            primaryColor: Colors.purple.shade900,
                                            calendarTextColor: Colors.black87,
                                            backgroundColor: Colors.white,
                                            borderRadius: const Radius.circular(10),
                                            buttonTextColor: Colors.purple.shade900,
                                            headerTitle: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.purple.shade900,
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Hijri Calender",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                          if (dateTime != null) {
                                            debugPrint(dateTime.toString());
                                          }
                                        },
                                        child: Column(
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
                                            InkWell(
                                              onTap: ()async{
                                                final dateTime = await showGlobalDatePicker(
                                                  context: context,
                                                  startDate: JDateModel(dateTime: DateTime.parse("1984-12-24")),
                                                  selectedDate: JDateModel(dateTime: DateTime.now()),
                                                  endDate: JDateModel(dateTime: DateTime.parse("2035-09-20")),
                                                  pickerMode: DatePickerMode.day,
                                                  pickerTheme: Theme.of(context),
                                                  // textDirection: TextDirection.rtl,
                                                  //locale: const Locale("ar", "SA"),
                                                  okButtonText: "OK",
                                                  cancelButtonText: "Cancel",
                                                  onOk: (value) {
                                                    Get.back();
                                                    // debugPrint(value.toString());
                                                    // Navigator.pop(context);
                                                  },
                                                  onCancel: () {
                                                    Get.back();
                                                  },
                                                  primaryColor: Colors.purple.shade900,
                                                  calendarTextColor: Colors.black87,
                                                  backgroundColor: Colors.white,
                                                  borderRadius: const Radius.circular(10),
                                                  buttonTextColor: Colors.purple.shade900,
                                                  headerTitle: const Center(
                                                    child: Text(
                                                      "Hijri Calender",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                                if (dateTime != null) {
                                                  debugPrint(dateTime.toString());
                                                }
                                              },
                                              child: Text(
                                                "${_today.longMonthName}, ${_today
                                                    .hYear}", style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),),
                                            ),
                                            SizedBox(height: 5.0,),
                                            InkWell(
                                              onTap: ()async{
                                                final dateTime = await showGlobalDatePicker(
                                                  context: context,
                                                  startDate: JDateModel(dateTime: DateTime.parse("1984-12-24")),
                                                  selectedDate: JDateModel(dateTime: DateTime.now()),
                                                  endDate: JDateModel(dateTime: DateTime.parse("2035-09-20")),
                                                  pickerMode: DatePickerMode.day,
                                                  pickerTheme: Theme.of(context),
                                                  // textDirection: TextDirection.rtl,
                                                  //locale: const Locale("ar", "SA"),
                                                  okButtonText: "حفظ",
                                                  cancelButtonText: "عودة",
                                                  onOk: (value) {
                                                    Get.back();
                                                    // debugPrint(value.toString());
                                                    // Navigator.pop(context);
                                                  },
                                                  onCancel: () {
                                                    Get.back();
                                                  },
                                                  primaryColor: Colors.purple.shade900,
                                                  calendarTextColor: Colors.black87,
                                                  backgroundColor: Colors.white,
                                                  borderRadius: const Radius.circular(10),
                                                  buttonTextColor: Colors.purple.shade900,
                                                  headerTitle: const Center(
                                                    child: Text(
                                                      "التقويم الهجري",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                                if (dateTime != null) {
                                                  debugPrint(dateTime.toString());
                                                }
                                              },

                                              child: Text(
                                                "${DateFormat('EEEE, d MMM, yyyy')
                                                    .format
                                                  (_todayEnglish)}",
                                                style:
                                                TextStyle(color: whiteColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                            ),


                                          ],
                                        ),
                                      )


                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            left: 80,
                            top: 40,
                            child: SizedBox(
                              height: 60,
                              width: 320,
                              child: Lottie.asset("assets/animation/Animation - 1697094018761.json",fit: BoxFit.fill,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Expanded(

                    child: Column(
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Get.to(()=>AzkarData());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height/1.4,
                            width: MediaQuery.of(context).size.width,
                            decoration:  const BoxDecoration(

                              image: DecorationImage(
                                opacity: 0.90,
                                // colorFilter:
                                // ColorFilter.mode(Colors.white.withOpacity(0.2),
                                //     BlendMode.dstATop),
                                image: AssetImage(
                                  "assets/checkImage.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    flex: 14,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Center(
                                          child:
                                          Text(
                                            "وَاذْکُرْ رَّبَّکَ فِيْ نَفْسِکَ تَضَرُّعًا وَّ خِيْفَةً وَّ دُوْنَ الْجَھْرِ مِنَ الْقَوْلِ بِالْغُدُوِّ وَالْاٰصَالِ وَ لَا تَکُنْ مِّنَ الْغٰفِلِيْنَ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 24.0,

                                                fontWeight: FontWeight.w500,
                                                fontFamily: "noorehuda",
                                                color: arabicColor),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Center(
                                          child: Text(
                                            "اور اپنے رب کو اپنے دل میں یاد کروگڑگڑاتے ہوئے اور ڈرتے ہوئے اور بلندی سے کچھ کم آواز میں ،صبح و شام، اور غافلوں میں سے نہ ہونا",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(

                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Jameelnoori",
                                                color: black),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Center(
                                          child: Opacity(
                                            opacity: .5,
                                            child: Text(
                                              "(الأعراف، 7 : 205)",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Jameelnoori",
                                                  color: black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    flex: 9,
                                    child: InkWell(
                                      onTap: (){
                                        Get.to(()=>AzkarData());
                                        // shareText();
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 40,
                                          width: 140,

                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius: BorderRadius.circular(10),

                                          ),
                                          child: const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              Text("اذکار کے لیے یہاں پر کلک کریں",style: TextStyle(color: arabicColor,fontSize:14,fontFamily:"Jameelnoori",fontWeight:FontWeight.w700),),
                                              // Icon(Icons.)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );}
      ),

    );
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
          const SizedBox(height: 8,),
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
  rateusUrl()async{
    const url = 'https://play.google.com/store/apps/details?id=com.ito.islam786';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURLPrivacy() async {
    const url = 'https://quranteacher.uk/bb/privacy-policy.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  quranLine(addImage,onPress,  text,) {

    return InkWell(
      onTap: onPress,
      child:
      Container(
        width:MediaQuery.of(context).size.width/2.28,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade200,
            // image:DecorationImage(
            //   image: AssetImage("assets/icons/lessons.png",),
            //   fit: BoxFit.fill,
            // ),
            boxShadow: const [
              BoxShadow(
                  color: arabicColor,
                  spreadRadius: 2,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 2)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(addImage,height: 22,width: 22,color: arabicColor,),
            // SvgPicture.asset(
            //   images,
            //   height: 22,
            //   width: 22,
            //   color: arabicColor,
            // ),
            // const SizedBox(
            //   height: 3,
            // ),
            _textUtils.medium(text, arabicColor, 14.0, TextAlign.center),
          ],
        ),
      ),
    );
  }
}
