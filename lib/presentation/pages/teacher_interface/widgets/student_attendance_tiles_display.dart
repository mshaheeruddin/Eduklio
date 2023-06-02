import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/class_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/repositories/general_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../bottombar.dart';

class UpdatedStudentAttendanceTiles {

FirebaseFirestore _firestore = FirebaseFirestore.instance;

UserRepository userRepository = UserRepository();
ClassRepository classRepository = ClassRepository();
Repository repository = Repository();

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
                  log((FirebaseAuth.instance.currentUser!.uid).toString());
                  log((userMap["teacherId"]).toString());
                  log((FirebaseAuth.instance.currentUser!.uid == userMap["userId"]).toString());
                  if(FirebaseAuth.instance.currentUser!.uid == userMap["teacherId"]) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 300,
                          child: Card(
                            borderOnForeground: true,
                            elevation: 5,
                            shadowColor: Colors.black,
                            child: Padding(padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Attendance Record',
                                          style: GoogleFonts.actor(fontSize: 18),
                                      ),
                                      Text(userMap["isVerified"] == false ? 'Pending verification...': 'Verified',
                                        style: GoogleFonts.actor(fontSize: 18, color: userMap["isVerified"] == false ? Colors.red: Colors.green),
                                      ),
                                    ],
                                  ),
                                  Divider(color: userMap["isVerified"] == false ? Colors.red : Colors.green, thickness: 5,),
                                  SizedBox(height: 20,),
                                  Text('Class conducted: ${userMap["classDate"]}',
                                      style: GoogleFonts.abhayaLibre(fontSize: 17)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('Class Duration: ${userMap["classDuration"]}',
                                      style: GoogleFonts.abhayaLibre(fontSize: 17)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('Marked On: ${userMap["createdAt"]}',
                                      style: GoogleFonts.abhayaLibre(fontSize: 17)
                                  ),


                                ],
                              ),

                            ),
                            /* title: Text(currentClass.className),
                          subtitle: Text(currentClass.classCode),*/
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
          }}
        else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }},
    );
  }
}