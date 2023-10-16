import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:islamm786/Constants.dart';

import 'hadith.dart';

// ignore: must_be_immutable
class HadithChapters extends StatefulWidget {
  var bookSlug;
  HadithChapters(this.bookSlug, );

  @override
  State<HadithChapters> createState() => _HadithChaptersState();
}

class _HadithChaptersState extends State<HadithChapters> {
  late Map rawdatamap = {};
  late List datalist = [];
  void getapi() async {
    var slug = widget.bookSlug;
    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";
    var res = await http.get(
        Uri.parse("https://hadithapi.com/api/$slug/chapters?apiKey=$apiKey"));

// print("SMASB" + res.body);

    if (res.statusCode == 200) {
      setState(() {
        rawdatamap = jsonDecode(res.body);
        datalist = rawdatamap["chapters"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          leading: InkWell(
            onTap: (){
              Get.back();
            },
              child: Icon(Icons.arrow_back_ios,size: 16,color: Colors.white,)),
          title: Text(
            "Hadith Books Chapters",
            style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: arabicColor,
        ),
      ),
      backgroundColor: Colors.white,
      body: datalist.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  boxShadow:  [
                    BoxShadow(
                        color: Colors.grey.shade700,
                        spreadRadius: 3,
                        blurStyle: BlurStyle.outer,
                        blurRadius: 2)
                  ],
                    //border: Border.all(color:arabicColor)
              ),
              child: ListTile(
                onTap: () {
                  var bookSlug = datalist[index]["bookSlug"];
                  var chapterNumber = datalist[index]["chapterNumber"];
              
                  print(bookSlug + chapterNumber);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Hadiths(bookSlug, chapterNumber),
                      ));
                },
                tileColor: Colors.grey.shade100,
                textColor: Color(0XFF404040),
                leading: CircleAvatar(
                  radius: 15,
                    backgroundColor: arabicColor,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: Color(0XFFF2F2F2),fontSize: 15),
                    )),
              
                title:
              
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
              
                    Text(
                      datalist[index]["chapterArabic"].toString(),
                      style: TextStyle(color:arabicColor,fontFamily: "noorehuda", fontSize: 18,fontWeight: FontWeight.w500),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        datalist[index]["chapterUrdu"].toString(),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                        style: TextStyle(color:black,fontFamily: "Jameelnoori")),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   datalist[index]["chapterEnglish"].toString(),
                    //   textAlign: TextAlign.center,
                    // ),
                  ],
                ),
              
              ),
            ),
          );
        },
        itemCount: datalist.length,
      ),

    );
  }
}