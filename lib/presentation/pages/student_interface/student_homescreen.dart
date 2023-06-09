import 'package:eduklio/domain/usecases/manage_student_class_usecase.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/enroll_bloc/enroll_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/movement_bloc/movement_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/manage_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/repositories/user_repository.dart';
import '../../../domain/usecases/manageclass_usecase.dart';
import '../../../domain/usecases/signout_usecase.dart';
import '../teacher_interface/class_schedule_screen.dart';
import '../teacher_interface/manage_class.dart';

class StudentHomeScreen extends StatefulWidget {
  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  Logout logout = Logout();
  String? userName;

  UserRepository userRepository = UserRepository();

  final ClassManagerStudent classManager = ClassManagerStudent();

  Future<void> retrieveUserName() async {
    String? userDisplayName = await userRepository.getUserFirstName();
    setState(() {
      userName = userDisplayName;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveUserName();
  }

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
        title: Text("Student's Portal"),
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
                  SafeArea(
                    child: Text(
                      'Hi, ${userName}',
                      style: GoogleFonts.adventPro(fontSize: 30),
                      textAlign: TextAlign.end,
                    ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MultiBlocProvider(
  providers: [
    BlocProvider(
  create: (context) => EnrollBloc(),
),
    BlocProvider(
      create: (context) => MovementBloc(),
    ),
  ],
  child: ManageClassStudent(),
)));
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
                                'Attendance Portal',
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