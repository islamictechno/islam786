import 'dart:convert';
import 'dart:developer';
// import 'dart:js';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:islamm786/controller/common_controller.dart';
import 'package:islamm786/extra/models/complete_quran.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiInterface extends GetConnect {
  CommonController commonController = Get.put(CommonController());
  // final AppUtils _appUtils = AppUtils();

  final connect = GetConnect();



  /// Get Find Professional Api

  /// Get All Favourites Api
  Future<QuranModel?> getaCompleteQuran() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // String? to = pref.getString(token);
    // String? to = pref.getString(token);
    // debugPrint('token: $to');
    // var headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer $to'
    // };

    var response =
    await get("http://api.alquran.cloud/v1/quran",);
    print("response:${response.statusCode} body: ${response.body}");

    if (response.statusCode == 200) {
      commonController.quranModel.value =
          QuranModel.fromJson(
              response.body as Map<String, dynamic>);

    }
  }

  /// UnFavourite Api

  // ///Get All Appointments
  // Future<GetAllAppointments?> getallappointments() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   // String? to = pref.getString(token);
  //   //  String to = "48|jzLvU4z7l5916xyLIUYpqFKBa6AIoZEV6qMBU6pW";
  //   //debugPrint('token: $to');
  //   connect.timeout = Duration(seconds: 20);
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${commonController.loginResponse.value.token}'
  //   };
  //   var response = await connect.get(
  //       '${ApiIUrl.baseUrl}client/show_all_my_appointments', headers: headers);
  //   if (response.statusCode == 200) {
  //
  //     print(response.body);
  //
  //     commonController.showAllAppointments.value =
  //         GetAllAppointments.fromJson(response.body as Map<String,dynamic>);
  //     //Fluttertoast.showToast(msg: "Sucessfully");
  //   }
  //
  //   print('responseAppointments:${response.statusCode}+ body:${response.body}');
  //   //print('length:${commonController.showAllAppointments.value.allAppointments.}');
  //   /// Get Show single pro details
  //
  // }

}