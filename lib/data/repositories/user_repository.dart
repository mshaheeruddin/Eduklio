import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/signin_usecase.dart';


class UserRepository {


  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  //instances required

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  SignInUseCase signInUseCase = SignInUseCase();


  //methods


// get user type

  Future<String?> getUserType(String collectionName, String userName) async {
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    String userType = "";
    for (var doc in snapshot.docs) {
      Map<String, dynamic> userMap = doc.data() as Map<String, dynamic>;
      if (userMap["name"] == userName) {
        userType = userMap["userType"];
      }
      return userType;
    }
    /*if (snapshot) {
      // Document exists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.toString();
    } else {
      // Document does not exist
      return "Document not found";
    }*/
  }

  String? getUserUID() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }

    return null; // User UID not available
  }

  String? getUserName() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName;
    }
    return null; // User UID not available
  }


  //updating teacher user credentials
  Future<void> updateTeacherUserCredentials(String name, String email) async {
    Map<String, dynamic> newUserData = {
      "name": "",
      "email": "",
    };

    //If you want to update a doc
    await _firestore.collection("users").doc("your-doc-id-here").update({
      "email": "<updated email>",
    });

    //updating student user credentials
    Future<void> updateStudentUserCredentials(String name, String email) async {
      Map<String, dynamic> newUserData = {
        "name": "",
        "email": "",
      };

      //If you want to update a doc
      await _firestore.collection("users").doc("your-doc-id-here").update({
        "email": "<updated email>",
      });
    }


    //deleting
    Future<void> deleteUser(String collectionName, String id) async {
      await _firestore.collection(collectionName).doc(id).delete();
    }


  }
}