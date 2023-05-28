import 'package:cloud_firestore/cloud_firestore.dart';

class ClassRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  //add class
  Future<void> addClass(String className, String classCode, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "classCode": classCode,
      "userId": userId,

    };
    await _firestore.collection("teacher_classes").add(newUserData);

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
      "userId": userId,

    };
    await _firestore.collection("teacher_announcements").add(newUserData);

  }
}