import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:islamm786/Constants.dart';


import '../../../utils/constants/colors.dart';
import 'components/quran_chapter_list_surah.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
