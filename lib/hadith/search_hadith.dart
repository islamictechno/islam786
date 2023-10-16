import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:islamm786/Constants.dart';

class SearchHadith extends StatefulWidget {
  // const SearchHadith({super.key});

  @override
  State<SearchHadith> createState() => _SearchHadithState();
}

class _SearchHadithState extends State<SearchHadith> {
  late Map rawdatamap = {};
  late List datalist = [];
  late String searchInput = "";
  late String selectlang = "";
  bool isLoading = false;
  TextEditingController _searchController = TextEditingController();

  void getapi(String value) async {
    setState(() {
      isLoading = true;
    });

    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";

    var hadithApiBase =
        "https://hadithapi.com/public/api/hadiths?apiKey=$apiKey&paginate=100000";

    String queryParam = '';

    if (value == 'Arabic') {
      queryParam = 'hadithArabic';
    } else if (value == 'Urdu') {
      queryParam = 'hadithUrdu';
    } else if (value == 'English') {
      queryParam = 'hadithEnglish';
    } else if (value == 'Hadith No') {
      queryParam = 'hadithNumber';
    } else {
      print("Please select a search type first.");
      return;
    }

    var res =
    await http.get(Uri.parse("$hadithApiBase&$queryParam=$searchInput"));
    if (res.statusCode == 200) {
      setState(() {
        rawdatamap = jsonDecode(res.body);
        datalist = rawdatamap["hadiths"]["data"];
        isLoading = false;
      });
    }
    // print("SMASB" + res.body);
  }
  List<dynamic> searchInData(List<dynamic> data, String searchTerm) {
    return data.where((item) {
      final itemData = item.toString().toLowerCase();
      return itemData.contains(searchTerm.toLowerCase());
    }).toList();
  }

  final FocusNode _textFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_textFieldFocusNode.hasFocus) {
          _textFieldFocusNode.unfocus();
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
             Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "سرچ کے لیے مندرجہ ذیل آپشن کو پہلے  منتخب کیجیے",
                style: TextStyle(
                  fontFamily: "Jameelnoori",
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: CustomRadioButton(
                margin: EdgeInsets.only(right: 5),
                absoluteZeroSpacing: true,
                elevation: 0,
                unSelectedBorderColor: Color(0XFFD9D9D9),
                enableShape: true,
                selectedBorderColor: arabicColor,
                selectedColor: arabicColor,
                unSelectedColor: Color(0XFFD9D9D9),
                buttonLables: ['Arabic', 'Urdu',  'Hadith'],
                buttonValues: ['Arabic', 'Urdu',  'Hadith'],
                buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: black,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (String value) {
                  setState(() {
                    selectlang = value;
                    print("Select language");
                    print(selectlang);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                enabled: true,
                controller: _searchController,
                focusNode: _textFieldFocusNode ,
                decoration: selectlang == 'Urdu' || selectlang == 'Arabic'
                    ? const InputDecoration(
                    filled: true,
                    hintText: " ..... تلاش کریں ",
                    hintStyle: TextStyle(color: black),
                    suffixIcon: Icon(Icons.search_rounded,color: black,))
                    : InputDecoration(

                    hintText: "Search Here.....  ",
                    hintStyle: TextStyle(color: black),
                    prefixIcon: Icon(Icons.search_rounded,color: black,)),
                onSubmitted: (value){
                  setState(() {
                    _textFieldFocusNode.requestFocus();
                    //searchInData(datalist, value);
                    searchInput=value;
                  });

                  print("search value smas=>" + searchInput);
                },
                style: selectlang == 'Urdu' || selectlang == 'Arabic'
                    ? TextStyle(fontFamily: "jameel")
                    : TextStyle(fontFamily: "alq"),
                textAlign: selectlang == 'Urdu' || selectlang == 'Arabic'
                    ? TextAlign.right
                    : TextAlign.left,
                textDirection: selectlang == 'Urdu' || selectlang == 'Arabic'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            ),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    getapi(selectlang);
                  });

                },
                child: Text("Search")),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemBuilder: (context, index) {
                  String hadithdata = '';

                  if (selectlang == 'Arabic') {
                    hadithdata = 'hadithArabic';
                  } else if (selectlang == 'Urdu') {
                    hadithdata = 'hadithUrdu';
                  } else if (selectlang == 'English') {
                    hadithdata = 'hadithEnglish';
                  } else {
                    print("Please select a search type first.");
                  }

                  String searchResult =
                  datalist[index][hadithdata].toString();
                  print("below smas" + hadithdata);
                  String searchTerm = searchInput;
                  int startIndex = searchResult.indexOf(searchTerm);

                  if (startIndex != -1) {
                    String first20Words = searchResult.substring(startIndex,
                        min(startIndex + 50, searchResult.length));

                    return Card(
                      color: Colors.grey.shade100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                              title: Text("Hadith Number:" +
                                  datalist[index]["hadithNumber"]
                                      .toString(),
                                style: TextStyle(color: black,fontSize: 15),
                              ),
                              trailing: Text("Status :" +
                                  datalist[index]["status"].toString(),
                                style: TextStyle(color: black,fontSize: 15),)),
                          Card(
                            color: Colors.grey.shade50,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    first20Words.toString(),
                                    style:

                                    selectlang == 'Urdu' ||
                                        selectlang == 'Arabic'
                                        ? TextStyle(fontFamily: "Jameelnoori",color: black)
                                        : TextStyle(fontFamily: "noorehuda",color: black),
                                    textAlign: selectlang == 'Urdu' ||
                                        selectlang == 'Arabic'
                                        ? TextAlign.center
                                        : TextAlign.center,
                                    textDirection: selectlang == 'Urdu' ||
                                        selectlang == 'Arabic'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
                itemCount: datalist.length,
              ),
            ),
          ],
        ),

      ),
    );
  }
}