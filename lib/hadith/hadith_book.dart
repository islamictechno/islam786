import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:islamm786/Constants.dart';

import 'haidth_chapter.dart';

class HadithBooks extends StatefulWidget {
  // const HadithBooks({super.key});

  @override
  State<HadithBooks> createState() => _HadithBooksState();
}

class _HadithBooksState extends State<HadithBooks> {
  late Map rawdatamap = {};
  late List datalist = [];

  void getapi() async {
    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";
    var res = await http
        .get(Uri.parse("https://hadithapi.com/api/books?apiKey=$apiKey"));
// print("SMASB" + res.body);

    if (res.statusCode == 200) {
      setState(() {
        print("Api Data:");
        rawdatamap = jsonDecode(res.body);
        datalist = rawdatamap["books"];
        print("Api Data:");
        print(rawdatamap["books"]);
      });
    }
  }
  List imgList = [
    Image.asset('assets/bukhari new.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/muslim new.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/tirmzi.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/abu dawood new.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/ibne maja new.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/nisaiiiiiiiiii.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/png bukhari.png',color: arabicColor,height: 55,width: 200,),
    Image.asset('assets/png bukhari.png',color: arabicColor,height: 30,width: 150,),
    Image.asset('assets/png bukhari.png',color: arabicColor,height: 30,width: 150,),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapi();
    print("Api Data:");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: datalist.isEmpty
          ? SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          )
          : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 58.0),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                  gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 2 / 1.3,
                      crossAxisSpacing: 15,
                      // mainAxisSpacing: 15,
                    maxCrossAxisExtent: 200,
                  ),padding: const EdgeInsets.only(left: 10,right: 10),
                  itemCount: datalist.length>6?6:datalist.length,

                  itemBuilder: (BuildContext ctx, index) {
                      // if(datalist.length<5)
                      return InkWell(
                      onTap: (){
                        var bookSlug = datalist[index]["bookSlug"];
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HadithChapters(bookSlug),
                            ));
                      },
                      child:
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(

                          margin: const EdgeInsets.symmetric(vertical: 5,),
                                            decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.grey.shade200,
                          boxShadow: const [
                            BoxShadow(
                                color: arabicColor,
                                spreadRadius: 3,
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2)
                          ],

                                            //     image: DecorationImage(
                                            // image:imgList[index],
                                            //
                                            // fit: BoxFit.fill,
                                            // ),
                                            ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Image.asset("assets/png bukhari.png",height: 45,width: 120,color: arabicColor,),
                          // Text("Chapters :" +
                          //     datalist[index]["chapters_count"].toString()),
                              imgList[index],
                          Text("Ahadiths :" +
                                            datalist[index]["hadiths_count"].toString(),
                          style: TextStyle(color: black),),
                              // Text(
                              //   datalist[index]["bookName"].toString(),
                              //   style: TextStyle(fontFamily: "alq"),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
      // ListView.builder(
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child:
      //       ListTile(
      //         onTap: () {
      //           var bookSlug = datalist[index]["bookSlug"];
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => HadithChapters(bookSlug),
      //               ));
      //         },
      //         tileColor:  Colors.white,
      //         textColor: arabicTextColor,
      //         title:
      //         Image.asset("assets/png bukhari.png",height: 85,width: 120,color: arabicColor,),

      //         // subtitle: Text(datalist[index]["writerName"].toString()),
      //         leading: Text("${index + 1}"),
      //         trailing: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             datalist[index]["hadiths_count"] == "0"
      //                 ? Text("")
      //                 :
      //
      //             Text("Ahadiths :" +
      //                 datalist[index]["hadiths_count"].toString()),
      //             Text("Chapters :" +
      //                 datalist[index]["chapters_count"].toString()),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      //   itemCount: datalist.length,
      // ),
      backgroundColor: Colors.white,
    );
  }
}