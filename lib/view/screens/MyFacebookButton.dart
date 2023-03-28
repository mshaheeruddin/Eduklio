import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyFacebookButton extends StatelessWidget {
  const MyFacebookButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: FaIcon(
        FontAwesomeIcons.facebook,
        color: Colors.white,
      ),
      label: Text(
        'FACEBOOK'
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: (
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Color(
                0x990003B5)
        ),
        fixedSize: Size(150, 50),
      ),
    );
  }
}





