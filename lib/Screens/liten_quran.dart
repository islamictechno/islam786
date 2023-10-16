import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/extra/audio_surah2/frontend/pages/home_page/components/quran_chapter_list_surah.dart';




class HomePageScreenLitenQuran extends StatelessWidget {
  const HomePageScreenLitenQuran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
        backgroundColor: arabicColor,
        title:  Text("Listen Quran",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: QuranChapterListBySurah()
            ),
          ],
        ),
      ),
    );
  }
}