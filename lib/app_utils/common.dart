

import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Constants.dart';

class Common{
  static String fontFamily = "Uthmani";
  static String fontFamilyTeko = "Uthman";
  // static String secretKey = "sk_test_51NqC6wJZTlfftfa0vEfSsIwlCiVak0nlQ4rbGLYA9WjfoJuKRjxx2jGirFhzHw5Iq7pCKIN8MyX33ajJelD4cTpx00Sl1bCNmQ";
  //
  // static String? verificationIDReceived;
  // static String? codeSent;
  // static int? resendToken;
  // static PhoneAuthCredential? credential;
  // static bool verified = false;

}
class MoveController extends GetxController{
  double _move = 10;
  double _startPos = 0;

  double get startPos => _startPos;
  double get move => _move;

  @override
  void onInit() {
    _startPos = 500;
    // TODO: implement onInit
    super.onInit();
  }

  void setPos(double valueStart){
    _startPos = valueStart;
    _move = move +10;
    update();
  }

  void setMove(){
    _move = 10;
    update();
  }

}
ComingSoon(height,width){
  return SizedBox(
      height: height,
      width: width,
      child: const Center(child: Text("Coming in March",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: black),)));
}
