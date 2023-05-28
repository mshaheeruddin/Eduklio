import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signin_interface/signin_as_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MyGoogleButton extends StatelessWidget {
  BuildContext loginScreenContext;

  MyGoogleButton({required this.loginScreenContext});
   SignInUseCase signInUseCase = SignInUseCase();




   Future askForUserRole(BuildContext context) {
     return showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text('Choose a role'),
           content: Text('Continue as a Teacher or a Student?'),
           actions: [
             TextButton(
               child: Text('Continue as Teacher'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
             TextButton(
               child: Text('Continue as Student'),
               onPressed: () {
                 Navigator.of(context).pop();
               },
             ),
           ],
         );
       },
     );
   }



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


