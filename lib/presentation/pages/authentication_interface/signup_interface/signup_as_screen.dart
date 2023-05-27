import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_student.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupAs extends StatefulWidget {
  const SignupAs({Key? key}) : super(key: key);

  @override
  State<SignupAs> createState() => _SignupAsState();
}

class _SignupAsState extends State<SignupAs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1.0),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
        child: Column(
          children: [
            Text(
              'Signup as',
              style: GoogleFonts.acme(color: Colors.black,decoration: TextDecoration.none, fontSize: 40, ),
              textAlign: TextAlign.center,


            ),
            SizedBox(height: 10),
            //TEACHER SIGNUP BUTTON
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupTeacher()));
            },

              child: Text('TEACHER'),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(326, 50)), // change the width and height as required
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // change the value of the radius as required
                  ),
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? MaterialStateProperty.all(Colors.black)
                    : MaterialStateProperty.all(Color.fromRGBO(
                    47, 79, 79, 1.0)),

              ),

            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignupStudent()));
            },

              child: Text('STUDENT'),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(326, 50)), // change the width and height as required
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // change the value of the radius as required
                  ),
                ),
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? MaterialStateProperty.all(Colors.black)
                    : MaterialStateProperty.all(Color.fromRGBO(204, 85, 0, 1.0)),

              ),

            ),
          ],
        ),
      ),
    );
  }
}
