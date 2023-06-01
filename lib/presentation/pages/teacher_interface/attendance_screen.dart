import 'package:eduklio/presentation/pages/student_interface/widgets/attendance_tiles_display.dart';
import 'package:eduklio/presentation/pages/teacher_interface/widgets/RealTimeDisplayOfTilesChecking.dart';
import 'package:eduklio/presentation/pages/teacher_interface/widgets/attendance_tiles_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatefulWidget {
  String className = "";

  AttendanceScreen(this.className);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  TilesForTeacherAttendance tilesForTeacherAttendance = TilesForTeacherAttendance();


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
               "Attendance",
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          //SizedBox(child: tilesForTeacherAttendance.realTimeDisplayOfAdding(context)),
          SizedBox(child: tilesForTeacherAttendance.realTimeDisplayOfAdding(context, widget.className)),

        ],
      ),
    );
  }




}