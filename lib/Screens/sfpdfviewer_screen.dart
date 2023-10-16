
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() => runApp(SfPDFScreen());

class SfPDFScreen extends StatefulWidget {
  // String? filePath;

  @override
  _SfPDFScreenState createState() => _SfPDFScreenState();
}

class _SfPDFScreenState extends State<SfPDFScreen> {
  PdfViewerController? _pdfViewerController;

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
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios,size: 20,color: Colors.white,)),
        backgroundColor: arabicColor,
        title: const Center(child: Padding(
          padding: EdgeInsets.only(right: 48.0),
          child: Text('Quran',),
        )),
        titleTextStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
      ),
      body:
      Center(
        child: SfPdfViewer.asset(
        "assets/pdf/Quran-with-Big-Font_compressed.pdf",
          onDocumentLoaded: (details) {
            _pdfViewerController;
          },
          initialScrollOffset: Offset.fromDirection(850),
          // 'https://downloadthequran.com/wp-content/uploads/2017/12/Quran-with-Big-Font.pdf',
          scrollDirection: PdfScrollDirection.vertical,
           initialZoomLevel: BorderSide.strokeAlignCenter,
          // onTextSelectionChanged:
          //     (PdfTextSelectionChangedDetails details) {
          //   if (details.selectedText == null && _overlayEntry != null) {
          //     _showContextMenu(context, details);
          //
          //   } else {
          //     _overlayEntry?.remove();
          //     _overlayEntry = null;
          //   }
          // },
          controller: _pdfViewerController,
        ),
      ),
    );
  }
}

