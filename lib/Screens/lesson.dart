import 'package:adhan/adhan.dart';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/Screens/pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants.dart';
import '../extra/prayer_time/views/prayer_time_page.dart';

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

  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    final myCoordinates = Coordinates(31.430396637646854,
        74.2845230327133); // Replace with your own location lat, lng.
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: <Widget>[
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
                                    image: AssetImage(getImage())),
                              ),
                              child: Container(
                                color:
                                    const Color(0xff3A1660).withOpacity(0.40),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.menu),
                                          onPressed: () {
                                            _globalKey.currentState!
                                                .openDrawer();
                                          },
                                          color: whiteColor,
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.whatshot),
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
                                              icon: const Icon(
                                                  Icons.notifications),
                                              onPressed: () => Get.to(
                                                PrayerTimePage(),
                                              ),
                                              color: whiteColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: displayHeight * 0.012,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Now",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${prayerTimes.currentPrayer().name.toUpperCase()}",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              const Text(
                                                "upcoming",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
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
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 19,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              Text(
                                                (prayerTimes
                                                            .currentPrayer()
                                                            .name ==
                                                        "isha")
                                                    ? "${DateFormat.jm().format(prayerTimes.fajr)}"
                                                    : (prayerTimes
                                                                .currentPrayer()
                                                                .name ==
                                                            "fajr")
                                                        ? "${DateFormat.jm().format(prayerTimes.dhuhr)}"
                                                        : (prayerTimes
                                                                    .currentPrayer()
                                                                    .name ==
                                                                "dhuhr")
                                                            ? "${DateFormat.jm().format(prayerTimes.asr)}"
                                                            : (prayerTimes
                                                                        .currentPrayer()
                                                                        .name ==
                                                                    "asr")
                                                                ? "${DateFormat.jm().format(prayerTimes.maghrib)}"
                                                                : (prayerTimes
                                                                            .currentPrayer()
                                                                            .name ==
                                                                        "maghrib")
                                                                    ? "${DateFormat.jm().format(prayerTimes.isha)}"
                                                                    : "${DateFormat.jm().format(prayerTimes.fajr)}",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                'assets/icons/moon-outlined_1.png',
                                                height: 25,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${_today.hDay}",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 23,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              Text(
                                                "${_today.longMonthName}, ${_today.hYear}",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${DateFormat('EEEE, d MMM, yyyy').format(_todayEnglish)}",
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    fontFamily: "Lato",
                                                    letterSpacing: 1.0),
                                              ),
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
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () async {
                                  var document = await PDFDocument.fromAsset(
                                      'assets/pdf/urduLesson.pdf');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewerScreen(
                                              doc: document, number: "2")));
                                },
                                child: lessons(text: "Lesson No", number: "1")),
                            InkWell(
                                onTap: () async {
                                  var document = await PDFDocument.fromAsset(
                                      'assets/pdf/englishLesson.pdf');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewerScreen(
                                              doc: document, number: "2")));
                                },
                                child: lessons(text: "Lesson No", number: "2")),
                            InkWell(
                                onTap: () async {
                                  var document = await PDFDocument.fromAsset(
                                      'assets/pdf/englishLesson.pdf');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewerScreen(
                                              doc: document, number: "3")));
                                },
                                child: lessons(text: "Lesson No", number: "3")),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () async {
                                  var document = await PDFDocument.fromAsset(
                                      'assets/pdf/urduLesson.pdf');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewerScreen(
                                              doc: document, number: "4")));
                                },
                                child: lessons(text: "Lesson No", number: "4")),
                            InkWell(
                                onTap: () async {
                                  var document = await PDFDocument.fromAsset(
                                      'assets/pdf/quran.pdf');

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PdfViewerScreen(
                                              doc: document, number: "4")));
                                },
                                child:
                                    lessons(text: "Complete", number: "Quran")),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.width * 0.20,
                            )
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
            style: TextStyle(
                color: whiteColor,
                fontFamily: "Lato",
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          Text(
            number,
            style: TextStyle(
                color: whiteColor,
                fontFamily: "Lato",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
