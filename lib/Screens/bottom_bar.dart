import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/Screens/NotePad/note_pad.dart';
import 'package:islamm786/Screens/dua_screen.dart';
import 'package:islamm786/Screens/home_screen.dart';
import 'package:islamm786/Screens/lesson.dart';
import 'package:islamm786/app_utils/common.dart';

import 'package:islamm786/extra/quran_screen.dart';

import 'more.dart';
final List<Map <String, dynamic>>pageDetails=[
{

  "pageName":HomeScreen(),

},
  {
    "pageName":Dua(),

  },
  {
    "pageName":QuranScreen(),

  },
  {
    "pageName":Lesson(),
  },
  {
    "pageName":More(),
  },
];


class BottomBarNavigate extends StatefulWidget {
  @override
  State createState() {
    return _BottomBarNavigateState();
  }
}

class _BottomBarNavigateState extends State {
  Widget? _child;

  int _selectedIndex = 0;

  @override
  void initState() {
    //  _activePageindex= 2;
    //
    // if(_activePageindex= 2){
    //   HomeScreen();
    // }

    // _child = HomeScreen();
    super.initState();
  }
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int index = 0;
  PageController _pageController= PageController(initialPage: 0);
  int _activePageindex = 0;
  @override
  Widget build(context) {
    // Get.put(MoveController());
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      // Get.put(MoveController());
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: Scaffold(
          backgroundColor: Color(0xFF75B7E1),
          extendBody: true,
          body:PageView(
            controller: _pageController,
            //physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index){
              setState(() {
                _activePageindex = index;
              });
            },
            // controller: _pageController,
            children: <Widget>[
              pageDetails[0]["pageName"],
              pageDetails[1]["pageName"],
              pageDetails[2]["pageName"],
              pageDetails[3]["pageName"],
              pageDetails[4]["pageName"],
              // Center(
              //   child: HomeScreen(),
              // ),
              // Center(
              //   child: QuranScreen(),
              // ),
              // Center(
              //   child: NotePad(),
              // ),
              // Center(
              //   child: Lesson(),
              // ),
              // Center(
              //   child:More(),
              // ),

              //You have to define all screens here
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(

            height: 50,
            color: Color(0xff9662d6),
            backgroundColor: Colors.white,
            index: _activePageindex,
            key: _bottomNavigationKey,
            items: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/bottom/home.svg',height: 20.0,width: 20.0,color: _activePageindex==0?Colors.white:Colors.white, ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/bottom/pray.svg',height: 20.0,width: 20.0, color: _activePageindex==3?Colors.white:Colors.white,)
          ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/icons8-quran-66.png", height: 25,width: 25,color: _activePageindex==2?Colors.white:Colors.white,)

                // SvgPicture.asset('assets/bottom/quran.svg',height: 15.0,width: 15.0, ),
              ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/bottom/madni.svg',height: 25.0,width: 25.0, color: _activePageindex==3?Colors.white:Colors.white,),
          ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Image.asset("assets/icons8-more-100.png", height: 30,width: 30,color: _activePageindex==2?Colors.white:Colors.white,),
             ),

            ],
            onTap: (index) {
              setState(() {
                // index=_handleNavigationChange;
                _pageController.animateToPage(

                    index, duration: Duration(microseconds: 40), curve: Curves.ease

                );


              });
            },
          ),
          // bottomNavigationBar: Container(
          //    //height: 77.0,
          //   child: BottomNavigationBar(
          //     type:  BottomNavigationBarType.fixed,
          //     onTap: _handleNavigationChange,
          //     items: [
          //       BottomNavigationBarItem(icon:CircleAvatar(
          //       backgroundColor:_handleNavigationChange==0? darkPurpleColor:buttonColor.withOpacity(0.1),
          //           radius: 20.0,
          //           child: SvgPicture.asset('assets/bottom/quran.svg',height: 17.0,width: 17.0,)),label: "" ),
          //       BottomNavigationBarItem(icon:CircleAvatar(
          //           backgroundColor: _handleNavigationChange==1? darkPurpleColor:buttonColor.withOpacity(0.1),
          //           radius: 20.0,
          //           child: SvgPicture.asset('assets/bottom/note.svg',height: 20.0,width: 20.0)),label: "" ),
          //       BottomNavigationBarItem(icon:CircleAvatar(
          //           backgroundColor: _handleNavigationChange==2? darkPurpleColor:buttonColor.withOpacity(0.1),
          //           radius: 23.0,
          //           child: SvgPicture.asset('assets/bottom/home.svg',height: 17.0,width: 17.0,color: Colors.white,)),label: "" ),
          //       BottomNavigationBarItem(icon:CircleAvatar(
          //
          //           backgroundColor: _handleNavigationChange==3? darkPurpleColor:buttonColor.withOpacity(0.1),
          //           radius: 20.0,
          //           child: SvgPicture.asset('assets/bottom/madni.svg',height: 20.0,width: 20.0)),label: "" ),
          //       BottomNavigationBarItem(icon:CircleAvatar(
          //
          //           backgroundColor: _handleNavigationChange==4? darkPurpleColor:buttonColor.withOpacity(0.2),
          //           radius: 20.0,
          //           child: Icon(Icons.more_vert)),label: ""),
          //
          //
          //     ],
          //     // currentIndex: _selectedIndex,
          //     // onChange: _handleNavigationChange,
          //     // style: const FluidNavBarStyle(
          //     //
          //     //   iconSelectedForegroundColor: buttonColor,
          //     //   barBackgroundColor: verseColor,
          //     //     iconBackgroundColor: Color(0xffEDDFF8),
          //     //     iconUnselectedForegroundColor: purpleColor
          //     // ),
          //     // scaleFactor: 1.5,
          //     // defaultIndex: 2,
          //     // itemBuilder: (icon, item) => Semantics(
          //     //   label: icon.extras!["label"],
          //     //   child: item,
          //     // ),
          //   ),
          // ),
        ),
      ),
    );
  }

  // void _handleNavigationChange(int index) {
  //   setState(() {
  //     switch (index) {
  //       case 0:
  //
  //         _child = QuranScreen();
  //         break;
  //       case 1:
  //         _child = NotePad();
  //         break;
  //       case 2:
  //         _child = HomeScreen();
  //         break;
  //       case 3:
  //         _child = Lesson();
  //         break;
  //       case 4:
  //         _child = More();
  //         break;
  //     }
  //     _child = AnimatedSwitcher(
  //
  //       switchInCurve: Curves.easeOut,
  //       switchOutCurve: Curves.easeIn,
  //       duration: const Duration(milliseconds: 500),
  //       child: _child,
  //     );
  //   });
  // }
}