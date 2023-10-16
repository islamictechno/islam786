import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islamm786/AppPrefs.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/Screens/tasbee_counter.dart';
import 'package:lamsz_quran_api/api/quran_api.dart';
import 'package:lamsz_quran_api/model/surah_header_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_bar.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}
class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: 8.0,
      width: isActive ? 10.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ?buttonColor: whiteColor ,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/check.png"),fit: BoxFit.fill,
            )
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 130.0),
                        const Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                'Recite Quran',
                                style: TextStyle(color: whiteColor, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Lato"),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Carry your digital Quran with you at all times and recite the Holy Quran anytime in Arabic with translation and Tafseer.',textAlign: TextAlign.center,
                                      style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500, fontFamily: "Lato",),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/quran.png",width: 300,height: 300, fit: BoxFit.cover,),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 130.0),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                'Prayer Times',
                                style: TextStyle(color: whiteColor, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Lato"),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Get notified of prayer times for the daily prayers as per your current location and never miss your prayer in a foreign land!',textAlign: TextAlign.center,
                                      style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w300, fontFamily: "Lato",),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/prayer.png",width: 300,height: 300, fit: BoxFit.fill,),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 130.0),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                'Qibla Direction',
                                style: TextStyle(color: whiteColor, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Lato"),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Locate the accurate qibla direction and pray wherever you are! Turn on your location services to find direction.',textAlign: TextAlign.center,
                                      style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w300, fontFamily: "Lato",),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/qibla.png",width: 300,height: 300, fit: BoxFit.fill,),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 130.0),
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            children: [
                              Text(
                                'Live Sessions',
                                style: TextStyle(color: whiteColor, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: "Lato"),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Learn Holy Quran from the best instructors in the world & understand the essence of Holy Book through live sessions as per your time zone. ',textAlign: TextAlign.center,
                                      style: TextStyle(color: whiteColor, fontSize: 20, fontWeight: FontWeight.w300, fontFamily: "Lato",),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/live.png",width: 300,height: 300, fit: BoxFit.fill,),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: _buildPageIndicator(),
                    ),
                  ),
                  _currentPage != _numPages - 1
                      ? Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: MaterialButton(
                        onPressed: () async{

                          print(_currentPage);
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                  color: whiteColor, fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Lato"
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ) :
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: MaterialButton(
                        onPressed: () async{
                          SharedPreferences sp=await SharedPreferences.getInstance();
                        AppPrefs.setPhoneNumber('true');
                          Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => BottomBarNavigate()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Get Started !',
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Lato"
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
