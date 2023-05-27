import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyTwitterButton extends StatelessWidget {
  MyTwitterButton({Key? key}) : super(key: key);
  SignInUseCase signInUseCase = SignInUseCase();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        signInUseCase.signInWithTwitter(context);
      },
      icon: Padding(
        padding: EdgeInsets.only(left: 14),
        child: FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.white,
        ),
      ),
      label: Text(
          ''
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: (Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Color(
            0xff4886fa)),
        fixedSize: Size(90, 50),
      ),
    );
  }
}