import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:islamm786/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: const Text("Add Notes", style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "Lato"),),
        centerTitle: true,
        leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onTap: (){
              Navigator.pop(context);
          },
        ),
        actions: [
           Padding(
            padding: EdgeInsets.only(right: 10),
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
                    Navigator.of(context).pop();
                  }
                },
                child: Icon(Icons.done, color: Colors.black,)),
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

                TextFormField(
                  controller: textController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter Notes..."
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
