import 'package:flutter/material.dart';
import 'package:islamm786/Constants.dart';
import '../models/qari.dart';

class QariCustomTile extends StatefulWidget {
  const QariCustomTile({Key? key ,required this.qari,required this.ontap}) : super(key: key);

  final Qari qari;
  final VoidCallback ontap;

  @override
  _QariCustomTileState createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          //alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color:buttonColor.withOpacity(0.1),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0,1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.qari.name!,textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16,color: arabicColor),),
            ],
          ),
        ),
      ),
    );
  }
}
