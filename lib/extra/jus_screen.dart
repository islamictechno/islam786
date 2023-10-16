import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:islamm786/Constants.dart';

import 'package:islamm786/extra/widgets/juz_custom_tile.dart';


import 'api_services.dart';
import 'constants/constants.dart';
import 'models/juz.dart';

class JuzScreen extends StatelessWidget {
  static const String id = 'juz_screen';

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.back();
           // Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_sharp,color: Colors.white,)),
          backgroundColor: arabicColor,
          title: Text('Juzz'),
        ),
        body: FutureBuilder<JuzModel>(
          future: apiServices.getJuzz(Constants.juzIndex!),
          builder: (context, AsyncSnapshot<JuzModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            } else if(snapshot.hasData){
              print('${snapshot.data!.juzAyahs.length} length');
              return ListView.builder(
                itemCount: snapshot.data!.juzAyahs.length,
                itemBuilder: (context, index) {
                  return JuzCustomTile(list: snapshot.data!.juzAyahs,index: index,);
                },
              );
            }
            else{
              return Center(child: Text('Data not found'),);
            }
          },
        ),
      ),
    );
  }

}