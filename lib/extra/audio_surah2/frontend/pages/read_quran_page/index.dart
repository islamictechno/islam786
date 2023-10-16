import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';

import 'package:islamm786/Constants.dart';
import 'package:islamm786/app_utils/text_utils.dart';
import 'package:provider/provider.dart';


import '../../../backend/models/quran_chapter.dart';
import '../../../utils/constants/colors.dart';
import '../../providers/read_chapter_provider.dart';
import '../../widgets/loading_widget.dart';
import 'components/chapter_detail.dart';
import 'components/chapter_verse.dart';

class ReadQuranPage extends StatelessWidget {
  ReadQuranPage({Key? key, required this.quranChapter}) : super(key: key);
  ScrollController listScrollController = ScrollController(
    keepScrollOffset: true, initialScrollOffset: 1.0
  );
  final QuranChapter quranChapter;
  TextUtils _textUtils=TextUtils();



  @override
  Widget build(BuildContext context) {
    // final chapter = ModalRoute.of(context)!.settings.arguments as QuranChapter;
    // print(chapter);
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ReadChapterProvider(quranChapter),)
          ],
          child: Consumer<ReadChapterProvider>(
            builder: (context, value, child) {
              QuranChapter chapter = value.chapter;
              print(value.allVersePlayerState);
              return Stack(
                children: [       
                  Positioned.fill(
                    top: 60,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        controller: value.scrollController,
                        // physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [

                            ChapterDetail(quranChapter: quranChapter),

                            // SizedBox(height: 24,),
                            ListView.builder(
                              shrinkWrap: true, primary: false,
                              padding: EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                return value.loading ?
                                LoadingWidget(

                                    child:
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.fromLTRB(0,0,0,15),
                                  decoration: const BoxDecoration(

                                      border: Border(
                                          bottom: BorderSide(color: arabicColor)
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: arabicColor,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              radius: 15,
                                              child: Text("${index + 1}", style: TextStyle(
                                                  fontSize: 18, color: Colors.white
                                              ),),
                                              backgroundColor: MaterialColor(0xFF863ED5, colorMap).withOpacity(.5),
                                            ),
                                            Container(
                                              height:30,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.black87,
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: arabicColor)
                                              ),
                                              child: Center(child: _textUtils.medium("Tafseer", arabicColor, 14.0, TextAlign.center)),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [

                                                Icon(IconlyLight.send, color: arabicColor,),
                                                SizedBox(width: 10,),
                                                Icon(IconlyLight.play, color:  arabicColor,),
                                                SizedBox(width: 10,),
                                                Icon(IconlyLight.bookmark, color:  arabicColor,),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30,),
                                      Container(
                                        child: Text('َﻦﻳِمَلٰعْلا ِّبَر ِهَّلِل ُدْمَحْلا', style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w400
                                        ), textAlign: TextAlign.end,),
                                        alignment: Alignment.centerRight,
                                      ),
                                      const SizedBox(height: 15,),
                                      Container(
                                        child:Text('[All] praise is [due] to Allah, Lord of the worlds -', style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w400
                                        ), textAlign: TextAlign.end,),
                                        alignment: Alignment.centerRight,
                                      ),
                                    ],
                                  ),
                                )) :
                                ChapterVerseWidget(chapterVerse: value.verses[index]);
                              },
                              itemCount: value.loading ? 1 : value.verses.length,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0, left: 0, right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: const Icon(IconlyBold.arrowLeft,
                                    color: Color(0xFF8789A3),),
                                  onTap: () => Get.back(),
                                ),
                                SizedBox(width: 20,),
                                Expanded(
                                  child: Text("${chapter.nameSimple}", style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700, color: arabicColor
                                  ),),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )),
                  Positioned(
                    right: 0, left: 0, bottom: 0,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                if ([PlayState.Buffering, PlayState.Loading].contains(value.allVersePlayerState))
                                  ...[
                                    Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: arabicColor,
                                        ),
                                      ),
                                    ),
                                  ],

                                Container(
                                  child: Center(
                                    child: InkWell(
                                        onTap: () async {
                                          value.playAllVerse();
                                        },
                                        child: Icon(value.allVersePlaying ? Icons.pause_circle_filled_rounded : IconlyBold.play, size: 40, color: arabicColor,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 15,),
                          Expanded(
                            child: Container(
                              child: Text('${chapter.nameSimple}'),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
