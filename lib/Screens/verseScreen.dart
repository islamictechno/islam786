import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';

import '../extra/audio_surah2/frontend/pages/home_page/components/quran_chapter_list_surah.dart';
import '../extra/audio_surah2/frontend/pages/home_page/index.dart';
class VerseScreen extends StatefulWidget {


  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: arabicColor,
          leading: InkWell(onTap: (){
            Get.back();
          },
              child: Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
          title: Text("Verse ",style: TextStyle(color: Colors.white,fontSize: 18),),
          centerTitle: true,
        ),
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
