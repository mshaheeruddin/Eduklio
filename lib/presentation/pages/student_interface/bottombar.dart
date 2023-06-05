
import 'dart:core';


import 'package:eduklio/domain/usecases/manageclass_usecase.dart';
import 'package:eduklio/presentation/pages/student_interface/assignment_screen_student.dart';
import 'package:eduklio/presentation/pages/student_interface/attendance_student.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/dp_bloc/dp_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/profile_screen.dart';
import 'package:eduklio/presentation/pages/student_interface/student_bottom_homescreen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/assignment_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/attendance_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/subject_home_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/manage_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../teacher_interface/widgets/bloc/student_attendance_tile_bloc/student_attendance_tiles_bloc.dart';

class BottomBarStudent extends StatefulWidget {
 String className = "";
 BottomBarStudent(this.className);

  @override
  State<BottomBarStudent> createState() => _BottomBarStudentState();
}

class _BottomBarStudentState extends State<BottomBarStudent> {

  _BottomBarStudentState();

  late final List<Widget> _widgetOptions;
Widget getSubjectWidget() {
  return SubjectScreen(widget.className);
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widgetOptions = <Widget>[
      BlocProvider(
  create: (context) => TextFieldAnnounceBloc(),
  child: BottomHomeScreen(widget.className),
),
      AssignmentScreenStudent(widget.className),
      BlocProvider(
  create: (context) => StudentAttendanceTilesBloc(),
  child: AttendanceStudent(),
),
      BlocProvider(
  create: (context) => DpBloc(),
  child: ProfilePage(user:FirebaseAuth.instance.currentUser!),
)
    ];
  }

  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState( () {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label:"Home"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_book_formula_text_filled),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_book_formula_text_filled),
              label:"Assignments"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_checkmark_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_checkmark_filled), label:"Attendance"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled), label:"Profile")
        ],
      ),
    );
  }
}
