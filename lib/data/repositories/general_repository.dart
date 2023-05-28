import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduklio/domain/usecases/signin_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Repository {

  static final Repository _singleton = Repository._internal();
  factory Repository() {
    return _singleton;
  }
  Repository._internal();


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignInUseCase signInUseCase = SignInUseCase();

  //get data
  Future<void> getAllDocuments(String collectionName) async {
    //fetching all documents (only) not actual data
    //QuerySnapshot is a container for documents[Collection] (it contains it)
    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    //get data from snapshot that holds the document
    //so do doc.data() to get data inside document
    for(var doc in snapshot.docs) {

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

  Future<String?> getUserType(String collectionName, String userName) async {

    QuerySnapshot snapshot = await _firestore.collection(collectionName).get();

    String userType ="";
    for(var doc in snapshot.docs) {
      Map<String, dynamic> userMap = doc.data() as Map<String, dynamic>;
      if(userMap["name"] == userName) {
        userType = userMap["userType"];
      }
      return userType;
    }
    /*if (snapshot.exists) {
      // Document exists
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return data.toString();
    } else {
      // Document does not exist
      return "Document not found";
    }*/
  }


//upload File
  String downloadURL = "";
  Future uploadFile(PlatformFile? pickedFile) async {
    final path = 'files/${Uuid().v1()}/${pickedFile!.name}';
    log(path.toString());
    final file = File(pickedFile!.path!);
    log(file.toString());
    final ref = FirebaseStorage.instance.ref().child(path);
    log(ref.toString());
    UploadTask uploadTask = ref.putFile(file);
    log(uploadTask.toString());
    TaskSnapshot taskSnapshot = await uploadTask;
    log(taskSnapshot.toString());
    downloadURL = await taskSnapshot.ref.getDownloadURL();
    log(downloadURL);
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




  /*//add data
  Future<void> addUser(String name, String email) async{

    Map<String, dynamic> newUserData = {
      "name": name,
      "email": email,
    };
    await _firestore.collection("users").add(newUserData);


    *//*
         * If you want to give your own doc ID:
         * HERE WE USE `set`
         * await _firestore.collection("users").doc("your-doc-id-here").set(newUserData);
         * It will be created if doc doesn't exist.
       *//*
  }*/

//announce to class
  Future<void> addAnnouncement(String className, String description, String? userId) async{

    Map<String, dynamic> newUserData = {
      "className": className,
      "description": description,
      "userId": userId,

    };
    await _firestore.collection("teacher_announcements").add(newUserData);

  }

//
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