import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ClassRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
UserRepository userRepository = UserRepository();

  //get current Time
  String getCurrentTime() {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat.jm().format(currentTime);
    return formattedTime;
  }


  //add class
  Future<void> addClass(String className, String classCode, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "classCode": classCode,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "studentsEnrolled": [],
      "createdAt": getCurrentTime()
    };
    DocumentReference documentReference = await _firestore.collection("teacher_classes").add(newUserData);
    userRepository.addToArray(FirebaseAuth.instance.currentUser!.uid, "users", "classes", documentReference.id);
    userRepository.addToArray(FirebaseAuth.instance.currentUser!.uid, "teachers", "classes", documentReference.id);

  }

  void deleteArrayValueFromCollection(String collectionName,String classId, String teacherId) async {
    // Remove the class ID from the teacher's array in the teachers collection
    await FirebaseFirestore.instance.collection(collectionName).doc(teacherId).update({
      'classes': FieldValue.arrayRemove([classId]),
    });
  }


  //deleting class
  Future<void> deleteClass(String collectionName,String id) async{
    await _firestore.collection(collectionName).doc(id).delete();
  }

//announce to class
  Future<void> addAnnouncement(String className, String description, String? userId) async{
    Map<String, dynamic> newUserData = {
      "className": className,
      "description": description,
      "timeStamp": getCurrentTime(),
    };
    await _firestore.collection("teacher_announcements").doc(FirebaseAuth.instance.currentUser!.uid).set(newUserData);

  }
}