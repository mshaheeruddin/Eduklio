import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/presentation/dialogs/bloc/add_attendance_bloc/add_attendance_bloc.dart';
import 'package:eduklio/presentation/pages/teacher_interface/update_attendance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/class_repository.dart';
import '../../../../data/repositories/general_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../student_interface/bottombar.dart';
import '../../teacher_interface/bottombar.dart';
import '../bottombar.dart';

class TilesForTeacherAttendance {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserRepository userRepository = UserRepository();
  ClassRepository classRepository = ClassRepository();
  Repository repository = Repository();


  Widget realTimeDisplayOfAdding(BuildContext context, String className) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("teacher_classes").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData && snapshot.data != null) {
            return SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return FutureBuilder<List<Card>>(
                    future: _buildCardsAsync(
                        snapshot.data!.docs[index], context, className),
                    builder: (context, cardSnapshot) {
                      if (cardSnapshot.hasData && cardSnapshot.data != null) {
                        return Column(
                          children: cardSnapshot.data!,
                        );
                      } else {
                        return SizedBox(); // Placeholder widget while loading
                      }
                    },
                  );
                },
              ),
            );
          } else {
            return Text("No Data");
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Card>> _buildCardsAsync(DocumentSnapshot document,
      BuildContext context, String className) async {
    Map<String, dynamic> userMap = document.data() as Map<String, dynamic>;
    String documentId = document.id;

    List<String> studentsEnrolledNames = List<String>.from(
        userMap["studentsEnrolledNames"]);
    String? name = await userRepository.getUserFirstName();
    String nameNonNull = name ?? "";
    List<Card> cards = [];


    if (userMap["className"] == className) {
      for (int i = 0; i < studentsEnrolledNames.length; i++) {
        String studentId = userMap["studentsEnrolled"][i];
        String studentName = studentsEnrolledNames[i];
        cards.add(
          Card(
            elevation: 10,
            shadowColor: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: BlocProvider(
                create: (context) => AddAttendanceBloc(),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateAttendance(studentName, studentId),
                      ),
                    );
                  },
                  title: Text(studentName, style: TextStyle(fontSize: 22)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('class enrolled: ' + userMap["className"],
                          style: TextStyle(fontSize: 15)),
                      Text("teacher: " + nameNonNull),
                    ],
                  ),

                ),
              ),
            ),
          ),
        );

      }
    }
    return cards;
  }

}