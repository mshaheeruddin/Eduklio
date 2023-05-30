import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AssignmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//get current Time
  String getCurrentTime() {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat.jm().format(currentTime);
    return formattedTime;
  }

  Future<void> addAssignmentAnnouncement(String className, String description,String downloadURL,PlatformFile? platformFile, String? dueOn, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "description": description,
      "assignmentFileName": platformFile!.name,
      "assignment": downloadURL,
      "dueDate": dueOn,
      "timeStamp": getCurrentTime(),
      "userId": userId,

    };
    await _firestore.collection("teacher_assignments").doc(FirebaseAuth.instance.currentUser!.uid).set(newUserData);

  }



}