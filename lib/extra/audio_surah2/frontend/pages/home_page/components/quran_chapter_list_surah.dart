import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/extra/audio_surah2/frontend/pages/read_quran_page/index.dart';

import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';


import '../../../../backend/models/quran_chapter.dart';
import '../../../../utils/constants/routes.dart';
import '../../../providers/chapter_list_provider.dart';
import '../../../widgets/loading_widget.dart';

class QuranChapterListBySurah extends StatelessWidget {
  const QuranChapterListBySurah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterListProvider>(
      builder: (context, value, child) {
        if (value.loading) {
          return Container(
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 3),
              itemCount: 5,
              itemBuilder: (context, index) {
                return LoadingWidget(
                  child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  leading: SizedBox(
                    width: 50,
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset('assets/numbering_decorator.png'),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text("${index + 1}"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text("Al-Fatiah", style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600
                  ),),
                  subtitle: Text('MECCAN - 7 VERSES', style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400
                  ),),
                  trailing: Text("ةحتافلا", style: TextStyle(
                      fontSize: 20, color: Color(0xFF863ED5)
                  ),),
                ),
                );
              },
            ),
          );
        }
        if (value.errorOccurred) {
          return Container(
            child: Column(
              children: [
                Center(
                  child: Text("${value.message}"),
                ),
                TextButton(onPressed: () => value.initialize(), child: Text("Retry"))
              ],
            ),
          );
        }
        return Container(
          height: 100,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 3),
            itemCount: value.chapters.length,
            itemBuilder: (context, index) {
              QuranChapter chapter = value.chapters[index];
              return FadeInUp(
                child: ListTile(
                  onTap: () =>
                      Get.to(()=>ReadQuranPage(quranChapter: chapter)),
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadQuranPage(quranChapter: chapter))),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  leading: SizedBox(
                    width: 50,
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset('assets/numbering_decorator.png',color: arabicColor,),
                        ),
                        Positioned.fill(
                          child: Center(
                            child: Text("${chapter.id}",style: TextStyle(fontWeight: FontWeight.bold,color: arabicColor),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text("${chapter.nameSimple}", style: TextStyle(
                      color: arabicColor,
                      fontSize: 16, fontWeight: FontWeight.w600
                  ),),
                  subtitle: Text('${chapter.revelationPlace} - ${chapter.versesCount} VERSES', style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400
                  ),),
                  trailing: Text("${chapter.nameArabic}", style: TextStyle(
                    fontFamily: "Noorehira",
                      fontSize: 20, color: arabicColor
                  ),),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
