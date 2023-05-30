import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/manage_student_class_usecase.dart';
import 'package:eduklio/presentation/dialogs/class_dialogue_enroll.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/enroll_bloc/enroll_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bottombar.dart';
import 'package:eduklio/presentation/pages/teacher_interface/subject_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter_login/entity/user.dart';

import '../../../data/repositories/general_repository.dart';
import '../../../domain/entities/class.dart';
import '../../../domain/usecases/manageclass_usecase.dart';
import '../../dialogs/class_dialog.dart';
import 'package:dotted_border/dotted_border.dart';

class ManageClassStudent extends StatefulWidget {
  //final ClassManagerStudent classManager;
  String className = "";
  ManageClassStudent();


  @override
  _ManageClassStudentState createState() => _ManageClassStudentState(className);



}


class _ManageClassStudentState extends State<ManageClassStudent> {

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _populateTeachersList();

  }

  String className = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  _ManageClassStudentState(this.className);
  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();
  Widget build(BuildContext context) {



    //streambuilder to get
    Widget realTimeDisplayOfAdding(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        //subscribed to firestore collection called users
        //so whenever doc is added/changed, we get 'notification'
        stream: _firestore.collection("teacher_classes").snapshots(),
        //snapshot is real time data we will get
        builder: (context, snapshot) {
          //if connection (With firestore) is established then.....
          if (snapshot.connectionState == ConnectionState.active) {
            if(snapshot.hasData && snapshot.data != null) {
              return Expanded(
                child: ListView.builder(
                  //length as much as doc we have
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //from docs array we are now selecting a doc
                    Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                    //get users document id
                    String documentId = snapshot.data!.docs[index].id;

                    if(userRepository.getUserUID() == userMap["userId"]) {
                      return Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          BottomBar(userMap["className"])));
                                },

                                title: Text(userMap["className"],
                                    style: TextStyle(fontSize: 22)),
                                subtitle: Text(userMap["classCode"],
                                    style: TextStyle(fontSize: 15)),
                                trailing: IconButton(onPressed: () {
                                  //delete with specific document function comes
                                  userRepository.deleteSomethingFromCollection(
                                      "teacher_classes", documentId);
                                },
                                  icon: Icon(Icons.delete),

                                ),
                              ),
                            ],
                          ),

                        ),
                        /* title: Text(currentClass.className),
                    subtitle: Text(currentClass.classCode),*/
                      );
                    }
                  },),
              );
            }
            else {
              return Text("No Data");
            }}
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }},
      );
    }


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
              'Manage your classes',
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          _buildAddTask(),
          realTimeDisplayOfAdding(context),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ClassDialogEnroll(classManager: widget.classManager);

            },
          );
        },
        child: Icon(Icons.add),
      ),*/
    );
  }

  Widget _buildAddTask() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(20),
          dashPattern: [10,10],
          color: Colors.grey,
          strokeWidth: 2,
          child: BlocBuilder<EnrollBloc, EnrollState>(
  builder: (context, state) {
    return GestureDetector(
            onTap: () {
              BlocProvider.of<EnrollBloc>(context).add(EnrollClickedEvent(true));
              if (state is EnrollDialogueBoxLaunchState) {
                _showAlertBox();
              }
            },
            child: Center(
              child: Text('+ Enroll in class',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
            ),
          );
  },
),
        ),
      ),
    );
  }
  String selectedSubject = "";
  bool _selected = false;
  List<String> availableClasses = [];
  List<String> enrolledClasses = [];


  String selectedTeacher = "";
  bool _isSelectedTeacher = false;
  List<String> availableTeachers = [];
  List<String> teacherSelected = [];

  //populate available teachers
  Future<void> _populateTeachersList() async {
    availableClasses = await classRepository.getAllClasses("teacher_classes");
    availableTeachers = await classRepository.getAllTeachers("teachers");
  }



  Map<String, String> teacherSubjectMap = {};
  void _showAlertBox() async {
    await showDialog(
      context: context,
      builder: (context) => BlocBuilder<EnrollBloc, EnrollState>(
  builder: (context, state) {

    bool isSubjectSelected = state is EnrollSubjectedSelectedState;
    bool isTeacherSelected = state is EnrollTeacherSelectedState;

    return AlertDialog(
        title: Text('Select Class to enroll'),
        content: Column(
          children: [DropdownButton<String>(
            hint: Text('Choose subject'),
            value: _selected ? selectedSubject: null,
            isExpanded: true,
            items: availableClasses.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: Colors.blue),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              if(newValue!.isNotEmpty) BlocProvider.of<EnrollBloc>(context).add(EnrollSubjectSelectionEvent(true,selectedSubject));
              log(newValue!.isNotEmpty.toString());
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                if (state is EnrollSubjectedSelectedState) {
                  log((state is EnrollSubjectedSelectedState).toString());

                }
              });

                selectedSubject = newValue!;
                _selected  = true;


            },
          ),
            DropdownButton<String>(
              hint: Text('Choose Teacher'),
              value: _isSelectedTeacher? selectedTeacher: null,
              isExpanded: true,
              items: availableTeachers.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.blue),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if(newValue!.isNotEmpty)BlocProvider.of<EnrollBloc>(context).add(EnrollTeacherSelectionEvent(true,selectedSubject));
                log(newValue!.isNotEmpty.toString());
                log((state is EnrollTeacherSelectedState).toString());

                  selectedTeacher = newValue!;
    _isSelectedTeacher  = true;
    newValue = "";
    },
            ),
      ]
        ),
        actions: [
          BlocBuilder<EnrollBloc, EnrollState>(
  builder: (context, state) {
    return TextButton(
            child: Text('Enroll'),
            onPressed: () {
              BlocProvider.of<EnrollBloc>(context).add(EnrollButtonPressedEvent(true, selectedSubject, selectedTeacher));
              teacherSubjectMap[selectedTeacher] = selectedSubject;

              if(userRepository.getFieldFromDocument("users",FirebaseAuth.instance.currentUser!.uid, "teachers") != 'teacher') {
                userRepository.addFieldToDocument("users",FirebaseAuth.instance.currentUser!.uid, "teachers", [selectedTeacher]);
              }

              userRepository.addFieldToDocument("users",FirebaseAuth.instance.currentUser!.uid, "subjects", [selectedSubject]);
              Navigator.of(context).pop();
            });
  },
),
        ],
      );
  },
),
    );
  }


}
