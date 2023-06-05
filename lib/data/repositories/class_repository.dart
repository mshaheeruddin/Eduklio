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


  //getClass
  //get all classes data
  Future<List<String>> getAllClasses(String collectionName, bool byName) async {
    //fetching all documents (only) not actual data
    //QuerySnapshot is a container for documents[Collection] (it contains it)
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
    List<String> classesIds = [];
    List<String> availableClasses = [];
    //get data from snapshot that holds the document
    //so do doc.data() to get data inside document
    for(var doc in snapshot.docs) {
      classesIds.add(doc.id);
    }

    for(var classid in classesIds) {
      String idgotten = await userRepository.getFieldFromDocument(
          "teacher_classes", classid, "className");

      availableClasses.add(idgotten);
    }


    if(byName) {return availableClasses;}
    return classesIds;
  }


  //get all teachers data
  Future<List<String>> getAllTeachers(String collectionName, bool byName) async {
    //fetching all documents (only) not actual data
    //QuerySnapshot is a container for documents[Collection] (it contains it)
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    List<String> ids = [];
    List<String> availableTeachers = [];
    //get data from snapshot that holds the document
    //so do doc.data() to get data inside document
    for(var doc in snapshot.docs) {
      log("doc id: "+ doc.id );
      ids.add(doc.id);
    }

    for(var id in ids) {
      String idgotten = await userRepository.getFieldFromDocument("users",id, "name");
      availableTeachers.add(idgotten);
    }
    if (byName) {
      log(availableTeachers[0].toString());
      return availableTeachers;
    }
    return ids;

  }

  //add class
  Future<void> addClass(String className, String classCode, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "classCode": classCode,
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "studentsEnrolled": [],
      "studentsEnrolledNames":[],
      "studentsNameToIdMap": {},
      "createdAt": getCurrentTime()
    };
    DocumentReference documentReference = await _firestore.collection("teacher_classes").add(newUserData);
    userRepository.addToArray(FirebaseAuth.instance.currentUser!.uid, "users", "classes", documentReference.id);
    userRepository.addToArray(FirebaseAuth.instance.currentUser!.uid, "teachers", "classes", documentReference.id);

  }



  Future<void> addAttendance(String classDuration,String studentName, String studentId, String classDate) async{

    Map<String, dynamic> newUserData = {
      "classDuration": classDuration,
      "studentName": studentName,
      "teacherId": FirebaseAuth.instance.currentUser!.uid,
      "studentId": studentId,
      "classDate": classDate,
      "createdAt": getCurrentTime(),
      "isVerified": false
    };
    DocumentReference documentReference = await _firestore.collection("class_attendance").add(newUserData);

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
      "userId": FirebaseAuth.instance.currentUser!.uid
    };
    await _firestore.collection("teacher_announcements").add(newUserData);

  }
}