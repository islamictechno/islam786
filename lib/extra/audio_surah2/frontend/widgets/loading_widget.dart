import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../utils/constants/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: lightPrimaryColor.withOpacity(.5),
      highlightColor: lightPrimaryColor
    );
  }
}
