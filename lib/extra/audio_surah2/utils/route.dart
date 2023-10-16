

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:islamm786/extra/audio_surah2/utils/constants/routes.dart';


import '../backend/models/quran_chapter.dart';
import '../frontend/pages/home_page/index.dart';
import '../frontend/pages/read_quran_page/index.dart';

class RouteGenerator {


  static Route onGenerateRoute(RouteSettings settings) {
    String name = settings.name!;
    dynamic arguments = settings.arguments;
    print(arguments);

    switch (name) {

      case HOME_PAGE_SCREEN_ROUTE:
        return MaterialPageRoute(builder: (context) => HomePageScreen(),);
      case INITIAL_ROUTE:
        //return MaterialPageRoute(builder: (context) => ReadQuranPage(quranChapter: arguments as QuranChapter,),);
        return MaterialPageRoute(builder: (context) => HomePageScreen(),);
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}