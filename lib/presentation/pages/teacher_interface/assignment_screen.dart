import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/assignment_repository.dart';
import 'package:eduklio/data/repositories/general_repository.dart';
import 'package:eduklio/data/repositories/storage_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:eduklio/domain/usecases/manageclass_usecase.dart';
import 'package:eduklio/presentation/pages/teacher_interface/bloc/bottombar_homescreen_bloc/text_field_announce_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/manage_class.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignmentScreen extends StatefulWidget {

  String className = "";

  AssignmentScreen(this.className);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();


}

class _AssignmentScreenState extends State<AssignmentScreen> {

  PlatformFile? pickedFile;
  String? dueOn;

  _AssignmentScreenState();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //reposoitory Instances
  UserRepository userRepository = UserRepository();
  StorageRepository storageRepository = StorageRepository();
  AssignmentRepository assignmentRepository = AssignmentRepository();



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
              "Manage Assignments",
              style: GoogleFonts.adventPro(fontSize: 30),
            ),
          ),
          SizedBox(height: 30,),
          _announceTextBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              _scheduleClassButton(),

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
  Widget realTimeDisplayOfAdding(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //subscribed to firestore collection called users
      //so whenever doc is added/changed, we get 'notification'
      stream: _firestore.collection("teacher_assignments").snapshots(),
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
                  if(widget.className == userMap["className"]) {
                    return SizedBox(
                      height: 200,
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
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Transform.translate(
                                            offset: Offset(0, -8),
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                color: Colors.grey,
                                              ),
                                              child: Icon(
                                                  CupertinoIcons.person_fill),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 3,),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 12),
                                          child: Text(userRepository.getUserName()!,
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 45, bottom: 15),
                                          child: IconButton(onPressed: () {
                                            //delete with specific document function comes
                                            userRepository.deleteUser(
                                                "teacher_assignments",
                                                documentId);
                                          },
                                            icon: Icon(Icons.delete),),
                                        )

                                      ]
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text('Posted an assignment: ${userMap["assignmentFileName"]} due on: ${userMap["dueDate"]}',
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text('Additional Instructions: ${userMap["description"]}',
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
                    );
                  }},),
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
        dueOn = _dateTime.day.toString() + " " +
            _monthFormatter(_dateTime.month) + " " +
            _dateTime.year.toString();
      });
    });
  }



  //selectFile

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }
  String shortenFileName(String fileName, int maxLength) {
    if (fileName.length <= maxLength) {
      return fileName;
    } else {
      String nameWithoutExtension = fileName.substring(0, fileName.lastIndexOf('.'));
      String extension = fileName.substring(fileName.lastIndexOf('.'));

      String shortenedName = nameWithoutExtension.substring(0, maxLength - extension.length - 3) + '...' + extension;
      return shortenedName;
    }
  }

  //schedule a class
  Widget _scheduleClassButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: IconButton(onPressed: (){
            _showDatePicker();
          }, icon: FaIcon(FontAwesomeIcons.calendar)),
        ),
        SizedBox(width: 1,),
        Column(
          children: [
            ElevatedButton(onPressed: selectFile, child: Text('Select File')),

            if (pickedFile != null) Text(shortenFileName(pickedFile!.name, 20), maxLines: 2, overflow: TextOverflow.fade,)
          ],
        )
      ],
    );
  }



//submit button
  Widget _shareButton() {
    return BlocBuilder<TextFieldAnnounceBloc, TextFieldAnnounceState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: (state is TextFieldEmptyState) ? null : () {
            storageRepository.uploadFile(pickedFile!);
            assignmentRepository.addAssignmentAnnouncement(
                widget.className, announceToClass.text,storageRepository.downloadURL,pickedFile,dueOn,userRepository.getUserUID());

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
              labelText: state is TextFieldEmptyState ? 'Enter something' : 'Announce to class',
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


}