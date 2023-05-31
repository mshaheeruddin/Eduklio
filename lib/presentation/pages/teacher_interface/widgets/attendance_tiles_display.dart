import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/class_repository.dart';
import '../../../../data/repositories/general_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../student_interface/bottombar.dart';
import '../../teacher_interface/bottombar.dart';
import '../bottombar.dart';

class StudentsEnrolledTiles {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();
  Repository repository = Repository();
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
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              shrinkWrap: true,
              //length as much as doc we have
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //from docs array we are now selecting a doc
                Map<String, dynamic> userMap = snapshot.data!.docs[index]
                    .data() as Map<String, dynamic>;
                //get users document id
                String documentId = snapshot.data!.docs[index].id;
                bool condition = false;
                List<dynamic> studentsEnrolled = userMap["studentsEnrolled"];

                for (int i=0;i<studentsEnrolled.length;i++) {
                  if (userRepository.getUserUID() == userMap["studentsEnrolled"][i]) {
                    condition = true;
                  }
                }

                List<dynamic> studentNames = [];
                for (int i=0;i<studentsEnrolled.length;i++) {
                  if (userRepository.getUserUID() == userMap["studentsEnrolled"][i]) {
                    studentNames.add(userRepository.getFieldFromDocument("users",userMap["studentsEnrolled"][i], "name"));
                  }
                }


                //name is displayed

                log(studentNames.toString());

                //class is displayed


                //date is displayed





                if (condition) {
                  return Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomBarStudent(userMap["className"])));
                            },
                            title: Text(userMap["className"],
                                style: TextStyle(fontSize: 22)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userMap["classCode"],
                                    style: TextStyle(fontSize: 15)),
                                Text("teacher:")
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                //delete with specific document function comes
                                userRepository
                                    .removeFromArray(documentId, "teacher_classes", "studentsEnrolled", FirebaseAuth.instance.currentUser!.uid);
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
              },
            );
          } else {
            return Text("No Data");
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}