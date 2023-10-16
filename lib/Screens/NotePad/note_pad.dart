import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamm786/Constants.dart';
import 'package:islamm786/main.dart';

import 'add_notes.dart';

class NotePad extends StatefulWidget {
  const NotePad({Key? key}) : super(key: key);

  @override
  State<NotePad> createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  List _searchList = [] ;
  Future<QuerySnapshot>? postDocum;
  var textEnter;
initSearching(text){
  postDocum=FirebaseFirestore.instance.collection('notes').limit(1).where('text',isGreaterThanOrEqualTo: text).get();

setState(() {
  postDocum;
});
}
// populate _personList
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
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
        title: Text("Notepad", style: TextStyle(color: arabicColor,
            fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "AlQalamQuran"),),
        centerTitle: true,

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: purpleColor,
            child: Icon(Icons.add, size: 30,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddNote()));
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: buttonColor.withOpacity(0.2),
                        blurRadius: 1,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: purpleColor,
                    maxLines: 1,
                    style: const TextStyle(color: blackColor),
                    onChanged: (val){
                      textEnter=val;
                      setState(() {

                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide:  BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder:OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.transparent,),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: "Search", hintStyle: TextStyle(color: blackColor.withOpacity(0.4), fontSize: 14, fontFamily: "Lato"),
                      isDense: true,
                      fillColor: whiteColor,
                      filled: true,

                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search, color: blackColor, size: 25,)),
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                (textEnter==null)?   Container(
                    height: displayHeight*0.7,
                    child:StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('notes').where('token',isEqualTo:tokenDevice).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot doc = snapshot.data!.docs[index];

                                return Padding(
                                  padding:  EdgeInsets.only(bottom: displayHeight*0.02),
                                  child:    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      notePad(doc['text'],doc['date'],doc.id),
                                    ],
                                  ),
                                );
                              }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:  2),);
                        } else {
                          return Text("No data");
                        }
                      },
                    )

                ):Container(
                    height: displayHeight*0.7,
                    child:StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('notes').where('token',isEqualTo:tokenDevice).where('text',isGreaterThanOrEqualTo: textEnter).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];

                              return Padding(
                                padding:  EdgeInsets.only(bottom: displayHeight*0.02),
                                child:    Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    notePad(doc['text'],doc['date'],doc.id),
                                  ],
                                ),
                              );
                            }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:  2),);
                        } else {
                          return Text("No data");
                        }
                      },
                    )

                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget notePad(text,date,id){
    var displayWidth = MediaQuery.of(context).size.width;
    var displayHeight = MediaQuery.of(context).size.height;
    return InkWell(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.27,
          width: MediaQuery.of(context).size.width * 0.438,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: buttonColor.withOpacity(0.2),
                offset: Offset(0, 7),
                blurRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(onTap: (){
                      FirebaseFirestore.instance.collection('notes').doc(id).delete().then((value) => Fluttertoast.showToast(msg: "Deleted",backgroundColor: arabicColor,), );


                    },child: SvgPicture.asset("assets/icons/delete.svg", width: displayWidth*0.02, height: displayHeight*0.02,color: arabicColor,)),
                  ],
                ),
                SizedBox(
                  height: displayHeight * 0.04,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(text,textAlign: TextAlign.justify,maxLines: 1,
                      style: TextStyle(color: arabicColor, fontSize: 16, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: displayHeight * 0.04,
                ),
                Text('$date',style: TextStyle(color: arabicTextColor, fontSize: 16, fontWeight: FontWeight.w400,)),
              ],
            ),
          )
      ),
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context) => Details()));
      },
    );
  }
}
