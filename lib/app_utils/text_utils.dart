import 'package:flutter/material.dart';
import 'package:islamm786/app_utils/common.dart';

class TextUtils {
  String fontFamily = Common.fontFamily;

  Text normal(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
     // overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize:fontSize, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }


}
class TextUtil {
  String fontFamily = Common.fontFamilyTeko;

  Text normal(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      // overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize:fontSize, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }


}