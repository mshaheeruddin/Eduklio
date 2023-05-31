import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/manage_student_class_usecase.dart';
import 'package:eduklio/presentation/dialogs/class_dialogue_enroll.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/enroll_bloc/enroll_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/bloc/movement_bloc/movement_bloc.dart';
import 'package:eduklio/presentation/pages/student_interface/widgets/RealTimeDisplayOfTiles.dart';
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
  double _position = 0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _populateTeachersListByName();
    _populateTeachersListByIds();
    log(_position.toString());
  }

  String className = "";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _ManageClassStudentState(this.className);
  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();
  Repository repository = Repository();
  RealTimeDisplayOfTiles realTimeTiles = RealTimeDisplayOfTiles();
  Widget build(BuildContext context) {
  
  
  


    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  'Manage your classes',
                  style: GoogleFonts.adventPro(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(child: realTimeTiles.realTimeDisplayOfAdding(context)),
              SizedBox(
                height: 30,
              ),
            SizedBox(child: _buildAddTask()),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddTask() {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<MovementBloc, MovementState>(
  builder: (context, state) {
    return Stack(
          children: [AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: 0.0,
            right: 0.0,
            top: _position,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _populateTeachersListByName();
                    _populateTeachersListByIds();
                    /*BlocProvider.of<MovementBloc>(context).add(
                        ClickedOnEnrollEvent(
                            true, _position));*/
                    if(state is GoDownState) _position = state.position;
                    log(availableClassesIds.toString() + "Class ids");
                    log(availableTeachersIds.toString() + "Class ids");
                    BlocProvider.of<EnrollBloc>(context)
                        .add(EnrollClickedEvent(true));
                    teacherNameToTeacherIdMap = _populateListsToMap(
                        availableTeachers, availableTeachersIds);
                    classNameToClassIdMap = _populateListsToMap(
                        availableClasses, availableClassesIds);
                    var s = _populateMapOfIdsToIds(teacherNameToTeacherIdMap, classNameToClassIdMap);
                    if(s != null) {
                      mapOfIdsToIds = s;
                    }
                    if (state is EnrollDialogueBoxLaunchState) {
                      _showAlertBox();
                    }
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(20),
                    dashPattern: [10, 10],
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: BlocBuilder<EnrollBloc, EnrollState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            _populateTeachersListByName();
                            _populateTeachersListByIds();
                            BlocProvider.of<EnrollBloc>(context)
                                .add(EnrollClickedEvent(true));
                             teacherNameToTeacherIdMap = _populateListsToMap(
                                availableTeachers, availableTeachersIds);
                             classNameToClassIdMap = _populateListsToMap(
                                availableClasses, availableClassesIds);
                            var s = _populateMapOfIdsToIds(teacherNameToTeacherIdMap, classNameToClassIdMap);
                            if(s != null) {
                              mapOfIdsToIds = s;
                            }
                            if (state is EnrollDialogueBoxLaunchState) {
                              _showAlertBox();
                            }
                          },
                          child: Center(
                            child: Text(
                              '+ Enroll in class',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            )

          ),]
        );
  },
),
      );
  }
  
  
  
  
  
  
  
  
  //ALERT BOX CODE
  
  
  
  
  

  String selectedSubject = "";
  bool _selected = false;
  List<String> availableClasses = [];
  List<String> availableClassesIds = [];
  List<String> enrolledClasses = [];
  Map<String, String> mapOfIdsToIds = {};
  Map<String, String> teacherNameToTeacherIdMap = {};

  String selectedTeacher = "";
  bool _isSelectedTeacher = false;
  List<String> availableTeachers = [];
  List<String> availableTeachersIds = [];
  List<String> teacherSelected = [];
  Map<String, String> classNameToClassIdMap = {};
  //populate available teachers
  Future<void> _populateTeachersListByName() async {
    availableClasses =
        await classRepository.getAllClasses("teacher_classes", true);
    availableTeachers = await classRepository.getAllTeachers("teachers", true);
  }

  //populate available teachers
  Future<void> _populateTeachersListByIds() async {
    availableClassesIds =
        await classRepository.getAllClasses("teacher_classes", false);
    availableTeachersIds =
        await classRepository.getAllTeachers("teachers", false);
  }

  Map<String, String> teacherSubjectMap = {};
  void _showAlertBox() async {
    await showDialog(
      context: context,
      builder: (context) => BlocBuilder<EnrollBloc, EnrollState>(
        builder: (context, state) {
          return AlertDialog(
            title: Text('Select Class to enroll'),
            content: Column(children: [
              DropdownButton<String>(
                hint: Text('Choose subject'),
                value: _selected ? selectedSubject : null,
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
                  if (newValue!.isNotEmpty)
                    BlocProvider.of<EnrollBloc>(context).add(
                        EnrollSubjectSelectionEvent(true, selectedSubject));
                  log(newValue!.isNotEmpty.toString());
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    if (state is EnrollSubjectedSelectedState) {
                      log((state is EnrollSubjectedSelectedState).toString());
                    }
                  });

                  selectedSubject = newValue!;
                  _selected = true;
                },
              ),
              DropdownButton<String>(
                hint: Text('Choose Teacher'),
                value: _isSelectedTeacher ? selectedTeacher : null,
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
                  if (newValue!.isNotEmpty)
                    BlocProvider.of<EnrollBloc>(context).add(
                        EnrollTeacherSelectionEvent(true, selectedSubject));
                  log(newValue!.isNotEmpty.toString());
                  log((state is EnrollTeacherSelectedState).toString());

                  selectedTeacher = newValue!;
                  _isSelectedTeacher = true;
                  newValue = "";
                },
              ),
            ]),
            actions: [
              BlocBuilder<EnrollBloc, EnrollState>(
                builder: (context, state) {
                  return TextButton(
                      child: Text('Enroll'),
                      onPressed: () {
                        BlocProvider.of<MovementBloc>(context).add(
                            ClickedOnEnrollEvent(
                                true, _position));
                         log('emitted');
                        BlocProvider.of<EnrollBloc>(context).add(
                            EnrollButtonPressedEvent(
                                true, selectedSubject, selectedTeacher));
                        //ADD TO USERS(students)
                        userRepository.addToArray(
                            FirebaseAuth.instance.currentUser!.uid,
                            "users",
                            "enrolledClasses",
                            _getSelectedOptionIds(selectedSubject, false) != null ? _getSelectedOptionIds(selectedSubject, false)! : "");
                        userRepository.addToArray(
                            FirebaseAuth.instance.currentUser!.uid,
                            "students",
                            "enrolledClasses",
                            _getSelectedOptionIds(selectedSubject, false) != null ?_getSelectedOptionIds(selectedSubject, false)! : "" );
                        userRepository.addToArray(
                            FirebaseAuth.instance.currentUser!.uid,
                            "students",
                            "teachers",
                            _getSelectedOptionIds(selectedTeacher, true) != null ? _getSelectedOptionIds(selectedTeacher, true)! : "" );
                        userRepository.addToArray(
                            FirebaseAuth.instance.currentUser!.uid,
                            "users",
                            "teachers",
                            _getSelectedOptionIds(selectedTeacher, true) != null ? _getSelectedOptionIds(selectedTeacher, true)!:"");
                        //add to users (teachers)
                        userRepository.addToArray(
                            _getSelectedOptionIds(selectedTeacher, true) != null? _getSelectedOptionIds(selectedTeacher, true)!:"",
                            "users",
                            "students",
                            FirebaseAuth.instance.currentUser!.uid);
                        userRepository.addToArray(
                            _getSelectedOptionIds(selectedTeacher, true)!= null ? _getSelectedOptionIds(selectedTeacher, true)! : "",
                            "teachers",
                            "students",
                            FirebaseAuth.instance.currentUser!.uid);
                         //add to classes collection
                        userRepository.addToArray(
                            _getSelectedOptionIds(selectedSubject, false) != null ? _getSelectedOptionIds(selectedSubject, false)! : "",
                            "teacher_classes",
                            "studentsEnrolled",
                            FirebaseAuth.instance.currentUser!.uid);
                        log(selectedSubject.toString());
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

  //method to take two lists and create a map out of it

  Map<String, String> _populateListsToMap(
      List<String> list1, List<String> list2) {
    Map<String, String> idToNameMap = {};



   for (var item in list1) {
      for (var item2 in list2) {
        idToNameMap[item] = item2;
        list2.remove(item2);
        break;
      }
    }

    log(idToNameMap.toString());
    return idToNameMap;
  }

  //map of teacher id to its associated subject id
  Map<String, String>? _populateMapOfIdsToIds(
      Map<String, String> map1, Map<String, String> map2) {
    Map<String, String> idToNameMap = {};

    for (var item in map1.values) {
      for (var item2 in map2.values) {
        idToNameMap[item] = item2;
        break;
      }

      log(idToNameMap.toString());
      return idToNameMap;
    }
  }



  String? _getSelectedOptionIds(String? option, bool isTeacher) {
    if (isTeacher) {
        return teacherNameToTeacherIdMap[option];
    }
    else {
      return classNameToClassIdMap[option];
    }
  }




}
