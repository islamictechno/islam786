import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:islamm786/Constants.dart';

// ignore: must_be_immutable
class Hadiths extends StatefulWidget {
  var slug;
  var number;
  Hadiths(this.slug, this.number, );

  @override
  State<Hadiths> createState() => _HadithsState();
}

class _HadithsState extends State<Hadiths> {
  late Map rawdatamap = {};
  late List datalist = [];
  void getapi() async {
    var bookslug = widget.slug;
    var number = widget.number;
    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";
    var res = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=$apiKey&book=$bookslug&chapter=$number&paginate=100000"));

    // print("SMASB" + res.body);
    if (res.statusCode == 200) {
      setState(() {
        rawdatamap = jsonDecode(res.body);

        datalist = rawdatamap["hadiths"]["data"];
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
        preferredSize:  const Size.fromHeight(40.0),
        child: AppBar(
          leading: InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios,size: 18,color: Colors.white,)),
          title: const Text(
            "Hadith Books Collection",
            style: TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: arabicColor,
        ),
      ),
      body: datalist.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                    title: Text("Hadith Number: " +
                        datalist[index]["hadithNumber"].toString(),
                    style: const TextStyle(color: arabicColor,fontWeight: FontWeight.w600,fontSize: 16),
                    ),
                    trailing: Text("Status :" +
                        datalist[index]["status"].toString(),
                      style: const TextStyle(color: arabicColor,fontWeight: FontWeight.w500,fontSize: 14),
                    )),
                Card(
                  color: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        datalist[index]["hadithArabic"].toString(),
                        style: const TextStyle(
                            fontFamily: "noorehuda",
                            fontSize: 17,
                            color: black,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ),
                // Card(
                //   color: Colors.grey.shade100,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Text(
                //         datalist[index]["hadithUrdu"].toString(),
                //         style: const TextStyle(
                //           fontFamily: "Jameelnoori",
                //           fontSize: 17,
                //           color: black,
                //         ),
                //         textAlign: TextAlign.center,
                //         textDirection: TextDirection.rtl,
                //       ),
                //     ),
                //   ),
                // ),
                // Card(
                //   color: Color(0XFFF2F2F2),
                //   child: Container(
                //     width: double.infinity,
                //     child: Padding(
                //       padding: const EdgeInsets.all(16.0),
                //       child: Text(
                //         datalist[index]["hadithEnglish"].toString(),
                //         style: const TextStyle(
                //           fontFamily: "alq",
                //           fontSize: 20,
                //         ),
                //         textAlign: TextAlign.justify,
                //         textDirection: TextDirection.ltr,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
        itemCount: datalist.length,
      ),
    );

  }
}