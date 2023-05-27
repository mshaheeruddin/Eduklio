import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyGoogleButton extends StatelessWidget {
   MyGoogleButton({Key? key}) : super(key: key);
  SignInUseCase signInUseCase = SignInUseCase();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        signInUseCase.loginGoogle(context);
      },
      icon: Padding(
          padding: EdgeInsets.only(left: 14),
          child: SvgPicture.asset(
            'assets/svgs/logo_google.svg',
            width: 40.0,
            height: 40.0,
          )),
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
            0xffffffff)),
        fixedSize: Size(90, 50),
      ),
    );
  }
}


