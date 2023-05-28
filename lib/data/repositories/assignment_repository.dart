import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class AssignmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<void> addAssignmentAnnouncement(String className, String description,String downloadURL,PlatformFile? platformFile, String? dueOn, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "description": description,
      "assignmentFileName": platformFile!.name,
      "assignment": downloadURL,
      "dueDate": dueOn,
      "userId": userId,

    };
    await _firestore.collection("teacher_assignments").add(newUserData);

  }



}