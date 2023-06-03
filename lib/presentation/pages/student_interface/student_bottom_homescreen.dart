import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:eduklio/data/repositories/general_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/manageclass_usecase.dart';
import 'package:eduklio/presentation/pages/student_interface/assignment_screen_student.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/manage_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

class BottomHomeScreen extends StatefulWidget {

  String className = "";

  BottomHomeScreen(this.className);




  @override
  State<BottomHomeScreen> createState() => _BottomHomeScreenState();




}

class _BottomHomeScreenState extends State<BottomHomeScreen> {

  late AssignmentScreenStudent assignmentScreenStudent;

  _BottomHomeScreenState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignmentScreenStudent= AssignmentScreenStudent(widget.className);
  }




  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();

  TextEditingController announceToClass = TextEditingController();
  String userId = "";
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
              widget.className,
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          _announceTextBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _shareButton(),
                  )),
            ],
          ),
          realTimeDisplayOfAdding(context)
        ],
      ),
    );
  }

  //UI ENDS HERE

/*
  All widgets and logics are here
 */
  //create date time variable
  DateTime _dateTime = DateTime.now();

  //Month formatter
  String _monthFormatter(int month) {
    switch(month) {
      case 1:
        return "Jan";
        break;
      case 2:
        return "Feb";
        break;
      case 3:
        return "Mar";
        break;
      case 4:
        return "Apr";
        break;
      case 5:
        return "May";
        break;
      case 6:
        return "Jun";
        break;
      case 7:
        return "Jul";
        break;
      case 8:
        return "Aug";
        break;
      case 9:
        return "Sep";
        break;
      case 10:
        return "Oct";
        break;
      case 11:
        return "Nov";
        break;
      case 12:
        return "Dec";
        break;
      default:
        return "Invalid month";
        break;
    }
  }

  //listView

  //streambuilder to get
  //streambuilder to get
  Widget realTimeDisplayOfAdding(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //subscribed to firestore collection called users
      //so whenever doc is added/changed, we get 'notification'
      stream: _firestore.collection("teacher_assignments").snapshots(),
      //snapshot is real time data we will get
      builder: (context, snapshot) {
        //if connection (With firestore) is established then.....
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return Expanded(
              child: ListView.builder(
                //length as much as doc we have
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //from docs array we are now selecting a doc
                  Map<String, dynamic> userMap = snapshot.data!.docs[index]
                      .data() as Map<String, dynamic>;
                  //get users document id
                  String documentId = snapshot.data!.docs[index].id;
                  if (widget.className == userMap["className"]) {
                    return FutureBuilder(
                        future: _getUserNameAsync(
                            snapshot.data!.docs[index], context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          } else {
                            return SizedBox(
                              child: Card(
                                elevation: 5,
                                shadowColor: Colors.black,
                                child: Padding(padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          SafeArea(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(
                                                        8.0),
                                                    child: Transform.translate(
                                                      offset: Offset(0, -8),
                                                      child: Container(
                                                        height: 32,
                                                        width: 32,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(6)),
                                                          color: Colors.grey,
                                                        ),
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .person_fill),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 0,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        bottom: 12),
                                                    child: Text(userRepository
                                                        .getUserName() != null
                                                        ? userRepository
                                                        .getUserName()!
                                                        : snapshot.data!,
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                  ),
                                                  /*Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 15),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      //delete with specific document function comes
                                                      userRepository
                                                          .deleteSomethingFromCollection(
                                                          "teacher_assignments",
                                                          documentId);
                                                    },
                                                    icon: Icon(Icons.delete),),
                                                )*/

                                                ]
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Text(
                                                'Posted an assignment: ${userMap["assignmentFileName"]} due on: ${userMap["dueDate"]}',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 12),
                                            child: Text(
                                                'Additional Instructions: ${userMap["description"]}',
                                                style: TextStyle(fontSize: 15)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                                /* title: Text(currentClass.className),
                        subtitle: Text(currentClass.classCode),*/
                              ),
                            );}
                        }
                    );
                  }
                },),
            );
          }
          else {
            return Text("No Data");
          }
        }
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }



  //show datetime picker method
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime(2023, 12, 31),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        /*dateController.text = _dateTime.day.toString() + " " +
            _monthFormatter(_dateTime.month) + " " +
            _dateTime.year.toString();*/
      });
    });
  }


  //async function







//submit button
  Widget _shareButton() {
    return BlocBuilder<TextFieldAnnounceBloc, TextFieldAnnounceState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: (state is TextFieldEmptyState) ? null : () {
            classRepository.addAnnouncement(
                widget.className, announceToClass.text, userRepository.getUserUID());
          }
          , child: Text('Share'), style: ButtonStyle(backgroundColor: state is TextFieldEmptyState ?  MaterialStateProperty.all(Colors.grey) :  MaterialStateProperty.all(Colors.black),
            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.25 , 40)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),)
        ),);
      },
    );
  }

  Widget _announceTextBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<TextFieldAnnounceBloc, TextFieldAnnounceState>(
        builder: (context, state) {
          return TextFormField(
            onChanged: (value){
              BlocProvider.of<TextFieldAnnounceBloc>(context).add(TextFieldChangedEvent(announceToClass.text));
            },
            textInputAction: TextInputAction.next,
            controller: announceToClass,

            decoration:  InputDecoration(
              labelText: 'Discuss Something with class',
              labelStyle: TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(),

              ),
            ),

          );
        },
      ),
    );
  }

  Future<String?> _getUserNameAsync(DocumentSnapshot document,
      BuildContext context) async {
    Map<String, dynamic> userMap = document.data() as Map<String, dynamic>;
    String documentId = document.id;

    String? name = await userRepository.getFieldFromDocument("users", userMap["userId"],"name");
    return userRepository.firstNameFormatter(name == null ? '':name);
  }
}
