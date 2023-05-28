
import 'dart:core';


import 'package:eduklio/domain/usecases/manageclass_usecase.dart';
import 'package:eduklio/presentation/pages/teacher_interface/assignment_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/attendance_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/subject_home_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/manage_class.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
 String className = "";
 BottomBar(this.className);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  _BottomBarState();

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
  child: SubjectScreen(widget.className),
),
      AssignmentScreen(widget.className),
      AttendanceScreen(),
      const Text("Profile")
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
