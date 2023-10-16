
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:islamm786/extra/models/complete_quran.dart';

class CommonController extends GetxController {


   Rx<QuranModel> quranModel = QuranModel().obs;
  // Rx<UserLoginModel> loginResponse = UserLoginModel().obs;

}