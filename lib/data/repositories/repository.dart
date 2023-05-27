import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Repository {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Repository() {

  }
SignInUseCase signInUseCase = SignInUseCase();
  //get data

  Future<void> getAllDocuments(String collectionName) async {
    //fetching all documents (only) not actual data
    //QuerySnapshot is a container for documents[Collection] (it contains it)
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();
    log(snapshot.docs.toString());
    //get data from snapshot that holds the document
    //so do doc.data() to get data inside document
    for(var doc in snapshot.docs) {
      log(doc.data().toString());
    }
  }



  Future<String> getSingleDocument(String collectionName, String docId) async {
    DocumentSnapshot snapshot =
    await _firestore.collection(collectionName).doc(docId).get();

    if (snapshot.exists) {
      // Document exists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.toString();
    } else {
      // Document does not exist
      return "Document not found";
    }
  }

  //get current userId

  Future<String> getCurrentUserId() async {

    return getUserIdByEmail(signInUseCase.emailController.text).toString();
  }



  //get user uid

  String? getUserUID()  {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }

    return null; // User UID not available
  }

  String? getUserName()  {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName;
    }

    return null; // User UID not available
  }

  //get userId

  Future<String?> getUserIdByEmail(String email) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id; // Return the document ID of the first matching user
    }

    return null; // User with the provided email not found
  }

  //add data
  Future<void> addUser(String name, String email) async{

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
    };
    await _firestore.collection("users").add(newUserData);
    log('New User Saved');

    /*
         * If you want to give your own doc ID:
         * HERE WE USE `set`
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       */
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


  //add class
  Future<void> addClass(String className, String classCode, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "classCode": classCode,
      "userId": userId,

    };
    await _firestore.collection("teacher_classes").add(newUserData);

  }


  //updating data
  Future<void> updateUserCredentials(String name, String email) async {

    Map<String, dynamic> newUserData = {
      "name": "",
      "email": "",
    };

    //If you want to update a doc
    await _firestore.collection("users").doc("your-doc-id-here").update({
      "email":"<updated email>",
    });


  }

  //deleting
  Future<void> deleteUser(String collectionName,String id) async{
    await _firestore.collection(collectionName).doc(id).delete();
  }

//deleting class
  Future<void> deleteClass(String collectionName,String id) async{
    await _firestore.collection(collectionName).doc(id).delete();
  }


}