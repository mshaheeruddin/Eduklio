import 'package:eduklio/presentation/pages/teacher_interface/class_schedule_screen.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bottombar.dart';
import 'package:eduklio/presentation/pages/teacher_interface/manage_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/usecases/manageclass_usecase.dart';
import '../../../domain/usecases/signout_usecase.dart';

class TeacherHomeScreen extends StatelessWidget {
  Logout logout = Logout();
 final ClassManager classManager = ClassManager();
  @override
  Widget build(BuildContext context) {


    Widget _contentOfTile(String text1, String text2, String text3, String text4, String text5) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Text(text1,
            style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,),
          SizedBox(height: 8,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 5,
                ),
                Text(text2),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 1,
                  ),
                ),
                Text(text3),

              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5,
                ),
                Text(text4),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 1,
                  ),
                ),
                Text(text5),
              ],
            ),
          ),
        ],
      );
    }



    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Teacher's Portal"),
        actions: [
          IconButton(onPressed: () {
            logout.logOut(context);
          }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(

                children: [
                  Container(
                    height: 45,
                    width: 45,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/newdp.png')
                    ),
                  ),
                  SizedBox(width:8,),
                  Text(
                      'Hi, Shaheer',
                    style: GoogleFonts.adventPro(fontSize: 30),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the Schedule screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassSchedule()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Class Schedule',
                                style: GoogleFonts.aBeeZee(fontSize: 20),
                              ),
                              Icon(Icons.calendar_today, size: 20.0),
                            ],
                          ),
                          _contentOfTile("Upcoming classes....", "Additional Maths", "12:00 PM", "Computer Science","11:23 AM")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the attendance screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ManageClass(classManager: classManager)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Manage Classes',
                                style: GoogleFonts.aBeeZee(fontSize: 20),
                              ),
                              Icon(Icons.book, size: 20.0),
                            ],
                          ),
                          SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the attendance screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'View Performance Report',
                                style: GoogleFonts.aBeeZee(fontSize: 20),
                              ),
                              Icon(Icons.bar_chart, size: 20.0),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: InkWell(
                    onTap: () {
                      // Navigate to the attendance screen
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Manage Attendance',
                                style: GoogleFonts.aBeeZee(fontSize: 20),
                              ),
                              Icon(Icons.people, size: 20.0),

                            ],
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}