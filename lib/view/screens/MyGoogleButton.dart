import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyGoogleButton extends StatelessWidget {
  const MyGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.white,
      ),
      label: Text(
          'GOOGLE'
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Color(
            0xefde470b)),
        fixedSize: Size(150, 50),
      ),
    );
  }
}


