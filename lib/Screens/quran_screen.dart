import 'package:flutter/material.dart';
import 'package:islamm786/api_interface/api_interface.dart';
import 'package:islamm786/app_utils/text_utils.dart';
import 'package:islamm786/controller/common_controller.dart';

class CompleteQuranSrc extends StatefulWidget {
  // const CompleteQuranSrc({super.key});

  @override
  State<CompleteQuranSrc> createState() => _CompleteQuranSrcState();
}

class _CompleteQuranSrcState extends State<CompleteQuranSrc> {
  CommonController commonController = CommonController();
  TextUtils _textUtils = TextUtils();

  @override
  void initState() {
    ApiInterface().getaCompleteQuran();
    debugPrint("Quran Data");

    // debugPrint(ApiInterface().getaCompleteQuran());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.purple.shade900,
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )),
                        const SizedBox(width: 5,),
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.purple.shade900)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.note_alt,size: 15,color: Colors.black87,),
                              _textUtils.medium(
                                  "Tafseer", Colors.black87, 15.0, TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
