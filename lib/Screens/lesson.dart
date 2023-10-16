import 'package:adhan/adhan.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'package:islamm786/Screens/quran_screen.dart';
import 'package:islamm786/api_interface/api_interface.dart';
import 'package:islamm786/app_utils/text_utils.dart';
import 'package:islamm786/extra/quran_screen.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import '../drawer_screen/about_us.dart';
import '../extra/prayer_time/views/prayer_time_page.dart';
import '../hadith/hadith_book.dart';
import '../hadith/search_hadith.dart';
import 'award.dart';

class Lesson extends StatefulWidget {
  const Lesson({Key? key}) : super(key: key);

  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  var image1 = "assets/morning.jpg";
  var image2 = "assets/eve.jpg";
  var image3 = "assets/night.jpg";
  String? _currentAddress;
  Position? _currentPosition;

  var image;

  @override
  initState() {
    super.initState();
  }

  HijriCalendar _today = HijriCalendar.now();
  var _todayEnglish = DateTime.now();

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

  getImage() {
    var hour = DateTime.now().hour;
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

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  TextUtils _textUtils = TextUtils();

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    final myCoordinates = Coordinates(31.430396637646854,
        74.2845230327133); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              children: <Widget>[
                Column(
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
                                      const Text("Hadith",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white),),
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
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const TabBar(
                  labelColor: arabicColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: arabicColor,
                  tabs: [
                    Tab(
                      text: "Hadith Books",
                    ),
                    Tab(
                      text: "Search Hadiths",
                    ),
                  ],
                ),
                // const SizedBox(height: 10,),
                Expanded(

                  child:
                  TabBarView(children: [
                    HadithBooks(),
                    SearchHadith(),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget lessons({required String text, required String number}) {
    // var displayWidth = MediaQuery.of(context).size.width;
    // var displayHeight = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.width * 0.20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        image: DecorationImage(image: AssetImage("assets/icons/lessons.png")),
        color: purpleColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: whiteColor,
                fontFamily: "Lato",
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          Text(
            number,
            style: const TextStyle(
                color: whiteColor,
                fontFamily: "Lato",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
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
}
