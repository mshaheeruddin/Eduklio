import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/data/repositories/general_repository.dart';
import 'package:eduklio/data/repositories/user_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AssignmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserRepository userRepository = UserRepository();
  Repository repository = Repository();

//get current Time
  String getCurrentTime() {
    DateTime currentTime = DateTime.now();
    String formattedTime = DateFormat.jm().format(currentTime);
    return formattedTime;
  }

  Future<void> addAssignmentAnnouncement(String collectionName,String className, String description,String downloadURL,PlatformFile? platformFile, String? dueOn, String? userId) async{
    DateTime currentDate = DateTime.now();
    String formattedDate = DateFormat('dd MMMM yyyy').format(currentDate);
    Map<String, dynamic> newUserData = {
      "className": className,
      "description": description,
      "assignmentFileName": platformFile!.name,
      "assignment": downloadURL,
      "currentDate": formattedDate,
      "dueDate": dueOn,
      "timeStamp": getCurrentTime(),
      "userId": userId,

    };
    await _firestore.collection(collectionName).add(newUserData);



  }



}