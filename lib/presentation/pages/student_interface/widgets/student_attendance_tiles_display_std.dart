import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/presentation/pages/teacher_interface/widgets/bloc/student_attendance_tile_bloc/student_attendance_tiles_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/repositories/class_repository.dart';
import '../../../../data/repositories/general_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../bottombar.dart';

class VerifyAttendanceTiles {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();
  Repository repository = Repository();
  bool isPressed = true;
  //streambuilder to get
  Widget realTimeDisplayOfAdding(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //subscribed to firestore collection called users
      //so whenever doc is added/changed, we get 'notification'
      stream: _firestore.collection("class_attendance").snapshots(),
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

                  if (FirebaseAuth.instance.currentUser!.uid ==
                      userMap["studentId"]) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 300,
                          child: BlocBuilder<StudentAttendanceTilesBloc, StudentAttendanceTilesState>(
  builder: (context, state) {
    return Card(
                            borderOnForeground: true,
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Padding(padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text('Attendance Record',
                                        style: GoogleFonts.actor(fontSize: 18),
                                      ),
                                      SizedBox(height: 50,child: CupertinoButton(child:Text(state is VerifiedState ? 'Verified' : 'Verify' , style: GoogleFonts.adventPro(fontSize: 16, color:  state is VerifiedState ? Colors.black: Colors.white),),
                                        onPressed: () {
                                          BlocProvider.of<StudentAttendanceTilesBloc>(context).add(ButtonPressedEvent(isPressed));
                                          repository.updateField("class_attendance", documentId, "isVerified", isPressed);
                                          isPressed = isPressed == true ? false : true;
                                        }, color: state is VerifiedState ? Colors.green: Colors.black,)),
                                    ],
                                  ),
                                  Divider(color: state is VerifiedState ? Colors.green: Colors.red, thickness: 5,),
                                  SizedBox(height: 20,),
                                  Text(
                                      'Class conducted: ${userMap["classDate"]}',
                                      style: GoogleFonts.abhayaLibre(
                                          fontSize: 17)
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                      'Class Duration: ${userMap["classDuration"]}',
                                      style: GoogleFonts.abhayaLibre(
                                          fontSize: 17)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('Marked On: ${userMap["createdAt"]}',
                                      style: GoogleFonts.abhayaLibre(
                                          fontSize: 17)
                                  ),


                                ],
                              ),

                            ),
                            /* title: Text(currentClass.className),
                          subtitle: Text(currentClass.classCode),*/
                          );
  },
),
                        ),
                      ),
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
}
