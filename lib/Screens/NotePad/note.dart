import 'package:flutter/material.dart';
class Note extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
          )
        ],
      ),
    );
  }
}
