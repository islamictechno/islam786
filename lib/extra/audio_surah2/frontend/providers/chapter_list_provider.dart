

import '../../backend/models/quran_chapter.dart';
import '../../backend/services/implementation/index.dart';
import '../../utils/base_provider.dart';

class ChapterListProvider extends BaseProvider {

  List<QuranChapter> chapters = [];

  ChapterListProvider() {
    initialize();
  }

  void initialize() async {
    try {
      backToLoading(msg: 'Loading...');
      chapters = await quranServiceApi.getListOfChapters();
      print(chapters);
      backToLoaded();
    } catch (error) {
      backToFailed(msg: "Error: $error");
      rethrow;
    }
  }
}