import 'dart:developer';

import 'package:eduklio/presentation/dialogs/add_attendance_dialogue_teacher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/usecases/manageclass_usecase.dart';
import '../../dialogs/class_dialog.dart';

class UpdateAttendance extends StatefulWidget {
  String studentName = "";
  String className = "";
  String studentId = "";
  UpdateAttendance(this.studentName, this.studentId);

  @override
  State<UpdateAttendance> createState() => _UpdateAttendanceState();
}

class _UpdateAttendanceState extends State<UpdateAttendance> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log(widget.studentId);
  }



  final ClassManager classManager = ClassManager();
  DateTime _dateTime = DateTime.now();
  String dueOn = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.arrowLeft)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 14),
            child: Text(
              widget.studentName,
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 14),
            child: Text(
              'Mark Attendance',
              style: GoogleFonts.adventPro(fontSize: 20),
            ),
          ),


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddAttendanceDialogue(classManager, widget.studentName,widget.studentId);

            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    ).then((value) {
      setState(() {
        /*_dateTime = value!;
        dueOn = _dateTime.day.toString() + " " +
            _monthFormatter(_dateTime.month) + " " +
            _dateTime.year.toString();*/
      });
    });
  }
}
