import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants.dart';
class PdfViewerScreen extends StatefulWidget {
  final doc;
  final number;

  const PdfViewerScreen({Key? key, this.doc, this.number}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  var _isLoading=true;



  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: blackColor,),
          onTap: (){
            Navigator.pop(context);
          },
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Column(
            children: [

              SvgPicture.asset("assets/icons/bismillah.svg", fit: BoxFit.cover,width: 150,)
            ],
          ),
        ),
      ),
      body: (_isLoading==true)?Container(
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
          indicatorText: Colors.white,
          document: widget.doc,
          zoomSteps: 1,
          showIndicator: true,

          showPicker: false,
          showNavigation: true,

        ),
      ):CircularProgressIndicator(),
    );
  }
}
