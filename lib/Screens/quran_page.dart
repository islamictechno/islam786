

import 'package:adhan/adhan.dart';


import 'package:arabic_font/arabic_font.dart';
import 'package:dio/dio.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:path/path.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Screens/NotePad/note.dart';
import 'package:islamm786/Screens/liten_quran.dart';

import 'package:islamm786/Screens/quran_details/madniqaida_page.dart';
import 'package:islamm786/Screens/quran_details/kanzu_iman.dart';
import 'package:islamm786/Screens/quran_details/surah_mulak.dart';
import 'package:islamm786/Screens/quran_details/surah_muzammil.dart';
import 'package:islamm786/Screens/quran_details/surah_rehman.dart';

import 'package:islamm786/Screens/sfpdfviewer_screen.dart';
import 'package:jhijri_picker/_src/_jWidgets.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants.dart';
import '../app_utils/text_utils.dart';
import '../drawer_screen/about_us.dart';
import '../extra/audio_surah2/frontend/pages/home_page/index.dart';
import '../extra/prayer_time/views/prayer_time_page.dart';
import '../extra/qari_screen.dart';
import '../extra/quran_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../pdf_viwer_page.dart';
import 'award.dart';


class QuranPage extends StatefulWidget {
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  var live = 'verse';
  var image1 = "assets/morning.jpg";
  var image2 = "assets/eve.jpg";
  var image3 = "assets/night.jpg";
  // String? _currentAddress;
  // Position? _currentPosition;
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();




  _launchWhatsapp(context) async {
    var whatsapp = "+923044747104";
    var whatsappAndroid =
    Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
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

  HijriCalendar _today = HijriCalendar.now();
  var _todayEnglish = DateTime.now();

  var image;
  var loader = true;

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

  TextUtils _textUtils = TextUtils();
  // String? path;
  //   String fileUrl = 'https://www.quran-pdf.com/arabic-quran.pdf';
  // Future<void> downloadFile() async {
  //   final response = await http.get(Uri.parse(fileUrl));
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //
  //   File file = File('${documentDirectory.path}/sample.pdf');
  //   await file.writeAsBytes(response.bodyBytes);
  //
  //   setState(() {
  //     path = file.path;
  //   });
  // }

  // Future<String?> _downloadFile() async {
  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     final response = await http.get(Uri.parse(fileUrl));
  //     final documentDirectory = await getExternalStorageDirectory();
  //
  //     if (documentDirectory != null) {
  //       final filePath = '${documentDirectory.path}/quran.pdf'; // Replace with your desired file name and extension
  //       File file = File(filePath);
  //        await file.writeAsBytes(response.bodyBytes);
  //       return filePath;
  //     }
  //   } else {
  //     throw 'Permission denied';
  //   }
  //   return null;
  // }
  // Future<void> _openFile(String filePath) async {
  //   if (await canLaunch(filePath)) {
  //     await launch(filePath);
  //   } else {
  //     throw 'Could not open $filePath';
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final myCoordinates = Coordinates(31.430396637646854,
        74.2845230327133); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    print(_today.hDay);
    var file;
    return Scaffold(
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
        key: _globalKey,
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Stack(
                      children: [
                        Container(
                          height:MediaQuery.of(context).size.height*.28,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage(getImage())),
                          ),
                          child: Container(
                            color: const Color(0xff3A1660).withOpacity(0.40),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.menu_outlined,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        _globalKey.currentState!.openDrawer();
                                      },
                                      color: whiteColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 28.0),
                                      child: _textUtils.semiBold("Quran",
                                          Colors.white, 18.0, TextAlign.center),
                                    ),
                                    // Spacer(),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              _launchWhatsapp(context);
                                            },
                                            child: Image.asset(
                                              "assets/icons8-whatsapp-24.png",
                                              height: 20,
                                              width: 20,
                                              color: Colors.white,
                                            )),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.search,
                                              color: Colors.white,
                                              size: 20,
                                            )),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Get.to(PrayerTimePage());
                                            },
                                            child: const Icon(
                                              Icons.notifications,
                                              color: Colors.white,
                                              size: 20,
                                            )),
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
                                // const SizedBox(
                                //   height: 13,
                                // ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 11, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Get.to(PrayerTimePage());
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Now",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                            const SizedBox(
                                              height: 0.0,
                                            ),
                                            Text(
                                              "${prayerTimes
                                                  .currentPrayer()
                                                  .name
                                                  .toUpperCase()}",
                                              style: const TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            const Text(
                                              "upcoming",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                            const SizedBox(
                                              height: 0.0,
                                            ),
                                            Text(
                                              (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "isha")
                                                  ? "FAJR"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "fajr")
                                                  ? "DHUHR"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "dhuhr")
                                                  ? "ASR"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "asr")
                                                  ? "MAGHRIB"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "maghrib")
                                                  ? "ISHA"
                                                  : prayerTimes
                                                  .nextPrayer()
                                                  .name
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                            Text(
                                              (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "isha")
                                                  ? "${DateFormat.jm().format(
                                                  prayerTimes.fajr)}"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "fajr")
                                                  ? "${DateFormat.jm().format(
                                                  prayerTimes.dhuhr)}"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "dhuhr")
                                                  ? "${DateFormat.jm().format(
                                                  prayerTimes.asr)}"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "asr")
                                                  ? "${DateFormat.jm().format(
                                                  prayerTimes.maghrib)}"
                                                  : (prayerTimes
                                                  .currentPrayer()
                                                  .name ==
                                                  "maghrib")
                                                  ? DateFormat.jm().format(
                                                  prayerTimes.isha)
                                                  : DateFormat.jm().format(
                                                  prayerTimes.fajr),
                                              style: const TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          final dateTime =
                                          await showGlobalDatePicker(
                                            context: context,
                                            startDate: JDateModel(
                                                dateTime:
                                                DateTime.parse("1984-12-24")),
                                            selectedDate: JDateModel(
                                                dateTime: DateTime.now()),
                                            endDate: JDateModel(
                                                dateTime:
                                                DateTime.parse("2035-09-20")),
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
                                                  borderRadius:
                                                  BorderRadius.circular(12)),
                                              child: const Center(
                                                child: Text(
                                                  "Hijri Calender",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                          if (dateTime != null) {
                                            debugPrint(dateTime.toString());
                                          }
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/icons/moon-outlined_1.png',
                                              height: 20,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${_today.hDay}",
                                              style: const TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  fontFamily: "Lato",
                                                  letterSpacing: 1.0),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final dateTime =
                                                await showGlobalDatePicker(
                                                  context: context,
                                                  startDate: JDateModel(
                                                      dateTime: DateTime.parse(
                                                          "1984-12-24")),
                                                  selectedDate: JDateModel(
                                                      dateTime: DateTime.now()),
                                                  endDate: JDateModel(
                                                      dateTime: DateTime.parse(
                                                          "2035-09-20")),
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
                                                  primaryColor:
                                                  Colors.purple.shade900,
                                                  calendarTextColor: Colors.black87,
                                                  backgroundColor: Colors.white,
                                                  borderRadius:
                                                  const Radius.circular(10),
                                                  buttonTextColor:
                                                  Colors.purple.shade900,
                                                  headerTitle: const Center(
                                                    child: Text(
                                                      "Hijri Calender",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                                if (dateTime != null) {
                                                  debugPrint(dateTime.toString());
                                                }
                                              },
                                              child: Text(
                                                "${_today.longMonthName}, ${_today
                                                    .hYear}",
                                                style: const TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                final dateTime =
                                                await showGlobalDatePicker(
                                                  context: context,
                                                  startDate: JDateModel(
                                                      dateTime: DateTime.parse(
                                                          "1984-12-24")),
                                                  selectedDate: JDateModel(
                                                      dateTime: DateTime.now()),
                                                  endDate: JDateModel(
                                                      dateTime: DateTime.parse(
                                                          "2035-09-20")),
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
                                                  primaryColor:
                                                  Colors.purple.shade900,
                                                  calendarTextColor: Colors.black87,
                                                  backgroundColor: Colors.white,
                                                  borderRadius:
                                                  const Radius.circular(10),
                                                  buttonTextColor:
                                                  Colors.purple.shade900,
                                                  headerTitle: const Center(
                                                    child: Text(
                                                      "التقويم الهجري",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                                if (dateTime != null) {
                                                  debugPrint(dateTime.toString());
                                                }
                                              },
                                              child: Text(
                                                DateFormat('EEEE, d MMM, yyyy')
                                                    .format(_todayEnglish),
                                                style: const TextStyle(
                                                    color: whiteColor,
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
                            top: 62,
                            child: SizedBox(
                              height: 60,
                              width: 320,
                              child: Lottie.asset(
                                "assets/animation/Animation - 1697094018761.json",
                                fit: BoxFit.fill,
                              ),
                            )),

                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 12, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            quranLine(() {
                               // openPdf(context, File(fileBits, fileName), url as String);
                               Get.to(() => const QuranScreen());
                            }, "assets/icons/read.svg", "Quran Digital"),
                            Stack(
                              children: [
                                quranLine(() async{
                                  // await Fluttertoast.showToast(
                                  //     msg: "Start Downloading",
                                  //     toastLength: Toast.LENGTH_SHORT,
                                  //     gravity: ToastGravity.CENTER,
                                  //     timeInSecForIosWeb: 1,
                                  //     backgroundColor: arabicColor,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0
                                  // );
                                  // const url =
                                  //     "https://downloadthequran.com/wp-content/uploads/2017/12/Quran-with-Big-Font.pdf";
                                  // final file = await loadPdfFromNetwork(url);
                                  // openPdf(context, file, url);




                                  // String url = 'http://www.africau.edu/images/default/sample.pdf';
                                  // final file = await pickFile();
                                  // if (file == null) return;
                                  // openPdf(context, file, url);
                                  // var filePath;
                                  // if (filePath != null) {
                                  //   _openFile(filePath);
                                  // } else {
                                  //   // Handle null file path
                                  // }
                                   //Get.to(()=>SfPDFScreen());
                                   Get.to(()=>SfPDFScreen(
                                     pdfAssetPath: 'assets/pdf/AlQuranAlKareem16Lines-TajCompany_removed.pdf',
                                   ),);
                                }, "assets/icons/read.svg",
                                    "Quran (16 Line)"),
                                // Positioned(
                                //   bottom: 2,
                                //   left: 50,
                                //   child: InkWell(onTap:() async {
                                //     // const url =
                                //     //     "https://www.quran-pdf.com/arabic-quran.pdf";
                                //     // final file = await loadPdfFromNetwork(url);
                                //     // openPdf(context, file, url);
                                //     const url =
                                //         "https://www.quran-pdf.com/arabic-quran.pdf";
                                //     saveFile(url, "quran.pdf");
                                //
                                //      //await _downloadFile();
                                //    // await downloadFile();
                                //
                                //   } ,
                                //   //     ()async{
                                //   //   // const url =
                                //   //   //     "https://www.quran-pdf.com/arabic-quran.pdf";
                                //   //   // final file = await loadPdfFromNetwork(url);
                                //   //
                                //   // },
                                //       child:
                                //       Text(file==null?"Download":"remove",style: TextStyle(color: Colors.green.shade900,fontSize: 10),)),
                                // )
                              ],
                            ),

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            quranLine(() {
                              Get.to(()=>const HomePageScreenLitenQuran());
                              //Get.to(()=>const QariListScreen());
                            }, "assets/icons/read.svg",
                                "Listen Quran"),

                            quranLine(() async{
                              // const url =
                              //     "http://www.africau.edu/images/default/sample.pdf";
                              // final file = await loadPdfFromNetwork(url);
                              // openPdf(context, file, url);
                              // String url = 'http://www.africau.edu/images/default/sample.pdf';
                              // final file = await pickFile();
                              // if (file == null) return;
                              // openPdf(context, file, url);
                              //Get.to(()=>PdfViewerScreen());
                              // Get.to(()=>MadniQaidaPage());

                              Get.to(()=>SurahYassen(
                                pdfAssetPath: 'assets/pdf/36-surah-ya-sin.pdf',
                              ),);

                            }, "assets/icons/read.svg",
                                "Surah Yaseen"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            quranLine(() async {
                              Get.to(()=>SurahMuzammil(
                                pdfAssetPath: 'assets/pdf/73-surah-al-muzammil.pdf',
                              ),);


                            }, "assets/icons/read.svg", "Surah Muzammil"),

                            quranLine(() async {

                              // Get.to(()=>SurahMulk());
                              Get.to(()=>SurahMulk(
                                pdfAssetPath: 'assets/pdf/67-surah-al-mulk.pdf',
                              ),);
                            }, "assets/icons/read.svg", "Surah Mulk"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            quranLine(() async {
                              Get.to(()=>SurahMulk(
                                pdfAssetPath: 'assets/pdf/55-surah-ar-rahman.pdf',
                              ),);

                            }, "assets/icons/read.svg", "Surah Rehman"),

                            quranLine(() {
                              Get.to(()=>Kanzulman(
                                pdfAssetPath: 'assets/pdf/kanzul iman tafsir ur di_removed_compressed_compressed_compressed.pdf',
                              ),);
                              // Fluttertoast.showToast(
                              //         msg: "Coming Soon",
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.CENTER,
                              //         timeInSecForIosWeb: 1,
                              //         backgroundColor: arabicColor,
                              //         textColor: Colors.white,
                              //         fontSize: 16.0
                              //     );
                            }, "assets/icons/read.svg", "Kanzul iman "),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height*.25,
              left: 5,
              child: Container(
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width/1.1,
                margin: const EdgeInsets.only(left: 14, right: 14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade100,width: 4)),
                child: const Center(
                  child: Text(
                    "ذٰلِكَ الْكِتٰبُ لَا رَیْبَ فِیْهِ هُدًى لِّلْمُتَّقِیْنَِ",
                    style: ArabicTextStyle(
                        arabicFont: ArabicFont.cairo,
                        fontSize: 19,
                        color: arabicColor
                        , fontWeight: FontWeight.normal),
                  ),
                ),
                // Center(child: _textUtils.semiBold("وَرَتِّلِ الْقُرْاٰنَ تَرْتِیْلًا", arabicColor, 22.0, TextAlign.center)
                // ),
              ),
            ),
          ],
        )
        );
  }

  drawer(onPress, icon, text) {
    return Column(
      children: [
        InkWell(
          onTap: onPress,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Icon(
                    icon,
                    color: arabicColor,
                  )),
              Expanded(
                flex: 8,
                child: Text(text,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(),
      ],
    );
  }

  sharePress() async {
    // Share.share('check out my Application https://play.google.com/store/apps/details?id=com.ito.islam786');
    Share.share(
        'check out my Application : https://play.google.com/store/apps/details?id=com.ito.islam786',
        subject: 'Look what I made!');
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

  rateusUrl() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.ito.islam786';
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


   quranLine(onPress, images, text,) {

    return InkWell(
      onTap: onPress,
      child:
      Container(
        width:MediaQuery.of(context).size.width/2.28,
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade200,
            boxShadow: const [
              BoxShadow(
                  color: arabicColor,
                  spreadRadius: 3,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 2)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              images,
              height: 22,
              width: 22,
              color: arabicColor,
            ),
            const SizedBox(
              height: 3,
            ),
            _textUtils.medium(text, arabicColor, 14.0, TextAlign.center),
          ],
        ),
      ),
    );
  }

  // Future<File?> pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );
  //   if (result == null) return null;
  //   return File(result.paths.first ?? '');
  // }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = "quran.pdf";
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }
  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );

}
Future<bool> saveFile(String url, String fileName) async {
  try {
    if (await _requestPermission(Permission.storage)) {
      Directory? directory;
      directory = await getExternalStorageDirectory();
      String newPath = "";
      List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/PDF_Download";
      directory = Directory(newPath);
      File saveFile = File(directory.path + "/$fileName");
      if (kDebugMode) {
        print(saveFile.path);
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await Dio().download(
          url,
          saveFile.path,
        );
      }
    }
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
