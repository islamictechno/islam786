import 'dart:convert';
import 'dart:math';

import '../Models/aya_model.dart';
import 'package:http/http.dart'as http;

import '../Screens/home_screen.dart';
class ApiService{
  Future<AyaOfDay> getAya()async{
    String url='https://api.alquran.cloud/v1/ayah/${random(3, 63)}/editions/quran-uthmani,en.asad,en.pickthall';
final response=await http.get(Uri.parse(url));
print("dsdsds");
print(response.body);

if(response.statusCode==200){
  return AyaOfDay.fromJSON(json.decode(response.body));
}else{
  throw Exception("Failesd");
}
  }
  random(min,max){
    var rn=new Random();
    return min+rn.nextInt(max-min);
  }
}