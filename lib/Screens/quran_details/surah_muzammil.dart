
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'dart:io';

class SurahMuzammil extends StatefulWidget {
  final doc;
  final number;

  const SurahMuzammil({Key? key, this.doc, this.number}) : super(key: key);
  @override
  _SurahMuzammilState createState() => _SurahMuzammilState();
}

class _SurahMuzammilState extends State<SurahMuzammil> {
  PdfViewerController? _pdfViewerController;
  var _isLoading=true;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  OverlayEntry? _overlayEntry;
  void _showContextMenu(BuildContext context,PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion?.bottomLeft.dx,
        child:
        ElevatedButton(
          child: const Text('Search',
              style: TextStyle(fontSize: 17)),
          onPressed: (){
            Clipboard.setData(ClipboardData(text: details.selectedText!));
            _pdfViewerController?.clearSelection();
          },),
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
          backgroundColor: arabicColor,
          title: const Center(child: Padding(
            padding: EdgeInsets.only(right: 48.0),
            child: Text('Surah Muzammil',),
          )),
          titleTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
        ),
        body:Center(
          child: (_isLoading==true)?Container(
            height: MediaQuery.of(context).size.height,
            child: PDFViewer(
              tooltip: PDFViewerTooltip(
                first: 'First',
                next: 'Next',
                jump: 'Jump',
                last: '569',

                pick: 'Pick a Page',

              ),
              scrollDirection: Axis.vertical,
              enableSwipeNavigation: true,
              //indicatorText: Colors.white,
              document: widget.doc,
              zoomSteps: 1,
              showIndicator: true,

              showPicker: false,
              showNavigation: true,

            ),
          ):CircularProgressIndicator(),)
      // SfPdfViewer.asset(
      //   'assets/pdf/36-surah-ya-sin.pdf',
      //   // onTextSelectionChanged:
      //   //     (PdfTextSelectionChangedDetails details) {
      //   //   if (details.selectedText == null && _overlayEntry != null) {
      //   //     _showContextMenu(context, details);
      //   //
      //   //   } else {
      //   //     _overlayEntry?.remove();
      //   //     _overlayEntry = null;
      //   //   }
      //   // },
      //   controller: _pdfViewerController,
      // ),
    );
  }
}

