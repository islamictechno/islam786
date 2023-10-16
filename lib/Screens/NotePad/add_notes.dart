import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var textController=TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
          return false;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.3,
          title: const Text("Add Notes", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
          centerTitle: true,
          leading: GestureDetector(
              child: const Icon(Icons.arrow_back_ios, color: Colors.black,),
            onTap: (){
                Navigator.pop(context);
            },
          ),
          actions: [
             Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: ()async{
                    if(textController.text.isEmpty){
                      Fluttertoast.showToast(msg: "Type Something");
                    }else {
                      final DateTime now = DateTime.now();
                      DateFormat formatter = DateFormat('yyyy-MM-dd');
                      final String formatted = formatter.format(now);
                      print(formatted);
                      FirebaseFirestore.instance
                          .collection('notes')
                          .add({
                        'text': textController.text,
                        'date': formatted,
                        'token': tokenDevice
                      });
                      Fluttertoast.showToast(msg: "Added");
                       Get.back();
                    }
                  },
                  child: const Icon(Icons.done, color: Colors.black,)),
            )
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Focus(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: textController,

                      maxLines: 5,
                      keyboardType:TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Enter Notes...",
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
