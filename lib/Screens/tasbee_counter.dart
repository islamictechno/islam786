
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/Screens/tasbee_model/tasbee_model.dart';



class Tasbee extends StatefulWidget {
  const Tasbee({Key? key}) : super(key: key);

  @override
  State<Tasbee> createState() => _TasbeeState();
}

class _TasbeeState extends State<Tasbee> {
  List<bool> soundClick = [
   false,
    false,
    false,
  ];
  int _itemCount = 0;
  int _itemCount33 = 0;
  int _itemCount100 = 0;
  int currentIndex = 0;
bool? selected;
 bool sound=true;
  // final player = AudioCache();
  final player = AudioPlayer();

  void resetCounter() {
    setState(() {
      _itemCount = 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: arabicColor,
        elevation: 0.3,
        title: Text("Tasbeeh Counter", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.white,size: 18,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                child:Icon(sound?Icons.volume_off:Icons.volume_up, color: Colors.white,),
              onTap: (){
                setState(() {
                  sound = !sound;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                child: Icon(Icons.refresh, color: Colors.white,),
              onTap: (){
                resetCounter();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,right: 10),
            child: GestureDetector(
              child: Icon(Icons.maximize,color: Colors.white,),
              onTap: (){
                setState(() => _itemCount==0?_itemCount:_itemCount--);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 5,
            right: 5,
            child: Column(
              children: [
                for (int i = 0; i < tasbeehList.length; i++)
                tasbeehDesign(
                    tasbeehList[i].title, () {
                  setState(() {
                    resetCounter();
                    currentIndex = i;
                  });
                }
                ),

              ],
            ),
          ),
        ],

      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/tbg.png"),fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            if (currentIndex == 0)
            Column(
              children: [
                SizedBox(
                  height: displayHeight * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: displayWidth * 0.40,
                      height: displayHeight * 0.055,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: borderColor, width: 2)
                      ),
                      child: Text(
                        _itemCount.toString(), style: TextStyle(color: borderColor, fontSize: 25, fontWeight: FontWeight.bold),),
                    ),


                  ],
                ),
                const SizedBox(height: 30,),
                GestureDetector(
                  child: Container(
                    width: 110,
                    height: 110,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: buttonbgColor,
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                    ),
                    child: Text("+", style: TextStyle(color: borderColor, fontSize: 45, fontWeight: FontWeight.bold),),
                  ),
                  onTap: ()async
                  {
                    await  sound==false?AssetsAudioPlayer.newPlayer().open(
                      Audio("assets/audio/WhatsApp Audio 2024-01-09 at 02.48.40_1d9d55ad.mp3"),
                      autoStart: true,
                      showNotification: false,
                    ):"";
                    // await player.play(('assets/audio/mech-keyboard-02-102918.mp3'));
                    // player.play("assets/audio/mixkit-digital-clock-digital-alarm-buzzer-992.wav");
                    setState(() {
                      _itemCount++;
    }
                    );

                  },
                ),
              ],
            ),
            if (currentIndex == 1)
              Column(
                children: [
                  SizedBox(
                    height: displayHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: displayWidth * 0.40,
                        height: displayHeight * 0.055,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(color: borderColor, width: 2)
                        ),
                        child: Text(
                          _itemCount.toString(), style: TextStyle(color: borderColor, fontSize: 25, fontWeight: FontWeight.bold),),
                      ),


                    ],
                  ),
                  SizedBox(height: 30,),
                  GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: buttonbgColor,
                        borderRadius: BorderRadius.all(Radius.circular(90)),
                      ),
                      child: Text("+", style: TextStyle(color: borderColor, fontSize: 45, fontWeight: FontWeight.bold),),
                    ),
                    onTap:()async{
                     await  sound==false?AssetsAudioPlayer.newPlayer().open(
                        Audio("assets/audio/WhatsApp Audio 2024-01-09 at 02.48.40_1d9d55ad.mp3"),
                        autoStart: true,
                        showNotification: false,
                      ):"";
                      setState(() {
                        _itemCount == 99?_itemCount:_itemCount++;
                       //_itemCount=_itemCount==99?_itemCount:_itemCount++;
                      }
                      );

                    },
                  ),
                ],
              ),
            if (currentIndex == 2)
              Column(
                children: [
                  SizedBox(
                    height: displayHeight * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: displayWidth * 0.40,
                        height: displayHeight * 0.055,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            border: Border.all(color: borderColor, width: 2)
                        ),
                        child: Text(
                          _itemCount.toString(), style: TextStyle(color: borderColor, fontSize: 25, fontWeight: FontWeight.bold),),
                      ),


                    ],
                  ),
                  const SizedBox(height: 30,),
                  GestureDetector(
                    child: Container(
                      width: 110,
                      height: 110,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: buttonbgColor,
                        borderRadius: BorderRadius.all(Radius.circular(55)),
                      ),
                      child: Text("+", style: TextStyle(color: borderColor, fontSize: 45, fontWeight: FontWeight.bold),),
                    ),
                    onTap: ()async{
                     await sound==false?
                     AssetsAudioPlayer.newPlayer().open(
                        Audio("assets/audio/WhatsApp Audio 2024-01-09 at 02.48.40_1d9d55ad.mp3"),
                        autoStart: true,
                        showNotification: false,
                      ):"";
                      setState(() {
                        _itemCount == 33?_itemCount:_itemCount++;
                      }







                      );

                    },
                  ),
                ],
              ),

            Align(
              alignment: FractionalOffset.bottomLeft,
              child: SvgPicture.asset("assets/icons/tasbee.svg", width: displayWidth * 0.3, height: displayHeight*0.5,),
            ),
          ],
        )
      ),
    );
  }

  tasbeehDesign(text,onPress) {
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
     return  Container(
       decoration: BoxDecoration(
           image: DecorationImage(
               image: AssetImage("assets/icons/fab.png",)
           )
       ),
       width: displayWidth* 0.2,
       height: displayHeight * 0.1,
       child: FloatingActionButton(
         backgroundColor: Colors.transparent,
         elevation: 0,
         child: Text(text,style: TextStyle(color:Colors.white,fontSize: 18),),
         onPressed: onPress,
       ),
     );
  }
}
