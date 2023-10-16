import 'package:flutter/material.dart';
import 'package:islamm786/Constants.dart';
class DeveloperInfo extends StatefulWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  _DeveloperInfoState createState() => _DeveloperInfoState();
}

class _DeveloperInfoState extends State<DeveloperInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: arabicTextColor,
        title: Text('Developer',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: buttonColor.withOpacity(0.1),
                    image: const DecorationImage(
                      image: AssetImage('assets/developer.png',),fit: BoxFit.contain
                    ),
                    borderRadius: BorderRadius.circular(90),

                  ),

                ),
                Text('Eng.  Mehar  Muhammd  Umair',
                  style: TextStyle(color: arabicColor,fontWeight: FontWeight.w700,
                      fontFamily: 'AlQalamQuran',fontSize: 18),),
                Container(
                  width: 270,
                  child: Text('Specialist  in  Mobile  App  Development  For  IOS  &  Android.',textAlign: TextAlign.center,
                    style: TextStyle(color: arabicColor,fontFamily: 'AlQalamQuran',
                       fontSize: 16)),
                ),
                Text('meharumair85@gmail.com',
                  style: TextStyle(color: arabicColor,fontWeight: FontWeight.w300,
                     fontSize: 14),)

              ],
            )
          ],
        ),
      ),
    );
  }
}
