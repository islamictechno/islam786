import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamm786/Constants.dart';

class Tasbee extends StatefulWidget {
  const Tasbee({Key? key}) : super(key: key);

  @override
  State<Tasbee> createState() => _TasbeeState();
}

class _TasbeeState extends State<Tasbee> {
  int _itemCount = 0;
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
        backgroundColor: whiteColor,
        elevation: 0.3,
        title: Text("Tasbeeh Counter", style: TextStyle(color: blackColor, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: blackColor,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
                child: Icon(Icons.refresh, color: blackColor,),
              onTap: (){
                resetCounter();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,right: 10),
            child: GestureDetector(
              child: Icon(Icons.maximize,color: Colors.black,),
              onTap: (){
                setState(() => _itemCount==0?_itemCount:_itemCount--);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
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
          child: Text("33"),
          onPressed: null,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/tbg.png"),fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: displayHeight * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(
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
                      child: Text(_itemCount.toString(), style: TextStyle(color: borderColor, fontSize: 25, fontWeight: FontWeight.bold),),
                    ),


                  ],
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: buttonbgColor,
                      borderRadius: BorderRadius.all(Radius.circular(90)),
                    ),
                    child: Text("+", style: TextStyle(color: borderColor, fontSize: 40, fontWeight: FontWeight.bold),),
                  ),
                  onTap: (){
                    setState(() => _itemCount == 33?_itemCount:_itemCount++);
                  },
                ),
              ],
            ),
            Align(
              alignment: FractionalOffset.bottomLeft,
              child: SvgPicture.asset("assets/icons/tasbee.svg", width: displayWidth * 0.3, height: displayHeight*0.5,),
            )
          ],
        )
      ),
    );
  }
}
