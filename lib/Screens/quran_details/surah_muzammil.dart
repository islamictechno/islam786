
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Constants.dart';

class SurahMuzammil extends StatelessWidget {
  SurahMuzammil({Key? key, required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
        backgroundColor: arabicColor,
        centerTitle: true,
        title: Text('Surah Muzammil',style: TextStyle(color: Colors.white,fontSize: 17),),
//         titleTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                      ),
                      child: Text(snapshot.data!,style: TextStyle(color: Colors.white),),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _pdfViewController.future,
      //   builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData && snapshot.data != null) {
      //       return Row(
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: <Widget>[
      //           FloatingActionButton(
      //             backgroundColor: arabicColor,
      //             heroTag: '-',
      //             child: const Text('-',style: TextStyle(color: Colors.white),),
      //             onPressed: () async {
      //               final PDFViewController pdfController = snapshot.data!;
      //               final int currentPage =
      //                   (await pdfController.getCurrentPage())! - 1;
      //               if (currentPage >= 0) {
      //                 await pdfController.setPage(currentPage);
      //               }
      //             },
      //           ),
      //           FloatingActionButton(
      //             backgroundColor: arabicColor,
      //             heroTag: '+',
      //             child: const Text('+',style: TextStyle(color: Colors.white)),
      //             onPressed: () async {
      //               final PDFViewController pdfController = snapshot.data!;
      //               final int currentPage =
      //                   (await pdfController.getCurrentPage())! + 1;
      //               final int numberOfPages =
      //                   await pdfController.getPageCount() ?? 0;
      //               if (numberOfPages > currentPage) {
      //                 await pdfController.setPage(currentPage);
      //               }
      //             },
      //           ),
      //         ],
      //       );
      //     }
      //     return const SizedBox();
      //   },
      // ),
    );
  }
}