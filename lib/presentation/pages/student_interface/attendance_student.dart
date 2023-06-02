import 'package:eduklio/presentation/pages/student_interface/widgets/student_attendance_tiles_display_std.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceStudent extends StatefulWidget {
  const AttendanceStudent({Key? key}) : super(key: key);

  @override
  State<AttendanceStudent> createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {

  VerifyAttendanceTiles verifyAttendanceTiles = VerifyAttendanceTiles();

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
                child: IconButton(
                    onPressed: () {}, icon: FaIcon(FontAwesomeIcons.arrowLeft)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 14),
            child: Text(
              "View and Verify Attendance",
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),

        verifyAttendanceTiles.realTimeDisplayOfAdding(context)
        ],
      ),
    );
  }
}
