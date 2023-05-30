

import 'dart:developer';

import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_student.dart';
import 'package:eduklio/presentation/pages/authentication_interface/signup_interface/signup_screen_teacher.dart';
import 'package:eduklio/presentation/pages/student_interface/student_homescreen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/teacher_homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInAs extends StatefulWidget {
    bool isTeacher = false;
   SignInAs({Key? key}) : super(key: key);

  @override
  State<SignInAs> createState() => _SignInAsState();
}




class _SignInAsState extends State<SignInAs> {
  bool isTeacher = false;
  UserRepository userRepository = UserRepository();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1.0),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
        child: Column(
          children: [
            Text(
              'Who are you?',
              style: GoogleFonts.acme(color: Colors.black,decoration: TextDecoration.none, fontSize: 40, ),
              textAlign: TextAlign.center,


            ),
            SizedBox(height: 10),
            //TEACHER SIGNUP BUTTON
            ElevatedButton(onPressed: () {
              widget.isTeacher = true;
              String? userId = userRepository.getUserUID();
              log(userId!);
              userRepository.addFieldToDocument("users",userId!,"userType", "Teacher");
              userRepository.addFieldToDocument("users",userId!,"students", []);
              userRepository.addFieldToDocument("users",userId!,"classes", []);
              userRepository.addTeacherUser(FirebaseAuth.instance.currentUser!.displayName!,FirebaseAuth.instance.currentUser!.email!, FirebaseAuth.instance.currentUser!.uid, "Google");
              Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherHomeScreen()));
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
              widget.isTeacher = false;
              String? userId = userRepository.getUserUID();
              userRepository.addFieldToDocument("users",userId!,"userType", "student");
              userRepository.addFieldToDocument("users",userId!,"teachers", []);
              userRepository.addFieldToDocument("users",userId!,"classes", []);
              userRepository.addStudentUser(FirebaseAuth.instance.currentUser!.displayName!,FirebaseAuth.instance.currentUser!.email!, FirebaseAuth.instance.currentUser!.uid, "Google");
              Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHomeScreen()));
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
