import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class MyAnimatedIconData extends AnimatedIconData {
  const MyAnimatedIconData({required String semanticLabel, required double size});

  @override
  IconData toIcon() {
    return const IconData(0xe000, fontFamily: 'E'); // Replace with the appropriate icon for your SVG file
  }

  @override
  // TODO: implement matchTextDirection
  bool get matchTextDirection => throw UnimplementedError();


}
