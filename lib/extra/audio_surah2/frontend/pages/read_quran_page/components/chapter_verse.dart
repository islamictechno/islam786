import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:islamm786/Constants.dart';

import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';


import '../../../../backend/models/chapter_verse.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/end_points.dart';
import '../../../providers/read_chapter_provider.dart';

class ChapterVerseWidget extends StatelessWidget {
  const ChapterVerseWidget({Key? key, required this.chapterVerse}) : super(key: key);
  final ChapterVerse chapterVerse;

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    final readQuranProvider = Provider.of<ReadChapterProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.fromLTRB(0,0,0,15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color(0xFFBBC4CE).withOpacity(.35))
          )
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF863ED5).withOpacity(.05),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: buttonColor.withOpacity(0.1),
                  radius: 15,
                  child: Text("${chapterVerse.verseNumber}", style: TextStyle(
                      fontSize: 18, color: arabicColor,fontWeight: FontWeight.bold
                  ),),

                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(IconlyLight.send, color: arabicColor,),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: () async {
                          readQuranProvider.playVerse("$VERSE_AUDIO_FILE_END_POINT${chapterVerse.audio!.url}", chapterVerse.verseNumber);
                          // await player.play(/);
                        },
                        child: (readQuranProvider.versePlaying && readQuranProvider.playedVerse == chapterVerse.verseNumber) ? Icon(Icons.pause_circle_outline, color: arabicColor,) : Icon(IconlyLight.play, color: arabicColor,)
                      ),
                      SizedBox(width: 10,),
                      Icon(IconlyLight.bookmark, color:arabicColor,),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 30,),
          Container(
            color: (readQuranProvider.currentAyahIndex == chapterVerse.verseNumber! - 1) ? Colors.red.withOpacity(.1) : Colors.transparent,
            // child: RichText(
            //   text: TextSpan(
            //       style: GoogleFonts.amiri(
            //           fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black
            //       ),
            //       children: [
            //         ...chapterVerse.words!.map((e) => TextSpan(
            //             text: '${e.!}'
            //         )),
            //       ]
            //   ),
            //   textAlign: TextAlign.start,
            // ),
            child: Text('${chapterVerse.textUthmani}  ', textAlign:TextAlign.center, style: TextStyle(
              color: arabicColor,
              fontFamily: "Noorehira",
              fontSize: 24
            ),),
            alignment: Alignment.centerRight,
          ),
          SizedBox(height: 15,),
          Container(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontFamily: "AlQalamQuran",
                      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black
                  ),
                  children: [
                    ...chapterVerse.words!.map((e) => TextSpan(
                        text: '${e.transliteration!.text.toString().replaceAll('ull', '')} ',
                      recognizer: TapGestureRecognizer()..onTap = () async {

                          await player.setUrl('$VERSE_AUDIO_FILE_END_POINT${e.audioUrl!}');
                          await player.play();
                      }
                    ))
                  ]
              ),
              textAlign: TextAlign.start,
            ),
            alignment: Alignment.centerLeft,
          ),
          SizedBox(height: 15,),
          Container(
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontFamily: "NooreHidayat",
                      fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black
                  ),
                  children: [
                    ...chapterVerse.words!.map((e) => TextSpan(
                        text: '${e.translation!.text.toString().replaceAll('Ayah ${chapterVerse.verseNumber}', '')} '
                    )),
                  ]
              ),
              textAlign: TextAlign.justify,
            ),
            alignment: Alignment.centerLeft,
          ),

        ],
      ),
    );
  }
}
